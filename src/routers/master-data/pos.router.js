const posRouter = require('express').Router()
const posController = require('../../controllers/master-data/pos.controller')

posRouter.get('/', posController.getAll)
posRouter.get('/pdf', posController.generatePdf)
posRouter.get('/excel', posController.generateExcel)
posRouter.get('/:id', posController.findOneById)
posRouter.post('/', posController.create)
posRouter.patch('/:id', posController.update)
posRouter.delete('/:id', posController.delete)

module.exports = posRouter
