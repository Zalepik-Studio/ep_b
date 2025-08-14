const errorhandler = require('../../helpers/errorhandler.helper')
const { payment, tenant } = require('../../models/index')
const fs = require('fs')
const puppeteer = require('puppeteer')
const ExcelJS = require('exceljs')
const dayjs = require('dayjs')
const Op = require('sequelize').Op

// Utility to fill the HTML template
function generateTableRows(data) {
    return data
        .map(
            (item) => `
    <tr>
      <td>${item.no}</td>
      <td>${item.jenis_payment}</td>
      <td>${item.status}</td>
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
    //             'jenis_payment',
    //             'payment_status',
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
    //                 { jenis_payment: { [Op.iLike]: `%${search}%` } },
    //                 { payment_status: { [Op.iLike]: `%${search}%` } },
    //             ]
    //         }
    //
    //         if (limit) {
    //             options.limit = limit
    //             options.offset = offset
    //         }
    //
    //         const { count, rows } = await payment.findAndCountAll(options)
    //
    //         return res.json({
    //             success: true,
    //             message: 'Get all payment successfully',
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
    //
    getAll: async (req, res) => {
        try {
            // === Cek dan insert data default kalau belum ada ===
            const defaultPayments = [
                { jenis_payment: 'Tunai', status: false },
                { jenis_payment: 'Bank', status: false },
                { jenis_payment: 'QRIS', status: false },
                { jenis_payment: 'Member', status: false },
            ]

            for (const paymentItem of defaultPayments) {
                const found = await payment.findOne({
                    where: {
                        jenis_payment: {
                            [Op.iLike]: paymentItem.jenis_payment, // case-insensitive
                        },
                    },
                })

                if (!found) {
                    await payment.create({
                        ...paymentItem,
                        createdAt: new Date(),
                        updatedAt: new Date(),
                    })
                }
            }

            // === Lanjutkan ke proses normal ===
            const search = req.query.search || ''
            const limit = req.query.limit ? parseInt(req.query.limit) : 10
            const page = req.query.page ? parseInt(req.query.page) : 1
            const offset = limit && page ? (page - 1) * limit : 0
            const sortBy = req.query.sortBy || 'id'
            const sortOrder =
                req.query.sortOrder?.toUpperCase() === 'DESC' ? 'DESC' : 'ASC'

            const allowedSortColumns = [
                'id',
                'jenis_payment',
                'payment_status',
                'createdAt',
                'updatedAt',
            ]
            const validSortBy = allowedSortColumns.includes(sortBy)
                ? sortBy
                : 'id'

            const options = {
                where: {},
                order: [[validSortBy, sortOrder]],
                include: [
                    {
                        model: tenant,
                        as: 'tenant',
                        attributes: ['id', 'nama_tenant'],
                    },
                ],
            }

            if (search) {
                options.where[Op.or] = [
                    { jenis_payment: { [Op.iLike]: `%${search}%` } },
                    { payment_status: { [Op.iLike]: `%${search}%` } }, // optional: jika kolom ini ada
                ]
            }

            if (limit) {
                options.limit = limit
                options.offset = offset
            }

            const { count, rows } = await payment.findAndCountAll(options)

            return res.json({
                success: true,
                message: 'Get all payment successfully',
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

            const data = await payment.findAll({
                where: {
                    createdAt: {
                        [Op.between]: [startDate, endDate],
                    },
                },
            })

            const tableData = data.map((item, index) => ({
                no: index + 1,
                jenis_payment: item.jenis_payment,
                status: item.status,
                created: dayjs(item.createdAt).format('DD-MM-YYYY'),
                updated: dayjs(item.updatedAt).format('DD-MM-YYYY'),
            }))

            const template = fs.readFileSync(
                'src/templates/setting/payment.template.html',
                'utf-8'
            )

            const downloadDate = dayjs().format('DD-MM-YYYY HH:mm')
            const rowsHtml = generateTableRows(tableData)
            const finalHtml = template
                .replace('{{rows}}', rowsHtml)
                .replace('{{date}}', downloadDate)

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
                'Content-Disposition': 'inline; filename="payment.pdf"',
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
            const data = await payment.findAll({
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
            const worksheet = workbook.addWorksheet('Data Payment')

            const dateStr = new Date().toLocaleDateString('id-ID', {
                day: '2-digit',
                month: 'long',
                year: 'numeric',
            })

            const headers = ['No.', 'Jenis Pembayaran', 'Status', 'Added']
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
            mergeAndStyle('Data Payment', { bold: true, size: 20 }, 3)
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
                    item.jenis_payment,
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
                'attachment; filename=DataPayment.xlsx'
            )
            await workbook.xlsx.write(res)
            res.end()
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    // create: async (req, res) => {
    //     try {
    //         const data = await payment.create(req.body)
    //         return res.json({
    //             success: true,
    //             message: 'Create payment successfully',
    //             results: data,
    //         })
    //     } catch (err) {
    //         return errorhandler(res, err)
    //     }
    // },
    create: async (req, res) => {
        try {
            const { jenis_payment } = req.body

            // Tolak jika tidak ada jenis_payment
            if (!jenis_payment || jenis_payment.trim() === '') {
                return res.status(400).json({
                    success: false,
                    message: 'Jenis pembayaran tidak boleh kosong.',
                })
            }

            // Cek apakah sudah ada jenis_payment dengan nama serupa (abaikan case)
            const existing = await payment.findOne({
                where: {
                    jenis_payment: {
                        [Op.iLike]: jenis_payment, // abaikan huruf besar kecil
                    },
                },
            })

            if (existing) {
                return res.status(400).json({
                    success: false,
                    message: `Jenis pembayaran '${jenis_payment}' sudah tersedia.`,
                })
            }

            // Simpan data baru
            const data = await payment.create(req.body)
            return res.json({
                success: true,
                message: 'Create payment successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },

    findOneById: async (req, res) => {
        try {
            const data = await payment.findAll({
                where: {
                    id: req.params.id,
                },
            })
            return res.json({
                success: true,
                message: 'Get payment successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    update: async (req, res) => {
        try {
            const data = await payment.update(req.body, {
                where: {
                    id: req.params.id,
                },
            })
            return res.json({
                success: true,
                message: 'Update payment successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    delete: async (req, res) => {
        try {
            const data = await payment.destroy({
                where: {
                    id: req.params.id,
                },
            })
            return res.json({
                success: true,
                message: 'Delete payment successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
}
