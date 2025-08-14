// File: src/controllers/transaksi/transaksiTipeTunai.controller.js
const { transaksi, pos, kendaraan, user, shift, tipe_kendaraan, payment } = require('../../models')
const { Op } = require('sequelize')
const dayjs = require('dayjs')

module.exports = {
  getAllRiwayatTransaksiTunai: async (req, res) => {
    try {
      const search = req.query.search || ''
      const page = parseInt(req.query.page) || 1
      const limit = parseInt(req.query.limit) || 10
      const offset = (page - 1) * limit
      const sortBy = req.query.sortBy || 'tanggal_masuk'
      const sortOrder = req.query.sortOrder?.toUpperCase() === 'DESC' ? 'DESC' : 'ASC'

      const whereClause = {
        is_active: true,
      }

      if (search) {
        whereClause[Op.or] = [
          { no_tiket: { [Op.iLike]: `%${search}%` } },
          { nomor_polisi: { [Op.iLike]: `%${search}%` } },
        ]
      }

      const result = await transaksi.findAndCountAll({
        where: whereClause,
        include: [
          {
            model: pos,
            as: 'pintu_masuk',
            attributes: ['keterangan']
          },
          {
            model: pos,
            as: 'pintu_keluar',
            attributes: ['keterangan']
          },
          {
            model: kendaraan,
            as: 'kendaraan',
            attributes: ['nama_kendaraan'],
            include: [
              {
                model: tipe_kendaraan,
                as: 'tipe_kendaraan',
                attributes: ['tipe_kendaraan']
              }
            ]
          },
          {
            model: user,
            as: 'petugas',
            attributes: ['nama']
          },
          {
            model: shift,
            as: 'shift',
            attributes: ['nama_shift']
          },
          {
            model: payment,
            as: 'jenis_pembayaran',
            attributes: ['jenis_payment'],
            where: {
              jenis_payment: 'Tunai'
            }
          }
        ],
        order: [[sortBy, sortOrder]],
        offset,
        limit
      })

      const rows = result.rows.map((item, index) => {
        return {
          no: offset + index + 1,
          nomor_tiket: item.no_tiket || '-',
          waktu_masuk: item.tanggal_masuk ? dayjs(item.tanggal_masuk).format('YYYY-MM-DD HH:mm') : '-',
          gerbang_masuk: item.pintu_masuk?.keterangan || '-',
          jenis_kendaraan: item.kendaraan?.tipe_kendaraan?.tipe_kendaraan || '-',
          nomor_polisi: item.nomor_polisi || '-',
          waktu_keluar: item.tanggal_keluar ? dayjs(item.tanggal_keluar).format('YYYY-MM-DD HH:mm') : '-',
          pintu_keluar: item.pintu_keluar?.keterangan || '-',
          durasi_parkir: item.interval || '-',
          denda: (parseInt(item.jumlah_denda_tiket || 0) + parseInt(item.jumlah_denda_stnk || 0)),
          total_pembayaran: parseInt(item.biaya_parkir || 0),
          jenis_transaksi: item.jenis_pembayaran?.jenis_payment || '-',
          added: dayjs(item.createdAt).format('YYYY-MM-DD HH:mm'),
          updated: dayjs(item.updatedAt).format('YYYY-MM-DD HH:mm'),
        }
      })

      return res.json({
        success: true,
        message: 'Get all riwayat transaksi tunai successfully',
        results: {
          data: rows,
          totalData: result.count,
          totalPages: Math.ceil(result.count / limit),
          currentPage: page,
          pageSize: limit,
        }
      })
    } catch (err) {
      console.error(err)
      return res.status(500).json({ success: false, message: 'Internal server error', error: err.message })
    }
  }
}
