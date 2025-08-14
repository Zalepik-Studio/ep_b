'use strict'
const { Model } = require('sequelize')
module.exports = (sequelize, DataTypes) => {
    class shift extends Model {
        /**
         * Helper method for defining associations.
         * This method is not a part of Sequelize lifecycle.
         * The `models/index` file will call this method automatically.
         */
        static associate(models) {
            // define association here
            shift.belongsTo(models.user, { foreignKey: 'user_id', as: 'user' })

            shift.belongsTo(models.tenant, {
                foreignKey: 'tenant_id',
                as: 'tenant',
            })
        }
    }
    shift.init(
        {
            tenant_id: DataTypes.INTEGER,
            nama_shift: DataTypes.STRING,
            awal_shift: DataTypes.TIME,
            akhir_shift: DataTypes.TIME,
            status: DataTypes.BOOLEAN,
            user_id: DataTypes.INTEGER,
        },
        {
            sequelize,
            modelName: 'shift',
        }
    )
    return shift
}
