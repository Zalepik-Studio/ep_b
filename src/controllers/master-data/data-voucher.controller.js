const { literal } = require('sequelize')
const errorhandler = require('../../helpers/errorhandler.helper')
const {
    data_voucher,
    kendaraan,
    produk_voucher,
    tenant,
} = require('../../models/index')

module.exports = {
    getAll: async (req, res) => {
        try {
            const search = req.query.search || ''
            const limit = req.query.limit ? parseInt(req.query.limit) : null
            const page = req.query.page ? parseInt(req.query.page) : null
            const offset = page && limit ? (page - 1) * limit : null
            const sortBy = req.query.sortBy || 'id'
            const sortOrder = req.query.sortOrder || 'asc'

            const options = {
                include: [
                    {
                        model: kendaraan,
                        as: 'kendaraan',
                    },
                    {
                        model: produk_voucher,
                        as: 'produk_voucher',
                    },
                    {
                        model: tenant,
                        as: 'tenant',
                        attributes: ['id', 'nama_tenant'],
                    },
                ],
                order: [[sortBy, sortOrder]],
                where: {},
            }

            if (search) {
                options.where = {
                    [Op.or]: [
                        {
                            '$produk_voucher.nama$': {
                                [Op.iLike]: `%${search}%`,
                            },
                        },
                        literal(`CAST("tarif" AS TEXT) ILIKE '%${search}%'`),
                        literal(
                            `CAST("model_bayar" AS TEXT) ILIKE '%${search}%'`
                        ),
                        literal(
                            `CAST("verifikasi" AS TEXT) ILIKE '%${search}%'`
                        ),
                        { no_tiket_atau_nopol: { [Op.iLike]: `%${search}%` } },
                        {
                            '$kendaraan.nama_kendaraan$': {
                                [Op.iLike]: `%${search}%`,
                            },
                        },
                        {
                            keterangan: {
                                [Op.iLike]: `%${search}%`,
                            },
                        },
                    ],
                }
            }

            if (limit !== null && offset !== null) {
                options.limit = limit
                options.offset = offset
            }

            const { count, rows } = await data_voucher.findAndCountAll(options)

            return res.json({
                success: true,
                message: 'Get all data voucher successfully',
                results: {
                    data: rows,
                    totalData: count,
                    totalPages: limit ? Math.ceil(count / limit) : null,
                    currentPage: page,
                    pageSize: limit,
                },
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    create: async (req, res) => {
        try {
            const data = await data_voucher.create(req.body)
            return res.json({
                success: true,
                message: 'Create data voucher successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    findOneById: async (req, res) => {
        try {
            const data = await data_voucher.findAll({
                where: {
                    id: req.params.id,
                },
            })
            return res.json({
                success: true,
                message: 'Get data voucher successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    update: async (req, res) => {
        try {
            const data = await data_voucher.update(req.body, {
                where: {
                    id: req.params.id,
                },
            })
            return res.json({
                success: true,
                message: 'Update data_voucher successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    delete: async (req, res) => {
        try {
            const data = await data_voucher.destroy({
                where: {
                    id: req.params.id,
                },
            })
            return res.json({
                success: true,
                message: 'Delete data voucher successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
}
