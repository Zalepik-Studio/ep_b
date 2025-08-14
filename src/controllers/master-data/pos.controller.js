const dayjs = require('dayjs')
const errorhandler = require('../../helpers/errorhandler.helper')
const {
    pos,
    user,
    tipe_manless,
    nama_printer,
    nama_interface,
    tenant,
} = require('../../models/index')
const puppeteer = require('puppeteer')
const fs = require('fs')
const ExcelJS = require('exceljs')
const Op = require('sequelize').Op

// Utility to fill the HTML template
function generateTableRows(data) {
    return data
        .map(
            (item) => `
    <tr>
      <td>${item.no}</td>
      <td>${item.kode}</td>
      <td>${item.keterangan}</td>
      <td>${item.tipe_pos}</td>
      <td>${item.tipe_manless}</td>
      <td>${item.tipe_kendaraan}</td>
      <td>${item.kamera_1}</td>
      <td>${item.kamera_2}</td>
      <td>${item.nama_printer}</td>
      <td>${item.nama_interface}</td>
      <td>${item.com_port}</td>
      <td>${item.otorisasi}</td>
      <td>${item.synchronize}</td>
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
                'kode',
                'keterangan',
                'tipe_pos',
                'tipe_manless_id',
                'tipe_kendaraan',
                'kamera_1',
                'kamera_2',
                'nama_printer_id',
                'nama_interface_id',
                'com_port',
                'otorisasi',
                'synchronize',
                'user_id',
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
                        model: user,
                        as: 'user',
                        attributes: ['id', 'nama'],
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
                    { kode: { [Op.iLike]: `%${search}%` } },
                    { keterangan: { [Op.iLike]: `%${search}%` } },
                    { tipe_pos: { [Op.iLike]: `%${search}%` } },
                    {
                        '$tipe_manless.tipe_manless$': {
                            [Op.iLike]: `%${search}%`,
                        },
                    },
                    { tipe_kendaraan: { [Op.iLike]: `%${search}%` } },

                    ...(statusFilter !== null
                        ? [
                              {
                                  kamera_1: statusFilter,
                                  kamera_2: statusFilter,
                              },
                          ]
                        : []),

                    literal(
                        `CAST("nama_printer_id" AS TEXT) ILIKE '%${search}%'`
                    ),
                    literal(
                        `CAST("nama_interface_id" AS TEXT) ILIKE '%${search}%'`
                    ),
                    { com_port: { [Op.iLike]: `%${search}%` } },
                    literal(`CAST("otorisasi" AS TEXT) ILIKE '%${search}%'`),
                    { synchronize: { [Op.iLike]: `%${search}%` } },
                    { '$user.nama$': { [Op.iLike]: `%${search}%` } },
                ]
            }

            if (limit) {
                options.limit = limit
                options.offset = offset
            }

            const { count, rows } = await pos.findAndCountAll(options)

            return res.json({
                success: true,
                message: 'Get all pos successfully',
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

            const data = await pos.findAll({
                include: [
                    {
                        model: user,
                        as: 'user',
                        attributes: ['id', 'nama'],
                    },
                    {
                        model: tipe_manless,
                        as: 'tipe_manless',
                    },
                    {
                        model: nama_printer,
                        as: 'printer',
                    },
                    {
                        model: nama_interface,
                        as: 'interface',
                    },
                ],
                where: {
                    createdAt: {
                        [Op.between]: [startDate, endDate],
                    },
                },
            })

            const tableData = data.map((item, index) => {
                return {
                    no: index + 1,
                    kode: item.kode,
                    keterangan: item.keterangan,
                    tipe_pos: item.tipe_pos,
                    tipe_manless: item.tipe_manless.tipe_manless,
                    tipe_kendaraan: item.tipe_kendaraan,
                    kamera_1: item.kamera_1 === true ? 'Ya' : 'Tidak',
                    kamera_2: item.kamera_2 === true ? 'Ya' : 'Tidak',
                    nama_printer: item.printer.nama_printer,
                    nama_interface: item.interface.nama_interface,
                    com_port: item.com_port,
                    otorisasi: item.otorisasi === true ? 'Ya' : 'Tidak',
                    synchronize: item.synchronize,
                    created: dayjs(item.createdAt).format('DD-MM-YYYY'),
                    updated: dayjs(item.updatedAt).format('DD-MM-YYYY'),
                }
            })

            const template = fs.readFileSync(
                'src/templates/master-data/pos.template.html',
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
                format: 'A3',
                printBackground: true,
            })

            await browser.close()

            res.set({
                'Content-Type': 'application/pdf',
                'Content-Disposition': 'inline; filename="data-pos.pdf"',
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
            const data = await pos.findAll({
                include: [
                    {
                        model: user,
                        as: 'user',
                        attributes: ['id', 'nama'],
                    },
                    {
                        model: tipe_manless,
                        as: 'tipe_manless',
                    },
                    {
                        model: nama_printer,
                        as: 'printer',
                    },
                    {
                        model: nama_interface,
                        as: 'interface',
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
            const worksheet = workbook.addWorksheet('Data POS')

            const dateStr = new Date().toLocaleDateString('id-ID', {
                day: '2-digit',
                month: 'long',
                year: 'numeric',
            })

            const headers = [
                'No.',
                'Kode',
                'Keterangan',
                'Tipe POS',
                'Tipe Manless',
                'Tipe Kendaraan',
                'Kamera 1?',
                'Kamera 2?',
                'Printer Name',
                'Interface Name',
                'COM Port',
                'Otorisasi',
                'Synchronize (Menit)',
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
            mergeAndStyle('Data POS', { bold: true, size: 20 }, 3)
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
                    item.kode,
                    item.keterangan,
                    item.tipe_pos,
                    item.tipe_manless,
                    item.tipe_kendaraan,
                    item.kamera_1,
                    item.kamera_2,
                    item.nama_printer,
                    item.nama_interface,
                    item.com_port,
                    item.otorisasi,
                    item.synchronize,
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
                'attachment; filename=DataPOS.xlsx'
            )
            await workbook.xlsx.write(res)
            res.end()
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    create: async (req, res) => {
        try {
            const data = await pos.create(req.body)
            return res.json({
                success: true,
                message: 'Create pos successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    findOneById: async (req, res) => {
        try {
            const data = await pos.findAll({
                where: {
                    id: req.params.id,
                },
                include: [
                    {
                        model: tipe_manless,
                        as: 'tipe_manless',
                    },
                    {
                        model: nama_printer,
                        as: 'printer',
                    },
                    {
                        model: nama_interface,
                        as: 'interface',
                    },
                ],
            })
            return res.json({
                success: true,
                message: 'Get pos successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    update: async (req, res) => {
        try {
            const data = await pos.update(req.body, {
                where: {
                    id: req.params.id,
                },
            })
            return res.json({
                success: true,
                message: 'Update pos successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    delete: async (req, res) => {
        try {
            const data = await pos.destroy({
                where: {
                    id: req.params.id,
                },
            })
            return res.json({
                success: true,
                message: 'Delete pos successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
}
