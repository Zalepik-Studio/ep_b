'use strict'
const { Model } = require('sequelize')
module.exports = (sequelize, DataTypes) => {
    class tarif_parkir extends Model {
        /**
         * Helper method for defining associations.
         * This method is not a part of Sequelize lifecycle.
         * The `models/index` file will call this method automatically.
         */
        static associate(models) {
            // define association here
            tarif_parkir.belongsTo(models.kendaraan, {
                foreignKey: 'kendaraan_id',
                as: 'kendaraan',
            })

            tarif_parkir.belongsTo(models.tenant, {
                foreignKey: 'tenant_id',
                as: 'tenant',
            })
        }
    }
    tarif_parkir.init(
        {
            tenant_id: DataTypes.INTEGER,
            kendaraan_id: DataTypes.INTEGER,
            grace_period: {
                type: DataTypes.INTEGER,
                allowNull: true,
                validate: { min: 0 },
            },
            tarif_grace_period: {
                type: DataTypes.INTEGER,
                allowNull: true,
                validate: { min: 0 },
            },
            rotasi_pertama: {
                type: DataTypes.INTEGER,
                allowNull: true,
                validate: { min: 0 },
            },
            tarif_rotasi_pertama: {
                type: DataTypes.INTEGER,
                allowNull: true,
                validate: { min: 0 },
            },
            rotasi_kedua: {
                type: DataTypes.INTEGER,
                allowNull: true,
                validate: { min: 0 },
            },
            tarif_rotasi_kedua: {
                type: DataTypes.INTEGER,
                allowNull: true,
                validate: { min: 0 },
            },
            rotasi_ketiga: {
                type: DataTypes.INTEGER,
                allowNull: true,
                validate: { min: 0 },
            },
            tarif_rotasi_ketiga: {
                type: DataTypes.INTEGER,
                allowNull: true,
                validate: { min: 0 },
            },
            tarif_maksimal: {
                type: DataTypes.INTEGER,
                allowNull: true,
                validate: { min: 0 },
            },
            tarif_flat: {
                type: DataTypes.INTEGER,
                allowNull: true,
                validate: { min: 0 },
            },
        },
        {
            sequelize,
            modelName: 'tarif_parkir',
        }
    )
    return tarif_parkir
}
