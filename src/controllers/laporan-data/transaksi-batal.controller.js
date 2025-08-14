const { convertMMDDYYYYtoYYYYMMDD } = require('../../helpers/dateformat.helper')
const errorhandler = require('../../helpers/errorhandler.helper')
const { Op } = require('sequelize')
const { pos, user, laporan_transaksi_batal } = require('../../models/index')

module.exports = {
    getAllPembatalanTransaksi: async (req, res) => {
        try {
            const search = req.query.search || ''
            const start_date = req.query.start_date
            const end_date = req.query.end_date
            const limit = req.query.limit ? parseInt(req.query.limit) : 10
            const page = req.query.page ? parseInt(req.query.page) : 1
            const offset = limit && page ? (page - 1) * limit : 0
            const sortBy = req.query.sortBy || 'id'
            const sortOrder =
                req.query.sortOrder?.toUpperCase() === 'DESC' ? 'DESC' : 'ASC'

            const allowedSortColumns = [
                'id',
                'no_tiket',
                'tanggal_masuk',
                'pintu_masuk_id',
                'tanggal_pembatalan',
                'alasan_pembatalan',
                'penjelasan_pembatalan',
                'user_id',
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
                        model: user,
                        as: 'user',
                        attributes: ['id', 'nama'],
                    },
                ],
                order: [[validSortBy, sortOrder]],
            }

            const mmddyyyyRegex = /^\d{2}-\d{2}-\d{4}$/
            if (start_date && end_date) {
                if (
                    !mmddyyyyRegex.test(start_date) ||
                    !mmddyyyyRegex.test(end_date)
                ) {
                    return res.status(400).json({
                        success: false,
                        message: 'Format tanggal harus mm-dd-yyyy',
                    })
                }
                const startSQL = convertMMDDYYYYtoYYYYMMDD(start_date)
                const endSQL = convertMMDDYYYYtoYYYYMMDD(end_date)

                options.where.createdAt = {
                    [Op.between]: [startSQL, endSQL],
                }
            }

            if (search) {
                options.where[Op.or] = [
                    literal(
                        `CAST("tanggal_masuk" AS TEXT) ILIKE '%${search}%'`
                    ),
                    {
                        '$pintu_masuk.keterangan$': {
                            [Op.iLike]: `%${search}%`,
                        },
                    },
                    { no_tiket: { [Op.iLike]: `%${search}%` } },
                    { alasan_pembatalan: { [Op.iLike]: `%${search}%` } },
                    { penjelasan_pembatalan: { [Op.iLike]: `%${search}%` } },
                ]
            }

            if (limit) {
                options.limit = limit
                options.offset = offset
            }

            const { count, rows } =
                await laporan_transaksi_batal.findAndCountAll(options)

            return res.json({
                success: true,
                message: 'Get all laporan transaksi batal successfully',
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
}
