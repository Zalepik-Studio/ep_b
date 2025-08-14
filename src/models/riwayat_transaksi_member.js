module.exports = (sequelize, DataTypes) => {
    const RiwayatTransaksiMember = sequelize.define(
        'riwayat_transaksi_member',
        {
            id: {
                type: DataTypes.INTEGER,
                primaryKey: true,
                autoIncrement: true,
            },
            tgl_transaksi: {
                type: DataTypes.DATE,
                allowNull: false,
            },
            produk_id: {
                type: DataTypes.INTEGER,
                allowNull: false,
            },
            tarif: {
                type: DataTypes.INTEGER,
                allowNull: false,
            },
            masa_aktif: {
                type: DataTypes.ARRAY(DataTypes.STRING), // atau ARRAY jika pakai PostgreSQL
                allowNull: false,
            },
            user_id: {
                type: DataTypes.INTEGER,
                allowNull: false,
            },
            data_member_id: {
                type: DataTypes.INTEGER,
                allowNull: false,
            },
        },
        {
            tableName: 'riwayat_transaksi_member',
            timestamps: false,
        }
    )
    // 🔹 Definisikan relasi di sini
    RiwayatTransaksiMember.associate = function (models) {
        RiwayatTransaksiMember.belongsTo(models.data_member, {
            foreignKey: 'data_member_id',
            as: 'data_member',
        })
        RiwayatTransaksiMember.belongsTo(models.produk_member, {
            foreignKey: 'produk_id',
            as: 'produk_member',
        })
    }

    return RiwayatTransaksiMember
}
