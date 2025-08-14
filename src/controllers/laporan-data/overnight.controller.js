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
}
