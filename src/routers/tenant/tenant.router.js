const tenantRouter = require('express').Router()
const tenantController = require('../../controllers/tenant/tenant.controller')

tenantRouter.get('/', tenantController.getAll)
tenantRouter.get('/:id', tenantController.findOneById)
tenantRouter.post('/', tenantController.create)
tenantRouter.patch('/:id', tenantController.update)
tenantRouter.delete('/:id', tenantController.delete)

module.exports = tenantRouter
