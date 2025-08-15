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
    payment,
    jenis_perhitungan_pembayaran,
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
                jenis_perhitungan_id,
                jenis_pembayaran_id,
                id_data_member,
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
            // Pengecekan Jenis Pembayaran
            // ===============================

            if (!jenis_pembayaran_id) {
                return res.status(400).json({
                    success: false,
                    message: 'Jenis pembayaran wajib diisi.',
                })
            }

            const paymentMethod = await payment.findOne({
                where: { id: jenis_pembayaran_id },
            })

            if (!paymentMethod) {
                return res.status(404).json({
                    success: false,
                    message: `Jenis pembayaran dengan ID ${jenis_pembayaran_id} tidak ditemukan.`,
                })
            }

            // Daftar metode tanpa perhitungan tarif
            const metodeTanpaTarif = ['VOUCHER', 'FREE', 'PREPAID']

            // === LOGIKA UNTUK CASUAL ===
            if (!id_data_member) {
                if (paymentMethod.jenis_payment.toUpperCase() === 'MEMBER') {
                    return res.status(400).json({
                        success: false,
                        message: `Transaksi casual tidak boleh menggunakan jenis pembayaran "Member".`,
                    })
                }

                if (
                    metodeTanpaTarif.includes(
                        paymentMethod.jenis_payment?.toUpperCase()
                    )
                ) {
                    biayaParkir = 0
                    jumlahDendaTiket = 0
                    jumlahDendaSTNK = 0
                    totalBayar = 0
                    // lanjut simpan transaksi casual tanpa perhitungan tarif
                } else {
                    // Informasi, tapi tidak return supaya alur lanjut ke perhitungan tarif
                    console.log(
                        `Transaksi casual dengan jenis pembayaran "${paymentMethod.jenis_payment}" boleh dilanjutkan ke perhitungan tarif.`
                    )
                }

                // ===============================
                // Pengecekan Jenis Perhitungan
                // ===============================
                if (!jenis_perhitungan_id) {
                    return res.status(400).json({
                        success: false,
                        message:
                            'Jenis perhitungan wajib diisi untuk transaksi casual yang dihitung tarifnya.',
                    })
                }

                // Ambil data jenis perhitungan dari DB
                const jenisPerhitungan =
                    await jenis_perhitungan_pembayaran.findOne({
                        where: { id: jenis_perhitungan_id },
                    })

                if (!jenisPerhitungan) {
                    return res.status(404).json({
                        success: false,
                        message: `Jenis perhitungan dengan ID ${jenis_perhitungan_id} tidak ditemukan.`,
                    })
                }

                // Kembalikan info ID dan nama jenis perhitungan
                // return res.status(200).json({
                //     success: true,
                //     message: `Jenis perhitungan siap diproses.`,
                //     data: {
                //         id: jenisPerhitungan.id,
                //         nama: jenisPerhitungan.nama,
                //     },
                // })

                // === Ganti return info saja dengan perhitungan sementara ===
                // ===============================
                // Ambil kendaraan dari transaksi
                // ===============================
                const kendaraanData = await kendaraan.findOne({
                    where: { id: data.kendaraan_id },
                    include: [
                        {
                            model: tarif_parkir,
                            as: 'tarif_parkir',
                        },
                    ],
                })

                if (!kendaraanData) {
                    return res.status(404).json({
                        success: false,
                        message: `Kendaraan dengan ID ${data.kendaraan_id} tidak ditemukan.`,
                    })
                }

                // Ambil tarif berdasarkan tipe kendaraan
                const tarifData = kendaraanData.tarif_parkir

                if (!tarifData) {
                    return res.status(404).json({
                        success: false,
                        message:
                            'Data tarif untuk tipe kendaraan ini tidak ditemukan.',
                    })
                }

                // ===============================
                // Perhitungan REGULER
                // ===============================
                if (jenisPerhitungan.nama.toUpperCase() === 'REGULER') {
                    let biayaParkir = 0

                    const tanggalMasuk = new Date(data.tanggal_masuk)
                    const tanggalKeluar = data.tanggal_keluar
                        ? new Date(data.tanggal_keluar)
                        : new Date()

                    let durasiMenit = Math.ceil(
                        (tanggalKeluar - tanggalMasuk) / 60000
                    )

                    if (durasiMenit <= tarifData.grace_period) {
                        biayaParkir = tarifData.tarif_grace_period || 0
                    } else if (durasiMenit <= tarifData.rotasi_pertama) {
                        biayaParkir = tarifData.tarif_rotasi_pertama || 0
                    } else if (durasiMenit <= tarifData.rotasi_kedua) {
                        biayaParkir = tarifData.tarif_rotasi_kedua || 0
                    } else if (durasiMenit <= tarifData.rotasi_ketiga) {
                        biayaParkir = tarifData.tarif_rotasi_ketiga || 0
                    } else {
                        // Jika lebih dari rotasi ketiga
                        biayaParkir =
                            tarifData.tarif_maksimal ||
                            tarifData.tarif_rotasi_ketiga ||
                            0
                    }

                    // Batasi biaya dengan tarif maksimal
                    if (
                        tarifData.tarif_maksimal !== null &&
                        biayaParkir > tarifData.tarif_maksimal
                    ) {
                        biayaParkir = tarifData.tarif_maksimal
                    }

                    return res.status(200).json({
                        success: true,
                        message: `Perhitungan sementara (Reguler): ${biayaParkir}`,
                    })
                }
            }

            // === LOGIKA UNTUK MEMBER ===
            else {
                return res.status(200).json({
                    success: false,
                    message: `#002 Transaksi casual dengan jenis pembayaran member boleh dilakukan untuk nomor polisi tidak terdaftar di data member.`,
                })
            }

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
