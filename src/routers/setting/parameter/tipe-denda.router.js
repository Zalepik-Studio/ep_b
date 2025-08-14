const tipeDendaRouter = require('express').Router()
const tipeDendaController = require('../../../controllers/setting/parameter/tipe-denda.controller')

tipeDendaRouter.get('/', tipeDendaController.getAll)
tipeDendaRouter.get('/:id', tipeDendaController.findOneById)
tipeDendaRouter.post('/', tipeDendaController.create)
tipeDendaRouter.patch('/:id', tipeDendaController.update)
tipeDendaRouter.delete('/:id', tipeDendaController.delete)

module.exports = tipeDendaRouter
