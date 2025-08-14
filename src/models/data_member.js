'use strict'
const { Model } = require('sequelize')
module.exports = (sequelize, DataTypes) => {
    class data_member extends Model {
        /**
         * Helper method for defining associations.
         * This method is not a part of Sequelize lifecycle.
         * The `models/index` file will call this method automatically.
         */
        static associate(models) {
            // define association here
            data_member.belongsTo(models.perusahaan, {
                foreignKey: 'perusahaan_id',
                as: 'perusahaan',
            })

            data_member.belongsTo(models.produk_member, {
                foreignKey: 'produk_id',
                as: 'produk_member',
            })

            data_member.hasMany(models.data_nomor_polisi, {
                foreignKey: 'data_member_id',
                as: 'data_nomor_polisi',
            })

            data_member.belongsTo(models.user, {
                foreignKey: 'user_id',
                as: 'user',
            })

            data_member.belongsTo(models.tenant, {
                foreignKey: 'tenant_id',
                as: 'tenant',
            })
        }
    }
    data_member.init(
        {
            tenant_id: DataTypes.INTEGER,
            nama: DataTypes.STRING,
            no_hp: DataTypes.STRING,
            perusahaan_id: DataTypes.INTEGER,
            akses_tiket: DataTypes.BOOLEAN,
            akses_kartu: DataTypes.BOOLEAN,
            no_kartu: DataTypes.STRING,
            tgl_input: DataTypes.DATE,
            produk_id: DataTypes.INTEGER,
            tarif: {
                type: DataTypes.INTEGER,
                allowNull: false,
                validate: { min: 0 },
            },
            biaya_member: {
                type: DataTypes.INTEGER,
                allowNull: false,
                validate: { min: 0 },
            },
            biaya_kartu: {
                type: DataTypes.INTEGER,
                allowNull: false,
                validate: { min: 0 },
            },
            periode: DataTypes.RANGE(DataTypes.DATEONLY),
            user_id: DataTypes.INTEGER,
        },
        {
            sequelize,
            modelName: 'data_member',
        }
    )
    return data_member
}
