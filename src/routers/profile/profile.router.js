const profileRouter = require('express').Router()
const profileController = require('../../controllers/profile/profile.controller')

profileRouter.get('/', profileController.getAll)
profileRouter.get('/pdf', profileController.generatePdf)
profileRouter.get('/excel', profileController.generateExcel)
profileRouter.get('/:id', profileController.findOneById)
profileRouter.post('/', profileController.create)
profileRouter.patch('/:id', profileController.update)
profileRouter.delete('/:id', profileController.delete)

module.exports = profileRouter
