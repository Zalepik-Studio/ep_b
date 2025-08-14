const dayjs = require('dayjs')
const {
    kendaraan,
    user,
    shift,
    tarif_parkir,
    tipe_kendaraan,
    transaksi,
    data_member,
    data_nomor_polisi,
    Sequelize,
} = require('../../../models')
const { Op } = Sequelize

module.exports = {
    update: async (req, res) => {
        try {
            const {
                no_tiket,
                is_manual,
                nomor_polisi,
                pintu_keluar_id,
                tanggal_keluar,
                petugas_id,
                shift_id,
                denda,
                tipe_denda_id,
                keterangan_atau_penjelasan,
                jumlah_denda_stnk,
                jumlah_denda_tiket,
            } = req.body

            // ===============================
            // Validasi input wajib (spesifik per field)
            // ===============================
            // if (!no_tiket) {
            //     return res.status(400).json({
            //         success: false,
            //         message: 'Nomor tiket wajib diisi',
            //     })
            // }

            if (typeof is_manual === 'undefined' || is_manual === null) {
                return res.status(400).json({
                    success: false,
                    message: 'Status manual (is_manual) wajib diisi',
                })
            }

            if (!nomor_polisi) {
                return res.status(400).json({
                    success: false,
                    message: 'Nomor polisi wajib diisi',
                })
            }

            if (!tanggal_keluar) {
                return res.status(400).json({
                    success: false,
                    message: 'Tanggal keluar wajib diisi',
                })
            }

            if (is_manual == false && (!nomor_polisi || !no_tiket)) {
                return res.status(400).json({
                    success: false,
                    message: 'Nomor tiket dan nomor polisi wajib diisi',
                })
            }

            if (is_manual == true && !nomor_polisi && !no_tiket) {
                return res.status(400).json({
                    success: false,
                    message: 'Nomor tiket atau nomor polisi wajib diisi',
                })
            }

            

            // ===============================
            // Validasi tiket duplikat (sudah pernah digunakan)
            // ===============================
            const tiketSudahPernahDipakai = await transaksi.findOne({
                where: {
                    no_tiket,
                    tanggal_masuk: { [Op.ne]: null },
                    tanggal_keluar: { [Op.ne]: null },
                },
            })

            if (tiketSudahPernahDipakai) {
                return res.status(400).json({
                    success: false,
                    message:
                        'Transaksi gagal! Nomor tiket ini sudah pernah digunakan. Kemungkinan kecurangan terdeteksi.',
                })
            }

            // ===============================
            // Cek apakah kendaraan terdaftar di member
            // ===============================
            const memberData = await data_nomor_polisi.findOne({
                where: { nomor_polisi },
                include: [
                    {
                        model: data_member,
                        as: 'data_member',
                    },
                ],
            })

            if (memberData) {
                return res.status(400).json({
                    success: false,
                    message:
                        'Kendaraan sudah terdaftar di member. Silakan melakukan transaksi dengan kartu member.',
                })
            }

            // ===============================
            // Validasi keamanan pencurian kendaraan
            // ===============================
            let data // deklarasi sekali di awal

            // Cari transaksi aktif berdasarkan tiket dulu
            const transaksiTiket = await transaksi.findOne({
                where: {
                    no_tiket,
                    tanggal_masuk: { [Op.ne]: null },
                    tanggal_keluar: null,
                },
            })

            if (transaksiTiket) {
                // Cek apakah nomor polisi saat masuk berbeda dengan input keluar
                if (transaksiTiket.nomor_polisi !== nomor_polisi) {
                    return res.status(400).json({
                        success: false,
                        message:
                            'Peringatan! Nomor tiket sama namun nomor polisi berbeda. Kemungkinan pencurian kendaraan.',
                    })
                }
                data = transaksiTiket
            } else {
                // Kalau tiket tidak ketemu, cari berdasarkan plat
                const transaksiPlat = await transaksi.findOne({
                    where: {
                        nomor_polisi,
                        tanggal_masuk: { [Op.ne]: null },
                        tanggal_keluar: null,
                    },
                })

                if (!transaksiPlat) {
                    return res.status(404).json({
                        success: false,
                        message:
                            'Kendaraan belum melakukan transaksi masuk di pintu masuk.',
                    })
                }

                // Cek apakah nomor tiket saat masuk berbeda dengan input keluar
                if (transaksiPlat.no_tiket !== no_tiket) {
                    return res.status(400).json({
                        success: false,
                        message:
                            'Peringatan! Nomor polisi sama namun nomor tiket berbeda. Kemungkinan pencurian kendaraan.',
                    })
                }

                data = transaksiPlat
            }

            // ===============================
            // Validasi tanggal keluar
            // ===============================
            const masuk = new Date(data.tanggal_masuk)
            const keluar = tanggal_keluar
                ? new Date(tanggal_keluar)
                : new Date()

            if (keluar < masuk) {
                return res.status(400).json({
                    success: false,
                    message:
                        'Tanggal keluar tidak boleh lebih awal dari tanggal masuk',
                })
            }

            // ===============================
            // Hitung durasi parkir (jam)
            // ===============================
            const selisihMs = keluar - masuk
            const selisihJam = Math.ceil(selisihMs / (1000 * 60 * 60))

            // ===============================
            // Bagian tarif & denda sementara dinonaktifkan
            // ===============================
            /*
            const tarif = await tarif_parkir.findOne({
                where: { tipe_kendaraan_id: data.kendaraan_id },
            })

            if (!tarif) {
                return res.status(404).json({
                    success: false,
                    message: 'Tarif parkir tidak ditemukan untuk tipe kendaraan ini.',
                })
            }

            let biaya_parkir = tarif.tarif_awal
            if (selisihJam > 1) {
                biaya_parkir += (selisihJam - 1) * tarif.tarif_perjam
            }

            if (tarif.tarif_maksimal && biaya_parkir > tarif.tarif_maksimal) {
                biaya_parkir = tarif.tarif_maksimal
            }
            */

            // ===============================
            // Update transaksi keluar casual (tanpa tarif & denda)
            // ===============================
            await data.update({
                tanggal_keluar: keluar,
                pintu_keluar_id,
                petugas_id,
                shift_id,
                interval: selisihJam,
                // biaya_parkir,
                denda: denda ?? false,
                tipe_denda_id: tipe_denda_id || null,
                keterangan_atau_penjelasan: keterangan_atau_penjelasan || null,
                jumlah_denda_stnk: jumlah_denda_stnk ?? 0,
                jumlah_denda_tiket: jumlah_denda_tiket ?? 0,
            })

            // ===============================
            // Tentukan pesan sukses
            // ===============================
            let message = 'Transaksi Casual keluar berhasil (TANPA tarif/denda)'
            if (data.is_manual) {
                message = `Transaksi Casual Manual - ${message}`
            }

            return res.json({
                success: true,
                message,
                results: data,
            })
        } catch (err) {
            return res.status(500).json({
                success: false,
                message: err.message,
            })
        }
    },
}
