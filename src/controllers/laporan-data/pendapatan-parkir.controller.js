const {
    isValidDDMMYYYY,
    convertDDMMYYYYtoMMDDYYYY,
} = require('../../helpers/dateformat.helper')
const errorhandler = require('../../helpers/errorhandler.helper')
const { sequelize } = require('../../models/index')

module.exports = {
    pendapatanDariCasual: async (req, res) => {
        try {
            let {
                start_date,
                end_date,
                search,
                sortBy = 'tanggal',
                sortOrder = 'desc',
                limit = 10,
                page = 1,
            } = req.query

            const pageSize = parseInt(limit) || 10
            const currentPage = parseInt(page) || 1
            const offset = (currentPage - 1) * pageSize

            const sortableColumns = [
                'tanggal',
                'no_tiket',
                'nomor_polisi',
                'tarif_asli',
                'nama_voucher',
                'potongan_voucher',
                'pembayaran',
            ]
            const orderByColumn = sortableColumns.includes(sortBy)
                ? sortBy
                : 'tanggal'
            const orderDirection =
                sortOrder.toLowerCase() === 'asc' ? 'ASC' : 'DESC'

            let whereClause = `
            WHERE t.id_data_member IS NULL
            AND t.tanggal_keluar IS NOT NULL
            `
            const replacements = {}

            if (start_date) {
                if (!isValidDDMMYYYY(start_date))
                    return errorhandler(res, 'Invalid start_date format')

                start_date = convertDDMMYYYYtoMMDDYYYY(start_date)

                whereClause += ` AND t.tanggal_keluar::date >= :start_date`
                replacements.start_date = start_date
            }
            if (end_date) {
                if (!isValidDDMMYYYY(end_date)) {
                    return errorhandler(res, 'Invalid end_date format')
                }

                end_date = convertDDMMYYYYtoMMDDYYYY(end_date)

                whereClause += ` AND t.tanggal_keluar::date <= :end_date`
                replacements.end_date = end_date
            }
            if (search) {
                whereClause += ` AND (t.no_tiket ILIKE :search OR t.nomor_polisi ILIKE :search)`
                replacements.search = `%${search}%`
            }

            const dataQuery = `
            SELECT
              t.tanggal_keluar::date AS tanggal,
              t.no_tiket,
              t.nomor_polisi,
              t.biaya_parkir AS tarif_asli,
              pv.nama AS nama_voucher,
              dv.diskon AS potongan_voucher,
              p.jenis_payment AS pembayaran
            FROM transaksis t
            LEFT JOIN data_vouchers dv ON dv.id = t.id_data_voucher
            LEFT JOIN produk_vouchers pv ON pv.id = dv.produk_voucher_id
            LEFT JOIN payments p ON p.id = t.jenis_pembayaran_id
            ${whereClause}
            ORDER BY ${orderByColumn} ${orderDirection}
            LIMIT :limit OFFSET :offset
            `

            const countQuery = `
            SELECT COUNT(*) AS total
            FROM transaksis t
            LEFT JOIN data_vouchers dv ON dv.id = t.id_data_voucher
            LEFT JOIN produk_vouchers pv ON pv.id = dv.produk_voucher_id
            LEFT JOIN payments p ON p.id = t.jenis_pembayaran_id
            ${whereClause}
            `

            const replacementsWithPage = {
                ...replacements,
                limit: pageSize,
                offset,
            }

            const rows = await sequelize.query(dataQuery, {
                replacements: replacementsWithPage,
                type: sequelize.QueryTypes.SELECT,
            })

            const countRows = await sequelize.query(countQuery, {
                replacements,
                type: sequelize.QueryTypes.SELECT,
            })

            const totalData = parseInt(countRows.total, 10)
            const totalPages = Math.ceil(totalData / pageSize)

            return res.json({
                success: true,
                message: 'Get all pendapatan parkir casual successfully',
                results: {
                    data: rows,
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
    pendapatanDariMember: async (req, res) => {
        try {
            let {
                start_date,
                end_date,
                search,
                sortBy = 'tanggal',
                sortOrder = 'desc',
                limit = 10,
                page = 1,
            } = req.query

            const pageSize = parseInt(limit) || 10
            const currentPage = parseInt(page) || 1
            const offset = (currentPage - 1) * pageSize

            const sortableColumns = [
                'tanggal',
                'no_tiket',
                'nopol',
                'nama_member',
                'tarif_asli',
                'voucher_id',
                'nama_voucher',
                'potongan_voucher',
                'metode_pembayaran',
            ]
            const orderByColumn = sortableColumns.includes(sortBy)
                ? sortBy
                : 'tanggal'
            const orderDirection =
                sortOrder.toLowerCase() === 'asc' ? 'ASC' : 'DESC'

            let whereClause = `
            WHERE t.id_data_member IS NOT NULL
            `
            const replacements = {}

            if (start_date) {
                if (!isValidDDMMYYYY(start_date)) {
                    return errorhandler(
                        res,
                        400,
                        'Format start_date tidak valid'
                    )
                }

                start_date = convertDDMMYYYYtoMMDDYYYY(start_date)

                whereClause += ` AND t.tanggal_keluar::date >= :start_date`
                replacements.start_date = start_date
            }
            if (end_date) {
                if (!isValidDDMMYYYY(end_date)) {
                    return errorhandler(res, 400, 'Format end_date tidak valid')
                }

                end_date = convertDDMMYYYYtoMMDDYYYY(end_date)

                whereClause += ` AND t.tanggal_keluar::date <= :end_date`
                replacements.end_date = end_date
            }

            if (search) {
                whereClause += ` AND (t.no_tiket ILIKE :search OR t.nomor_polisi ILIKE :search OR m.nama ILIKE :search)`
                replacements.search = `%${search}%`
            }

            const dataQuery = `
            SELECT
              t.tanggal_keluar::date AS tanggal,
              t.no_tiket,
              t.nomor_polisi AS nopol,
              m.nama AS nama_member,
              t.biaya_parkir AS tarif_asli,
              v.id AS voucher_id,
              pr.nama AS nama_voucher,
              v.diskon AS potongan_voucher,
              pay.jenis_payment AS metode_pembayaran
            FROM transaksis t
            JOIN data_members m ON m.id = t.id_data_member
            LEFT JOIN data_vouchers v ON v.id = t.id_data_voucher
            LEFT JOIN produk_vouchers pr ON pr.id = v.produk_voucher_id
            LEFT JOIN tarif_parkirs pv ON pv.kendaraan_id = t.kendaraan_id
            LEFT JOIN payments pay ON pay.id = t.jenis_pembayaran_id
            ${whereClause}
            ORDER BY ${orderByColumn} ${orderDirection}
            LIMIT :limit OFFSET :offset
            `

            const countQuery = `
            SELECT COUNT(*) AS total
            FROM transaksis t
            JOIN data_members m ON m.id = t.id_data_member
            LEFT JOIN data_vouchers v ON v.id = t.id_data_voucher
            LEFT JOIN produk_vouchers pr ON pr.id = v.produk_voucher_id
            LEFT JOIN tarif_parkirs pv ON pv.kendaraan_id = t.kendaraan_id
            LEFT JOIN payments pay ON pay.id = t.jenis_pembayaran_id
            ${whereClause}
            `

            const replacementsWithPage = {
                ...replacements,
                limit: pageSize,
                offset,
            }

            const rows = await sequelize.query(dataQuery, {
                replacements: replacementsWithPage,
                type: sequelize.QueryTypes.SELECT,
            })

            const countRows = await sequelize.query(countQuery, {
                replacements,
                type: sequelize.QueryTypes.SELECT,
            })

            const totalData = parseInt(countRows.total, 10)
            const totalPages = Math.ceil(totalData / pageSize)

            return res.json({
                success: true,
                message: 'Get all pendapatan parkir member successfully',
                results: {
                    data: rows,
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
}
