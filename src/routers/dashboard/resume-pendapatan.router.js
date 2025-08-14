const router = require('express').Router()
const resumeController = require('../../controllers/dashboard/resume-pendapatan.controller')

router.get('/', resumeController.getResumePendapatanDashboard)

module.exports = router
