const errorhandler = require('../../helpers/errorhandler.helper')
const {
    produk_member,
    user,
    data_member,
    kendaraan,
    tenant,
} = require('../../models/index')
const fs = require('fs')
const puppeteer = require('puppeteer')
const ExcelJS = require('exceljs')
const { literal } = require('sequelize')
const Op = require('sequelize').Op

// Utility to fill the HTML template
function generateTableRows(data) {
    return data
        .map(
            (item) => `
    <tr>
      <td>${item.no}</td>
      <td>${item.nama}</td>
      <td>${item.periode}</td>
      <td>${item.kendaraan}</td>
      <td>${item.max_kendaraan}</td>
      <td>${item.tarif}</td>
      <td>${item.biaya_kartu}</td>
      <td>${item.biaya_ganti_nopol}</td>
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
                'periode',
                'list_id_kendaraan',
                'max_kendaraan',
                'tarif',
                'biaya_kartu',
                'biaya_ganti_nopol',
                'status',
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
                        model: data_member,
                        as: 'data_member',
                        attributes: [
                            'id',
                            'nama',
                            'no_hp',
                            'perusahaan_id',
                            'produk_id',
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
                    { nama: { [Op.iLike]: `%${search}%` } },
                    literal(`CAST("periode" AS TEXT) ILIKE '%${search}%'`),
                    literal(
                        `CAST("list_id_kendaraan" AS TEXT) ILIKE '%${search}%'`
                    ),
                    literal(
                        `CAST("max_kendaraan" AS TEXT) ILIKE '%${search}%'`
                    ),
                    literal(`CAST("tarif" AS TEXT) ILIKE '%${search}%'`),
                    literal(`CAST("biaya_kartu" AS TEXT) ILIKE '%${search}%'`),
                    literal(
                        `CAST("biaya_ganti_nopol" AS TEXT) ILIKE '%${search}%'`
                    ),

                    ...(statusFilter !== null
                        ? [
                              {
                                  status: statusFilter,
                              },
                          ]
                        : []),
                ]
            }

            if (limit) {
                options.limit = limit
                options.offset = offset
            }

            const { count, rows } = await produk_member.findAndCountAll(options)

            return res.json({
                success: true,
                message: 'Get all produk member successfully',
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

            const [produkMembers, kendaraanList] = await Promise.all([
                produk_member.findAll({
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
                }),
                kendaraan.findAll({ attributes: ['id', 'nama_kendaraan'] }),
            ])

            const kendaraanMap = {}
            kendaraanList.forEach((k) => {
                kendaraanMap[k.id] = k.nama_kendaraan
            })

            const tableData = produkMembers.map((item, index) => {
                const periodeStr =
                    item.periode?.length === 2
                        ? `${new Date(item.periode[0].value).toLocaleDateString(
                              'id-ID'
                          )} s/d ${new Date(
                              item.periode[1].value
                          ).toLocaleDateString('id-ID')}`
                        : '-'

                const kendaraanStr = (item.list_id_kendaraan || [])
                    .map((id) => kendaraanMap[id] || `ID ${id}`)
                    .join(', ')

                return {
                    no: index + 1,
                    nama: item.nama,
                    user: item.user?.nama || '-',
                    periode: periodeStr,
                    kendaraan: kendaraanStr,
                    max_kendaraan: item.max_kendaraan,
                    tarif: `Rp${item.tarif.toLocaleString('id-ID')}`,
                    biaya_kartu: `Rp${item.biaya_kartu.toLocaleString(
                        'id-ID'
                    )}`,
                    biaya_ganti_nopol: `Rp${item.biaya_ganti_nopol.toLocaleString(
                        'id-ID'
                    )}`,
                    status: item.status ? 'Aktif' : 'Nonaktif',
                    created: new Date(item.createdAt).toLocaleDateString(
                        'id-ID'
                    ),
                }
            })

            // === Generate HTML Table Rows ===
            const generateTableRows = (rows) => {
                return rows
                    .map((row) => {
                        return `
                    <tr>
                        <td>${row.no}</td>
                        <td>${row.nama}</td>
                        <td>${row.user}</td>
                        <td>${row.periode}</td>
                        <td>${row.kendaraan}</td>
                        <td>${row.max_kendaraan}</td>
                        <td>${row.tarif}</td>
                        <td>${row.biaya_kartu}</td>
                        <td>${row.biaya_ganti_nopol}</td>
                        <td>${row.status}</td>
                        <td>${row.created}</td>
                    </tr>
                    `
                    })
                    .join('')
            }

            const template = fs.readFileSync(
                'src/templates/master-data/produk-member.template.html',
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
                'Content-Disposition':
                    'inline; filename="DataProdukMember.pdf"',
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
            const [produkMembers, kendaraanList] = await Promise.all([
                produk_member.findAll({
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
                }),
                kendaraan.findAll({ attributes: ['id', 'nama_kendaraan'] }),
            ])

            const kendaraanMap = {}
            kendaraanList.forEach((k) => {
                kendaraanMap[k.id] = k.nama_kendaraan
            })

            const workbook = new ExcelJS.Workbook()
            const worksheet = workbook.addWorksheet('Data Produk Member')

            const dateStr = new Date().toLocaleDateString('id-ID', {
                day: '2-digit',
                month: 'long',
                year: 'numeric',
            })

            const headers = [
                'No.',
                'Nama',
                'User',
                'Periode',
                'Daftar Kendaraan',
                'Max Kendaraan',
                'Tarif',
                'Biaya Kartu',
                'Biaya Ganti Nopol',
                'Status',
                'Tanggal Dibuat',
            ]

            const lastColLetter = String.fromCharCode(65 + headers.length - 1)

            const mergeAndStyle = (value, font, rowIdx) => {
                worksheet.mergeCells(`A${rowIdx}:${lastColLetter}${rowIdx}`)
                const cell = worksheet.getCell(`A${rowIdx}`)
                cell.value = value
                cell.alignment = { horizontal: 'center' }
                cell.font = font
            }

            mergeAndStyle('Evolusi Park', { bold: true, size: 12 }, 1)
            mergeAndStyle(
                'Developed by PT. Evosist (Evolusi Sistem)',
                { italic: true, size: 10 },
                2
            )
            mergeAndStyle('Data Produk Member', { bold: true, size: 20 }, 3)
            mergeAndStyle(dateStr, { size: 10 }, 4)

            worksheet.addRow([])

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

            produkMembers.forEach((item, index) => {
                const periodeFormatted =
                    item.periode?.length === 2
                        ? `${new Date(item.periode[0].value).toLocaleDateString(
                              'id-ID'
                          )} s/d ${new Date(
                              item.periode[1].value
                          ).toLocaleDateString('id-ID')}`
                        : '-'

                const kendaraanStr = (item.list_id_kendaraan || [])
                    .map((id) => kendaraanMap[id] || `ID ${id}`)
                    .join(', ')

                const row = worksheet.addRow([
                    index + 1,
                    item.nama,
                    item.user?.nama || '-',
                    periodeFormatted,
                    kendaraanStr,
                    item.max_kendaraan,
                    `Rp${item.tarif.toLocaleString('id-ID')}`,
                    `Rp${item.biaya_kartu.toLocaleString('id-ID')}`,
                    `Rp${item.biaya_ganti_nopol.toLocaleString('id-ID')}`,
                    item.status ? 'Aktif' : 'Nonaktif',
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

            res.setHeader(
                'Content-Type',
                'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
            )
            res.setHeader(
                'Content-Disposition',
                'attachment; filename=DataProdukMember.xlsx'
            )
            await workbook.xlsx.write(res)
            res.end()
        } catch (err) {
            console.error(err)
            return errorhandler(res, err)
        }
    },
    create: async (req, res) => {
        try {
            const data = await produk_member.create(req.body)
            return res.json({
                success: true,
                message: 'Create produk member successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    findOneById: async (req, res) => {
        try {
            const data = await produk_member.findAll({
                include: [
                    {
                        model: user,
                        as: 'user',
                        attributes: ['id', 'nama'],
                    },
                    {
                        model: data_member,
                        as: 'data_member',
                    },
                ],
                where: {
                    id: req.params.id,
                },
            })
            return res.json({
                success: true,
                message: 'Get produk member successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    update: async (req, res) => {
        try {
            const data = await produk_member.update(req.body, {
                where: {
                    id: req.params.id,
                },
            })
            return res.json({
                success: true,
                message: 'Update produk member successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    updateStatus: async (req, res) => {
        try {
            const data = await produk_member.update(
                { status: req.body.status },
                {
                    where: {
                        id: req.params.id,
                    },
                }
            )
            return res.json({
                success: true,
                message: 'Update produk member successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    delete: async (req, res) => {
        try {
            const data = await produk_member.destroy({
                where: {
                    id: req.params.id,
                },
            })
            return res.json({
                success: true,
                message: 'Delete produk member successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
}
