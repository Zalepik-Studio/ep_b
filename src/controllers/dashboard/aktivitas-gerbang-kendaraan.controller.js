const errorhandler = require('../../helpers/errorhandler.helper')
const {
    aktivitas_gerbang_kendaraan,
    user,
    tenant,
} = require('../../models/index')
const fs = require('fs')
const puppeteer = require('puppeteer')
const ExcelJS = require('exceljs')
const dayjs = require('dayjs')
const Op = require('sequelize').Op
const { isValidDDMMYYYY } = require('../../helpers/dateformat.helper')
const { convertDDMMYYYYtoMMDDYYYY } = require('../../helpers/dateformat.helper')

// Utility to fill the HTML template
function generateTableRows(data) {
    return data
        .map(
            (item) => `
    <tr>
      <td>${item.no}</td>
      <td>${item.tiket}</td>
      <td>${item.plat_nomor}</td>
      <td>${item.kendaraan}</td>
      <td>${item.waktu}</td>
      <td>${item.lokasi_gerbang}</td>
      <td>${item.buka_atau_tutup}</td>
      <td>${item.petugas}</td>
      <td>${item.status_palang}</td>
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
            const limit = req.query.limit ? parseInt(req.query.limit) : null
            const page = req.query.page ? parseInt(req.query.page) : null
            const offset = page && limit ? (page - 1) * limit : null
            const sortBy = req.query.sortBy || 'id'
            const sortOrder = req.query.sortOrder || 'asc'
            const startDate = req.query.start_date
            const endDate = req.query.end_date

            const options = {
                where: {},
                order: [[sortBy, sortOrder]],
                include: [
                    {
                        model: user,
                        as: 'petugas',
                        attributes: ['id', 'nama'],
                    },
                    {
                        model: user,
                        as: 'petugas',
                        attributes: ['id', 'nama'],
                    },
                    {
                        model: tenant,
                        as: 'tenant',
                        attributes: ['id', 'nama_tenant'],
                    },
                    {
                        model: require('../../models').data_member,
                        as: 'data_member',
                        attributes: ['id', 'nama'], // atau atribut lain yang diperlukan
                    },
                    {
                        model: require('../../models').kendaraan,
                        as: 'kendaraan',
                        attributes: ['id', 'nama_kendaraan'], // ubah sesuai kolom yang Anda punya
                    },
                ],
                distinct: true, // menghilangkan duplikat
            }

            // Awal: Siapkan filter awal
            options.where = {}

            if (startDate && endDate) {
                if (!isValidDDMMYYYY(startDate) || !isValidDDMMYYYY(endDate)) {
                    return res.status(400).json({
                        success: false,
                        message: 'Format tanggal harus DD-MM-YYYY',
                    })
                }

                const start = new Date(convertDDMMYYYYtoMMDDYYYY(startDate))
                const end = new Date(
                    new Date(convertDDMMYYYYtoMMDDYYYY(endDate)).setHours(
                        23,
                        59,
                        59,
                        999
                    )
                )

                options.where.createdAt = {
                    [Op.between]: [start, end],
                }
            }

            if (search) {
                options.where[Op.and] = [
                    ...(options.where[Op.and] || []), // biar nggak overwrite
                    {
                        [Op.or]: [
                            { tiket: { [Op.iLike]: `%${search}%` } },
                            { plat_nomor: { [Op.iLike]: `%${search}%` } },
                            { waktu: { [Op.iLike]: `%${search}%` } },
                            { lokasi_gerbang: { [Op.iLike]: `%${search}%` } },
                            { buka_atau_tutup: { [Op.iLike]: `%${search}%` } },
                            { status_palang: { [Op.iLike]: `%${search}%` } },
                            { '$petugas.nama$': { [Op.iLike]: `%${search}%` } },
                            {
                                '$data_member.nama$': {
                                    [Op.iLike]: `%${search}%`,
                                },
                            },
                        ],
                    },
                ]
            }

            // if (search) {
            //     options.where = {
            //         [Op.or]: [
            //             { tiket: { [Op.iLike]: `%${search}%` } },
            //             { plat_nomor: { [Op.iLike]: `%${search}%` } },
            //             {
            //                 '$kendaraan.nama_kendaraan$': {
            //                     [Op.iLike]: `%${search}%`,
            //                 },
            //             },
            //             { waktu: { [Op.iLike]: `%${search}%` } },
            //             { lokasi_gerbang: { [Op.iLike]: `%${search}%` } },
            //             { buka_atau_tutup: { [Op.iLike]: `%${search}%` } },
            //             { petugas: { [Op.iLike]: `%${search}%` } },
            //             { status_palang: { [Op.iLike]: `%${search}%` } },
            //         ],
            //     }
            // }

            if (limit !== null && offset !== null) {
                options.limit = limit
                options.offset = offset
            }

            const { count, rows } =
                await aktivitas_gerbang_kendaraan.findAndCountAll(options)

            return res.json({
                success: true,
                message: 'Get all aktivitas gerbang kendaraan successfully',
                results: {
                    data: rows,
                    totalData: count,
                    totalPages: limit ? Math.ceil(count / limit) : 1,
                    currentPage: page || 1,
                    pageSize: limit || count,
                },
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    create: async (req, res) => {
        try {
            const data = await aktivitas_gerbang_kendaraan.create(req.body)

            return res.json({
                success: true,
                message: 'Create aktivitas gerbang kendaraan successfully',
                results: data,
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

            const data = await aktivitas_gerbang_kendaraan.findAll({
                include: [
                    {
                        model: user,
                        as: 'user',
                        attributes: ['id', 'nama'],
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
                tiket: item.tiket,
                plat_nomor: item.plat_nomor,
                kendaraan: item.kendaraan.nama_kendaraan,
                waktu: item.waktu,
                lokasi_gerbang: item.lokasi_gerbang,
                buka_atau_tutup: item.buka_atau_tutup,
                petugas: item.petugas,
                status_palang: item.status_palang,
                // created: dayjs(item.createdAt).format('DD-MM-YYYY'),
                created: dayjs(item.createdAt)
                    .tz('Asia/Jakarta')
                    .format('DD-MM-YYYY'),
                // updated: dayjs(item.updatedAt).format('DD-MM-YYYY'),
                updated: dayjs(item.updatedAt)
                    .tz('Asia/Jakarta')
                    .format('DD-MM-YYYY'),
            }))

            const template = fs.readFileSync(
                'src/templates/dashboard/aktivitas-gerbang-kendaraan.template.html',
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
            const data = await aktivitas_gerbang_kendaraan.findAll({
                include: [
                    {
                        model: user,
                        as: 'user',
                        attributes: ['id', 'nama'],
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
            const worksheet = workbook.addWorksheet(
                'Data Aktivitas Gerbang Kendaraan'
            )

            const dateStr = new Date().toLocaleDateString('id-ID', {
                day: '2-digit',
                month: 'long',
                year: 'numeric',
            })

            const headers = [
                'No.',
                'Tiket',
                'Plat Nomor',
                'Kendaraan',
                'Waktu',
                'Lokasi Gerbang',
                'Buka Atau Tutup',
                'Petugas',
                'Status Palang',
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
            mergeAndStyle(
                'Data Aktivitas Gerbang Kendaraan',
                { bold: true, size: 20 },
                3
            )
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
                    item.tiket,
                    item.plat_nomor,
                    item.kendaraan,
                    item.waktu,
                    item.lokasi_gerbang,
                    item.buka_atau_tutup,
                    item.petugas,
                    item.status_palang,
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
                'attachment; filename=DataAktivitasGerbangKendaraan.xlsx'
            )
            await workbook.xlsx.write(res)
            res.end()
        } catch (err) {
            return errorhandler(res, err)
        }
    },
}
