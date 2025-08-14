const { transaksi, Sequelize } = require('../../../models')
const { Op } = Sequelize

module.exports = {
    create: async (req, res) => {
        try {
            const {
                nomor_polisi,
                kendaraan_id,
                pintu_masuk_id,
                tanggal_masuk,
                petugas_id,
                shift_id,
                is_member,
                is_manual,
                no_tiket,
            } = req.body

            if (!nomor_polisi || !kendaraan_id || !pintu_masuk_id) {
                return res.status(400).json({
                    success: false,
                    message:
                        'Nomor polisi, kendaraan, dan pintu masuk wajib diisi',
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

            // 1. Cek apakah sudah ada transaksi aktif
            const existing = await transaksi.findOne({
                where: {
                    nomor_polisi,
                    tanggal_masuk: { [Op.ne]: null },
                    tanggal_keluar: null,
                    is_active: true,
                },
            })

            if (existing) {
                return res.status(400).json({
                    success: false,
                    message:
                        'Masih ada transaksi aktif untuk kendaraan ini. Harus keluar dulu sebelum masuk lagi.',
                })
            }

            // 2. Validasi untuk casual (non member)
            if (!is_member) {
                if (!is_manual && (!no_tiket || no_tiket.trim() === '')) {
                    return res.status(400).json({
                        success: false,
                        message:
                            'Nomor tiket wajib diisi untuk transaksi casual non-manual.',
                    })
                }
            }

            // 3. Simpan transaksi
            const newData = await transaksi.create({
                nomor_polisi,
                kendaraan_id,
                pintu_masuk_id,
                tanggal_masuk: tanggal_masuk
                    ? new Date(tanggal_masuk)
                    : new Date(),
                petugas_id,
                shift_id,
                is_member: !!is_member,
                is_manual: !!is_manual,
                no_tiket: no_tiket || null,
                is_active: true,
                jumlah_denda_stnk: 0,
                jumlah_denda_tiket: 0,
            })

            // 4. Tentukan pesan
            let message = ''
            if (is_member) {
                message = is_manual
                    ? 'Transaksi Member Manual berhasil dibuat'
                    : 'Transaksi Member berhasil dibuat'
            } else {
                message = is_manual
                    ? 'Transaksi Casual Manual berhasil dibuat'
                    : 'Transaksi Casual berhasil dibuat'
            }

            return res.status(201).json({
                success: true,
                message,
                results: newData,
            })
        } catch (err) {
            return res.status(500).json({
                success: false,
                message: err.message,
            })
        }
    },
}
