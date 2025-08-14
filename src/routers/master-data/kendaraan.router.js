const kendaraanRouter = require('express').Router()
const kendaraanController = require('../../controllers/master-data/kendaraan.controller')

kendaraanRouter.get('/', kendaraanController.getAll)
kendaraanRouter.get('/pdf', kendaraanController.generatePdf)
kendaraanRouter.get('/excel', kendaraanController.generateExcel)
kendaraanRouter.get('/:id', kendaraanController.findOneById)
kendaraanRouter.post('/', kendaraanController.create)
kendaraanRouter.patch('/:id', kendaraanController.update)
kendaraanRouter.patch('/status/:id', kendaraanController.updateStatus)
kendaraanRouter.delete('/:id', kendaraanController.delete)

module.exports = kendaraanRouter
