const { transaksi, pos, kendaraan, tipe_kendaraan, payment } = require('../../models');
const { Op } = require('sequelize');

module.exports = {
  getAllRiwayatTransaksiMember: async (req, res) => {
    try {
      const search = req.query.search || '';
      const limit = req.query.limit ? parseInt(req.query.limit) : 10;
      const page = req.query.page ? parseInt(req.query.page) : 1;
      const offset = limit && page ? (page - 1) * limit : 0;

      const sortBy = req.query.sortBy || 'createdAt';
      const sortOrder =
        req.query.sortOrder?.toUpperCase() === 'DESC' ? 'DESC' : 'ASC';

      const options = {
        where: {
          jenis_pembayaran_id: 17, // ID untuk Member
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
            attributes: ['id', 'nama_kendaraan'],
            include: [
              {
                model: tipe_kendaraan,
                as: 'tipe_kendaraan',
                attributes: ['id', 'tipe_kendaraan'],
              },
            ],
          },
          {
            model: payment,
            as: 'jenis_pembayaran',
            attributes: ['id', 'jenis_payment'],
          },
        ],
        order: [[sortBy, sortOrder]],
        limit,
        offset,
      };

      if (search) {
        options.where[Op.or] = [
          { no_tiket: { [Op.iLike]: `%${search}%` } },
          { nomor_polisi: { [Op.iLike]: `%${search}%` } },
        ];
      }

      const { count, rows } = await transaksi.findAndCountAll(options);

      const mappedData = rows.map((t, index) => ({
        no: offset + index + 1,
        nomor_tiket: t.no_tiket,
        waktu_masuk: t.tanggal_masuk,
        gerbang_masuk: t.pintu_masuk?.keterangan || '-',
        jenis_kendaraan: t.kendaraan?.tipe_kendaraan?.tipe_kendaraan || '-',
        nomor_polisi: t.nomor_polisi,
        waktu_keluar: t.tanggal_keluar,
        pintu_keluar: t.pintu_keluar?.keterangan || '-',
        durasi_parkir: t.interval,
        denda: t.denda,
        total_pembayaran: t.biaya_parkir,
        jenis_transaksi: t.jenis_pembayaran?.jenis_payment || '-',
        added: t.createdAt,
        updated: t.updatedAt,
      }));

      return res.json({
        success: true,
        message: 'Get all riwayat transaksi member successfully',
        results: {
          data: mappedData,
          totalData: count,
          totalPages: Math.ceil(count / limit),
          currentPage: page,
          pageSize: limit,
        },
      });
    } catch (err) {
      return res.status(500).json({
        success: false,
        message: err.message,
      });
    }
  },
};
