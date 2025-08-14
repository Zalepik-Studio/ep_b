'use strict'
const { Model } = require('sequelize')
module.exports = (sequelize, DataTypes) => {
    class permasalahan_atau_perbaikan extends Model {
        /**
         * Helper method for defining associations.
         * This method is not a part of Sequelize lifecycle.
         * The `models/index` file will call this method automatically.
         */
        static associate(models) {
            // define association here
            permasalahan_atau_perbaikan.belongsTo(models.pos, {
                foreignKey: 'pos_id',
                as: 'pos',
            })

            permasalahan_atau_perbaikan.belongsTo(models.tenant, {
                foreignKey: 'tenant_id',
                as: 'tenant',
            })
        }
    }
    permasalahan_atau_perbaikan.init(
        {
            tenant_id: DataTypes.INTEGER,
            judul_permasalahan: DataTypes.STRING,
            tanggal_permasalahan: DataTypes.STRING,
            kategori_permasalahan: DataTypes.ENUM(
                'Hardware/Alat',
                'Sistem',
                'SDM',
                'Operasional',
                'Lain-lain'
            ),
            pos_id: DataTypes.INTEGER,
            hardware_atau_alat: DataTypes.STRING,
            penyebab_permasalahan: DataTypes.TEXT,
            keterangan_permasalahan: DataTypes.TEXT,
            nama_pelapor: DataTypes.STRING,
            status_permasalahan: {
                type: DataTypes.ENUM('Pending', 'On Progress', 'Done'),
                allowNull: true,
            },
            tanggal_perbaikan: DataTypes.STRING,
            jenis_perbaikan: DataTypes.STRING,
            status_perbaikan: {
                type: DataTypes.ENUM('Pending', 'On Progress', 'Done'),
                allowNull: true,
            },
            penanganan: DataTypes.TEXT,
            keterangan_penanganan: DataTypes.TEXT,
            nama_yang_menangani: DataTypes.STRING,
        },
        {
            sequelize,
            modelName: 'permasalahan_atau_perbaikan',
        }
    )
    return permasalahan_atau_perbaikan
}
