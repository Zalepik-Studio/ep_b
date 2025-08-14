const namaInterfaceRouter = require('express').Router()
const namaInterfaceController = require('../../../controllers/setting/parameter/nama-interface.controller')

namaInterfaceRouter.get('/', namaInterfaceController.getAll)
namaInterfaceRouter.get('/:id', namaInterfaceController.findOneById)
namaInterfaceRouter.post('/', namaInterfaceController.create)
namaInterfaceRouter.patch('/:id', namaInterfaceController.update)
namaInterfaceRouter.delete('/:id', namaInterfaceController.delete)

module.exports = namaInterfaceRouter
