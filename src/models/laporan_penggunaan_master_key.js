'use strict'
const { Model } = require('sequelize')
module.exports = (sequelize, DataTypes) => {
    class laporan_penggunaan_master_key extends Model {
        /**
         * Helper method for defining associations.
         * This method is not a part of Sequelize lifecycle.
         * The `models/index` file will call this method automatically.
         */
        static associate(models) {
            // define association here
            laporan_penggunaan_master_key.belongsTo(models.pos, {
                foreignKey: 'pintu_masuk_id',
                as: 'pintu_masuk',
            })
        }
    }
    laporan_penggunaan_master_key.init(
        {
            pintu_masuk_id: DataTypes.INTEGER,
            tanggal_masuk: DataTypes.DATE,
            pintu_keluar_id: DataTypes.INTEGER,
            tanggal_keluar: DataTypes.DATE,
            no_tiket: DataTypes.STRING,
            kendaraan_id: DataTypes.INTEGER,
            nomor_polisi: DataTypes.STRING,
            petugas_id: DataTypes.INTEGER,
            shift_id: DataTypes.INTEGER,
            id_master_key: DataTypes.STRING,
        },
        {
            sequelize,
            modelName: 'laporan_penggunaan_master_key',
        }
    )
    return laporan_penggunaan_master_key
}
