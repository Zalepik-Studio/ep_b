const errorhandler = require('../../helpers/errorhandler.helper')
const { sequelize } = require('../../models/index')

module.exports = {
    getAll: async (req, res) => {
        const { start_date, end_date, search, sortBy, sortOrder, limit, page } =
            req.query

        if (!start_date || !end_date) {
            return res
                .status(400)
                .json({ message: 'start_date dan end_date wajib diisi' })
        }

        try {
            const parsedLimit = limit ? parseInt(limit) : null
            const parsedPage = page ? parseInt(page) : null
            const offset =
                parsedLimit && parsedPage
                    ? (parsedPage - 1) * parsedLimit
                    : null

            const validSortBy = sortBy || 'tanggal_keluar'
            const validSortOrder =
                sortOrder && ['asc', 'desc'].includes(sortOrder.toLowerCase())
                    ? sortOrder.toLowerCase()
                    : 'desc'

            let query = `
            SELECT
                tm.no_tiket_atau_tiket_manual AS "no_tiket",
                TO_CHAR(tm.tanggal_keluar, 'YYYY-MM-DD HH24:MI') AS "tanggal_keluar",
                pos_out.kode AS "pintu_keluar",
                tm.nomor_polisi AS "nopol",
                k.nama_kendaraan AS "kendaraan",
                tm."interval" AS "interval",
                tm.parkir AS "tarif",
                (tm.jumlah_denda_tiket + tm.jumlah_denda_stnk) AS "denda",
                COALESCE(td.tipe_denda, 'Tidak Ada') AS "tipe_denda",
                pay.jenis_payment AS "pembayaran",
                CASE
                    WHEN pay.jenis_payment ILIKE '%QRIS%' THEN 'GoPay'
                    WHEN pay.jenis_payment ILIKE '%VA%' THEN 'Mandiri VA'
                    WHEN pay.jenis_payment ILIKE '%Wallet%' THEN 'OVO'
                    ELSE 'Credit Card'
                END AS "channel",
                '-' AS "VA_QR",
                u.nama AS "petugas",
                s.nama_shift AS "shift",
                CONCAT('mtd-', tm.id) AS "transaction_id",
                CONCAT('ORD-', tm.id) AS "order_id",
                TO_CHAR(tm.tanggal_keluar, 'YYYY-MM-DD HH24:MI') AS "transaction_time",
                TO_CHAR(tm.tanggal_keluar + INTERVAL '3 days', 'YYYY-MM-DD') AS "settlement_time",
                CASE
                    WHEN tm.is_active = true THEN 'Settled'
                    WHEN tm.is_active = false AND tm.denda = true THEN 'Gagal'
                    ELSE 'Pending'
                END AS "settlement_status",
                CONCAT('st_', TO_CHAR(tm.tanggal_keluar, 'YYYYMMDD'), '.csv') AS "file_settlement"
            FROM transaksi_manuals tm
            LEFT JOIN pos pos_out ON tm.pintu_keluar_id = pos_out.id
            LEFT JOIN kendaraans k ON tm.kendaraan_id = k.id
            LEFT JOIN tipe_dendas td ON tm.tipe_denda_id = td.id
            LEFT JOIN payments pay ON tm.jenis_pembayaran_id = pay.id
            LEFT JOIN users u ON tm.petugas_id = u.id
            LEFT JOIN shifts s ON tm.shift_id = s.id
            WHERE tm.tanggal_keluar::date BETWEEN :startDate AND :endDate
            `

            const replacements = {
                startDate: start_date,
                endDate: end_date,
            }

            if (search) {
                query += `
                AND (
                    tm.no_tiket_atau_tiket_manual ILIKE :search
                    OR tm.nomor_polisi ILIKE :search
                    OR k.nama_kendaraan ILIKE :search
                    OR pos_out.kode ILIKE :search
                    OR pay.jenis_payment ILIKE :search
                    OR u.nama ILIKE :search
                    OR s.nama_shift ILIKE :search
                    OR td.tipe_denda ILIKE :search
                )
            `
                replacements.search = `%${search}%`
            }

            const validSortColumns = {
                no_tiket: 'tm.no_tiket_atau_tiket_manual',
                tanggal_keluar: 'tm.tanggal_keluar',
                pintu_keluar: 'pos_out.kode',
                nopol: 'tm.nomor_polisi',
                kendaraan: 'k.nama_kendaraan',
                interval: 'tm.interval',
                tarif: 'tm.parkir',
                denda: 'denda',
                tipe_denda: 'td.tipe_denda',
                pembayaran: 'pay.jenis_payment',
                channel: 'channel',
                VA_QR: 'VA_QR',
                petugas: 'u.nama',
                shift: 's.nama_shift',
                transaction_id: 'transaction_id',
                order_id: 'order_id',
                transaction_time: 'tm.tanggal_keluar',
                settlement_time: 'settlement_time',
                settlement_status: 'settlement_status',
                file_settlement: 'file_settlement',
            }

            const orderByColumn =
                validSortColumns[sortBy] || validSortColumns.tanggal_keluar
            query += ` ORDER BY ${orderByColumn} ${validSortOrder}`

            let countQuery = `
            SELECT COUNT(*) AS total
            FROM transaksi_manuals tm
            LEFT JOIN pos pos_out ON tm.pintu_keluar_id = pos_out.id
            LEFT JOIN kendaraans k ON tm.kendaraan_id = k.id
            LEFT JOIN tipe_dendas td ON tm.tipe_denda_id = td.id
            LEFT JOIN payments pay ON tm.jenis_pembayaran_id = pay.id
            LEFT JOIN users u ON tm.petugas_id = u.id
            LEFT JOIN shifts s ON tm.shift_id = s.id
            WHERE tm.tanggal_keluar::date BETWEEN :startDate AND :endDate
          `

            if (search) {
                countQuery += `
                AND (
                    tm.no_tiket_atau_tiket_manual ILIKE :search
                    OR tm.nomor_polisi ILIKE :search
                    OR k.nama_kendaraan ILIKE :search
                    OR pos_out.kode ILIKE :search
                    OR pay.jenis_payment ILIKE :search
                    OR u.nama ILIKE :search
                    OR s.nama_shift ILIKE :search
                    OR td.tipe_denda ILIKE :search
                )
            `
            }

            if (parsedLimit !== null && offset !== null) {
                query += ` LIMIT :limit OFFSET :offset`
                replacements.limit = parsedLimit
                replacements.offset = offset
            }

            const [[{ total }]] = await sequelize.query(countQuery, {
                replacements,
            })

            const [results] = await sequelize.query(query, {
                replacements,
            })

            return res.json({
                success: true,
                message: 'Get all settlement cashless successfully',
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
