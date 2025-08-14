'use strict'
const { Model } = require('sequelize')
module.exports = (sequelize, DataTypes) => {
    class tipe_manless extends Model {
        /**
         * Helper method for defining associations.
         * This method is not a part of Sequelize lifecycle.
         * The `models/index` file will call this method automatically.
         */
        static associate(models) {
            // define association here
            tipe_manless.belongsTo(models.tenant, {
                foreignKey: 'tenant_id',
                as: 'tenant',
            })
        }
    }
    tipe_manless.init(
        {
            tenant_id: DataTypes.INTEGER,
            tipe_manless: DataTypes.STRING,
        },
        {
            sequelize,
            modelName: 'tipe_manless',
        }
    )
    return tipe_manless
}
