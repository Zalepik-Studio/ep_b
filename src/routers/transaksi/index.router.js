const router = require('express').Router()
const transaksiRouter = require('./transaksi.router')
const permasalahanAtauPerbaikanRouter = require('./permasalahan-atau-perbaikan.router')

router.use('/permasalahan-atau-perbaikan', permasalahanAtauPerbaikanRouter)
router.use('/', transaksiRouter)

module.exports = router
