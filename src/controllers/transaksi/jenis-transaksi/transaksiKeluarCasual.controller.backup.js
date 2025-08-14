const { transaksi, tarif_parkir, tarif_denda, data_voucher, payment } = require('../../../models')
const dayjs = require('dayjs')

module.exports = {
    create: async (req, res) => {
        try {
            // ===============================
            // Ambil data tarif parkir & denda
            // ===============================
            const dataTarifParkir = await tarif_parkir.findOne({
                where: { kendaraan_id: req.body.kendaraan_id },
            })
            const dataTarifDenda = await tarif_denda.findOne({
                where: { kendaraan_id: req.body.kendaraan_id },
            })

            if (!dataTarifParkir)
                return res.status(404).json({ success: false, message: 'Tarif parkir tidak ditemukan' })
            if (!dataTarifDenda)
                return res.status(404).json({ success: false, message: 'Tarif denda tidak ditemukan' })

            // ===============================
            // Validasi waktu masuk & keluar
            // ===============================
            const masuk = new Date(dayjs(req.body.tanggal_masuk).format('YYYY-MM-DD HH:mm:ss'))
            const keluar = new Date(dayjs(req.body.tanggal_keluar).format('YYYY-MM-DD HH:mm:ss'))

            if (keluar < masuk)
                return res.status(400).json({ success: false, message: 'waktu_keluar tidak boleh lebih awal dari waktu_masuk' })

            const selisihMs = keluar - masuk
            const selisihJam = Math.ceil(selisihMs / (1000 * 60 * 60))

            // ===============================
            // Hitung biaya parkir dasar (rotasi)
            // ===============================
            let biaya = 0
            const t = dataTarifParkir

            if (selisihJam >= 1) biaya += t.tarif_rotasi_pertama || 0
            if (selisihJam >= 2) biaya += t.tarif_rotasi_kedua || 0
            if (selisihJam >= 3) biaya += (selisihJam - 2) * (t.tarif_rotasi_ketiga || 0)

            // ===============================
            // Terapkan tarif maksimal
            // ===============================
            if (t.tarif_maksimal && biaya > t.tarif_maksimal) {
                biaya = t.tarif_maksimal
            }

            // ===============================
            // Hitung biaya denda
            // ===============================
            let biayaDendaTiket = 0
            let biayaDendaStnk = 0
            const isDenda = req.body.denda === true || req.body.denda === 'true'
            const isTiketHilang = req.body.is_tiket_hilang === true || req.body.is_tiket_hilang === 'true'
            const isStnkHilang = req.body.is_stnk_hilang === true || req.body.is_stnk_hilang === 'true'

            if (isDenda) {
                if (isTiketHilang) biayaDendaTiket = dataTarifDenda.denda_tiket || 0
                if (isStnkHilang) biayaDendaStnk = dataTarifDenda.denda_stnk || 0
            }

            // ===============================
            // Potongan voucher (jika ada)
            // ===============================
            if (req.body.id_data_voucher) {
                const dataVoucher = await data_voucher.findOne({ where: { id: req.body.id_data_voucher } })
                if (dataVoucher) {
                    biaya -= dataVoucher.tarif || 0
                    if (biaya < 0) biaya = 0
                }
            }

            // ===============================
            // Simpan transaksi
            // ===============================
            const data = await transaksi.create({
                ...req.body,
                biaya_parkir: biaya,
                jumlah_denda_tiket: biayaDendaTiket,
                jumlah_denda_stnk: biayaDendaStnk,
                interval: selisihJam,
            })

            return res.json({
                success: true,
                message: 'Transaksi casual berhasil dibuat',
                results: data,
            })
        } catch (err) {
            return res.status(500).json({ success: false, message: err.message })
        }
    },
}
