const produkVoucherRouter = require('express').Router()
const produkVoucherController = require('../../controllers/master-data/produk-voucher.controller')

produkVoucherRouter.get('/', produkVoucherController.getAll)
produkVoucherRouter.get('/:id', produkVoucherController.findOneById)
produkVoucherRouter.post('/', produkVoucherController.create)
produkVoucherRouter.patch('/:id', produkVoucherController.update)
produkVoucherRouter.patch('/status/:id', produkVoucherController.updateStatus)
produkVoucherRouter.delete('/:id', produkVoucherController.delete)

module.exports = produkVoucherRouter
