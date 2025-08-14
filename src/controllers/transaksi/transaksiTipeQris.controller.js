const { sequelize, transaksi, pos, kendaraan, payment, tipe_kendaraan } = require('../../models');
const { QueryTypes } = require('sequelize');

module.exports = {
  getAllRiwayatTransaksiQris: async (req, res) => {
    try {
      const limit = req.query.limit ? parseInt(req.query.limit) : 10;
      const page = req.query.page ? parseInt(req.query.page) : 1;
      const offset = (page - 1) * limit;
      const search = req.query.search || '';

      const transaksiTable = sequelize.models.transaksi.getTableName();
      const posTable = sequelize.models.pos.getTableName();
      const kendaraanTable = sequelize.models.kendaraan.getTableName();
      const tipeKendaraanTable = sequelize.models.tipe_kendaraan.getTableName();
      const paymentTable = sequelize.models.payment.getTableName();

      let searchCondition = '';
      if (search) {
        searchCondition = `AND (
          t.no_tiket ILIKE :search OR
          t.nomor_polisi ILIKE :search
        )`;
      }

      const query = `
        SELECT
          t.id,
          t.no_tiket,
          t.tanggal_masuk,
          pm.keterangan AS gerbang_masuk,
          tk.tipe_kendaraan AS jenis_kendaraan,
          t.nomor_polisi,
          t.tanggal_keluar,
          pk.keterangan AS pintu_keluar,
          t.interval AS durasi_parkir,
          t.denda,
          t.biaya_parkir AS total_pembayaran,
          jp.jenis_payment AS jenis_transaksi,
          t."createdAt" AS added,
          t."updatedAt" AS updated
        FROM ${transaksiTable} t
        LEFT JOIN ${posTable} pm ON t.pintu_masuk_id = pm.id
        LEFT JOIN ${posTable} pk ON t.pintu_keluar_id = pk.id
        LEFT JOIN ${kendaraanTable} k ON t.kendaraan_id = k.id
        LEFT JOIN ${tipeKendaraanTable} tk ON k.tipe_kendaraan_id = tk.id
        LEFT JOIN ${paymentTable} jp ON t.jenis_pembayaran_id = jp.id
        WHERE jp.jenis_payment ILIKE 'QRIS'
        ${searchCondition}
        ORDER BY t."createdAt" DESC
        LIMIT :limit OFFSET :offset
      `;

      const data = await sequelize.query(query, {
        replacements: {
          limit,
          offset,
          search: `%${search}%`
        },
        type: QueryTypes.SELECT,
      });

      return res.json({
        success: true,
        message: 'Get all riwayat transaksi QRIS successfully',
        results: {
          data,
          totalData: data.length,
          currentPage: page,
          pageSize: limit,
        },
      });
    } catch (err) {
      return res.status(500).json({
        success: false,
        message: err.message,
        type: err.name,
        detail: err.parent?.detail || err,
      });
    }
  },
};
