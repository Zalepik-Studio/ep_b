const errorhandler = require('../../helpers/errorhandler.helper')
const { tenant, user } = require('../../models/index')
const Op = require('sequelize').Op
const argon = require('argon2')

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
                'tenant',
                'createdAt',
                'updatedAt',
            ]
            const validSortBy = allowedSortColumns.includes(sortBy)
                ? sortBy
                : 'id'

            const options = {
                where: {},
                order: [[validSortBy, sortOrder]],
            }

            if (search) {
                options.where[Op.or] = [
                    { tenant: { [Op.iLike]: `%${search}%` } },
                ]
            }

            if (limit) {
                options.limit = limit
                options.offset = offset
            }

            const { count, rows } = await tenant.findAndCountAll(options)

            return res.json({
                success: true,
                message: 'Get all tenant successfully',
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
            const data = await tenant.create(req.body)

            const hashedPassword = await argon.hash(req.body.password)

            await user.create({
                tenant_id: data.id,
                nama: data.nama_tenant,
                username: req.body.username,
                password: hashedPassword,
                level_pengguna_id: 2,
                status: true,
            })

            return res.json({
                success: true,
                message: 'Create tenant successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    findOneById: async (req, res) => {
        try {
            const data = await tenant.findAll({
                where: {
                    id: req.params.id,
                },
            })
            return res.json({
                success: true,
                message: 'Get tenant successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    update: async (req, res) => {
        try {
            const data = await tenant.update(req.body, {
                where: {
                    id: req.params.id,
                },
            })

            const hashedPassword = await argon.hash(req.body.password)

            await user.update(
                {
                    username: req.body.username,
                    password: hashedPassword,
                },
                {
                    where: {
                        tenant_id: req.params.id,
                    },
                }
            )

            return res.json({
                success: true,
                message: 'Update tenant successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    delete: async (req, res) => {
        try {
            const userData = await user.findOne({
                where: {
                    tenant_id: req.params.id,
                },
            })

            if (userData) {
                await user.destroy({
                    where: {
                        tenant_id: req.params.id,
                    },
                })
            }

            const data = await tenant.destroy({
                where: {
                    id: req.params.id,
                },
            })
            return res.json({
                success: true,
                message: 'Delete tenant successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
}
