'use strict'
const { Model } = require('sequelize')
module.exports = (sequelize, DataTypes) => {
    class laporan_riwayat_transaksi_member extends Model {
        /**
         * Helper method for defining associations.
         * This method is not a part of Sequelize lifecycle.
         * The `models/index` file will call this method automatically.
         */
        static associate(models) {
            // define association here
            laporan_riwayat_transaksi_member.belongsTo(models.pos, {
                foreignKey: 'gerbang_masuk_id',
                as: 'gerbang_masuk',
            })

            laporan_riwayat_transaksi_member.belongsTo(models.pos, {
                foreignKey: 'pintu_keluar_id',
                as: 'pintu_keluar',
            })

            laporan_riwayat_transaksi_member.belongsTo(models.kendaraan, {
                foreignKey: 'jenis_kendaraan_id',
                as: 'kendaraan',
            })

            laporan_riwayat_transaksi_member.belongsTo(models.tenant, {
                foreignKey: 'tenant_id',
                as: 'tenant',
            })
        }
    }
    laporan_riwayat_transaksi_member.init(
        {
            tenant_id: DataTypes.INTEGER,
            no: DataTypes.INTEGER,
            nomor_tiket: DataTypes.STRING,
            waktu_masuk: DataTypes.DATE,
            gerbang_masuk_id: DataTypes.INTEGER,
            jenis_kendaraan_id: DataTypes.INTEGER,
            nomor_polisi: DataTypes.STRING,
            waktu_keluar: DataTypes.STRING,
            pintu_keluar_id: DataTypes.INTEGER,
            durasi_parkir: DataTypes.STRING,
            denda: DataTypes.STRING,
            total_pembayaran: DataTypes.STRING,
            jenis_transaksi: DataTypes.STRING,
        },
        {
            sequelize,
            modelName: 'laporan_riwayat_transaksi_member',
        }
    )
    return laporan_riwayat_transaksi_member
}
