'use strict'
const { Model } = require('sequelize')
module.exports = (sequelize, DataTypes) => {
    class tipe_denda extends Model {
        /**
         * Helper method for defining associations.
         * This method is not a part of Sequelize lifecycle.
         * The `models/index` file will call this method automatically.
         */
        static associate(models) {
            // define association here
            tipe_denda.belongsTo(models.tenant, {
                foreignKey: 'tenant_id',
                as: 'tenant',
            })
        }
    }
    tipe_denda.init(
        {
            tenant_id: DataTypes.INTEGER,
            tipe_denda: DataTypes.STRING,
        },
        {
            sequelize,
            modelName: 'tipe_denda',
        }
    )
    return tipe_denda
}
