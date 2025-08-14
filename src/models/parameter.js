'use strict'
const { Model } = require('sequelize')
module.exports = (sequelize, DataTypes) => {
    class parameter extends Model {
        /**
         * Helper method for defining associations.
         * This method is not a part of Sequelize lifecycle.
         * The `models/index` file will call this method automatically.
         */
        static associate(models) {
            // define association here
            parameter.belongsTo(models.tenant, {
                foreignKey: 'tenant_id',
                as: 'tenant',
            })
        }
    }
    parameter.init(
        {
            tenant_id: DataTypes.INTEGER,
            nama: DataTypes.STRING,
            nilai: DataTypes.STRING,
            keterangan: DataTypes.STRING,
        },
        {
            sequelize,
            modelName: 'parameter',
        }
    )
    return parameter
}
