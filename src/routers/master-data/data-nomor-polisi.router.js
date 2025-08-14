const dataNomorPolisiRouter = require('express').Router()
const dataNomorPolisiController = require('../../controllers/master-data/data-nomor-polisi.controller')

dataNomorPolisiRouter.get('/', dataNomorPolisiController.getAll)
dataNomorPolisiRouter.get('/:id', dataNomorPolisiController.findOneById)
dataNomorPolisiRouter.post('/', dataNomorPolisiController.create)
dataNomorPolisiRouter.patch('/:id', dataNomorPolisiController.update)
dataNomorPolisiRouter.delete('/:id', dataNomorPolisiController.delete)

module.exports = dataNomorPolisiRouter
