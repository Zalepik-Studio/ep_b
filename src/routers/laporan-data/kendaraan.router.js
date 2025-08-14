const kendaraanRouter = require('express').Router()
const kendaraanController = require('../../controllers/laporan-data/kendaraan.controller')

kendaraanRouter.get('/kendaraan-in', kendaraanController.getAllDataKendaraanIn)
kendaraanRouter.get(
    '/kendaraan-out',
    kendaraanController.getAllDataKendaraanOut
)

module.exports = kendaraanRouter
