const { transaksi, payment } = require('../../../models')
const dayjs = require('dayjs')
const isBetween = require('dayjs/plugin/isBetween')
dayjs.extend(isBetween)

module.exports = {
    create: async (req, res, dataMember) => {
        try {
            // ===============================
            // Validasi jenis pembayaran member
            // ===============================
            const jenisPembayaran = await payment.findOne({
                where: { id: req.body.jenis_pembayaran_id },
            })

            if (!jenisPembayaran || jenisPembayaran.jenis_payment.toLowerCase() !== 'member') {
                return res.status(400).json({
                    success: false,
                    message: 'Jenis pembayaran untuk member hanya boleh "member"',
                })
            }

            // ===============================
            // Hitung biaya parkir member = 0
            // ===============================
            req.body.biaya_parkir = 0

            // ===============================
            // Validasi waktu masuk & keluar
            // ===============================
            const masuk = req.body.tanggal_masuk ? new Date(req.body.tanggal_masuk) : null
            const keluar = req.body.tanggal_keluar ? new Date(req.body.tanggal_keluar) : null

            if (masuk && keluar && keluar < masuk) {
                return res.status(400).json({
                    success: false,
                    message: 'waktu_keluar tidak boleh lebih awal dari waktu_masuk',
                })
            }

            const selisihMs = masuk && keluar ? keluar - masuk : 0
            const selisihJam = Math.ceil(selisihMs / (1000 * 60 * 60))

            // ===============================
            // Ambil periode member dari daterange PostgreSQL
            // ===============================
            let periode = dataMember.data_member.periode

            if (Array.isArray(periode)) {
                periode = periode.map((p) => (p && p.value ? p.value : null))
            }

            const periodeMulai = periode[0] ? dayjs(periode[0]) : null
            const periodeAkhir = periode[1] ? dayjs(periode[1]) : null
            const sekarang = dayjs()

            // ===============================
            // Tentukan status masa aktif
            // ===============================
            let success = true
            let message = 'Transaksi member masuk berhasil dibuat'

            const masaAktif =
                periodeMulai &&
                periodeMulai.isValid() &&
                periodeAkhir &&
                periodeAkhir.isValid()
                    ? sekarang.isBetween(periodeMulai, periodeAkhir, 'day', '[]')
                    : false

            if (!masaAktif) {
                if (!keluar) {
                    message = `Transaksi berhasil, kendaraan boleh masuk namun masa aktif member telah habis. Periode: ${
                        periodeMulai && periodeMulai.isValid()
                            ? periodeMulai.format('YYYY-MM-DD')
                            : 'N/A'
                    } s/d ${
                        periodeAkhir && periodeAkhir.isValid()
                            ? periodeAkhir.format('YYYY-MM-DD')
                            : 'N/A'
                    }`
                } else {
                    success = false
                    message = `Masa aktif member habis, harap perpanjang terlebih dahulu. Periode: ${
                        periodeMulai && periodeMulai.isValid()
                            ? periodeMulai.format('YYYY-MM-DD')
                            : 'N/A'
                    } s/d ${
                        periodeAkhir && periodeAkhir.isValid()
                            ? periodeAkhir.format('YYYY-MM-DD')
                            : 'N/A'
                    }`
                }
            }

            // ===============================
            // Simpan transaksi
            // ===============================
            const data = await transaksi.create({
                ...req.body,
                biaya_parkir: 0,
                jumlah_denda_tiket: 0,
                jumlah_denda_stnk: 0,
                interval: selisihJam,
                id_data_member: dataMember.data_member.id,
            })

            // ===============================
            // Tambahkan embel-embel jika manual
            // ===============================
            if (data.is_manual) {
                message = `Transaksi Member Manual - ${message}`
            }

            return res.json({
                success,
                message,
                results: data,
                masa_aktif: {
                    mulai:
                        periodeMulai && periodeMulai.isValid()
                            ? periodeMulai.format('YYYY-MM-DD')
                            : null,
                    akhir:
                        periodeAkhir && periodeAkhir.isValid()
                            ? periodeAkhir.format('YYYY-MM-DD')
                            : null,
                },
            })
        } catch (err) {
            return res.status(500).json({ success: false, message: err.message })
        }
    },
}
