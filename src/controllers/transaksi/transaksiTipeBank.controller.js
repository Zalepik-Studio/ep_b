const { transaksi, pos, kendaraan, user, shift, payment, tipe_kendaraan } = require('../../models')
const { Op } = require('sequelize')

module.exports = {
  getAllRiwayatTransaksiBank: async (req, res) => {
    try {
      const search = req.query.search || ''
      const limit = parseInt(req.query.limit) || 10
      const page = parseInt(req.query.page) || 1
      const offset = (page - 1) * limit
      const sortBy = req.query.sortBy || 'tanggal_masuk'
      const sortOrder = req.query.sortOrder?.toUpperCase() === 'DESC' ? 'DESC' : 'ASC'

      const options = {
        where: {
          jenis_pembayaran_id: 16, // ID untuk Bank
        },
        include: [
          {
            model: pos,
            as: 'pintu_masuk',
            attributes: ['id', 'keterangan'],
          },
          {
            model: pos,
            as: 'pintu_keluar',
            attributes: ['id', 'keterangan'],
          },
          {
            model: kendaraan,
            as: 'kendaraan',
            attributes: ['id', 'nama_kendaraan', 'tipe_kendaraan_id'],
            include: [
              {
                model: tipe_kendaraan,
                as: 'tipe_kendaraan',
                attributes: ['id', 'tipe_kendaraan'],
              },
            ],
          },
          {
            model: user,
            as: 'petugas',
            attributes: ['id', 'nama'],
          },
          {
            model: shift,
            as: 'shift',
            attributes: ['id', 'nama_shift'],
          },
          {
            model: payment,
            as: 'jenis_pembayaran',
            attributes: ['id', 'jenis_payment'],
          },
        ],
        order: [[sortBy, sortOrder]],
        offset,
        limit,
      }

      if (search) {
        options.where[Op.or] = [
          { no_tiket: { [Op.iLike]: `%${search}%` } },
          { nomor_polisi: { [Op.iLike]: `%${search}%` } },
        ]
      }

      const { count, rows } = await transaksi.findAndCountAll(options)

      const result = rows.map((item, index) => ({
        no: offset + index + 1,
        nomor_tiket: item.no_tiket,
        waktu_masuk: item.tanggal_masuk,
        gerbang_masuk: item.pintu_masuk?.keterangan || '-',
        jenis_kendaraan: item.kendaraan?.tipe_kendaraan?.tipe_kendaraan || '-',
        nomor_polisi: item.nomor_polisi,
        waktu_keluar: item.tanggal_keluar,
        pintu_keluar: item.pintu_keluar?.keterangan || '-',
        durasi_parkir: item.interval || '-',
        denda: item.denda ? 'Ya' : 'Tidak',
        total_pembayaran: item.biaya_parkir,
        jenis_transaksi: 'Bank',
        added: item.createdAt,
        updated: item.updatedAt,
      }))

      return res.json({
        success: true,
        message: 'Get all riwayat transaksi bank successfully',
        results: {
          data: result,
          totalData: count,
          totalPages: Math.ceil(count / limit),
          currentPage: page,
          pageSize: limit,
        },
      })
    } catch (err) {
      console.error(err)
      return res.status(500).json({
        success: false,
        message: 'Gagal mengambil data riwayat transaksi bank',
        error: err.message,
      })
    }
  },
}
