'use strict'
const { Model } = require('sequelize')
module.exports = (sequelize, DataTypes) => {
    class tipe_kendaraan extends Model {
        /**
         * Helper method for defining associations.
         * This method is not a part of Sequelize lifecycle.
         * The `models/index` file will call this method automatically.
         */
        static associate(models) {
            // define association here
            tipe_kendaraan.belongsTo(models.tenant, {
                foreignKey: 'tenant_id',
                as: 'tenant',
            })

            // ✅ Tambahkan relasi ke kendaraan
            tipe_kendaraan.hasMany(models.kendaraan, {
                foreignKey: 'tipe_kendaraan_id',
                as: 'kendaraan',
            })
        }
    }
    tipe_kendaraan.init(
        {
            tenant_id: DataTypes.INTEGER,
            tipe_kendaraan: DataTypes.STRING,
        },
        {
            sequelize,
            modelName: 'tipe_kendaraan',
        }
    )
    return tipe_kendaraan
}
