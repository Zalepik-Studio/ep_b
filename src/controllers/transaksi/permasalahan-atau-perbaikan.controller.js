const errorhandler = require('../../helpers/errorhandler.helper')
const {
    permasalahan_atau_perbaikan,
    pos,
    tenant,
} = require('../../models/index')
const fs = require('fs')
const puppeteer = require('puppeteer')
const ExcelJS = require('exceljs')
const dayjs = require('dayjs')
const { literal } = require('sequelize')
const Op = require('sequelize').Op

// Utility to fill the HTML template
function generateTableRows(data) {
    return data
        .map(
            (item) => `
    <tr>
      <td>${item.no}</td>
      <td>${item.judul_permasalahan}</td>
      <td>${item.tanggal_permasalahan}</td>
      <td>${item.kategori_permasalahan}</td>
      <td>${item.pos.keterangan}</td>
      <td>${item.hardware_atau_alat}</td>
      <td>${item.penyebab_permasalahan}</td>
      <td>${item.keterangan_permasalahan}</td>
      <td>${item.nama_pelapor}</td>
      <td>${item.status_permasalahan}</td>
      <td>${item.tanggal_perbaikan}</td>
      <td>${item.jenis_perbaikan}</td>
      <td>${item.status_perbaikan}</td>
      <td>${item.penanganan}</td>
      <td>${item.keterangan_penanganan}</td>
      <td>${item.nama_yang_menangani}</td>
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
                'nama',
                'deskripsi',
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
                        model: pos,
                        as: 'pos',
                        attributes: ['id', 'keterangan'],
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
                    { judul_permasalahan: { [Op.iLike]: `%${search}%` } },
                    { tanggal_permasalahan: { [Op.iLike]: `%${search}%` } },
                    { kategori_permasalahan: { [Op.iLike]: `%${search}%` } },
                    literal(
                        `pos.keterangan ILIKE '%${search}%' OR pos.nama ILIKE '%${search}%'`
                    ),
                    { hardware_atau_alat: { [Op.iLike]: `%${search}%` } },
                    { penyebab_permasalahan: { [Op.iLike]: `%${search}%` } },
                    { keterangan_permasalahan: { [Op.iLike]: `%${search}%` } },
                    { nama_pelapor: { [Op.iLike]: `%${search}%` } },
                    { status_permasalahan: { [Op.iLike]: `%${search}%` } },
                    { tanggal_perbaikan: { [Op.iLike]: `%${search}%` } },
                    { jenis_perbaikan: { [Op.iLike]: `%${search}%` } },
                    { status_perbaikan: { [Op.iLike]: `%${search}%` } },
                    { penangangan: { [Op.iLike]: `%${search}%` } },
                    { keterangan_penanganan: { [Op.iLike]: `%${search}%` } },
                    { nama_yang_menangani: { [Op.iLike]: `%${search}%` } },
                ]
            }

            if (limit) {
                options.limit = limit
                options.offset = offset
            }

            const { count, rows } =
                await permasalahan_atau_perbaikan.findAndCountAll(options)

            return res.json({
                success: true,
                message: 'Get all permasalahan atau perbaikan successfully',
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

            const data = await permasalahan_atau_perbaikan.findAll({
                include: [
                    {
                        model: pos,
                        as: 'pos',
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
                    judul_permasalahan: item.judul_permasalahan,
                    tanggal_permasalahan: dayjs(
                        item.tanggal_permasalahan
                    ).format('DD/MM/YYYY'),
                    kategori_permasalahan: item.kategori_permasalahan,
                    pos: item.pos.keterangan,
                    hardware_atau_alat: item.hardware_atau_alat,
                    penyebab_permasalahan: item.penyebab_permasalahan,
                    keterangan_permasalahan: item.keterangan_permasalahan,
                    nama_pelapor: item.nama_pelapor,
                    status_permasalahan: item.status_permasalahan,
                    tanggal_perbaikan: item.tanggal_perbaikan,
                    jenis_perbaikan: item.jenis_perbaikan,
                    status_perbaikan: item.status_perbaikan,
                    penanganan: item.penanganan,
                    keterangan_penanganan: item.keterangan_penanganan,
                    nama_yang_menangani: item.nama_yang_menangani,
                    status: item.status,
                    created: dayjs(item.createdAt).format('DD/MM/YYYY'),
                    updated: dayjs(item.updatedAt).format('DD/MM/YYYY'),
                }
            })

            const template = fs.readFileSync(
                'src/templates/transaksi/permasalahan-atau-perbaikan.template.html',
                'utf-8'
            )
            const rowsHtml = generateTableRows(tableData)
            const finalHtml = template.replace('{{rows}}', rowsHtml)

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
                'Content-Disposition': 'inline; filename="DataPengaduan.pdf"',
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
            const data = await permasalahan_atau_perbaikan.findAll({
                include: [
                    {
                        model: pos,
                        as: 'pos',
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
            const worksheet = workbook.addWorksheet('Data Kendaraan')

            const dateStr = new Date().toLocaleDateString('id-ID', {
                day: '2-digit',
                month: 'long',
                year: 'numeric',
            })

            const headers = [
                'No.',
                'Judul',
                'Tanggal Masalah',
                'Kategori Masalah',
                'Pos',
                'Alat yang bermasalah',
                'Penyebab',
                'Keterangan Masalah',
                'Pelapor',
                'Status Permasalahan',
                'Tanggal Perbaikan',
                'Jenis Perbaikan',
                'Status Perbaikan',
                'Penanganan',
                'Keterangan Perbaikan',
                'Yang Menangani',
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
                'Data Permasalahan Atau Perbaikan',
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
                    item.judul_permasalahan,
                    item.tanggal_permasalahan,
                    item.kategori_permasalahan,
                    item.pos.keterangan,
                    item.hardware_atau_alat,
                    item.penyebab_permasalahan,
                    item.keterangan_permasalahan,
                    item.nama_pelapor,
                    item.status_permasalahan,
                    item.tanggal_perbaikan,
                    item.jenis_perbaikan,
                    item.status_perbaikan,
                    item.penanganan,
                    item.keterangan_penanganan,
                    item.nama_yang_menangani,
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
                'attachment; filename=DataKendaraan.xlsx'
            )
            await workbook.xlsx.write(res)
            res.end()
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    create: async (req, res) => {
        try {
            const data = await permasalahan_atau_perbaikan.create(req.body)
            return res.json({
                success: true,
                message: 'Create permasalahan atau perbaikan successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    findOneById: async (req, res) => {
        try {
            const data = await permasalahan_atau_perbaikan.findAll({
                where: {
                    id: req.params.id,
                },
            })
            return res.json({
                success: true,
                message: 'Get permasalahan atau perbaikan successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    update: async (req, res) => {
        try {
            const data = await permasalahan_atau_perbaikan.update(req.body, {
                where: {
                    id: req.params.id,
                },
            })
            return res.json({
                success: true,
                message: 'Update permasalahan atau perbaikan successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    delete: async (req, res) => {
        try {
            const data = await permasalahan_atau_perbaikan.destroy({
                where: {
                    id: req.params.id,
                },
            })
            return res.json({
                success: true,
                message: 'Delete permasalahan atau perbaikan successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
}
