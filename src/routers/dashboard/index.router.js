const router = require('express').Router()
const aktivitasGerbangKendaraan = require('./aktivitas-gerbang-kendaraan.router')
const grafikRouter = require('./grafik.router')
const resumePendapatanRouter = require('./resume-pendapatan.router')

router.use('/aktivitas-gerbang-kendaraan', aktivitasGerbangKendaraan)
router.use('/grafik', grafikRouter)
router.use('/resume-pendapatan', resumePendapatanRouter)

module.exports = router
