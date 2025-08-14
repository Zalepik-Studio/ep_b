const router = require('express').Router()
const kendaraanRouter = require('./kendaraan.router')
const pendapatanParkirRouter = require('./pendapatan-parkir.router')
const overnightRouter = require('./overnight.router.js.backup')
const transaksiBatalRouter = require('./transaksi-batal.router')
const auditTransaksiRouter = require('./audit-transaksi.router')
const settlementCashlessRouter = require('./settlement-cashless.router')

router.use('/kendaraan', kendaraanRouter)
router.use('/pendapatan-parkir', pendapatanParkirRouter)
// router.use('/overnight', overnightRouter)
router.use('/transaksi-batal', transaksiBatalRouter)
router.use('/audit-transaksi', auditTransaksiRouter)
router.use('/settlement-cashless', settlementCashlessRouter)

module.exports = router
