const {
    isValidDDMMYYYY,
    convertDDMMYYYYtoMMDDYYYY,
} = require('../../helpers/dateformat.helper')
const errorhandler = require('../../helpers/errorhandler.helper')
const { sequelize } = require('../../models/index')
const { QueryTypes } = require('sequelize')

module.exports = {
    getAllDataKendaraanIn: async (req, res) => {
        try {
            let {
                start_date,
                end_date,
                search,
                sortBy = 'createdAt',
                sortOrder = 'desc',
                limit = 10,
                page = 1,
            } = req.query

            limit = parseInt(limit)
            page = parseInt(page)
            const offset = (page - 1) * limit

            // validasi kolom sort
            const allowedSort = [
                'createdAt',
                'tiket',
                'plat_nomor',
                'kendaraan_id',
            ]
            if (!allowedSort.includes(sortBy)) {
                sortBy = 'createdAt'
            }
            sortOrder = sortOrder.toLowerCase() === 'asc' ? 'ASC' : 'DESC'

            // WHERE clause dinamis
            const conditions = [`agk.tipe_gerbang = 'In'`]
            const replacements = {}

            if (start_date) {
                if (!isValidDDMMYYYY(start_date)) {
                    return errorhandler(res, 'Invalid start date format', 400)
                }
                start_date = convertDDMMYYYYtoMMDDYYYY(start_date)
                conditions.push(`agk."createdAt" >= :start_date`)
                replacements.start_date = start_date
            }
            // if (end_date) {
            //     conditions.push(`agk."createdAt" <= :end_date`)
            //     replacements.end_date = end_date
            // }
            if (end_date) {
                if (!isValidDDMMYYYY(end_date)) {
                    return errorhandler(res, 'Invalid end date format', 400)
                }
                end_date = convertDDMMYYYYtoMMDDYYYY(end_date)
                conditions.push(
                    `agk."createdAt" < (:end_date::date + INTERVAL '1 day')`
                )
                replacements.end_date = end_date
            }

            if (search) {
                conditions.push(
                    `(agk.tiket ILIKE :search OR agk.plat_nomor ILIKE :search)`
                )
                replacements.search = `%${search}%`
            }

            // hanya tiket yang belum keluar
            conditions.push(`
            agk.tiket NOT IN (
              SELECT tiket FROM aktivitas_gerbang_kendaraans WHERE tipe_gerbang = 'Out'
            )
            `)

            const whereSql = conditions.length
                ? `WHERE ${conditions.join(' AND ')}`
                : ''

            // query data
            const dataQuery = `
            SELECT DISTINCT ON (agk.tiket)
              agk.tiket AS nomor_tiket,
              agk."createdAt" AS tanggal_masuk,
              agk.plat_nomor AS nomor_polisi,
              agk.kendaraan_id,
              dk.nama_kendaraan,
              agk.lokasi_gerbang,
              agk.buka_atau_tutup,
              NOW() - agk."createdAt" AS durasi,
              dm.id AS id_member,
              dm.nama AS nama_member,
              jsonb_build_object(
                'id', dm.id,
                'nama', dm.nama,
                'no_hp', dm.no_hp,
                'perusahaan_id', dm.perusahaan_id,
                'akses_tiket', dm.akses_tiket,
                'akses_kartu', dm.akses_kartu,
                'no_kartu', dm.no_kartu,
                'tgl_input', dm.tgl_input,
                'produk_id', dm.produk_id,
                'tarif', dm.tarif,
                'biaya_member', dm.biaya_member,
                'biaya_kartu', dm.biaya_kartu,
                'periode', dm.periode,
                'user_id', dm.user_id,
                'createdAt', dm."createdAt",
                'updatedAt', dm."updatedAt",
                'nama_perusahaan', p.nama,
                'nama_produk', pm.nama
              ) AS data_member

            FROM aktivitas_gerbang_kendaraans agk
            LEFT JOIN data_nomor_polisis dnp ON agk.kendaraan_id = dnp.kendaraan_id
            LEFT JOIN data_members dm ON dnp.data_member_id = dm.id
            LEFT JOIN kendaraans dk ON agk.kendaraan_id = dk.id
            LEFT JOIN perusahaans p ON dm.perusahaan_id = p.id
            LEFT JOIN produk_members pm ON dm.produk_id = pm.id
            ${whereSql}
            ORDER BY  agk.tiket, agk."${sortBy}" ${sortOrder}
            LIMIT :limit OFFSET :offset
            `

            // query total
            const countQuery = `
            SELECT COUNT(*) AS total FROM (
              SELECT DISTINCT ON (tiket)
                tiket
              FROM aktivitas_gerbang_kendaraans
              WHERE tipe_gerbang = 'In'
              ${start_date ? 'AND "createdAt" >= :start_date' : ''}
              ${
                  end_date
                      ? 'AND "createdAt" < (:end_date::date + INTERVAL \'1 day\')'
                      : ''
              }
              ${
                  search
                      ? 'AND (tiket ILIKE :search OR plat_nomor ILIKE :search)'
                      : ''
              }
              AND tiket NOT IN (
                SELECT tiket FROM aktivitas_gerbang_kendaraans WHERE tipe_gerbang = 'Out'
              )
              ORDER BY tiket, "createdAt" DESC
            ) AS subquery
            `

            //========================Settingan End Date Lama==============
            // const countQuery = `
            // SELECT COUNT(*) AS total FROM (
            //   SELECT DISTINCT ON (tiket)
            //     tiket
            //   FROM aktivitas_gerbang_kendaraans
            //   WHERE tipe_gerbang = 'In'
            //   ${start_date ? 'AND "createdAt" >= :start_date' : ''}
            //   ${end_date ? 'AND "createdAt" <= :end_date' : ''}
            //   ${search ? 'AND (tiket ILIKE :search OR plat_nomor ILIKE :search)' : ''}
            //   AND tiket NOT IN (
            //     SELECT tiket FROM aktivitas_gerbang_kendaraans WHERE tipe_gerbang = 'Out'
            //   )
            //   ORDER BY tiket, "createdAt" DESC
            // ) AS subquery
            // `

            //========================Tanpa Distinc========================
            // const countQuery = `
            // SELECT COUNT(*) AS total
            // FROM aktivitas_gerbang_kendaraans agk
            // LEFT JOIN data_nomor_polisis dnp ON agk.kendaraan_id = dnp.kendaraan_id
            // LEFT JOIN data_members dm ON dnp.data_member_id = dm.id
            // ${whereSql}
            // `

            replacements.limit = limit
            replacements.offset = offset

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

            const totalData = parseInt(countRows[0].total, 10)
            const totalPages = Math.ceil(totalData / limit)

            res.json({
                success: true,
                message: 'Get all kendaraan in successfully',
                results: {
                    data: rows,
                    totalData: totalData,
                    totalPages: totalPages,
                    currentPage: page,
                    pageSize: limit,
                },
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    getAllDataKendaraanOut: async (req, res) => {
        try {
            let {
                start_date,
                end_date,
                search,
                sortBy = 'tanggal_masuk',
                sortOrder = 'desc',
                limit = 10,
                page = 1,
            } = req.query

            // konversi ke angka
            limit = parseInt(limit)
            page = parseInt(page)
            const offset = (page - 1) * limit

            // validasi sortBy
            const allowedSort = [
                'tanggal_masuk',
                'nomor_tiket',
                'nomor_polisi',
                'kendaraan_id',
            ]
            if (!allowedSort.includes(sortBy)) {
                sortBy = 'tanggal_masuk'
            }

            sortOrder = sortOrder.toLowerCase() === 'asc' ? 'ASC' : 'DESC'

            const conditions = []
            const replacements = {}

            if (start_date) {
                if (!isValidDDMMYYYY(start_date)) {
                    return errorhandler(res, 'Invalid start_date format')
                }
                start_date = convertDDMMYYYYtoMMDDYYYY(start_date)
                conditions.push(`masuk."createdAt" >= :start_date`)
                replacements.start_date = start_date
            }
            if (end_date) {
                if (!isValidDDMMYYYY(end_date)) {
                    return errorhandler(res, 'Invalid end_date format')
                }
                end_date = convertDDMMYYYYtoMMDDYYYY(end_date)
                // conditions.push(`keluar."createdAt" <= :end_date`)
                conditions.push(
                    `keluar."createdAt" < (:end_date::date + INTERVAL '1 day')`
                )
                replacements.end_date = end_date
            }
            if (search) {
                conditions.push(`(
                masuk.tiket ILIKE :search
                OR masuk.plat_nomor ILIKE :search
                )`)
                replacements.search = `%${search}%`
            }

            const whereSql = conditions.length
                ? `WHERE ${conditions.join(' AND ')}`
                : ''

            const dataQuery = `
            SELECT
              masuk.tiket AS nomor_tiket,
              masuk."createdAt" AS tanggal_masuk,
              keluar."createdAt" AS tanggal_keluar,
              masuk.plat_nomor AS nomor_polisi,
              masuk.kendaraan_id,
              dk.nama_kendaraan,
              masuk.lokasi_gerbang AS lokasi_gerbang_masuk,
              keluar.lokasi_gerbang AS lokasi_gerbang,
              keluar.buka_atau_tutup AS buka_atau_tutup,
              u.nama AS nama_petugas,
              keluar."createdAt" - masuk."createdAt" AS durasi,
              t.biaya_parkir,
              t.jumlah_denda_stnk,
              t.jumlah_denda_tiket,
              t.jenis_pembayaran_id,
              pay.jenis_payment AS nama_jenis_pembayaran,
              t.id_data_member,
              jsonb_build_object(
                'id', t.id,
                'tanggal_masuk', t.tanggal_masuk,
                'pintu_masuk_id', t.pintu_masuk_id,
                'no_tiket', t.no_tiket,
                'is_manual', t.is_manual,
                'kendaraan_id', t.kendaraan_id,
                'nomor_polisi', t.nomor_polisi,
                'pintu_keluar_id', t.pintu_keluar_id,
                'tanggal_keluar', t.tanggal_keluar,
                'petugas_id', t.petugas_id,
                'shift_id', t.shift_id,
                'denda', t.denda,
                'tipe_denda_id', t.tipe_denda_id,
                'is_active', t.is_active,
                'jenis_pembayaran_id', t.jenis_pembayaran_id,
                'biaya_parkir', t.biaya_parkir,
                'id_data_voucher', t.id_data_voucher,
                'jumlah_denda_stnk', t.jumlah_denda_stnk,
                'jumlah_denda_tiket', t.jumlah_denda_tiket,
                'interval', t.interval,
                'keterangan_atau_penjelasan', t.keterangan_atau_penjelasan,
                'id_data_member', t.id_data_member,
                'createdAt', t."createdAt",
                'updatedAt', t."updatedAt"
              ) AS data_transaksi,
              dm.id AS id_member,
              dm.nama AS nama_member,
              jsonb_build_object(
                'id', dm.id,
                'nama', dm.nama,
                'no_hp', dm.no_hp,
                'perusahaan_id', dm.perusahaan_id,
                'akses_tiket', dm.akses_tiket,
                'akses_kartu', dm.akses_kartu,
                'no_kartu', dm.no_kartu,
                'tgl_input', dm.tgl_input,
                'produk_id', dm.produk_id,
                'tarif', dm.tarif,
                'biaya_member', dm.biaya_member,
                'biaya_kartu', dm.biaya_kartu,
                'periode', dm.periode,
                'user_id', dm.user_id,
                'createdAt', dm."createdAt",
                'updatedAt', dm."updatedAt",
                'nama_perusahaan', p.nama,
                'nama_produk', pm.nama
              ) AS data_member

            FROM (
              SELECT DISTINCT ON (tiket) *
              FROM aktivitas_gerbang_kendaraans
              WHERE tipe_gerbang = 'In'
              ORDER BY tiket, "createdAt" DESC
            ) masuk
            JOIN (
              SELECT DISTINCT ON (tiket) *
              FROM aktivitas_gerbang_kendaraans
              WHERE tipe_gerbang = 'Out'
              ORDER BY tiket, "createdAt" DESC
            ) keluar ON masuk.tiket = keluar.tiket

            LEFT JOIN (
              SELECT DISTINCT ON (no_tiket) *
              FROM transaksis
              WHERE is_active = true
              ORDER BY
                no_tiket,
                CASE
                  WHEN (biaya_parkir IS NOT NULL AND biaya_parkir::numeric > 0)
                    OR (jumlah_denda_stnk IS NOT NULL AND jumlah_denda_stnk::numeric > 0)
                    OR (jumlah_denda_tiket IS NOT NULL AND jumlah_denda_tiket::numeric > 0)
                  THEN 0
                  ELSE 1
                END,
                "createdAt" DESC
            ) t ON t.no_tiket = masuk.tiket

            LEFT JOIN data_nomor_polisis dnp ON masuk.kendaraan_id = dnp.kendaraan_id
            LEFT JOIN data_members dm ON t.id_data_member = dm.id
            LEFT JOIN kendaraans dk ON masuk.kendaraan_id = dk.id
            LEFT JOIN perusahaans p ON dm.perusahaan_id = p.id
            LEFT JOIN produk_members pm ON dm.produk_id = pm.id
            LEFT JOIN users u ON t.petugas_id = u.id
            LEFT JOIN payments pay ON t.jenis_pembayaran_id = pay.id
            ${whereSql}
            ORDER BY "${sortBy}" ${sortOrder}
            LIMIT :limit OFFSET :offset
            `

            // query total
            const countQuery = `
              SELECT COUNT(*) AS total
              FROM (
                SELECT masuk.tiket
                FROM (
                  SELECT DISTINCT ON (tiket) *
                  FROM aktivitas_gerbang_kendaraans
                  WHERE tipe_gerbang = 'In'
                  ORDER BY tiket, "createdAt" DESC
                ) masuk
                JOIN (
                  SELECT DISTINCT ON (tiket) *
                  FROM aktivitas_gerbang_kendaraans
                  WHERE tipe_gerbang = 'Out'
                  ORDER BY tiket, "createdAt" DESC
                ) keluar
                  ON masuk.tiket = keluar.tiket
                 AND keluar."createdAt" > masuk."createdAt"
                LEFT JOIN data_nomor_polisis dnp
                  ON masuk.kendaraan_id = dnp.kendaraan_id
                LEFT JOIN data_members dm
                  ON dnp.data_member_id = dm.id
                ${whereSql}
              ) AS subquery
            `

            // const countQuery = `
            // SELECT COUNT(*) AS total
            // FROM (
            //   SELECT masuk.tiket
            //   FROM aktivitas_gerbang_kendaraans masuk
            //   JOIN aktivitas_gerbang_kendaraans keluar
            //     ON masuk.tiket = keluar.tiket
            //    AND masuk.tipe_gerbang = 'In'
            //    AND keluar.tipe_gerbang = 'Out'
            //   LEFT JOIN data_nomor_polisis dnp
            //     ON masuk.kendaraan_id = dnp.kendaraan_id
            //   LEFT JOIN data_members dm
            //     ON dnp.data_member_id = dm.id
            //   ${whereSql}
            //   GROUP BY masuk.tiket, masuk."createdAt", masuk.plat_nomor, masuk.kendaraan_id,
            //            keluar.lokasi_gerbang, keluar.buka_atau_tutup, keluar."createdAt", dm.id
            // ) AS subquery
            // `

            replacements.limit = limit
            replacements.offset = offset

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

            const totalData = parseInt(countRows[0].total, 10)
            const totalPages = Math.ceil(totalData / limit)

            res.json({
                success: true,
                message: 'Get all kendaraan keluar successfully',
                results: {
                    data: rows,
                    totalData,
                    totalPages,
                    currentPage: page,
                    pageSize: limit,
                },
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
}
