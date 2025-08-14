'use strict'
const { Model } = require('sequelize')
module.exports = (sequelize, DataTypes) => {
    class nama_interface extends Model {
        /**
         * Helper method for defining associations.
         * This method is not a part of Sequelize lifecycle.
         * The `models/index` file will call this method automatically.
         */
        static associate(models) {
            // define association here
            nama_interface.belongsTo(models.tenant, {
                foreignKey: 'tenant_id',
                as: 'tenant',
            })
        }
    }
    nama_interface.init(
        {
            tenant_id: DataTypes.INTEGER,
            nama_interface: DataTypes.STRING,
        },
        {
            sequelize,
            modelName: 'nama_interface',
        }
    )
    return nama_interface
}
