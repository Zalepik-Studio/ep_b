const settlementCashlessRouter = require('express').Router()
const settlementCashlessController = require('../../controllers/laporan-data/settlement-cashless.controller')

settlementCashlessRouter.get('/', settlementCashlessController.getAll)

module.exports = settlementCashlessRouter
