'use strict'
const { Model } = require('sequelize')
module.exports = (sequelize, DataTypes) => {
    class riwayat_transaksi_ganti_nopol extends Model {
        /**
         * Helper method for defining associations.
         * This method is not a part of Sequelize lifecycle.
         * The `models/index` file will call this method automatically.
         */
        static associate(models) {
            // define association here
            riwayat_transaksi_ganti_nopol.belongsTo(models.user, {
                foreignKey: 'user_id',
                as: 'user',
            })

            riwayat_transaksi_ganti_nopol.belongsTo(models.tenant, {
                foreignKey: 'tenant_id',
                as: 'tenant',
            })
        }
    }
    riwayat_transaksi_ganti_nopol.init(
        {
            tenant_id: DataTypes.INTEGER,
            tgl_transaksi: DataTypes.DATE,
            nomor_polisi_lama: DataTypes.STRING,
            nomor_polisi_baru: DataTypes.STRING,
            tarif: {
                type: DataTypes.INTEGER,
                allowNull: false,
                validate: { min: 0 },
            },
            keterangan: DataTypes.STRING,
            user_id: DataTypes.INTEGER,
        },
        {
            sequelize,
            modelName: 'riwayat_transaksi_ganti_nopol',
        }
    )
    return riwayat_transaksi_ganti_nopol
}
