const { transaksi, pos, kendaraan, tipe_kendaraan } = require('../../models/index')
const errorhandler = require('../../helpers/errorhandler.helper')
const { Op } = require('sequelize')

module.exports = {
  getAllRiwayatTransaksiManual: async (req, res) => {
    try {
      const limit = parseInt(req.query.limit) || 10
      const page = parseInt(req.query.page) || 1
      const offset = (page - 1) * limit

      const { count, rows } = await transaksi.findAndCountAll({
        where: { is_manual: true },
        include: [
          {
            model: pos,
            as: 'pintu_masuk',
            attributes: ['keterangan'],
          },
          {
            model: pos,
            as: 'pintu_keluar',
            attributes: ['keterangan'],
          },
          {
            model: kendaraan,
            as: 'kendaraan',
            include: [
              {
                model: tipe_kendaraan,
                as: 'tipe_kendaraan',
                attributes: ['tipe_kendaraan'],
              },
            ],
          },
        ],
        order: [['createdAt', 'DESC']],
        limit,
        offset,
      })

      const data = rows.map((row, index) => {
        const denda =
          (row.jumlah_denda_tiket || 0) + (row.jumlah_denda_stnk || 0)
        const totalPembayaran = parseInt(row.biaya_parkir || 0) + denda

        return {
          no: offset + index + 1,
          nomor_tiket: row.no_tiket,
          waktu_masuk: row.tanggal_masuk,
          gerbang_masuk: row.pintu_masuk?.keterangan || '-',
          jenis_kendaraan: row.kendaraan?.tipe_kendaraan?.tipe_kendaraan || '-',
          nomor_polisi: row.nomor_polisi,
          waktu_keluar: row.tanggal_keluar,
          pintu_keluar: row.pintu_keluar?.keterangan || '-',
          durasi_parkir: row.interval || '-',
          denda,
          total_pembayaran: totalPembayaran,
          jenis_transaksi: 'Manual',
          added: row.createdAt,
          updated: row.updatedAt,
        }
      })

      res.json({
        success: true,
        message: 'Get riwayat transaksi manual successfully',
        results: {
          data,
          totalData: count,
          totalPages: Math.ceil(count / limit),
          currentPage: page,
          pageSize: limit,
        },
      })
    } catch (err) {
      return errorhandler(res, err)
    }
  },
}
