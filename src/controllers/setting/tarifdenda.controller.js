const errorhandler = require('../../helpers/errorhandler.helper')
const {
    tarif_denda,
    kendaraan,
    tipe_kendaraan,
    tenant,
} = require('../../models/index')
const fs = require('fs')
const puppeteer = require('puppeteer')
const ExcelJS = require('exceljs')
const dayjs = require('dayjs')
const Op = require('sequelize').Op
const { literal } = require('sequelize')

// Utility to fill the HTML template
function generateTableRows(data) {
    return data
        .map(
            (item) => `
    <tr>
      <td>${item.no}</td>
      <td>${item.kendaraan.nama}</td>
      <td>${item.denda_tiket}</td>
      <td>${item.denda_stnk}</td>
      <td>${item.denda_member}</td>
      <td>${item.status}</td>
      <td>${item.created}</td>
      <td>${item.updated}</td>
    </tr>
  `
        )
        .join('')
}

module.exports = {
    getAll: async (req, res) => {
        try {
            const search = req.query.search || ''
            const limit = req.query.limit ? parseInt(req.query.limit) : 10
            const page = req.query.page ? parseInt(req.query.page) : 1
            const offset = limit && page ? (page - 1) * limit : 0
            const sortBy = req.query.sortBy || 'id'
            const sortOrder =
                req.query.sortOrder?.toUpperCase() === 'DESC' ? 'DESC' : 'ASC'

            const allowedSortColumns = [
                'id',
                'kendaraan_id',
                'denda_tiket',
                'denda_stnk',
                'denda_member',
                'status',
                'createdAt',
                'updatedAt',
            ]
            const validSortBy = allowedSortColumns.includes(sortBy)
                ? sortBy
                : 'id'

            const options = {
                where: {},
                include: [
                    {
                        model: kendaraan,
                        as: 'kendaraan',
                        attributes: [
                            'id',
                            'nama_kendaraan',
                            'tipe_kendaraan_id',
                            'status',
                        ],
                        include: [
                            {
                                model: tipe_kendaraan,
                                as: 'tipe_kendaraan',
                                attributes: ['id', 'tipe_kendaraan'],
                            },
                        ],
                    },
                    {
                        model: tenant,
                        as: 'tenant',
                        attributes: ['id', 'nama_tenant'],
                    },
                ],
                order: [[validSortBy, sortOrder]],
            }

            if (search) {
                const searchLower = search.toLowerCase()
                let statusFilter = null

                if (searchLower === 'true' || searchLower === '1') {
                    statusFilter = true
                } else if (searchLower === 'false' || searchLower === '0') {
                    statusFilter = false
                }

                options.where[Op.or] = [
                    literal(`CAST("denda_tiket" AS TEXT) ILIKE '%${search}%'`),
                    literal(`CAST("denda_stnk" AS TEXT) ILIKE '%${search}%'`),
                    literal(`CAST("denda_member" AS TEXT) ILIKE '%${search}%'`),

                    ...(statusFilter !== null
                        ? [{ status: statusFilter }]
                        : []),

                    {
                        '$kendaraan.nama_kendaraan$': {
                            [Op.iLike]: `%${search}%`,
                        },
                    },
                    {
                        '$kendaraan.tipe_kendaraan.tipe_kendaraan$': {
                            [Op.iLike]: `%${search}%`,
                        },
                    },
                ]
            }

            if (limit) {
                options.limit = limit
                options.offset = offset
            }

            const { count, rows } = await tarif_denda.findAndCountAll(options)

            return res.json({
                success: true,
                message: 'Get all tarif denda successfully',
                results: {
                    data: rows,
                    totalData: count,
                    totalPages: limit ? Math.ceil(count / limit) : 1,
                    currentPage: page,
                    pageSize: limit || count,
                },
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    generatePdf: async (req, res) => {
        try {
            const startDate = new Date(req.query.start_date)
            const endDate = new Date(req.query.end_date)

            endDate.setHours(23, 59, 59, 999)

            const data = await tarif_denda.findAll({
                include: [
                    {
                        model: kendaraan,
                        as: 'kendaraan',
                    },
                ],
                where: {
                    createdAt: {
                        [Op.between]: [startDate, endDate],
                    },
                },
            })

            const tableData = data.map((item, index) => ({
                no: index + 1,
                kendaraan: item.kendaraan.nama,
                grace_period: item.grace_period,
                tarif_grace_period: item.tarif_grace_period,
                rotasi_pertama: item.rotasi_pertama,
                tarif_rotasi_pertama: item.tarif_rotasi_pertama,
                rotasi_kedua: item.rotasi_kedua,
                tarif_rotasi_kedua: item.tarif_rotasi_kedua,
                rotasi_ketiga: item.rotasi_ketiga,
                tarif_rotasi_ketiga: item.tarif_rotasi_ketiga,
                tarif_maksimal: item.tarif_maksimal,
                created: dayjs(item.createdAt).format('DD-MM-YYYY'),
                updated: dayjs(item.updatedAt).format('DD-MM-YYYY'),
            }))

            const template = fs.readFileSync(
                'src/templates/setting/tarif-denda.template.html',
                'utf-8'
            )
            const rowsHtml = generateTableRows(tableData)
            const finalHtml = template.replace('{{rows}}', rowsHtml)

            const browser = await puppeteer.launch()
            const page = await browser.newPage()
            await page.setContent(finalHtml, { waitUntil: 'networkidle0' })

            const pdfBuffer = await page.pdf({
                format: 'A3',
                printBackground: true,
            })

            await browser.close()

            res.set({
                'Content-Type': 'application/pdf',
                'Content-Disposition': 'inline; filename="tarif-denda.pdf"',
                'Content-Length': pdfBuffer.length,
            })

            res.send(pdfBuffer)
        } catch (err) {
            console.error(err)
            res.status(500).send('Error generating PDF')
        }
    },
    generateExcel: async (req, res) => {
        try {
            const data = await tarif_denda.findAll({
                include: [
                    {
                        model: kendaraan,
                        as: 'kendaraan',
                    },
                ],
                where: {
                    createdAt: {
                        [Op.between]: [
                            req.query.start_date,
                            req.query.end_date,
                        ],
                    },
                },
            })

            const workbook = new ExcelJS.Workbook()
            const worksheet = workbook.addWorksheet('Data Tarif Denda')

            const dateStr = new Date().toLocaleDateString('id-ID', {
                day: '2-digit',
                month: 'long',
                year: 'numeric',
            })

            const headers = [
                'No.',
                'Kendaraan',
                'Grace Period',
                'Tarif Grace Period',
                'Rotasi Pertama',
                'Tarif Rotasi Pertama',
                'Rotasi Kedua',
                'Tarif Rotasi Kedua',
                'Rotasi Ketiga',
                'Tarif Rotasi Ketiga',
                'Tarif Maksimal',
                'Added',
            ]
            const lastColLetter = String.fromCharCode(65 + headers.length - 1) // Convert to Excel letter

            const mergeAndStyle = (value, font, rowIdx) => {
                worksheet.mergeCells(`A${rowIdx}:${lastColLetter}${rowIdx}`)
                const cellObj = worksheet.getCell(`A${rowIdx}`)
                cellObj.value = value
                cellObj.alignment = { horizontal: 'center' }
                cellObj.font = font
            }

            // === Judul Atas ===
            mergeAndStyle('Evolusi Park', { bold: true, size: 12 }, 1)
            mergeAndStyle(
                'Developed by PT. Evosist (Evolusi Sistem)',
                { italic: true, size: 10 },
                2
            )
            mergeAndStyle('Data Tarif Denda', { bold: true, size: 20 }, 3)
            mergeAndStyle(dateStr, { size: 10 }, 4)

            worksheet.addRow([])

            // === Header Tabel ===
            const headerRow = worksheet.addRow(headers)
            headerRow.eachCell((cell) => {
                cell.fill = {
                    type: 'pattern',
                    pattern: 'solid',
                    fgColor: { argb: 'FFFF5B2A' },
                }
                cell.font = { bold: true, color: { argb: 'FFFFFFFF' } }
                cell.border = {
                    top: { style: 'thin' },
                    left: { style: 'thin' },
                    bottom: { style: 'thick' },
                    right: { style: 'thin' },
                }
                cell.alignment = { horizontal: 'center' }
            })

            // === Data Rows ===
            data.forEach((item, index) => {
                const row = worksheet.addRow([
                    index + 1,
                    item.kendaraan.nama,
                    item.grace_period,
                    item.tarif_grace_period,
                    item.rotasi_pertama,
                    item.tarif_rotasi_pertama,
                    item.tarif_rotasi_pertama,
                    item.rotasi_kedua,
                    item.tarif_rotasi_kedua,
                    item.rotasi_ketiga,
                    item.tarif_rotasi_ketiga,
                    item.tarif_maksimal,

                    new Date(item.createdAt).toLocaleString('id-ID'),
                ])

                row.eachCell((cell) => {
                    cell.border = {
                        top: { style: 'thin' },
                        left: { style: 'thin' },
                        bottom: { style: 'thin' },
                        right: { style: 'thin' },
                    }
                    cell.alignment = { vertical: 'middle' }
                })
            })

            // Auto-width kolom
            worksheet.columns.forEach((col) => {
                let maxLength = 10
                col.eachCell({ includeEmpty: true }, (cell) => {
                    if (cell.value) {
                        const length = cell.value.toString().length
                        if (length > maxLength) maxLength = length
                    }
                })
                col.width = maxLength + 2
            })

            // === Set header response and kirim Excel file ===
            res.setHeader(
                'Content-Type',
                'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
            )
            res.setHeader(
                'Content-Disposition',
                'attachment; filename=DataTarifDenda.xlsx'
            )
            await workbook.xlsx.write(res)
            res.end()
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    create: async (req, res) => {
        try {
            const data = await tarif_denda.create(req.body)
            return res.json({
                success: true,
                message: 'Create tarif denda successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    findOneById: async (req, res) => {
        try {
            const data = await tarif_denda.findAll({
                where: {
                    id: req.params.id,
                },
            })
            return res.json({
                success: true,
                message: 'Get tarif denda successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    update: async (req, res) => {
        try {
            const data = await tarif_denda.update(req.body, {
                where: {
                    id: req.params.id,
                },
            })
            return res.json({
                success: true,
                message: 'Update tarif denda successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    delete: async (req, res) => {
        try {
            const data = await tarif_denda.destroy({
                where: {
                    id: req.params.id,
                },
            })
            return res.json({
                success: true,
                message: 'Delete tarif denda successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
}
