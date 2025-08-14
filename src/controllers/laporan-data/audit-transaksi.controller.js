const errorhandler = require('../../helpers/errorhandler.helper')
const { sequelize } = require('../../models/index')
const { QueryTypes } = require('sequelize')
const { convertMMDDYYYYtoYYYYMMDD } = require('../../helpers/dateformat.helper')

module.exports = {
    getAllAuditTransaksiKendaraanKeluar: async (req, res) => {
        try {
            const {
                start_date,
                end_date,
                search = '',
                sortBy = 'createdAt',
                sortOrder = 'DESC',
                limit = 10,
                page = 1,
            } = req.query

            const pageSize = parseInt(limit) || 10
            const currentPage = parseInt(page) || 1
            const offset = (currentPage - 1) * pageSize

            const allowedSortFields = [
                'createdAt',
                'no_tiket',
                'nomor_polisi',
                'nama_member',
            ]
            const sortField = allowedSortFields.includes(sortBy)
                ? sortBy
                : 'createdAt'

            const sortDirection =
                sortOrder.toUpperCase() === 'ASC' ? 'ASC' : 'DESC'

            let whereDate = ''
            const replacements = {
                search: `%${search}%`,
                limit: pageSize,
                offset: offset,
            }

            // Validasi format mm-dd-yyyy
            const mmddyyyyRegex = /^\d{2}-\d{2}-\d{4}$/

            if (start_date && end_date) {
                if (
                    !mmddyyyyRegex.test(start_date) ||
                    !mmddyyyyRegex.test(end_date)
                ) {
                    return res.status(400).json({
                        success: false,
                        message: 'Format tanggal harus mm-dd-yyyy',
                    })
                }

                const startSQL = convertMMDDYYYYtoYYYYMMDD(start_date)
                const endSQL = convertMMDDYYYYtoYYYYMMDD(end_date)

                whereDate = ` AND t."createdAt" BETWEEN :startDate AND :endDate `
                replacements.startDate = startSQL
                replacements.endDate = endSQL
            }

            let whereSearch = ''
            if (search) {
                whereSearch = `
                AND (
                    t."no_tiket" ILIKE :search
                    OR t."nomor_polisi" ILIKE :search
                    OR m."nama" ILIKE :search
                )
            `
            }

            const dataQuery = `
            SELECT
                t."createdAt" AS tanggal,
                t."no_tiket",
                t."nomor_polisi" AS nopol,
                m."nama" AS nama_member,
                t."biaya_parkir"::numeric AS tarif_asli,
                pv."nama" AS nama_voucher,
                dv."diskon" AS potongan_voucher,
                (t."biaya_parkir"::numeric - COALESCE(dv."diskon",0)) AS tarif_dibayar,
                p."jenis_payment" AS jenis_pembayaran
            FROM public.transaksis t
            LEFT JOIN public.data_members m ON t."id_data_member" = m."id"
            LEFT JOIN public.data_vouchers dv ON t."id_data_voucher" = dv."id"
            LEFT JOIN public.produk_vouchers pv ON dv."produk_voucher_id" = pv."id"
            LEFT JOIN public.payments p ON t."jenis_pembayaran_id" = p."id"
            WHERE t."createdAt" IS NOT NULL
            ${whereDate}
            ${whereSearch}
            ORDER BY t."${sortField}" ${sortDirection}
            LIMIT :limit OFFSET :offset
        `

            const countQuery = `
            SELECT COUNT(*) AS total
            FROM public.transaksis t
            LEFT JOIN public.data_members m ON t."id_data_member" = m."id"
            LEFT JOIN public.data_vouchers dv ON t."id_data_voucher" = dv."id"
            LEFT JOIN public.produk_vouchers pv ON dv."produk_voucher_id" = pv."id"
            LEFT JOIN public.payments p ON t."jenis_pembayaran_id" = p."id"
            WHERE t."createdAt" IS NOT NULL
            ${whereDate}
            ${whereSearch}
        `

            const [rows, countRows] = await Promise.all([
                sequelize.query(dataQuery, {
                    replacements,
                    type: QueryTypes.SELECT,
                }),
                sequelize.query(countQuery, {
                    replacements,
                    type: QueryTypes.SELECT,
                }),
            ])

            const totalData = parseInt(countRows[0]?.total || 0, 10)
            const totalPages = Math.ceil(totalData / pageSize)

            return res.json({
                success: true,
                message:
                    'Get all audit transaksi kendaraan keluar successfully',
                results: {
                    data: rows,
                    totalData: totalData,
                    totalPages: totalPages,
                    currentPage: currentPage,
                    pageSize: pageSize,
                },
            })
        } catch (error) {
            return errorhandler(res, error)
        }
    },
    getAllAuditTransaksiManual: async (req, res) => {
        try {
            const search = req.query.search || ''
            const sortBy = req.query.sortBy || 'nama_pos'
            const sortOrder =
                req.query.sortOrder &&
                req.query.sortOrder.toUpperCase() === 'DESC'
                    ? 'DESC'
                    : 'ASC'
            const page = parseInt(req.query.page) || 1
            const pageSize = parseInt(req.query.pageSize) || 10
            const start_date = req.query.start_date
            const end_date = req.query.end_date

            const offset = (page - 1) * pageSize

            // Kolom yang diizinkan untuk sort
            const allowedSortFields = {
                nama_pos: 'nama_pos',
                nama_petugas: 'nama_petugas',
                qty_transaksi: 'qty_transaksi',
                total_biaya_parkir: 'total_biaya_parkir',
                total_diskon: 'total_diskon',
                total_biaya_akhir: 'total_biaya_akhir',
            }
            const sortField = allowedSortFields[sortBy] || 'nama_pos'

            let whereSearch = ''
            if (search) {
                whereSearch = `
                AND (
                    p.kode ILIKE :search OR
                    u.nama ILIKE :search
                )
            `
            }

            let whereDate = ''
            const replacements = {
                search: `%${search}%`,
                limit: pageSize,
                offset: offset,
            }

            // Filter tanggal dengan format mm-dd-yyyy
            const mmddyyyyRegex = /^\d{2}-\d{2}-\d{4}$/
            if (start_date && end_date) {
                if (
                    !mmddyyyyRegex.test(start_date) ||
                    !mmddyyyyRegex.test(end_date)
                ) {
                    return res.status(400).json({
                        success: false,
                        message: 'Format tanggal harus mm-dd-yyyy',
                    })
                }
                const startSQL = convertMMDDYYYYtoYYYYMMDD(start_date)
                const endSQL = convertMMDDYYYYtoYYYYMMDD(end_date)
                whereDate = ` AND t."createdAt" BETWEEN :startDate AND :endDate `
                replacements.startDate = startSQL
                replacements.endDate = endSQL
            }

            const baseQuery = `
            FROM transaksis t
            JOIN pos p ON t.pintu_keluar_id = p.id
            JOIN users u ON t.petugas_id = u.id
            LEFT JOIN data_vouchers v ON t.id_data_voucher = v.id
            WHERE t.is_manual = true
            ${whereSearch}
            ${whereDate}
            GROUP BY p.kode, u.nama
            `

            // Hitung total data
            const countQuery = `
            SELECT COUNT(*) as total_count FROM (
                SELECT 1 ${baseQuery}
            ) AS subquery
            `
            const countResult = await sequelize.query(countQuery, {
                replacements,
                type: QueryTypes.SELECT,
            })

            const totalData = parseInt(countResult[0].total_count, 10)
            const totalPages = Math.ceil(totalData / pageSize)

            // Query data
            const dataQuery = `
            SELECT
                p.kode AS nama_pos,
                u.nama AS nama_petugas,
                COUNT(t.id) AS qty_transaksi,
                COALESCE(SUM(CAST(t.biaya_parkir AS numeric)),0) AS total_biaya_parkir,
                COALESCE(SUM(COALESCE(v.diskon,0)),0) AS total_diskon,
                COALESCE(SUM(CAST(t.biaya_parkir AS numeric)) - SUM(COALESCE(v.diskon,0)),0) AS total_biaya_akhir
            ${baseQuery}
            ORDER BY ${sortField} ${sortOrder}
            LIMIT :limit OFFSET :offset
            `
            const data = await sequelize.query(dataQuery, {
                replacements,
                type: QueryTypes.SELECT,
            })

            res.json({
                success: true,
                message: 'Get all audit transaksi manual successfully',
                results: {
                    data: data,
                    totalData: totalData,
                    totalPages: totalPages,
                    currentPage: page,
                    pageSize: pageSize,
                },
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    getAllAuditTransaksiPenggunaanVoucher: async (req, res) => {
        try {
            const {
                start_date,
                end_date,
                search,
                sortBy = 'nama_voucher',
                sortOrder = 'ASC',
                limit = 10,
                page = 1,
            } = req.query

            const whereClauses = []
            const replacements = {}

            // Validasi format tanggal
            const mmddyyyyRegex = /^\d{2}-\d{2}-\d{4}$/
            if (start_date) {
                if (!mmddyyyyRegex.test(start_date)) {
                    return res.status(400).json({
                        success: false,
                        message: 'Format start_date harus mm-dd-yyyy',
                    })
                }
                whereClauses.push(`t."createdAt" >= :start_date`)
                replacements.start_date = convertMMDDYYYYtoYYYYMMDD(start_date)
            }
            if (end_date) {
                if (!mmddyyyyRegex.test(end_date)) {
                    return res.status(400).json({
                        success: false,
                        message: 'Format end_date harus mm-dd-yyyy',
                    })
                }
                whereClauses.push(`t."createdAt" <= :end_date`)
                replacements.end_date = convertMMDDYYYYtoYYYYMMDD(end_date)
            }

            if (search) {
                whereClauses.push(
                    `(pv.nama ILIKE :search OR u.nama ILIKE :search)`
                )
                replacements.search = `%${search}%`
            }

            const whereSQL =
                whereClauses.length > 0
                    ? `WHERE ${whereClauses.join(' AND ')}`
                    : ''

            // Kolom sort yang diizinkan
            const allowedSort = {
                nama_voucher: 'nama_voucher',
                potongan_voucher: 'potongan_voucher',
                nama_petugas_pos: 'nama_petugas_pos',
                quantity_voucher_digunakan: 'quantity_voucher_digunakan',
            }
            const sortColumn = allowedSort[sortBy] || 'nama_voucher'
            const order = sortOrder.toUpperCase() === 'DESC' ? 'DESC' : 'ASC'

            const pageSize = parseInt(limit, 10)
            const currentPage = parseInt(page, 10)
            const offset = (currentPage - 1) * pageSize

            const baseQuery = `
            SELECT
                pv.nama AS nama_voucher,
                pv.diskon AS potongan_voucher,
                u.nama AS nama_petugas_pos,
                COUNT(t.id) AS quantity_voucher_digunakan
            FROM transaksis t
            JOIN data_vouchers dv ON t.id_data_voucher = dv.id
            JOIN produk_vouchers pv ON dv.produk_voucher_id = pv.id
            JOIN users u ON t.petugas_id = u.id
            ${whereSQL}
            GROUP BY pv.nama, pv.diskon, u.nama
            `

            // Hitung total data
            const totalDataResult = await sequelize.query(
                `SELECT COUNT(*) as count FROM (${baseQuery}) AS sub`,
                { replacements, type: QueryTypes.SELECT }
            )
            const totalData = parseInt(totalDataResult[0].count, 10)
            const totalPages = Math.ceil(totalData / pageSize)

            // Query data final
            const finalQuery = `
            ${baseQuery}
            ORDER BY ${sortColumn} ${order}
            LIMIT :limit OFFSET :offset
        `
            const data = await sequelize.query(finalQuery, {
                replacements: { ...replacements, limit: pageSize, offset },
                type: QueryTypes.SELECT,
            })

            res.json({
                success: true,
                message: 'Get all audit penggunaan voucher successfully',
                results: {
                    data,
                    totalData,
                    totalPages,
                    currentPage,
                    pageSize,
                },
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    getAllAuditPembatalanTransaksi: async (req, res) => {
        const { start_date, end_date, search, sortBy, sortOrder, limit, page } =
            req.query

        // Validasi wajib isi tanggal
        if (!start_date || !end_date) {
            return res.status(400).json({
                success: false,
                message: 'start_date dan end_date wajib diisi',
            })
        }

        // Validasi format mm-dd-yyyy
        const mmddyyyyRegex = /^\d{2}-\d{2}-\d{4}$/
        if (!mmddyyyyRegex.test(start_date) || !mmddyyyyRegex.test(end_date)) {
            return res.status(400).json({
                success: false,
                message: 'Format tanggal harus mm-dd-yyyy',
            })
        }

        try {
            // Konversi ke yyyy-mm-dd
            const startSQL = convertMMDDYYYYtoYYYYMMDD(start_date)
            const endSQL = convertMMDDYYYYtoYYYYMMDD(end_date)

            const parsedLimit = limit ? parseInt(limit) : null
            const parsedPage = page ? parseInt(page) : null
            const offset =
                parsedLimit && parsedPage
                    ? (parsedPage - 1) * parsedLimit
                    : null

            // Kolom sort yang diizinkan
            const validSortColumns = {
                pos: 'pos',
                nama_petugas: 'nama_petugas',
                qty_transaksi_dibatalkan: 'qty_transaksi_dibatalkan',
                total_nominal_pembatalan: 'total_nominal_pembatalan',
            }

            const sortField =
                validSortColumns[sortBy] || 'qty_transaksi_dibatalkan'
            const sortDirection =
                sortOrder && sortOrder.toUpperCase() === 'ASC' ? 'ASC' : 'DESC'

            // Query utama
            let query = `
            SELECT
                pos.kode AS "pos",
                u.nama AS "nama_petugas",
                COUNT(t.id) AS "qty_transaksi_dibatalkan",
                SUM(CAST(regexp_replace(t.biaya_parkir, '[^0-9]', '', 'g') AS INTEGER)) AS "total_nominal_pembatalan"
            FROM transaksis t
            LEFT JOIN users u ON t.petugas_id = u.id
            LEFT JOIN pos ON t.pintu_keluar_id = pos.id
            WHERE t.is_active = false
              AND t."createdAt"::date BETWEEN :startDate AND :endDate
            `

            const replacements = {
                startDate: startSQL,
                endDate: endSQL,
            }

            if (search) {
                query += `
              AND (
                  pos.kode ILIKE :search
                  OR u.nama ILIKE :search
              )`
                replacements.search = `%${search}%`
            }

            query += ` GROUP BY pos.kode, u.nama`
            query += ` ORDER BY "${sortField}" ${sortDirection}`

            // Query hitung total data unik (pos + petugas)
            let countQuery = `
            SELECT COUNT(DISTINCT (pos.kode, u.nama)) AS total
            FROM transaksis t
            LEFT JOIN users u ON t.petugas_id = u.id
            LEFT JOIN pos ON t.pintu_keluar_id = pos.id
            WHERE t.is_active = false
              AND t."createdAt"::date BETWEEN :startDate AND :endDate
            `
            if (search) {
                countQuery += `
              AND (
                  pos.kode ILIKE :search
                  OR u.nama ILIKE :search
              )`
            }

            if (parsedLimit !== null && offset !== null) {
                query += ` LIMIT :limit OFFSET :offset`
                replacements.limit = parsedLimit
                replacements.offset = offset
            }

            const [[{ total }]] = await sequelize.query(countQuery, {
                replacements,
                type: QueryTypes.SELECT,
            })

            const [results] = await sequelize.query(query, {
                replacements,
                type: QueryTypes.SELECT,
            })

            return res.json({
                success: true,
                message: 'Get all audit pembatalan transaksi successfully',
                results: {
                    data: results,
                    totalData: parseInt(total),
                    totalPages: parsedLimit
                        ? Math.ceil(total / parsedLimit)
                        : 1,
                    currentPage: parsedPage || 1,
                    pageSize: parsedLimit || parseInt(total),
                },
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
}
