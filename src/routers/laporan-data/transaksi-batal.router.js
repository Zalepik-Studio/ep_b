const transaksiBatalRouter = require('express').Router()
const transaksiBatalController = require('../../controllers//laporan-data/transaksi-batal.controller')

transaksiBatalRouter.get(
    '/',
    transaksiBatalController.getAllPembatalanTransaksi
)

module.exports = transaksiBatalRouter
