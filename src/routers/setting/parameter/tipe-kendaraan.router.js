const tipeKendaraanRouter = require('express').Router()
const tipeKendaraanController = require('../../../controllers/setting/parameter/tipe-kendaraan.controller')

tipeKendaraanRouter.get('/', tipeKendaraanController.getAll)
tipeKendaraanRouter.get('/:id', tipeKendaraanController.findOneById)
tipeKendaraanRouter.post('/', tipeKendaraanController.create)
tipeKendaraanRouter.patch('/:id', tipeKendaraanController.update)
tipeKendaraanRouter.delete('/:id', tipeKendaraanController.delete)

module.exports = tipeKendaraanRouter
