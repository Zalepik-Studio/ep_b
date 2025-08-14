'use strict'
const { Model } = require('sequelize')
module.exports = (sequelize, DataTypes) => {
    class transaksi extends Model {
        /**
         * Helper method for defining associations.
         * This method is not a part of Sequelize lifecycle.
         * The `models/index` file will call this method automatically.
         */
        static associate(models) {
            // define association here
            transaksi.belongsTo(models.pos, {
                foreignKey: 'pintu_masuk_id',
                as: 'pintu_masuk',
            })

            transaksi.belongsTo(models.pos, {
                foreignKey: 'pintu_keluar_id',
                as: 'pintu_keluar',
            })

            transaksi.belongsTo(models.kendaraan, {
                foreignKey: 'kendaraan_id',
                as: 'kendaraan',
            })

            transaksi.belongsTo(models.user, {
                foreignKey: 'petugas_id',
                as: 'petugas',
            })

            transaksi.belongsTo(models.shift, {
                foreignKey: 'shift_id',
                as: 'shift',
            })

            transaksi.belongsTo(models.payment, {
                foreignKey: 'jenis_pembayaran_id',
                as: 'jenis_pembayaran',
            })

            transaksi.belongsTo(models.tipe_denda, {
                as: 'tipe_denda',
                foreignKey: 'tipe_denda_id',
            })

            transaksi.belongsTo(models.data_voucher, {
                foreignKey: 'id_data_voucher',
                as: 'data_voucher',
            })

            transaksi.belongsTo(models.data_member, {
                foreignKey: 'id_data_member',
                as: 'data_member',
            })

            transaksi.belongsTo(models.tenant, {
                foreignKey: 'tenant_id',
                as: 'tenant',
            })
        }
    }
    transaksi.init(
        {
            tenant_id: DataTypes.INTEGER,
            tanggal_masuk: DataTypes.DATE,
            pintu_masuk_id: DataTypes.INTEGER,
            no_tiket: DataTypes.STRING,
            is_manual: DataTypes.BOOLEAN,
            kendaraan_id: DataTypes.INTEGER,
            nomor_polisi: DataTypes.STRING,
            pintu_keluar_id: DataTypes.INTEGER,
            tanggal_keluar: DataTypes.DATE,
            petugas_id: DataTypes.INTEGER,
            shift_id: DataTypes.INTEGER,
            denda: DataTypes.BOOLEAN,
            tipe_denda_id: DataTypes.INTEGER,
            is_active: DataTypes.BOOLEAN,
            jenis_pembayaran_id: DataTypes.INTEGER,
            biaya_parkir: DataTypes.STRING,
            id_data_voucher: { type: DataTypes.INTEGER, allowNull: true },
            jumlah_denda_stnk: {
                type: DataTypes.INTEGER,
                allowNull: false,
                validate: { min: 0 },
            },
            jumlah_denda_tiket: {
                type: DataTypes.INTEGER,
                allowNull: false,
                validate: { min: 0 },
            },
            interval: DataTypes.STRING,
            keterangan_atau_penjelasan: DataTypes.STRING,
            id_data_member: { type: DataTypes.INTEGER, allowNull: true },
        },
        {
            sequelize,
            modelName: 'transaksi',
        }
    )
    return transaksi
}
