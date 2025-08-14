'use strict'
const { Model } = require('sequelize')
module.exports = (sequelize, DataTypes) => {
    class tarif_denda extends Model {
        /**
         * Helper method for defining associations.
         * This method is not a part of Sequelize lifecycle.
         * The `models/index` file will call this method automatically.
         */
        static associate(models) {
            // define association here
            tarif_denda.belongsTo(models.kendaraan, {
                foreignKey: 'kendaraan_id',
                as: 'kendaraan',
            })

            tarif_denda.belongsTo(models.tenant, {
                foreignKey: 'tenant_id',
                as: 'tenant',
            })
        }
    }
    tarif_denda.init(
        {
            tenant_id: DataTypes.INTEGER,
            kendaraan_id: {
                type: DataTypes.INTEGER,
                allowNull: false,
                validate: { min: 0 },
            },
            denda_tiket: {
                type: DataTypes.INTEGER,
                allowNull: false,
                validate: { min: 0 },
            },
            denda_stnk: {
                type: DataTypes.INTEGER,
                allowNull: false,
                validate: { min: 0 },
            },
            denda_member: DataTypes.BOOLEAN,
            status: DataTypes.BOOLEAN,
        },
        {
            sequelize,
            modelName: 'tarif_denda',
        }
    )
    return tarif_denda
}
