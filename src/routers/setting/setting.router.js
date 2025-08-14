const router = require('express').Router()
const tarifParkirRouter = require('./tarifparkir.router')
const tarifDendaRouter = require('./tarifdenda.router')
const parameterRouter = require('./parameter/index.router')
const globalRouter = require('./global.router')
const paymentRouter = require('./payment.router')

router.use('/tarif-parkir', tarifParkirRouter)
router.use('/tarif-denda', tarifDendaRouter)
router.use('/parameter', parameterRouter)
router.use('/global', globalRouter)
router.use('/payment', paymentRouter)

module.exports = router
