const { Op } = require('sequelize')
const errorhandler = require('../../helpers/errorhandler.helper')
const {
    level_pengguna,
    user,
    perusahaan,
    tenant,
} = require('../../models/index')

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

            const allowedSortColumns = ['id', 'nama', 'createdAt', 'updatedAt']
            const validSortBy = allowedSortColumns.includes(sortBy)
                ? sortBy
                : 'id'

            const options = {
                where: {},
                include: [
                    {
                        model: user,
                        as: 'user',
                        attributes: ['id', 'nama'],
                    },
                    {
                        model: perusahaan,
                        as: 'perusahaan',
                        attributes: ['id', 'nama', 'jenis_perusahaan'],
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
                options.where[Op.or] = [
                    { nama: { [Op.iLike]: `%${search}%` } },
                    { '$perusahaan.nama$': { [Op.iLike]: `%${search}%` } },
                    { '$user.nama$': { [Op.iLike]: `%${search}%` } },
                ]
            }

            if (limit) {
                options.limit = limit
                options.offset = offset
            }

            const { count, rows } = await level_pengguna.findAndCountAll(
                options
            )

            return res.json({
                success: true,
                message: 'Get all level pengguna successfully',
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

    getAllAdminTenant: async (req, res) => {
        try {
            const search = (req.query.search || '').trim()
            const limit = req.query.limit ? parseInt(req.query.limit, 10) : 10
            const page = req.query.page ? parseInt(req.query.page, 10) : 1
            const offset = (page - 1) * limit
            const sortBy = req.query.sortBy || 'id'
            const sortOrder =
                req.query.sortOrder?.toUpperCase() === 'DESC' ? 'DESC' : 'ASC'

            const allowedSortColumns = ['id', 'nama', 'createdAt', 'updatedAt']
            const validSortBy = allowedSortColumns.includes(sortBy)
                ? sortBy
                : 'id'

            const perusahaanId = req.query.perusahaan_id
                ? parseInt(req.query.perusahaan_id, 10)
                : null

            if (!perusahaanId) {
                return res.status(400).json({
                    success: false,
                    message:
                        'perusahaan_id wajib dikirim sebagai query parameter',
                })
            }

            // Base filter: hanya data milik perusahaan ini
            const where = { perusahaan_id: perusahaanId }

            // Optional: search, tanpa menghilangkan filter perusahaan
            if (search) {
                where[Op.and] = [
                    {
                        [Op.or]: [
                            { nama: { [Op.iLike]: `%${search}%` } }, // Postgres (iLike)
                            {
                                '$perusahaan.nama$': {
                                    [Op.iLike]: `%${search}%`,
                                },
                            },
                            { '$user.nama$': { [Op.iLike]: `%${search}%` } },
                        ],
                    },
                ]
            }

            const options = {
                where,
                include: [
                    { model: user, as: 'user', attributes: ['id', 'nama'] },
                    {
                        model: perusahaan,
                        as: 'perusahaan',
                        attributes: ['id', 'nama', 'jenis_perusahaan'],
                    },
                    {
                        model: tenant,
                        as: 'tenant',
                        attributes: ['id', 'nama_tenant'],
                    },
                ],
                order: [[validSortBy, sortOrder]],
                limit,
                offset,
                distinct: true,
            }

            const { count, rows } = await level_pengguna.findAndCountAll(
                options
            )

            return res.json({
                success: true,
                message: 'Get level pengguna by perusahaan_id successfully',
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

    getAllCustomUser: async (req, res) => {
        try {
            const search = req.query.search || ''
            const limit = req.query.limit ? parseInt(req.query.limit) : 10
            const page = req.query.page ? parseInt(req.query.page) : 1
            const offset = limit && page ? (page - 1) * limit : 0
            const sortBy = req.query.sortBy || 'id'
            const sortOrder =
                req.query.sortOrder?.toUpperCase() === 'DESC' ? 'DESC' : 'ASC'

            const allowedSortColumns = ['id', 'nama', 'createdAt', 'updatedAt']
            const validSortBy = allowedSortColumns.includes(sortBy)
                ? sortBy
                : 'id'

            const options = {
                where: {
                    nama: {
                        [Op.notIn]: [
                            'Super Administrator',
                            'Administrator Tenant',
                        ],
                    },
                },
                include: [
                    {
                        model: user,
                        as: 'user',
                        attributes: ['id', 'nama'],
                    },
                    {
                        model: perusahaan,
                        as: 'perusahaan',
                        attributes: ['id', 'nama', 'jenis_perusahaan'],
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
                options.where[Op.or] = [
                    { nama: { [Op.iLike]: `%${search}%` } },
                    { '$perusahaan.nama$': { [Op.iLike]: `%${search}%` } },
                    { '$user.nama$': { [Op.iLike]: `%${search}%` } },
                ]
            }

            if (limit) {
                options.limit = limit
                options.offset = offset
            }

            const { count, rows } = await level_pengguna.findAndCountAll(
                options
            )

            return res.json({
                success: true,
                message: 'Get all level pengguna successfully',
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
            const data = await level_pengguna.create({
                ...req.body,
                hak_akses: JSON.parse(req.body.hak_akses),
            })
            return res.json({
                success: true,
                message: 'Create level pengguna successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    findOneById: async (req, res) => {
        try {
            const data = await level_pengguna.findAll({
                where: {
                    id: req.params.id,
                },
            })
            return res.json({
                success: true,
                message: 'Get level pengguna successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    updateNama: async (req, res) => {
        try {
            const data = await level_pengguna.update(
                { nama: req.body.nama, perusahaan_id: req.body.perusahaan_id },
                {
                    where: {
                        id: req.params.id,
                    },
                }
            )
            return res.json({
                success: true,
                message: 'Update nama level pengguna successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    update: async (req, res) => {
        try {
            const data = await level_pengguna.update(
                { ...req.body, hak_akses: JSON.parse(req.body.hak_akses) },
                {
                    where: {
                        id: req.params.id,
                    },
                }
            )
            return res.json({
                success: true,
                message: 'Update level pengguna successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
    delete: async (req, res) => {
        try {
            const data = await level_pengguna.destroy({
                where: {
                    id: req.params.id,
                },
            })
            return res.json({
                success: true,
                message: 'Delete level pengguna successfully',
                results: data,
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
}
