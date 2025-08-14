const errorhandler = require('../../../helpers/errorhandler.helper')
const { parameter, tenant } = require('../../../models/index')
const fs = require('fs')
const puppeteer = require('puppeteer')
const ExcelJS = require('exceljs')
const Op = require('sequelize').Op
const dayjs = require('dayjs')
const defaultParameters = require('./parameterDefaults')
const { tipe_manless } = require('../../../models/index')
const parameterDefaultsManless = require('./parameterDefaultsManless')
const { nama_printer } = require('../../../models/index')
const parameterDefaultsPrinter = require('./parameterDefaultsPrinter')
const { nama_interface } = require('../../../models/index')
const parameterDefaultsInterface = require('./parameterDefaultsInterface')
const { tipe_kendaraan } = require('../../../models/index')
const parameterDefaultsTipeKendaraan = require('./parameterDefaultsTipeKendaraan')

function generateTableRows(data) {
    return data
        .map(
            (item) => `
    <tr>
      <td>${item.no}</td>
      <td>${item.nama}</td>
      <td>${item.nilai}</td>
      <td>${item.keterangan}</td>
      <td>${item.created}</td>
      <td>${item.updated}</td>
    </tr>
  `
        )
        .join('')
}

module.exports = {
    // getAll: async (req, res) => {
    //     try {
    //         const search = req.query.search || ''
    //         const limit = req.query.limit ? parseInt(req.query.limit) : 10
    //         const page = req.query.page ? parseInt(req.query.page) : 1
    //         const offset = limit && page ? (page - 1) * limit : 0
    //         const sortBy = req.query.sortBy || 'id'
    //         const sortOrder =
    //             req.query.sortOrder?.toUpperCase() === 'DESC' ? 'DESC' : 'ASC'
    //
    //         const allowedSortColumns = [
    //             'id',
    //             'nama',
    //             'value',
    //             'createdAt',
    //             'updatedAt',
    //         ]
    //         const validSortBy = allowedSortColumns.includes(sortBy)
    //             ? sortBy
    //             : 'id'
    //
    //         const options = {
    //             where: {},
    //             order: [[validSortBy, sortOrder]],
    //         }
    //
    //         if (search) {
    //             options.where[Op.or] = [
    //                 { nama: { [Op.iLike]: `%${search}%` } },
    //                 { nilai: { [Op.iLike]: `%${search}%` } },
    //                 { keterangan: { [Op.iLike]: `%${search}%` } },
    //             ]
    //         }
    //
    //         if (limit) {
    //             options.limit = limit
    //             options.offset = offset
    //         }
    //
    //         const { count, rows } = await parameter.findAndCountAll(options)
    //
    //         return res.json({
    //             success: true,
    //             message: 'Get all parameter successfully',
    //             results: {
    //                 data: rows,
    //                 totalData: count,
    //                 totalPages: limit ? Math.ceil(count / limit) : 1,
    //                 currentPage: page,
    //                 pageSize: limit || count,
    //             },
    //         })
    //     } catch (err) {
    //         return errorhandler(res, err)
    //     }
    // },
    getAll: async (req, res) => {
        try {
            // ✅ Cek dan insert default data untuk `parameter`
            let parameterSeeded = false

            for (const item of defaultParameters) {
                const exist = await parameter.findOne({
                    where: { nama: item.nama },
                })
                if (!exist) {
                    await parameter.create({
                        nama: item.nama,
                        nilai: item.nilai,
                        keterangan: item.keterangan,
                    })
                    parameterSeeded = true
                }
            }

            if (parameterSeeded) {
                // Hanya dijalankan jika ada parameter yang baru disisipkan
                await tipe_manless.bulkCreate(
                    parameterDefaultsManless.map((item) => ({
                        tipe_manless: item.nama,
                        nilai: item.nilai,
                        keterangan: item.keterangan,
                    })),
                    { ignoreDuplicates: true }
                )

                await nama_printer.bulkCreate(
                    parameterDefaultsPrinter.map((item) => ({
                        nama_printer: item.nama_printer,
                    })),
                    { ignoreDuplicates: true }
                )

                // Seeder nama_interface
                await nama_interface.bulkCreate(
                    parameterDefaultsInterface.map((item) => ({
                        nama_interface: item.nama_interface,
                    })),
                    { ignoreDuplicates: true }
                )

                await tipe_kendaraan.bulkCreate(
                    parameterDefaultsTipeKendaraan.map((item) => ({
                        tipe_kendaraan: item.tipe_kendaraan,
                    })),
                    { ignoreDuplicates: true }
                )
            }

            // 🔍 Search, Pagination, Sorting
            const search = req.query.search || ''
            const limit = req.query.limit ? parseInt(req.query.limit) : 10
            const page = req.query.page ? parseInt(req.query.page) : 1
            const offset = (page - 1) * limit
            const sortBy = req.query.sortBy || 'id'
            const sortOrder =
                req.query.sortOrder?.toUpperCase() === 'DESC' ? 'DESC' : 'ASC'

            const allowedSortColumns = [
                'id',
                'nama',
                'nilai',
                'keterangan',
                'createdAt',
                'updatedAt',
            ]
            const validSortBy = allowedSortColumns.includes(sortBy)
                ? sortBy
                : 'id'

            const whereCondition = search
                ? {
                      [Op.or]: [
                          { nama: { [Op.iLike]: `%${search}%` } },
                          { nilai: { [Op.iLike]: `%${search}%` } },
                          { keterangan: { [Op.iLike]: `%${search}%` } },
                      ],
                  }
                : {}

            const { count, rows } = await parameter.findAndCountAll({
                where: whereCondition,
                order: [[validSortBy, sortOrder]],
                limit,
                offset,
                include: [
                    {
                        model: tenant,
                        as: 'tenant',
                        attributes: ['id', 'nama_tenant'],
                    },
                ],
            })

            return res.json({
                success: true,
                message: 'Get all parameter successfully',
                results: {
                    data: rows,
                    totalData: count,
                    totalPages: Math.ceil(count / limit),
                    currentPage: page,
                    pageSize: limit,
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

            const data = await parameter.findAll({
                where: {
                    createdAt: {
                        [Op.between]: [startDate, endDate],
                    },
                },
            })

            const tableData = data.map((item, index) => {
                return {
                    no: index + 1,
                    nama: item.nama,
                    nilai: item.nilai,
                    keterangan: item.keterangan,
                    created: dayjs(item.createdAt).format('DD-MM-YYYY'),
                    updated: dayjs(item.updatedAt).format('DD-MM-YYYY'),
                }
            })

            const template = fs.readFileSync(
                'src/templates/setting/parameter.template.html',
                'utf-8'
            )
            const rowsHtml = generateTableRows(tableData)
            const downloadDate = dayjs().format('DD-MM-YYYY HH:mm')
            const finalHtml = template
                .replace('{{rows}}', rowsHtml)
                .replace('{{date}}', downloadDate)

            const browser = await puppeteer.launch()
            const page = await browser.newPage()
            await page.setContent(finalHtml, { waitUntil: 'networkidle0' })

            const pdfBuffer = await page.pdf({
                format: 'A4',
                printBackground: true,
            })

            await browser.close()

            res.set({
                'Content-Type': 'application/pdf',
                'Content-Disposition': 'inline; filename="report.pdf"',
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
            const data = await parameter.findAll({
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
            const worksheet = workbook.addWorksheet('Parameter')

            const dateStr = new Date().toLocaleDateString('id-ID', {
                day: '2-digit',
                month: 'long',
                year: 'numeric',
            })

            const headers = [
                'No.',
                'Nama',
                'Nilai',
                'Keterangan',
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
            mergeAndStyle('Data User', { bold: true, size: 20 }, 3)
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
                    item.nama,
                    item.nilai,
                    item.keterangan,
                    item.status,
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
                'attachment; filename=DataUser.xlsx'
            )
            await workbook.xlsx.write(res)
            res.end()
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    create: async (req, res) => {
        try {
            const data = await parameter.create(req.body)
            return res.json({
                success: true,
                message: 'Create parameter successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    findOneById: async (req, res) => {
        try {
            const data = await parameter.findAll({
                where: {
                    id: req.params.id,
                },
            })
            return res.json({
                success: true,
                message: 'Get parameter successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    update: async (req, res) => {
        try {
            const data = await parameter.update(req.body, {
                where: {
                    id: req.params.id,
                },
            })
            return res.json({
                success: true,
                message: 'Update parameter successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    delete: async (req, res) => {
        try {
            const data = await parameter.destroy({
                where: {
                    id: req.params.id,
                },
            })
            return res.json({
                success: true,
                message: 'Delete parameter successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
}
