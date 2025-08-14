const { literal } = require('sequelize')
const errorhandler = require('../../helpers/errorhandler.helper')
const { produk_voucher, user, tenant } = require('../../models/index')

module.exports = {
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
                'nama',
                'tarif',
                'createdAt',
                'updatedAt',
            ]
            const validSortBy = allowedSortColumns.includes(sortBy)
                ? sortBy
                : 'id'

            const options = {
                where: {},
                order: [[validSortBy, sortOrder]],
                include: [
                    {
                        model: tenant,
                        as: 'tenant',
                        attributes: ['id', 'nama_tenant'],
                    },
                ],
            }

            if (search) {
                const searchLower = search.toLowerCase()
                let statusFilter = null

                if (searchLower === 'true' || searchLower === '1') {
                    statusFilter = true
                } else if (searchLower === 'false' || searchLower === '0') {
                    statusFilter = false
                }

                options.where[Op.or] = [
                    { nama: { [Op.iLike]: `%${search}%` } },
                    literal(`CAST("periode" AS TEXT) ILIKE '%${search}%'`),
                    literal(
                        `CAST("list_id_kendaraan" AS TEXT) ILIKE '%${search}%'`
                    ),
                    literal(`CAST("tarif" AS TEXT) ILIKE '%${search}%'`),
                    { model_pembayaran: { [Op.iLike]: `%${search}%` } },
                    { metode_verifikasi: { [Op.iLike]: `%${search}%` } },
                    ...(statusFilter !== null
                        ? [
                              {
                                  status: statusFilter,
                              },
                          ]
                        : []),
                    { '$user.nama$': { [Op.iLike]: `%${search}%` } },
                ]
            }

            if (limit) {
                options.limit = limit
                options.offset = offset
            }

            const { count, rows } = await produk_voucher.findAndCountAll(
                options
            )

            return res.json({
                success: true,
                message: 'Get all produk voucher successfully',
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
    create: async (req, res) => {
        try {
            const data = await produk_voucher.create(req.body)
            return res.json({
                success: true,
                message: 'Create produk voucher successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    findOneById: async (req, res) => {
        try {
            const data = await produk_voucher.findAll({
                include: [
                    {
                        model: user,
                        as: 'user',
                        attributes: ['id', 'nama'],
                    },
                ],
                where: {
                    id: req.params.id,
                },
            })
            return res.json({
                success: true,
                message: 'Get produk voucher successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    update: async (req, res) => {
        try {
            const data = await produk_voucher.update(req.body, {
                where: {
                    id: req.params.id,
                },
            })
            return res.json({
                success: true,
                message: 'Update produk voucher successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    updateStatus: async (req, res) => {
        try {
            const data = await produk_voucher.update(
                { status: req.body.status },
                {
                    where: {
                        id: req.params.id,
                    },
                }
            )
            return res.json({
                success: true,
                message: 'Update produk voucher successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    delete: async (req, res) => {
        try {
            const data = await produk_voucher.destroy({
                where: {
                    id: req.params.id,
                },
            })
            return res.json({
                success: true,
                message: 'Delete produk voucher successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
}
