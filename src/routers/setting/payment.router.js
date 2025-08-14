const paymentRouter = require('express').Router()
const paymentController = require('../../controllers/setting/payment.controller')

paymentRouter.get('/', paymentController.getAll)
paymentRouter.get('/pdf', paymentController.generatePdf)
paymentRouter.get('/excel', paymentController.generateExcel)
paymentRouter.get('/:id', paymentController.findOneById)
paymentRouter.post('/', paymentController.create)
paymentRouter.patch('/:id', paymentController.update)
paymentRouter.delete('/:id', paymentController.delete)

module.exports = paymentRouter
