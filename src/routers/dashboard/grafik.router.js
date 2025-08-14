const grafikRouter = require('express').Router()
const grafikController = require('../../controllers/dashboard/grafik.controller')

grafikRouter.get('/overnight', grafikController.getAllOvernight)
grafikRouter.get('/overnight-keluar', grafikController.getOvernightYangSudahKeluar)
grafikRouter.get('/tipe-kendaraan', grafikController.getKendaraanChartData)

module.exports = grafikRouter
