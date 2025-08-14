'use strict'
const { Model } = require('sequelize')
module.exports = (sequelize, DataTypes) => {
    class produk_voucher extends Model {
        /**
         * Helper method for defining associations.
         * This method is not a part of Sequelize lifecycle.
         * The `models/index` file will call this method automatically.
         */
        static associate(models) {
            // define association here
            produk_voucher.belongsTo(models.user, {
                foreignKey: 'user_id',
                as: 'user',
            })

            produk_voucher.belongsTo(models.tenant, {
                foreignKey: 'tenant_id',
                as: 'tenant',
            })
        }
    }
    produk_voucher.init(
        {
            tenant_id: DataTypes.INTEGER,
            nama: DataTypes.STRING,
            periode: DataTypes.RANGE(DataTypes.DATEONLY),
            list_id_kendaraan: DataTypes.ARRAY(DataTypes.STRING),
            diskon: {
                type: DataTypes.INTEGER,
                allowNull: false,
                validate: { min: 0 },
            },
            model_pembayaran: DataTypes.ENUM('Check In', 'Check Out'),
            metode_verifikasi: DataTypes.ENUM('Tiket', 'Nopol'),
            status: DataTypes.BOOLEAN,
            user_id: DataTypes.INTEGER,
        },
        {
            sequelize,
            modelName: 'produk_voucher',
        }
    )
    return produk_voucher
}
