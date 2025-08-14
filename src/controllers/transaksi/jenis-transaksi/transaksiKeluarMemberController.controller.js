const dayjs = require('dayjs')
const isBetween = require('dayjs/plugin/isBetween')
dayjs.extend(isBetween)
const {
    pos,
    kendaraan,
    user,
    shift,
    tarif_parkir,
    tarif_denda,
    tipe_kendaraan,
    payment,
    data_voucher,
    laporan_transaksi_batal,
    tipe_denda,
    tenant,
    data_nomor_polisi,
    transaksi,
    data_member,
    Sequelize,
} = require('../../../models')
const { Op } = Sequelize

module.exports = {
    update: async (req, res) => {
        try {
            const {
                nomor_polisi,
                pintu_keluar_id,
                tanggal_keluar,
                petugas_id,
                shift_id,
                denda,
                tipe_denda_id,
                keterangan_atau_penjelasan,
            } = req.body

            if (!nomor_polisi) {
                return res.status(400).json({
                    success: false,
                    message: 'Nomor polisi wajib diisi',
                })
            }

            // 1. Cari transaksi aktif
            const data = await transaksi.findOne({
                where: {
                    nomor_polisi,
                    tanggal_masuk: { [Op.ne]: null },
                    tanggal_keluar: null,
                    is_active: true,
                },
                include: [
                    {
                        model: data_member,
                        as: 'data_member',
                        attributes: ['id', 'periode'],
                    },
                ],
            })

            if (!data) {
                return res.status(404).json({
                    success: false,
                    message:
                        'Tidak ada transaksi aktif. Silakan input transaksi masuk manual terlebih dahulu.',
                })
            }

            // 2. Validasi tanggal keluar
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

            const selisihMs = keluar - masuk
            const selisihJam = Math.ceil(selisihMs / (1000 * 60 * 60))

            // 3. Cek masa aktif member
            let periode = data.data_member?.periode || []
            if (Array.isArray(periode)) {
                periode = periode.map((p) => (p && p.value ? p.value : null))
            }

            const periodeMulai = periode[0] ? dayjs(periode[0]) : null
            const periodeAkhir = periode[1] ? dayjs(periode[1]) : null
            const sekarang = dayjs()

            const masaAktif =
                periodeMulai &&
                periodeMulai.isValid() &&
                periodeAkhir &&
                periodeAkhir.isValid() &&
                sekarang.isBetween(periodeMulai, periodeAkhir, 'day', '[]')

            if (!masaAktif) {
                return res.status(403).json({
                    success: false,
                    message: `Masa aktif member telah habis. Periode: ${
                        periodeMulai && periodeMulai.isValid()
                            ? periodeMulai.format('YYYY-MM-DD')
                            : 'N/A'
                    } s/d ${
                        periodeAkhir && periodeAkhir.isValid()
                            ? periodeAkhir.format('YYYY-MM-DD')
                            : 'N/A'
                    }. Silakan perpanjang masa aktif terlebih dahulu.`,
                })
            }

            // 4. Update transaksi
            await data.update({
                tanggal_keluar: keluar,
                pintu_keluar_id,
                petugas_id,
                shift_id,
                interval: selisihJam,
                biaya_parkir: 0, // member gratis
                denda,
                tipe_denda_id,
                keterangan_atau_penjelasan: keterangan_atau_penjelasan || null,
            })

            // 5. Beri embel-embel jika manual
            let message = 'Transaksi member keluar berhasil'
            if (data.is_manual) {
                message = `Transaksi Member Manual - ${message}`
            }

            return res.json({
                success: true,
                message,
                results: data,
                masa_aktif: {
                    mulai: periodeMulai.format('YYYY-MM-DD'),
                    akhir: periodeAkhir.format('YYYY-MM-DD'),
                },
            })
        } catch (err) {
            return res.status(500).json({
                success: false,
                message: err.message,
            })
        }
    },
}
