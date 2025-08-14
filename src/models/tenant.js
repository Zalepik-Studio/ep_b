'use strict'
const { Model } = require('sequelize')
module.exports = (sequelize, DataTypes) => {
    class tenant extends Model {
        /**
         * Helper method for defining associations.
         * This method is not a part of Sequelize lifecycle.
         * The `models/index` file will call this method automatically.
         */
        static associate(models) {
            // define association here
        }
    }
    tenant.init(
        {
            nama_tenant: DataTypes.STRING,
        },
        {
            sequelize,
            modelName: 'tenant',
        }
    )
    return tenant
}
