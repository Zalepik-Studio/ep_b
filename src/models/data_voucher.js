'use strict'
const { Model } = require('sequelize')
module.exports = (sequelize, DataTypes) => {
    class data_voucher extends Model {
        /**
         * Helper method for defining associations.
         * This method is not a part of Sequelize lifecycle.
         * The `models/index` file will call this method automatically.
         */
        static associate(models) {
            // define association here
            data_voucher.belongsTo(models.produk_voucher, {
                foreignKey: 'produk_voucher_id',
                as: 'produk_voucher',
            })

            data_voucher.belongsTo(models.kendaraan, {
                foreignKey: 'kendaraan_id',
                as: 'kendaraan',
            })

            data_voucher.belongsTo(models.tenant, {
                foreignKey: 'tenant_id',
                as: 'tenant',
            })
        }
    }

    data_voucher.init(
        {
            tenant_id: DataTypes.INTEGER,
            produk_voucher_id: DataTypes.INTEGER,
            periode: DataTypes.RANGE(DataTypes.DATEONLY),
            diskon: {
                type: DataTypes.INTEGER,
                allowNull: false,
                validate: { min: 0 },
            },
            model_bayar: DataTypes.ENUM('Check In', 'Check Out'),
            verifikasi: DataTypes.ENUM('Tiket', 'Nopol'),
            no_tiket: { type: DataTypes.STRING, allowNull: true },
            nomor_polisi: { type: DataTypes.STRING, allowNull: true },
            kendaraan_id: DataTypes.INTEGER,
            keterangan: DataTypes.STRING,
        },
        {
            sequelize,
            modelName: 'data_voucher',
        }
    )
    return data_voucher
}
