const permasalahanAtauPerbaikanRouter = require('express').Router()
const permasalahanAtauPerbaikanController = require('../../controllers/transaksi/permasalahan-atau-perbaikan.controller')

permasalahanAtauPerbaikanRouter.get(
    '/',
    permasalahanAtauPerbaikanController.getAll
)
permasalahanAtauPerbaikanRouter.get(
    '/pdf',
    permasalahanAtauPerbaikanController.generatePdf
)
permasalahanAtauPerbaikanRouter.get(
    '/excel',
    permasalahanAtauPerbaikanController.generateExcel
)
permasalahanAtauPerbaikanRouter.get(
    '/:id',
    permasalahanAtauPerbaikanController.findOneById
)
permasalahanAtauPerbaikanRouter.post(
    '/',
    permasalahanAtauPerbaikanController.create
)
permasalahanAtauPerbaikanRouter.patch(
    '/:id',
    permasalahanAtauPerbaikanController.update
)
permasalahanAtauPerbaikanRouter.delete(
    '/:id',
    permasalahanAtauPerbaikanController.delete
)

module.exports = permasalahanAtauPerbaikanRouter
