const tipeManlessRouter = require('express').Router()
const tipeManlessController = require('../../../controllers/setting/parameter/tipe-manless.controller')

tipeManlessRouter.get('/', tipeManlessController.getAll)
tipeManlessRouter.get('/:id', tipeManlessController.findOneById)
tipeManlessRouter.post('/', tipeManlessController.create)
tipeManlessRouter.patch('/:id', tipeManlessController.update)
tipeManlessRouter.delete('/:id', tipeManlessController.delete)

module.exports = tipeManlessRouter
