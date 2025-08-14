const errorhandler = require('../../helpers/errorhandler.helper')
const { global_setting, tenant } = require('../../models/index')
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
      <td>${item.nama_operator}</td>
      <td>${item.email_operator}</td>
      <td>${item.no_telp_operator}</td>
      <td>${item.no_fax_operator}</td>
      <td>${item.alamat_operator}</td>
      <td>${item.nama_lokasi}</td>
      <td>${item.email_lokasi}</td>
      <td>${item.no_telp_lokasi}</td>
      <td>${item.no_fax_lokasi}</td>
      <td>${item.alamat_lokasi}</td>
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
                'nama_operator',
                'email_operator',
                'no_telp_operator',
                'no_fax_operator',
                'alamat_operator',
                'nama_lokasi',
                'email_lokasi',
                'no_telp_lokasi',
                'no_fax_lokasi',
                'alamat_lokasi',
                'value',
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
                    { nama_operator: { [Op.iLike]: `%${search}%` } },
                    { email_operator: { [Op.iLike]: `%${search}%` } },
                    { no_telp_operator: { [Op.iLike]: `%${search}%` } },
                    { no_fax_operator: { [Op.iLike]: `%${search}%` } },
                    { alamat_operator: { [Op.iLike]: `%${search}%` } },
                    { nama_lokasi: { [Op.iLike]: `%${search}%` } },
                    { email_lokasi: { [Op.iLike]: `%${search}%` } },
                    { no_telp_lokasi: { [Op.iLike]: `%${search}%` } },
                    { no_fax_lokasi: { [Op.iLike]: `%${search}%` } },
                    { alamat_lokasi: { [Op.iLike]: `%${search}%` } },
                ]
            }

            if (limit) {
                options.limit = limit
                options.offset = offset
            }

            const { count, rows } = await global_setting.findAndCountAll(
                options
            )

            return res.json({
                success: true,
                message: 'Get all global setting successfully',
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

            const data = await global_setting.findAll({
                where: {
                    createdAt: {
                        [Op.between]: [startDate, endDate],
                    },
                },
            })

            const tableData = data.map((item, index) => ({
                no: index + 1,
                nama_operator: item.nama_operator,
                email_operator: item.email_operator,
                no_telp_operator: item.no_telp_operator,
                no_fax_operator: item.no_fax_operator,
                alamat_operator: item.alamat_operator,
                nama_lokasi: item.nama_lokasi,
                email_lokasi: item.email_lokasi,
                no_telp_lokasi: item.no_telp_lokasi,
                no_fax_lokasi: item.no_fax_lokasi,
                alamat_lokasi: item.alamat_lokasi,
                created: dayjs(item.createdAt).format('DD-MM-YYYY'),
                updated: dayjs(item.updatedAt).format('DD-MM-YYYY'),
            }))

            const template = fs.readFileSync(
                'src/templates/setting/global-settings.template.html',
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
            const data = await global_setting.findAll({
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
            const worksheet = workbook.addWorksheet('Data Global Settings')

            const dateStr = new Date().toLocaleDateString('id-ID', {
                day: '2-digit',
                month: 'long',
                year: 'numeric',
            })

            const headers = [
                'No.',
                'Nama Operator',
                'Email Operator',
                'No Telp Operator',
                'No Fax Operator',
                'Alamat Operator',
                'Nama Lokasi',
                'Email Lokasi',
                'No Telp Lokasi',
                'No Fax Lokasi',
                'Alamat Lokasi',
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
                    item.nama_operator,
                    item.email_operator,
                    item.no_telp_operator,
                    item.no_fax_operator,
                    item.alamat_operator,
                    item.nama_lokasi,
                    item.email_lokasi,
                    item.no_telp_lokasi,
                    item.no_fax_lokasi,
                    item.alamat_lokasi,

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
                'attachment; filename=DataGlobalSettings.xlsx'
            )
            await workbook.xlsx.write(res)
            res.end()
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    create: async (req, res) => {
        try {
            const data = await global_setting.create(req.body)
            return res.json({
                success: true,
                message: 'Create global setting successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    findOneById: async (req, res) => {
        try {
            const data = await global_setting.findAll({
                where: {
                    id: req.params.id,
                },
            })
            return res.json({
                success: true,
                message: 'Get global setting successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    update: async (req, res) => {
        try {
            const data = await global_setting.update(req.body, {
                where: {
                    id: req.params.id,
                },
            })
            return res.json({
                success: true,
                message: 'Update global setting successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    delete: async (req, res) => {
        try {
            const data = await global_setting.destroy({
                where: {
                    id: req.params.id,
                },
            })
            return res.json({
                success: true,
                message: 'Delete global setting successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
}
