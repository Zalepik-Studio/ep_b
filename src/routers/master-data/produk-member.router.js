const produkMemberRouter = require('express').Router()
const produkMemberController = require('../../controllers/master-data/produk-member.controller')

produkMemberRouter.get('/', produkMemberController.getAll)
produkMemberRouter.get('/pdf', produkMemberController.generatePdf)
produkMemberRouter.get('/excel', produkMemberController.generateExcel)
produkMemberRouter.get('/:id', produkMemberController.findOneById)
produkMemberRouter.post('/', produkMemberController.create)
produkMemberRouter.patch('/:id', produkMemberController.update)
produkMemberRouter.patch('/status/:id', produkMemberController.updateStatus)
produkMemberRouter.delete('/:id', produkMemberController.delete)

module.exports = produkMemberRouter
