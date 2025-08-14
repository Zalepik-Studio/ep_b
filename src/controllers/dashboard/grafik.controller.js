const { sequelize } = require('../../models/index')
const { QueryTypes } = require('sequelize')
const errorhandler = require('../../helpers/errorhandler.helper')

module.exports = {
    getAllOvernight: async (req, res) => {
        try {
            const rawQuery = `
                WITH gerbang_event AS (
                  SELECT
                    plat_nomor,
                    tipe_gerbang,
                    DATE("createdAt") AS tanggal,
                    "createdAt"
                  FROM aktivitas_gerbang_kendaraans
                  WHERE status_palang = 'Sukses'
                ),
                masuk AS (
                  SELECT plat_nomor, MIN("createdAt") AS masuk_time
                  FROM gerbang_event
                  WHERE tipe_gerbang = 'In'
                  GROUP BY plat_nomor
                ),
                keluar AS (
                  SELECT plat_nomor, MAX("createdAt") AS keluar_time
                  FROM gerbang_event
                  WHERE tipe_gerbang = 'Out'
                  GROUP BY plat_nomor
                ),
                combined AS (
                  SELECT
                    m.plat_nomor,
                    m.masuk_time,
                    k.keluar_time
                  FROM masuk m
                  LEFT JOIN keluar k ON m.plat_nomor = k.plat_nomor
                ),
                date_series AS (
                  SELECT DATE(generate_series(
                    CURRENT_DATE - INTERVAL '29 days',
                    CURRENT_DATE,
                    INTERVAL '1 day'
                  )) AS tanggal
                )
                SELECT
                  d.tanggal,
                  COUNT(c.plat_nomor) AS nilai
                FROM date_series d
                LEFT JOIN combined c
                  ON DATE(c.masuk_time) <= d.tanggal
                     AND (c.keluar_time IS NULL OR DATE(c.keluar_time) > d.tanggal)
                GROUP BY d.tanggal
                ORDER BY d.tanggal ASC;
            `

            const data = await sequelize.query(rawQuery, {
                type: QueryTypes.SELECT,
            })

            // Tambahkan ID manual
            const formattedData = data.map((item, index) => ({
                id: index + 1,
                tanggal: item.tanggal,
                nilai: parseInt(item.nilai),
            }))

            return res.status(200).json({
                success: true,
                message: 'Get all overnight data successfully',
                results: {
                    data: formattedData,
                    totalData: formattedData.length,
                },
            })
        } catch (error) {
            return errorhandler(res, error)
        }
    },
    getOvernightYangSudahKeluar: async (req, res) => {
    try {
      const rawQuery = `
        WITH gerbang_event AS (
          SELECT
            plat_nomor,
            tipe_gerbang,
            "createdAt"
          FROM aktivitas_gerbang_kendaraans
          WHERE status_palang = 'Sukses'
        ),
        masuk AS (
          SELECT plat_nomor, MIN("createdAt") AS masuk_time
          FROM gerbang_event
          WHERE tipe_gerbang = 'In'
          GROUP BY plat_nomor
        ),
        keluar AS (
          SELECT plat_nomor, MAX("createdAt") AS keluar_time
          FROM gerbang_event
          WHERE tipe_gerbang = 'Out'
          GROUP BY plat_nomor
        ),
        combined AS (
          SELECT
            m.plat_nomor,
            m.masuk_time,
            k.keluar_time,
            DATE(k.keluar_time) AS tanggal_keluar,
            DATE_PART('day', k.keluar_time - m.masuk_time) AS durasi_hari
          FROM masuk m
          JOIN keluar k ON m.plat_nomor = k.plat_nomor
        ),
        date_series AS (
          SELECT generate_series(
            CURRENT_DATE - INTERVAL '29 days',
            CURRENT_DATE,
            INTERVAL '1 day'
          )::date AS tanggal
        )
        SELECT
          ds.tanggal,
          COUNT(c.plat_nomor) AS nilai
        FROM date_series ds
        LEFT JOIN combined c
          ON DATE(c.keluar_time) = ds.tanggal
          AND c.durasi_hari >= 1
        GROUP BY ds.tanggal
        ORDER BY ds.tanggal ASC;
      `;

      const data = await sequelize.query(rawQuery, {
        type: QueryTypes.SELECT,
      });

      const formattedData = data.map((item, index) => ({
        id: index + 1,
        tanggal: item.tanggal,
        nilai: parseInt(item.nilai) || 0,
      }));

      return res.status(200).json({
        success: true,
        message: 'Get all overnight data successfully',
        results: {
          data: formattedData,
          totalData: formattedData.length,
        },
      });
    } catch (error) {
      return errorhandler(res, error);
    }
  },

    getKendaraanChartData: async (req, res) => {
        try {
            const rawQuery = `
            WITH date_series AS (
                SELECT generate_series(
                    CURRENT_DATE - INTERVAL '29 days',
                    CURRENT_DATE,
                    INTERVAL '1 day'
                )::date AS tanggal
            ),
            kendaraan_harian AS (
                SELECT
                    DATE_TRUNC('day', agk."createdAt")::DATE AS tanggal,
                    tk.tipe_kendaraan,
                    COUNT(*) AS jumlah
                FROM aktivitas_gerbang_kendaraans agk
                JOIN kendaraans k ON k.id = agk.kendaraan_id
                JOIN tipe_kendaraans tk ON tk.id = k.tipe_kendaraan_id
                WHERE agk."createdAt" >= NOW() - INTERVAL '30 days'
                AND agk.tipe_gerbang = 'In'
                GROUP BY tanggal, tk.tipe_kendaraan
            )
            SELECT
                ds.tanggal,
                kh.tipe_kendaraan,
                COALESCE(kh.jumlah, 0) AS jumlah
            FROM date_series ds
            LEFT JOIN kendaraan_harian kh ON ds.tanggal = kh.tanggal
            ORDER BY ds.tanggal ASC;
            `

            const rawData = await sequelize.query(rawQuery, {
                type: QueryTypes.SELECT,
            })

            // Pivot: grup berdasarkan tanggal
            const dataMap = {}

            for (const { tanggal, tipe_kendaraan, jumlah } of rawData) {
                const tgl = String(tanggal).slice(0, 10)
                if (!dataMap[tgl]) {
                    dataMap[tgl] = { tanggal: tgl }
                }
                if (tipe_kendaraan) {
                    const key = tipe_kendaraan
                        .toLowerCase()
                        .replace(/[^a-z0-9]/gi, '_')
                    dataMap[tgl][key] = jumlah
                }
            }

            const formattedData = Object.values(dataMap)

            const response = {
                success: true,
                message: 'Get kendaraan chart data successfully',
                results: {
                    data: formattedData,
                    totalData: formattedData.length,
                    totalPages: 1,
                    currentPage: 1,
                    pageSize: 1,
                },
            }

            return res.status(200).json(response)
        } catch (error) {
            return errorhandler(res, error)
        }
    },
}
