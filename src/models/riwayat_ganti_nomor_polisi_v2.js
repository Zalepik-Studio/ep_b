'use strict'

module.exports = (sequelize, DataTypes) => {
    const RiwayatGantiNomorPolisiV2 = sequelize.define(
        'riwayat_ganti_nomor_polisi_v2',
        {
            id: {
                type: DataTypes.INTEGER,
                primaryKey: true,
                autoIncrement: true,
            },
            data_member_id: {
                type: DataTypes.INTEGER,
                allowNull: false,
            },
            nomor_polisi_lama: {
                type: DataTypes.STRING,
                allowNull: false,
            },
            nomor_polisi_baru: {
                type: DataTypes.STRING,
                allowNull: false,
            },
            kendaraan_lama_id: {
                type: DataTypes.INTEGER,
                allowNull: true,
            },
            kendaraan_baru_id: {
                type: DataTypes.INTEGER,
                allowNull: true,
            },
            keterangan: {
                type: DataTypes.STRING,
                allowNull: true,
            },
            tgl_ganti: {
                type: DataTypes.DATE,
                allowNull: false,
                defaultValue: DataTypes.NOW,
            },
            user_id: {
                type: DataTypes.INTEGER,
                allowNull: false,
            },
        },
        {
            tableName: 'riwayat_ganti_nomor_polisi_v2',
            timestamps: true, // ✅ aktifkan
            createdAt: 'createdAt', // nama kolom di DB
            updatedAt: 'updatedAt', // nama kolom di DB
        }
    )

    RiwayatGantiNomorPolisiV2.associate = function (models) {
        RiwayatGantiNomorPolisiV2.belongsTo(models.data_member, {
            foreignKey: 'data_member_id',
            as: 'data_member',
        })
        RiwayatGantiNomorPolisiV2.belongsTo(models.produk_member, {
            foreignKey: 'produk_id',
            as: 'produk_member',
        })
        RiwayatGantiNomorPolisiV2.belongsTo(models.kendaraan, {
            foreignKey: 'kendaraan_lama_id',
            as: 'kendaraan_lama',
        })
        RiwayatGantiNomorPolisiV2.belongsTo(models.kendaraan, {
            foreignKey: 'kendaraan_baru_id',
            as: 'kendaraan_baru',
        })
    }

    return RiwayatGantiNomorPolisiV2
}
