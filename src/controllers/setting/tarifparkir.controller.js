const errorhandler = require('../../helpers/errorhandler.helper')
const {
    tarif_parkir,
    kendaraan,
    tipe_kendaraan,
    tarif_denda,
    sequelize,
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
      <td>${item.kendaraan}</td>
      <td>${item.grace_period}</td>
      <td>${item.tarif_grace_period}</td>
      <td>${item.rotasi_pertama}</td>
      <td>${item.tarif_rotasi_pertama}</td>
      <td>${item.rotasi_kedua}</td>
      <td>${item.tarif_rotasi_kedua}</td>
      <td>${item.rotasi_ketiga}</td>
      <td>${item.tarif_rotasi_ketiga}</td>
      <td>${item.tarif_maksimal}</td>
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
                'grace_period',
                'tarif_grace_period',
                'rotasi_pertama',
                'tarif_rotasi_pertama',
                'rotasi_kedua',
                'tarif_rotasi_kedua',
                'rotasi_ketiga',
                'tarif_rotasi_ketiga',
                'tarif_maksimal',
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
                options.where[Op.or] = [
                    literal(`CAST("grace_period" AS TEXT) ILIKE '%${search}%'`),
                    literal(
                        `CAST("tarif_grace_period" AS TEXT) ILIKE '%${search}%'`
                    ),
                    literal(
                        `CAST("rotasi_pertama" AS TEXT) ILIKE '%${search}%'`
                    ),
                    literal(
                        `CAST("tarif_rotasi_pertama" AS TEXT) ILIKE '%${search}%'`
                    ),
                    literal(`CAST("rotasi_kedua" AS TEXT) ILIKE '%${search}%'`),
                    literal(
                        `CAST("tarif_rotasi_kedua" AS TEXT) ILIKE '%${search}%'`
                    ),
                    literal(
                        `CAST("rotasi_ketiga" AS TEXT) ILIKE '%${search}%'`
                    ),
                    literal(
                        `CAST("tarif_rotasi_ketiga" AS TEXT) ILIKE '%${search}%'`
                    ),
                    literal(
                        `CAST("tarif_maksimal" AS TEXT) ILIKE '%${search}%'`
                    ),
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

            const { count, rows } = await tarif_parkir.findAndCountAll(options)

            return res.json({
                success: true,
                message: 'Get all tarif parkir successfully',
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

            const data = await tarif_parkir.findAll({
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
                'src/templates/setting/tarif-parkir.template.html',
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
                'Content-Disposition': 'inline; filename="global-settings.pdf"',
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
            const data = await tarif_parkir.findAll({
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
            const worksheet = workbook.addWorksheet('Data Tarif Parkir')

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
                'Status',
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
            mergeAndStyle('Data Global Setting', { bold: true, size: 20 }, 3)
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
                    item.kendaraan,
                    item.grace_period,
                    item.tarif_grace_period,
                    item.rotasi_pertama,
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
                'attachment; filename=DataTarifParkir.xlsx'
            )
            await workbook.xlsx.write(res)
            res.end()
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    create: async (req, res) => {
        const t = await sequelize.transaction()
        try {
            const dataTarif = await tarif_parkir.create(req.body, {
                transaction: t,
            })

            // Buat tarif denda otomatis setelah tarif parkir berhasil dibuat
            await tarif_denda.create(
                {
                    kendaraan_id: req.body.kendaraan_id,
                    denda_tiket: 0,
                    denda_stnk: 0,
                    denda_member: false,
                    status: false,
                },
                { transaction: t }
            )

            await t.commit()

            return res.json({
                success: true,
                message: 'Create tarif parkir & denda successfully',
                results: dataTarif,
            })
            // const data = await tarif_parkir.create(req.body)
            // return res.json({
            //     success: true,
            //     message: 'Create tarif parkir successfully',
            //     results: data,
            // })
        } catch (err) {
            await t.rollback()
            return errorhandler(res, err)
            // return errorhandler(res, err)
        }
    },
    findOneById: async (req, res) => {
        try {
            const data = await tarif_parkir.findAll({
                where: {
                    id: req.params.id,
                },
            })
            return res.json({
                success: true,
                message: 'Get tarif parkir successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    update: async (req, res) => {
        try {
            const data = await tarif_parkir.update(req.body, {
                where: {
                    id: req.params.id,
                },
            })
            return res.json({
                success: true,
                message: 'Update tarif parkir successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    delete: async (req, res) => {
        try {
            const data = await tarif_parkir.destroy({
                where: {
                    id: req.params.id,
                },
            })
            return res.json({
                success: true,
                message: 'Delete tarif parkir successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
}
