const router = require('express').Router()
const parameterRouter = require('./parameter.router')
const tipeDendaRouter = require('./tipe-denda.router')
const tipeKendaraanRouter = require('./tipe-kendaraan.router')
const tipeManlessRouter = require('./tipe-manless.router')
const namaPrinterRouter = require('./nama-printer.router')
const namaInterfaceRouter = require('./nama-interface.router')

router.use('/parameter', parameterRouter)
router.use('/tipe-kendaraan', tipeKendaraanRouter)
router.use('/tipe-denda', tipeDendaRouter)
router.use('/tipe-manless', tipeManlessRouter)
router.use('/nama-printer', namaPrinterRouter)
router.use('/nama-interface', namaInterfaceRouter)

module.exports = router
