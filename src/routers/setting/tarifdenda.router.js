const tarifDendaRouter = require('express').Router()
const tarifDendaController = require('../../controllers/setting/tarifdenda.controller')

tarifDendaRouter.get('/', tarifDendaController.getAll)
tarifDendaRouter.get('/:id', tarifDendaController.findOneById)
tarifDendaRouter.post('/', tarifDendaController.create)
tarifDendaRouter.patch('/:id', tarifDendaController.update)
tarifDendaRouter.delete('/:id', tarifDendaController.delete)

module.exports = tarifDendaRouter
