const aktivitasGerbangKendaraanRouter = require('express').Router()
const aktivitasGerbangKendaraanController = require('../../controllers/dashboard/aktivitas-gerbang-kendaraan.controller')

aktivitasGerbangKendaraanRouter.get(
    '/',
    aktivitasGerbangKendaraanController.getAll
)
aktivitasGerbangKendaraanRouter.post(
    '/',
    aktivitasGerbangKendaraanController.create
)
aktivitasGerbangKendaraanRouter.get(
    '/pdf',
    aktivitasGerbangKendaraanController.generatePdf
)
aktivitasGerbangKendaraanRouter.get(
    '/excel',
    aktivitasGerbangKendaraanController.generateExcel
)

module.exports = aktivitasGerbangKendaraanRouter
