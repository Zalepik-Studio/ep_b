const errorhandler = require('../../helpers/errorhandler.helper')
const transaksiMasukMember = require('./jenis-transaksi/transaksiMasukMember.controller')
const transaksiMasukCasual = require('./jenis-transaksi/transaksiMasukCasual.controller')
const {
    transaksi,
    pos,
    kendaraan,
    user,
    shift,
    tarif_parkir,
    tarif_denda,
    tipe_kendaraan,
    payment,
    data_voucher,
    data_member,
    laporan_transaksi_batal,
    tipe_denda,
    tenant,
    data_nomor_polisi,
} = require('../../models/index')
const dayjs = require('dayjs')
const relativeTime = require('dayjs/plugin/relativeTime')
const { literal } = require('sequelize')
const Op = require('sequelize').Op

dayjs.extend(relativeTime)

module.exports = {
    create: async (req, res) => {
        try {
            // Cari member berdasarkan kendaraan & nomor polisi tanpa filter periode
            const dataMember = await data_nomor_polisi.findOne({
                where: {
                    kendaraan_id: req.body.kendaraan_id,
                    nomor_polisi: req.body.nomor_polisi,
                },
                include: [
                    {
                        model: require('../../models').data_member,
                        as: 'data_member',
                    },
                ],
            })

            if (dataMember) {
                // Selalu diarahkan ke transaksi member
                return transaksiMasukMember.create(req, res, dataMember)
            } else {
                return transaksiMasukCasual.create(req, res)
            }
        } catch (err) {
            res.status(500).json({ success: false, message: err.message })
        }
    },
    // create: async (req, res) => {
    //     try {
    //         // ===============================
    //         // Cek apakah anggota member
    //         // ===============================
    //         const dataMember = await data_nomor_polisi.findOne({
    //             where: {
    //                 kendaraan_id: req.body.kendaraan_id,
    //                 nomor_polisi: req.body.nomor_polisi,
    //             },
    //             include: [
    //                 {
    //                     model: data_member,
    //                     as: 'data_member',
    //                     where: {
    //                         periode: {
    //                             [Op.contains]: dayjs().format('YYYY-MM-DD'), // masih aktif
    //                         },
    //                     },
    //                 },
    //             ],
    //         })

    //         if (dataMember) {
    //             // Anggota member
    //             const jenisPembayaran = await payment.findOne({
    //                 where: { id: req.body.jenis_pembayaran_id },
    //             })

    //             if (
    //                 !jenisPembayaran ||
    //                 jenisPembayaran.jenis_payment.toLowerCase() !== 'member'
    //             ) {
    //                 return res.status(400).json({
    //                     success: false,
    //                     message:
    //                         'Jenis pembayaran untuk member hanya boleh "member"',
    //                 })
    //             }

    //             req.body.biaya_parkir = 0
    //         }

    //         // ===============================
    //         // Cek jenis perhitungan pembayaran
    //         // ===============================

    //         // ===============================
    //         // Ambil data tarif parkir & denda
    //         // ===============================
    //         const dataTarifParkir = await tarif_parkir.findOne({
    //             where: { kendaraan_id: req.body.kendaraan_id },
    //         })

    //         const dataTarifDenda = await tarif_denda.findOne({
    //             where: { kendaraan_id: req.body.kendaraan_id },
    //         })

    //         if (!dataTarifParkir) {
    //             return res.status(404).json({
    //                 success: false,
    //                 message: 'Tarif parkir tidak ditemukan',
    //             })
    //         }

    //         if (!dataTarifDenda) {
    //             return res.status(404).json({
    //                 success: false,
    //                 message: 'Tarif denda tidak ditemukan',
    //             })
    //         }

    //         // ===============================
    //         // Validasi waktu masuk & keluar
    //         // ===============================
    //         const waktu_masuk = dayjs(req.body.tanggal_masuk).format(
    //             'YYYY-MM-DD HH:mm:ss'
    //         )
    //         const waktu_keluar = dayjs(req.body.tanggal_keluar).format(
    //             'YYYY-MM-DD HH:mm:ss'
    //         )

    //         if (!waktu_masuk || !waktu_keluar) {
    //             return res.status(400).json({
    //                 success: false,
    //                 message: 'Waktu Masuk dan Waktu Keluar wajib diisi',
    //             })
    //         }

    //         const masuk = new Date(waktu_masuk)
    //         const keluar = new Date(waktu_keluar)

    //         if (keluar < masuk) {
    //             return res.status(400).json({
    //                 success: false,
    //                 message:
    //                     'waktu_keluar tidak boleh lebih awal dari waktu_masuk',
    //             })
    //         }

    //         const selisihMs = keluar - masuk
    //         const selisihJam = Math.ceil(selisihMs / (1000 * 60 * 60))

    //         // ===============================
    //         // Hitung biaya parkir dasar (jika bukan member)
    //         // ===============================
    //         let biaya = 0
    //         if (!dataMember) {
    //             const tarifPertama = dataTarifParkir.tarif_rotasi_pertama || 0
    //             const tarifKedua = dataTarifParkir.tarif_rotasi_kedua || 0
    //             const tarifKetiga = dataTarifParkir.tarif_rotasi_ketiga || 0

    //             if (selisihJam >= 1) biaya += tarifPertama
    //             if (selisihJam >= 2) biaya += tarifKedua
    //             if (selisihJam >= 3) biaya += (selisihJam - 2) * tarifKetiga
    //         }

    //         // ===============================
    //         // Hitung biaya denda
    //         // ===============================
    //         const isDenda = req.body.denda === true || req.body.denda === 'true'
    //         const isTiketHilang =
    //             req.body.is_tiket_hilang === true ||
    //             req.body.is_tiket_hilang === 'true'
    //         const isStnkHilang =
    //             req.body.is_stnk_hilang === true ||
    //             req.body.is_stnk_hilang === 'true'

    //         let biayaDendaTiket = 0
    //         let biayaDendaStnk = 0

    //         if (isDenda) {
    //             if (isTiketHilang)
    //                 biayaDendaTiket = dataTarifDenda.denda_tiket || 0
    //             if (isStnkHilang)
    //                 biayaDendaStnk = dataTarifDenda.denda_stnk || 0
    //         }

    //         // ===============================
    //         // Jika ada voucher, kurangi biaya parkir (kecuali member)
    //         // ===============================
    //         if (req.body.id_data_voucher && !dataMember) {
    //             const dataVoucher = await data_voucher.findOne({
    //                 where: { id: req.body.id_data_voucher },
    //             })

    //             if (dataVoucher) {
    //                 const nilaiVoucher = dataVoucher.tarif || 0
    //                 biaya = biaya - nilaiVoucher
    //                 if (biaya < 0) biaya = 0 // jangan minus
    //             }
    //         }

    //         // ===============================
    //         // Simpan transaksi
    //         // ===============================
    //         const data = await transaksi.create({
    //             ...req.body,
    //             biaya_parkir: biaya,
    //             jumlah_denda_tiket: biayaDendaTiket,
    //             jumlah_denda_stnk: biayaDendaStnk,
    //             interval: selisihJam,
    //         })

    //         return res.json({
    //             success: true,
    //             message: 'Create transaksi tunai successfully',
    //             results: data,
    //         })
    //     } catch (err) {
    //         return errorhandler(res, err)
    //     }
    // },
    getAll: async (req, res) => {
        try {
            const search = req.query.search || ''
            const limit = req.query.limit ? parseInt(req.query.limit) : 10
            const page = req.query.page ? parseInt(req.query.page) : 1
            const offset = limit && page ? (page - 1) * limit : 0
            const sortBy = req.query.sortBy || 'id'
            const sortOrder =
                req.query.sortOrder?.toUpperCase() === 'DESC' ? 'DESC' : 'ASC'

            const allowedSortColumns = [
                'id',
                'nopol',
                'nomor_kartu',
                'waktu_masuk',
                'waktu_keluar',
                'biaya',
                'denda',
                'createdAt',
                'updatedAt',
            ]
            const validSortBy = allowedSortColumns.includes(sortBy)
                ? sortBy
                : 'id'

            const options = {
                where: {},
                include: [
                    {
                        model: pos,
                        as: 'pintu_masuk',
                        attributes: ['id', 'keterangan'],
                    },
                    {
                        model: pos,
                        as: 'pintu_keluar',
                        attributes: ['id', 'keterangan'],
                    },
                    {
                        model: kendaraan,
                        as: 'kendaraan',
                        attributes: [
                            'id',
                            'nama_kendaraan',
                            'tipe_kendaraan_id',
                        ],
                        include: [
                            {
                                model: tipe_kendaraan,
                                as: 'tipe_kendaraan',
                                attributes: ['id', 'tipe_kendaraan'],
                            },
                        ],
                    },
                    {
                        model: shift,
                        as: 'shift',
                        attributes: [
                            'id',
                            'nama_shift',
                            'awal_shift',
                            'akhir_shift',
                        ],
                    },
                    {
                        model: user,
                        as: 'petugas',
                        attributes: ['id', 'nama'],
                    },
                    {
                        model: payment,
                        as: 'jenis_pembayaran',
                        attributes: ['id', 'jenis_payment', 'status'],
                    },
                    {
                        model: data_voucher,
                        as: 'data_voucher',
                    },
                    {
                        model: data_member,
                        as: 'data_member',
                    },
                    {
                        model: tipe_denda,
                        as: 'tipe_denda',
                    },
                    {
                        model: tenant,
                        as: 'tenant',
                        attributes: ['id', 'nama_tenant'],
                    },
                ],
                order: [[validSortBy, sortOrder]],
            }

            if (search) {
                const searchLower = search.toLowerCase()
                let statusFilter = null

                if (searchLower === 'true' || searchLower === '1') {
                    statusFilter = true
                } else if (searchLower === 'false' || searchLower === '0') {
                    statusFilter = false
                }
                //=================================================================
                // Berhasil Untuk Pencarian Nomor Tiket dan Nomor Polisi
                //=================================================================
                options.where[Op.or] = [
                    { no_tiket: { [Op.iLike]: `%${search}%` } },
                    { nomor_polisi: { [Op.iLike]: `%${search}%` } },
                    //Kolom Tidak Ditemukan
                    // {
                    //     no_tiket_atau_tiket_manual: {
                    //         [Op.iLike]: `%${search}%`,
                    //     },
                    // },
                    ,
                ]

                /*
                options.where[Op.or] = [
                    literal(
                        `CAST("tanggal_masuk" AS TEXT) ILIKE '%${search}%'`
                    ),
                    {
                        '$pintu_masuk.keterangan$': {
                            [Op.iLike]: `%${search}%`,
                        },
                    },
                    //=======================================================================
                    //Kolom Tidak Ditemukan
                    //=======================================================================
                    // {
                    //     no_tiket_atau_tiket_manual: {
                    //         [Op.iLike]: `%${search}%`,
                    //     },
                    // },
                    {
                        '$kendaraan.nama_kendaraan$': {
                            [Op.iLike]: `%${search}%`,
                        },
                    },
                    { nomor_polisi: { [Op.iLike]: `%${search}%` } },
                    {
                        '$pintu_keluar.keterangan$': {
                            [Op.iLike]: `%${search}%`,
                        },
                    },
                    {
                        tanggal_keluar: {
                            [Op.iLike]: `%${search}%`,
                        },
                    },
                    {
                        '$petugas.nama$': {
                            [Op.iLike]: `%${search}%`,
                        },
                    },
                    {
                        '$shift.nama_shift$': {
                            [Op.iLike]: `%${search}%`,
                        },
                    },

                    ...(statusFilter !== null
                        ? [{ denda: statusFilter, is_active: statusFilter }]
                        : []),

                    {
                        '$kendaraan.nama_kendaraan$': {
                            [Op.iLike]: `%${search}%`,
                        },
                    },

                    {
                        '$tipe_denda.tipe_denda$': {
                            [Op.iLike]: `%${search}%`,
                        },
                    },

                    {
                        '$jenis_pembayaran.jenis_payment$': {
                            [Op.iLike]: `%${search}%`,
                        },
                    },

                    {
                        biaya_parkir: {
                            [Op.iLike]: `%${search}%`,
                        },
                    },

                    literal(
                        `CAST("jumlah_denda_stnk" AS TEXT) ILIKE '%${search}%'`
                    ),

                    literal(
                        `CAST("jumlah_denda_tiket" AS TEXT) ILIKE '%${search}%'`
                    ),

                    {
                        interval: {
                            [Op.iLike]: `%${search}%`,
                        },
                    },

                    {
                        keterangan_atau_penjelasan: {
                            [Op.iLike]: `%${search}%`,
                        },
                    },
                ]
                */
            }

            if (limit) {
                options.limit = limit
                options.offset = offset
            }

            const { count, rows } = await transaksi.findAndCountAll(options)

            return res.json({
                success: true,
                message: 'Get all transaksi successfully',
                results: {
                    data: rows,
                    totalData: count,
                    totalPages: limit ? Math.ceil(count / limit) : 1,
                    currentPage: page,
                    pageSize: limit || count,
                },
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    findOneById: async (req, res) => {
        try {
            const data = await transaksi.findAll({
                where: {
                    id: req.params.id,
                },
            })
            return res.json({
                success: true,
                message: 'Get transaksi tunai successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    update: async (req, res) => {
        try {
            const data = await transaksi.update(req.body, {
                where: {
                    id: req.params.id,
                },
            })
            return res.json({
                success: true,
                message: 'Update transaksi tunai successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    cancelTransaksi: async (req, res) => {
        try {
            const { no_tiket_atau_nomor_polisi } = req.query
            const { alasan_pembatalan, penjelasan_pembatalan, user_id } =
                req.body

            if (!no_tiket_atau_nomor_polisi) {
                return res.status(400).json({
                    message:
                        'Harus menyertakan no_tiket_atau_nomor_polisi di query',
                })
            }

            const transaksiData = await transaksi.findOne({
                where: {
                    is_active: true,
                    [Op.or]: [
                        { no_tiket: no_tiket_atau_nomor_polisi },
                        { nomor_polisi: no_tiket_atau_nomor_polisi },
                    ],
                },
            })

            if (!transaksiData) {
                return res.status(404).json({
                    message: 'Transaksi tidak ditemukan atau sudah tidak aktif',
                })
            }

            await transaksi.update(
                { is_active: false },
                {
                    where: { id: transaksiData.id },
                }
            )

            const laporan = await laporan_transaksi_batal.create({
                no_tiket: transaksiData.no_tiket,
                tanggal_masuk: transaksiData.tanggal_masuk,
                pintu_masuk_id: transaksiData.pintu_masuk_id,
                tanggal_pembatalan: new Date(),
                alasan_pembatalan,
                penjelasan_pembatalan,
                user_id,
            })

            return res.status(200).json({
                message: 'Transaksi berhasil dibatalkan',
                data: laporan,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    delete: async (req, res) => {
        try {
            const data = await transaksi.destroy({
                where: {
                    id: req.params.id,
                },
            })
            return res.json({
                success: true,
                message: 'Delete transaksi tunai successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
}
