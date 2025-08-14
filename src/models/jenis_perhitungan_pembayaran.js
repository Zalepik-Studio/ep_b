'use strict'
const { Model } = require('sequelize')
module.exports = (sequelize, DataTypes) => {
    class jenis_perhitungan_pembayaran extends Model {
        /**
         * Helper method for defining associations.
         * This method is not a part of Sequelize lifecycle.
         * The `models/index` file will call this method automatically.
         */
        static associate(models) {
            // define association here
        }
    }
    jenis_perhitungan_pembayaran.init(
        {
            nama: DataTypes.STRING,
        },
        {
            sequelize,
            modelName: 'jenis_perhitungan_pembayaran',
        }
    )
    return jenis_perhitungan_pembayaran
}
