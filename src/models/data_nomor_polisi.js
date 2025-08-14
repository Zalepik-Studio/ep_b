'use strict'
const { Model } = require('sequelize')
module.exports = (sequelize, DataTypes) => {
    class data_nomor_polisi extends Model {
        /**
         * Helper method for defining associations.
         * This method is not a part of Sequelize lifecycle.
         * The `models/index` file will call this method automatically.
         */
        static associate(models) {
            // define association here
            data_nomor_polisi.belongsTo(models.kendaraan, {
                foreignKey: 'kendaraan_id',
                as: 'kendaraan',
            })

            data_nomor_polisi.belongsTo(models.data_member, {
                foreignKey: 'data_member_id',
                as: 'data_member',
            })

            data_nomor_polisi.belongsTo(models.tenant, {
                foreignKey: 'tenant_id',
                as: 'tenant',
            })
        }
    }
    data_nomor_polisi.init(
        {
            tenant_id: DataTypes.INTEGER,
            data_member_id: DataTypes.INTEGER,
            kendaraan_id: DataTypes.INTEGER,
            nomor_polisi: {
                type: DataTypes.STRING,
                //  unique: true
            },
        },
        {
            sequelize,
            modelName: 'data_nomor_polisi',
        }
    )

    return data_nomor_polisi
}
