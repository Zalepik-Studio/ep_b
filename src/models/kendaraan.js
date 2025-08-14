'use strict'
const { Model } = require('sequelize')
module.exports = (sequelize, DataTypes) => {
    class kendaraan extends Model {
        /**
         * Helper method for defining associations.
         * This method is not a part of Sequelize lifecycle.
         * The `models/index` file will call this method automatically.
         */
        static associate(models) {
            // define association here
            kendaraan.hasOne(models.tarif_parkir, {
                foreignKey: 'kendaraan_id',
                as: 'tarif_parkir',
            })

            kendaraan.hasOne(models.tarif_denda, {
                foreignKey: 'kendaraan_id',
                as: 'tarif_denda',
            })

            kendaraan.belongsTo(models.user, {
                foreignKey: 'user_id',
                as: 'user',
            })

            kendaraan.belongsTo(models.tipe_kendaraan, {
                foreignKey: 'tipe_kendaraan_id',
                as: 'tipe_kendaraan',
            })

            kendaraan.belongsTo(models.tenant, {
                foreignKey: 'tenant_id',
                as: 'tenant',
            })
        }
    }
    kendaraan.init(
        {
            tenant_id: DataTypes.INTEGER,
            nama_kendaraan: DataTypes.STRING,
            tipe_kendaraan_id: DataTypes.INTEGER,
            status: DataTypes.BOOLEAN,
            user_id: DataTypes.INTEGER,
        },
        {
            sequelize,
            modelName: 'kendaraan',
        }
    )
    return kendaraan
}
