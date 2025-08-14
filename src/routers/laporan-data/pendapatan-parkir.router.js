const pendapatanParkirRouter = require('express').Router()
const pendapatanParkirController = require('../../controllers/laporan-data/pendapatan-parkir.controller')

pendapatanParkirRouter.get(
    '/casual',
    pendapatanParkirController.pendapatanDariCasual
)
pendapatanParkirRouter.get(
    '/member',
    pendapatanParkirController.pendapatanDariMember
)

module.exports = pendapatanParkirRouter
