const router = require('express').Router()
const authMiddleware = require('../../src/middleware/auth.middleware')
const tenantMiddleware = require('../../src/middleware/tenant.middleware')

router.use(
    '/dashboard',
    authMiddleware,
    tenantMiddleware,
    require('./dashboard/index.router')
)
router.use('/auth', require('./auth.router'))
router.use(
    '/master-data',
    authMiddleware,
    tenantMiddleware,
    require('../routers/master-data/master-data.router')
)
router.use(
    '/laporan-data',
    authMiddleware,
    require('../routers/laporan-data/index.router')
)
router.use(
    '/setting',
    authMiddleware,
    tenantMiddleware,
    require('../routers/setting/setting.router')
)
router.use(
    '/transaksi',
    authMiddleware,
    tenantMiddleware,
    require('./transaksi/index.router')
)
router.use(
    '/profile',
    authMiddleware,
    tenantMiddleware,
    require('../routers/profile/profile.router')
)
router.use('/tenant', require('../routers/tenant/tenant.router'))

router.get('/', (req, res) => {
    return res.json({
        success: true,
        message: 'Backend is running well',
    })
})

module.exports = router
