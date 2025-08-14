const levelPenggunaRouter = require('express').Router()
const levelPenggunaController = require('../../controllers/master-data/level-pengguna.controller')

levelPenggunaRouter.get('/', levelPenggunaController.getAll)
levelPenggunaRouter.get(
    '/admin-tenant',
    levelPenggunaController.getAllAdminTenant
)
levelPenggunaRouter.get(
    '/custom-user',
    levelPenggunaController.getAllCustomUser
)
levelPenggunaRouter.get('/:id', levelPenggunaController.findOneById)
levelPenggunaRouter.post('/', levelPenggunaController.create)
levelPenggunaRouter.patch('/nama/:id', levelPenggunaController.updateNama)
levelPenggunaRouter.patch('/:id', levelPenggunaController.update)
levelPenggunaRouter.delete('/:id', levelPenggunaController.delete)

module.exports = levelPenggunaRouter
