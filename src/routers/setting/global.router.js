const globalRouter = require('express').Router()
const globalController = require('../../controllers/setting/global.controller')

globalRouter.get('/', globalController.getAll)
globalRouter.get('/pdf', globalController.generatePdf)
globalRouter.get('/excel', globalController.generateExcel)
globalRouter.get('/:id', globalController.findOneById)
globalRouter.post('/', globalController.create)
globalRouter.patch('/:id', globalController.update)
globalRouter.delete('/:id', globalController.delete)

module.exports = globalRouter
