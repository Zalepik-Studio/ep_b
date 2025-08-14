'use strict'
const { Model } = require('sequelize')
module.exports = (sequelize, DataTypes) => {
    class laporan_transaksi_batal extends Model {
        /**
         * Helper method for defining associations.
         * This method is not a part of Sequelize lifecycle.
         * The `models/index` file will call this method automatically.
         */
        static associate(models) {
            // define association here
            laporan_transaksi_batal.belongsTo(models.pos, {
                foreignKey: 'pintu_masuk_id',
                as: 'pintu_masuk',
            })

            laporan_transaksi_batal.belongsTo(models.user, {
                foreignKey: 'user_id',
                as: 'user',
            })

            laporan_transaksi_batal.belongsTo(models.tenant, {
                foreignKey: 'tenant_id',
                as: 'tenant',
            })
        }
    }
    laporan_transaksi_batal.init(
        {
            tenant_id: DataTypes.INTEGER,
            no_tiket: DataTypes.STRING,
            tanggal_masuk: DataTypes.DATE,
            pintu_masuk_id: DataTypes.INTEGER,
            tanggal_pembatalan: DataTypes.DATE,
            alasan_pembatalan: DataTypes.STRING,
            penjelasan_pembatalan: DataTypes.STRING,
            user_id: DataTypes.INTEGER,
        },
        {
            sequelize,
            modelName: 'laporan_transaksi_batal',
        }
    )
    return laporan_transaksi_batal
}
