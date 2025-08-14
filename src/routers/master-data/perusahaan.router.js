const perusahaanRouter = require('express').Router()
const perusahaanController = require('../../controllers/master-data/perusahaan.controller')

perusahaanRouter.get('/', perusahaanController.getAll)
perusahaanRouter.get('/pdf', perusahaanController.generatePdf)
perusahaanRouter.get('/excel', perusahaanController.generateExcel)
perusahaanRouter.get('/:id', perusahaanController.findOneById)
perusahaanRouter.post('/', perusahaanController.create)
perusahaanRouter.patch('/:id', perusahaanController.update)
perusahaanRouter.patch('/status/:id', perusahaanController.updateStatus)
perusahaanRouter.delete('/:id', perusahaanController.delete)

module.exports = perusahaanRouter
