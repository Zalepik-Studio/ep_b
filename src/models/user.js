'use strict'
const { Model } = require('sequelize')
module.exports = (sequelize, DataTypes) => {
    class user extends Model {
        /**
         * Helper method for defining associations.
         * This method is not a part of Sequelize lifecycle.
         * The `models/index` file will call this method automatically.
         */
        static associate(models) {
            // define association here
            user.belongsTo(models.user, {
                foreignKey: 'added_by',
                as: 'added_by_user',
            })

            user.belongsTo(models.level_pengguna, {
                foreignKey: 'level_pengguna_id',
                as: 'level_pengguna',
            })

            user.belongsTo(models.perusahaan, {
                foreignKey: 'perusahaan_id',
                as: 'asal_perusahaan',
            })

            user.belongsTo(models.tenant, {
                foreignKey: 'tenant_id',
                as: 'tenant',
                onDelete: 'CASCADE',
                onUpdate: 'CASCADE',
            })
        }
    }
    user.init(
        {
            tenant_id: DataTypes.INTEGER,
            nama: { type: DataTypes.STRING, unique: true },
            jenis_kelamin: DataTypes.ENUM('Laki-laki', 'Perempuan'),
            no_hp: DataTypes.STRING,
            alamat_lengkap: DataTypes.STRING,
            username: { type: DataTypes.STRING, unique: true },
            password: DataTypes.STRING,
            perusahaan_id: DataTypes.INTEGER,
            level_pengguna_id: DataTypes.INTEGER,
            status: DataTypes.BOOLEAN,
            added_by: DataTypes.INTEGER,
        },
        {
            sequelize,
            modelName: 'user',
        }
    )
    return user
}
