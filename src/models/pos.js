'use strict'
const { Model } = require('sequelize')
module.exports = (sequelize, DataTypes) => {
    class pos extends Model {
        /**
         * Helper method for defining associations.
         * This method is not a part of Sequelize lifecycle.
         * The `models/index` file will call this method automatically.
         */
        static associate(models) {
            // define association here
            pos.belongsTo(models.user, { foreignKey: 'user_id', as: 'user' })

            pos.belongsTo(models.tipe_manless, {
                foreignKey: 'tipe_manless_id',
                as: 'tipe_manless',
            })

            pos.belongsTo(models.nama_printer, {
                foreignKey: 'nama_printer_id',
                as: 'printer',
            })

            pos.belongsTo(models.nama_interface, {
                foreignKey: 'nama_interface_id',
                as: 'interface',
            })

            pos.belongsTo(models.tenant, {
                foreignKey: 'tenant_id',
                as: 'tenant',
            })
        }
    }
    pos.init(
        {
            tenant_id: DataTypes.INTEGER,
            kode: DataTypes.STRING,
            keterangan: DataTypes.STRING,
            tipe_pos: DataTypes.ENUM('In', 'Out'),
            tipe_manless_id: DataTypes.INTEGER,
            tipe_kendaraan: DataTypes.ENUM('Mobil', 'Motor', 'All'),
            kamera_1: DataTypes.BOOLEAN,
            kamera_2: DataTypes.BOOLEAN,
            nama_printer_id: DataTypes.INTEGER,
            nama_interface_id: DataTypes.INTEGER,
            com_port: DataTypes.STRING,
            otorisasi: DataTypes.BOOLEAN,
            synchronize: DataTypes.STRING,
            user_id: DataTypes.INTEGER,
        },
        {
            sequelize,
            modelName: 'pos',
        }
    )
    return pos
}
