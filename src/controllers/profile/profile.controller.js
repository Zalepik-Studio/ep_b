const errorhandler = require('../../helpers/errorhandler.helper')
const {
    user,
    level_pengguna,
    perusahaan,
    tenant,
} = require('../../models/index')
const argon = require('argon2')
const dayjs = require('dayjs')
const fs = require('fs')
const puppeteer = require('puppeteer')
const ExcelJS = require('exceljs')
const Op = require('sequelize').Op

function generateTableRows(data) {
    return data
        .map(
            (item) => `
    <tr>
      <td>${item.no}</td>
      <td>${item.nama}</td>
      <td>${item.jenis_kelamin}</td>
      <td>${item.no_hp}</td>
      <td>${item.alamat_lengkap}</td>
      <td>${item.level_pengguna?.nama || '-'}</td>
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
                'email',
                'no_hp',
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
                        model: level_pengguna,
                        as: 'level_pengguna',
                        attributes: ['id', 'nama'],
                    },
                    {
                        model: user,
                        as: 'added_by_user',
                        attributes: ['id', 'nama'],
                    },
                    {
                        model: perusahaan,
                        as: 'asal_perusahaan',
                        attributes: ['id', 'nama', 'jenis_perusahaan'],
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
                    { nama: { [Op.iLike]: `%${search}%` } },
                    { jenis_kelamin: { [Op.iLike]: `%${search}%` } },
                    { no_hp: { [Op.iLike]: `%${search}%` } },
                    { alamat_lengkap: { [Op.iLike]: `%${search}%` } },
                    { username: { [Op.iLike]: `%${search}%` } },
                    { '$perusahaan.nama$': { [Op.iLike]: `%${search}%` } },
                    { '$level_pengguna.nama$': { [Op.iLike]: `%${search}%` } },
                ]
            }

            if (limit) {
                options.limit = limit
                options.offset = offset
            }

            const { count, rows } = await user.findAndCountAll(options)

            return res.json({
                success: true,
                message: 'Get all user successfully',
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

            const data = await user.findAll({
                include: [
                    {
                        model: user,
                        as: 'added_by_user',
                        attributes: ['id', 'nama'],
                    },
                    {
                        model: level_pengguna,
                        as: 'level_pengguna',
                        attributes: ['id', 'nama'],
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
                    nama: item.nama,
                    jenis_kelamin: item.jenis_kelamin,
                    no_hp: item.no_hp,
                    alamat_lengkap: item.alamat_lengkap,
                    level: item.level_pengguna?.nama || '-',
                    status: item.status,
                    created: dayjs(item.createdAt).format('DD-MM-YYYY'),
                    updated: dayjs(item.updatedAt).format('DD-MM-YYYY'),
                }
            })

            const template = fs.readFileSync(
                'src/templates/master-data/data-member.template.html',
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
            const data = await user.findAll({
                include: [
                    {
                        model: user,
                        as: 'added_by_user',
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
            const worksheet = workbook.addWorksheet('Data User')

            const dateStr = new Date().toLocaleDateString('id-ID', {
                day: '2-digit',
                month: 'long',
                year: 'numeric',
            })

            const headers = [
                'No.',
                'Nama',
                'Jenis Kelamin',
                'No HP',
                'Alamat Lengkap',
                'Level',
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
                    item.jenis_kelamin,
                    item.no_hp,
                    item.alamat_lengkap,
                    item.level_pengguna?.nama || '-',
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
            const { username, password } = req.body
            const checkUsername = await user.findOne({
                where: {
                    username: username,
                },
            })
            if (checkUsername) {
                throw Error('auth_duplicate_username')
            }

            const hashedPassword = await argon.hash(password)

            const data = {
                ...req.body,
                password: hashedPassword,
            }

            const users = await user.create(data)

            return res.json({
                success: true,
                message: 'Create user successfully',
                results: { data: users },
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    findOneById: async (req, res) => {
        try {
            const data = await user.findAll({
                include: [
                    {
                        model: level_pengguna,
                        as: 'level_pengguna',
                        attributes: ['id', 'nama'],
                    },
                    {
                        model: user,
                        as: 'added_by_user',
                        attributes: ['id', 'nama'],
                    },
                ],
                where: {
                    id: req.params.id,
                },
            })
            return res.json({
                success: true,
                message: 'Get user successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    update: async (req, res) => {
        try {
            const { password } = req.body

            let data = {}

            if (password) {
                const hashedPassword = await argon.hash(password)
                data = { ...req.body, password: hashedPassword }
            } else {
                data = { ...req.body }
            }

            const users = await user.update(
                { ...data },
                {
                    where: {
                        id: req.params.id,
                    },
                }
            )

            return res.json({
                success: true,
                message: 'Update user successfully',
                results: { data: users },
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    delete: async (req, res) => {
        try {
            const data = await user.destroy({
                where: {
                    id: req.params.id,
                },
            })
            return res.json({
                success: true,
                message: 'Delete user successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
}
