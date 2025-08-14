const transaksiRouter = require('express').Router()
const transaksiController = require('../../controllers/transaksi/transaksi.controller')
const transaksiTipeManualController = require('../../controllers/transaksi/transaksiTipeManual.controller')
const transaksiTipeTunaiController = require('../../controllers/transaksi/transaksiTipeTunai.controller')
const transaksiTipeBankController = require('../../controllers/transaksi/transaksiTipeBank.controller')
const transaksiTipeQrisController = require('../../controllers/transaksi/transaksiTipeQris.controller')
const transaksiTipeMemberController = require('../../controllers/transaksi/transaksiTipeMember.controller')
const transaksiKeluarMemberController = require('../../controllers/transaksi/jenis-transaksi/transaksiKeluarMemberController.controller')
const transaksiKeluarCasual = require('../../controllers/transaksi/jenis-transaksi/transaksiKeluarCasual.controller')

// ✅ Route baru untuk riwayat manual
transaksiRouter.get(
    '/riwayat-manual',
    transaksiTipeManualController.getAllRiwayatTransaksiManual
)
transaksiRouter.get(
    '/riwayat-tunai',
    transaksiTipeTunaiController.getAllRiwayatTransaksiTunai
)
transaksiRouter.get(
    '/riwayat-bank',
    transaksiTipeBankController.getAllRiwayatTransaksiBank
)
transaksiRouter.get(
    '/riwayat-qris',
    transaksiTipeQrisController.getAllRiwayatTransaksiQris
)
transaksiRouter.get(
    '/riwayat-member',
    transaksiTipeMemberController.getAllRiwayatTransaksiMember
)

// Routes utama
transaksiRouter.get('/', transaksiController.getAll)
transaksiRouter.post('/', transaksiController.create)
transaksiRouter.patch('/cancel-transaksi', transaksiController.cancelTransaksi)

// Route PATCH untuk transaksi keluar member
transaksiRouter.patch('/keluar-member', transaksiKeluarMemberController.update)
// Route PATCH untuk transaksi casual
transaksiRouter.patch('/keluar-casual', transaksiKeluarCasual.update)

transaksiRouter.get('/:id', transaksiController.findOneById)
transaksiRouter.patch('/:id', transaksiController.update)
transaksiRouter.delete('/:id', transaksiController.delete)

module.exports = transaksiRouter
