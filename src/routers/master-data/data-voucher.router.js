const dataVoucherRouter = require('express').Router()
const dataVoucherController = require('../../controllers/master-data/data-voucher.controller')

dataVoucherRouter.get('/', dataVoucherController.getAll)
dataVoucherRouter.get('/:id', dataVoucherController.findOneById)
dataVoucherRouter.post('/', dataVoucherController.create)
dataVoucherRouter.patch('/:id', dataVoucherController.update)
dataVoucherRouter.delete('/:id', dataVoucherController.delete)

module.exports = dataVoucherRouter
