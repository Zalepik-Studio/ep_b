const express = require('express')
const router = express.Router()
const controller = require('../../controllers/master-data/riwayat-ganti-nomorPolisi-v2.controller')

// GET all riwayat by memberId dengan optional query: search, limit, page
router.get('/:memberId', controller.getRiwayatByMemberId)

// POST create riwayat baru
router.post('/create', controller.createRiwayat)

module.exports = router
