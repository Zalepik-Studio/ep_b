const namaPrinterRouter = require('express').Router()
const namaPrinterController = require('../../../controllers/setting/parameter/nama-printer.controller')

namaPrinterRouter.get('/', namaPrinterController.getAll)
namaPrinterRouter.get('/:id', namaPrinterController.findOneById)
namaPrinterRouter.post('/', namaPrinterController.create)
namaPrinterRouter.patch('/:id', namaPrinterController.update)
namaPrinterRouter.delete('/:id', namaPrinterController.delete)

module.exports = namaPrinterRouter
