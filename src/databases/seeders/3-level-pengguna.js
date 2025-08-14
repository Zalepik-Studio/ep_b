'use strict'

/** @type {import('sequelize-cli').Migration} */
module.exports = {
    async up(queryInterface, Sequelize) {
        /**
         * Add seed commands here.
         *
         * Example:
         * await queryInterface.bulkInsert('People', [{
         *   name: 'John Doe',
         *   isBetaMember: false
         * }], {});
         */

        await queryInterface.bulkInsert(
            'level_penggunas',
            [
                {
                    id: 1,
                    tenant_id: 1,
                    nama: 'Super Admin',
                    hak_akses: JSON.stringify([
                        {
                            nama_menu: 'Dashboard',
                            nama_sub_menu: null,
                            aksi: {
                                read: true,
                                create: null,
                                delete: null,
                                update: null,
                            },
                        },
                        {
                            nama_menu: 'Master Data',
                            nama_sub_menu: [
                                {
                                    nama: 'Perusahaan',
                                    aksi: {
                                        read: true,
                                        create: true,
                                        delete: true,
                                        update: true,
                                        aktif_nonaktif: true,
                                    },
                                },
                                {
                                    nama: 'Level Pengguna',
                                    aksi: {
                                        read: true,
                                        create: true,
                                        delete: true,
                                        update: true,
                                        pengaturan: true,
                                    },
                                },
                                {
                                    nama: 'Data Pengguna',
                                    aksi: {
                                        read: true,
                                        create: true,
                                        delete: true,
                                        update: true,
                                        aktif_nonaktif: true,
                                    },
                                },
                                {
                                    nama: 'Pos (In/Out)',
                                    aksi: {
                                        read: true,
                                        create: true,
                                        delete: true,
                                        update: true,
                                    },
                                },
                                {
                                    nama: 'Data Kendaraan',
                                    aksi: {
                                        read: true,
                                        create: true,
                                        delete: true,
                                        update: true,
                                        aktif_nonaktif: true,
                                    },
                                },
                                {
                                    nama: 'Produk Member',
                                    aksi: {
                                        read: true,
                                        create: true,
                                        delete: true,
                                        update: true,
                                        aktif_nonaktif: true,
                                    },
                                },
                                {
                                    nama: 'Data Member',
                                    aksi: {
                                        read: true,
                                        create: true,
                                        delete: true,
                                        update: true,
                                        perpanjang: true,
                                        ganti_kartu: true,
                                        ganti_nomor_polisi: true,
                                        riwayat_transaksi: true,
                                    },
                                },
                                {
                                    nama: 'Produk Voucher',
                                    aksi: {
                                        read: true,
                                        create: true,
                                        delete: true,
                                        update: true,
                                        aktif_nonaktif: true,
                                    },
                                },
                                {
                                    nama: 'Data Voucher',
                                    aksi: {
                                        read: true,
                                        create: true,
                                        delete: true,
                                        update: true,
                                    },
                                },
                                {
                                    nama: 'Shift',
                                    aksi: {
                                        read: true,
                                        create: true,
                                        delete: true,
                                        update: true,
                                        aktif_nonaktif: true,
                                    },
                                },
                                {
                                    nama: 'Tenant',
                                    aksi: {
                                        read: true,
                                        create: true,
                                        delete: true,
                                        update: true,
                                        aktif_nonaktif: true,
                                    },
                                },
                            ],
                        },
                        {
                            nama_menu: 'Laporan Data',
                            nama_sub_menu: [
                                {
                                    nama: 'Kendaraan',
                                    aksi: {
                                        read: true,
                                        create: null,
                                        delete: null,
                                        update: null,
                                    },
                                },
                                {
                                    nama: 'Pendapatan Parkir',
                                    aksi: {
                                        read: true,
                                        create: null,
                                        delete: null,
                                        update: null,
                                    },
                                },
                                {
                                    nama: 'Transaksi Batal',
                                    aksi: {
                                        read: true,
                                        create: null,
                                        delete: null,
                                        update: null,
                                        batalkan_transaksi: true,
                                    },
                                },
                                {
                                    nama: 'Audit Transaksi',
                                    aksi: {
                                        read: true,
                                        create: null,
                                        delete: null,
                                        update: null,
                                    },
                                },
                                {
                                    nama: 'Settlement Cashless',
                                    aksi: {
                                        read: true,
                                        create: null,
                                        delete: null,
                                        update: null,
                                        unggah_file: true,
                                    },
                                },
                            ],
                        },
                        {
                            nama_menu: 'Transaksi',
                            nama_sub_menu: [
                                {
                                    nama: 'Tambah Transaksi',
                                    aksi: {
                                        read: null,
                                        create: true,
                                        delete: null,
                                        update: null,
                                    },
                                },
                                {
                                    nama: 'Riwayat Transaksi',
                                    aksi: {
                                        read: true,
                                        create: null,
                                        delete: null,
                                        update: null,
                                    },
                                },
                            ],
                        },
                        {
                            nama_menu: 'Pengaturan',
                            nama_sub_menu: [
                                {
                                    nama: 'Tarif Parkir',
                                    aksi: {
                                        read: true,
                                        create: null,
                                        delete: null,
                                        update: true,
                                    },
                                },
                                {
                                    nama: 'Tarif Denda',
                                    aksi: {
                                        read: true,
                                        create: null,
                                        delete: null,
                                        update: true,
                                        aktif_nonaktif: true,
                                    },
                                },
                                {
                                    nama: 'Pembayaran',
                                    aksi: {
                                        read: true,
                                        create: null,
                                        delete: null,
                                        update: null,
                                        aktif_nonaktif: true,
                                    },
                                },
                                {
                                    nama: 'Parameter',
                                    aksi: {
                                        read: true,
                                        create: null,
                                        delete: null,
                                        update: true,
                                    },
                                },
                                {
                                    nama: 'Global',
                                    aksi: {
                                        read: true,
                                        create: null,
                                        delete: null,
                                        update: true,
                                    },
                                },
                            ],
                        },
                        {
                            nama_menu: 'Bantuan',
                            nama_sub_menu: [
                                {
                                    nama: 'Tiket',
                                    aksi: {
                                        read: true,
                                        create: true,
                                        delete: true,
                                        update: true,
                                        proses_data_perbaikan: true,
                                    },
                                },
                            ],
                        },
                    ]),
                    createdAt: new Date(),
                    updatedAt: new Date(),
                },
                {
                    id: 2,
                    tenant_id: 1,
                    nama: 'Administrator Tenant',
                    hak_akses: JSON.stringify([
                        {
                            nama_menu: 'Dashboard',
                            nama_sub_menu: null,
                            aksi: {
                                read: true,
                                create: null,
                                delete: null,
                                update: null,
                            },
                        },
                        {
                            nama_menu: 'Master Data',
                            nama_sub_menu: [
                                {
                                    nama: 'Perusahaan',
                                    aksi: {
                                        read: true,
                                        create: true,
                                        delete: true,
                                        update: true,
                                        aktif_nonaktif: true,
                                    },
                                },
                                {
                                    nama: 'Level Pengguna',
                                    aksi: {
                                        read: true,
                                        create: true,
                                        delete: true,
                                        update: true,
                                        pengaturan: true,
                                    },
                                },
                                {
                                    nama: 'Data Pengguna',
                                    aksi: {
                                        read: true,
                                        create: true,
                                        delete: true,
                                        update: true,
                                        aktif_nonaktif: true,
                                    },
                                },
                                {
                                    nama: 'Pos (In/Out)',
                                    aksi: {
                                        read: true,
                                        create: true,
                                        delete: true,
                                        update: true,
                                    },
                                },
                                {
                                    nama: 'Data Kendaraan',
                                    aksi: {
                                        read: true,
                                        create: true,
                                        delete: true,
                                        update: true,
                                        aktif_nonaktif: true,
                                    },
                                },
                                {
                                    nama: 'Produk Member',
                                    aksi: {
                                        read: true,
                                        create: true,
                                        delete: true,
                                        update: true,
                                        aktif_nonaktif: true,
                                    },
                                },
                                {
                                    nama: 'Data Member',
                                    aksi: {
                                        read: true,
                                        create: true,
                                        delete: true,
                                        update: true,
                                        perpanjang: true,
                                        ganti_kartu: true,
                                        ganti_nomor_polisi: true,
                                        riwayat_transaksi: true,
                                    },
                                },
                                {
                                    nama: 'Produk Voucher',
                                    aksi: {
                                        read: true,
                                        create: true,
                                        delete: true,
                                        update: true,
                                        aktif_nonaktif: true,
                                    },
                                },
                                {
                                    nama: 'Data Voucher',
                                    aksi: {
                                        read: true,
                                        create: true,
                                        delete: true,
                                        update: true,
                                    },
                                },
                                {
                                    nama: 'Shift',
                                    aksi: {
                                        read: true,
                                        create: true,
                                        delete: true,
                                        update: true,
                                        aktif_nonaktif: true,
                                    },
                                },
                            ],
                        },
                        {
                            nama_menu: 'Laporan Data',
                            nama_sub_menu: [
                                {
                                    nama: 'Kendaraan',
                                    aksi: {
                                        read: true,
                                        create: null,
                                        delete: null,
                                        update: null,
                                    },
                                },
                                {
                                    nama: 'Pendapatan Parkir',
                                    aksi: {
                                        read: true,
                                        create: null,
                                        delete: null,
                                        update: null,
                                    },
                                },
                                {
                                    nama: 'Transaksi Batal',
                                    aksi: {
                                        read: true,
                                        create: null,
                                        delete: null,
                                        update: null,
                                        batalkan_transaksi: true,
                                    },
                                },
                                {
                                    nama: 'Audit Transaksi',
                                    aksi: {
                                        read: true,
                                        create: null,
                                        delete: null,
                                        update: null,
                                    },
                                },
                                {
                                    nama: 'Settlement Cashless',
                                    aksi: {
                                        read: true,
                                        create: null,
                                        delete: null,
                                        update: null,
                                        unggah_file: true,
                                    },
                                },
                            ],
                        },
                        {
                            nama_menu: 'Transaksi',
                            nama_sub_menu: [
                                {
                                    nama: 'Tambah Transaksi',
                                    aksi: {
                                        read: null,
                                        create: true,
                                        delete: null,
                                        update: null,
                                    },
                                },
                                {
                                    nama: 'Riwayat Transaksi',
                                    aksi: {
                                        read: true,
                                        create: null,
                                        delete: null,
                                        update: null,
                                    },
                                },
                            ],
                        },
                        {
                            nama_menu: 'Pengaturan',
                            nama_sub_menu: [
                                {
                                    nama: 'Tarif Parkir',
                                    aksi: {
                                        read: true,
                                        create: null,
                                        delete: null,
                                        update: true,
                                    },
                                },
                                {
                                    nama: 'Tarif Denda',
                                    aksi: {
                                        read: true,
                                        create: null,
                                        delete: null,
                                        update: true,
                                        aktif_nonaktif: true,
                                    },
                                },
                                {
                                    nama: 'Pembayaran',
                                    aksi: {
                                        read: true,
                                        create: null,
                                        delete: null,
                                        update: null,
                                        aktif_nonaktif: true,
                                    },
                                },
                                {
                                    nama: 'Parameter',
                                    aksi: {
                                        read: true,
                                        create: null,
                                        delete: null,
                                        update: true,
                                    },
                                },
                                {
                                    nama: 'Global',
                                    aksi: {
                                        read: true,
                                        create: null,
                                        delete: null,
                                        update: true,
                                    },
                                },
                            ],
                        },
                        {
                            nama_menu: 'Bantuan',
                            nama_sub_menu: [
                                {
                                    nama: 'Tiket',
                                    aksi: {
                                        read: true,
                                        create: true,
                                        delete: true,
                                        update: true,
                                        proses_data_perbaikan: true,
                                    },
                                },
                            ],
                        },
                    ]),
                    createdAt: new Date(),
                    updatedAt: new Date(),
                },
                {
                    id: 3,
                    tenant_id: 1,
                    nama: 'Member',
                    hak_akses: JSON.stringify([
                        {
                            nama_menu: 'Dashboard',
                            nama_sub_menu: null,
                            aksi: {
                                read: true,
                                create: null,
                                delete: null,
                                update: null,
                            },
                        },
                    ]),
                    createdAt: new Date(),
                    updatedAt: new Date(),
                },
            ],
            {}
        )
    },

    async down(queryInterface, Sequelize) {
        /**
         * Add commands to revert seed here.
         *
         * Example:
         * await queryInterface.bulkDelete('People', null, {});
         */
    },
}
