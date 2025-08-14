const auditTransaksiRouter = require('express').Router()
const auditTransaksiController = require('../../controllers/laporan-data/audit-transaksi.controller')

auditTransaksiRouter.get(
    '/audit-transaksi-kendaraan-yang-sering-keluar',
    auditTransaksiController.getAllAuditTransaksiKendaraanKeluar
)
auditTransaksiRouter.get(
    '/audit-transaksi-manual',
    auditTransaksiController.getAllAuditTransaksiManual
)
auditTransaksiRouter.get(
    '/audit-penggunaan-voucher',
    auditTransaksiController.getAllAuditTransaksiPenggunaanVoucher
)
auditTransaksiRouter.get(
    '/audit-pembatalan-transaksi',
    auditTransaksiController.getAllAuditPembatalanTransaksi
)

module.exports = auditTransaksiRouter
