'use strict'
const { Model } = require('sequelize')
module.exports = (sequelize, DataTypes) => {
    class riwayat_transaksi_kartu_member extends Model {
        /**
         * Helper method for defining associations.
         * This method is not a part of Sequelize lifecycle.
         * The `models/index` file will call this method automatically.
         */
        static associate(models) {
            // define association here
            riwayat_transaksi_kartu_member.belongsTo(models.user, {
                foreignKey: 'user_id',
                as: 'user',
            })

            riwayat_transaksi_kartu_member.belongsTo(models.tenant, {
                foreignKey: 'tenant_id',
                as: 'tenant',
            })
        }
    }
    riwayat_transaksi_kartu_member.init(
        {
            tenant_id: DataTypes.INTEGER,
            tgl_transaksi: DataTypes.DATE,
            no_kartu: DataTypes.STRING,
            tarif: {
                type: DataTypes.INTEGER,
                allowNull: false,
                validate: { min: 0 },
            },
            keterangan: DataTypes.STRING,
            user_id: DataTypes.INTEGER,
        },
        {
            sequelize,
            modelName: 'riwayat_transaksi_kartu_member',
        }
    )
    return riwayat_transaksi_kartu_member
}
