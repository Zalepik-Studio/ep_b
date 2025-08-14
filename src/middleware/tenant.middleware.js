// src/middleware/tenant.middleware.js
module.exports = (req, res, next) => {
    // Pastikan user dan tenant_id tersedia dari authMiddleware
    if (!req.user || !req.user.tenant_id) {
        return res.status(403).json({ message: 'Tenant ID tidak ditemukan' })
    }

    // Simpan tenant_id di request context
    req.tenant_id = req.user.tenant_id

    // Untuk POST, PUT, PATCH → tambahkan tenant_id ke req.body
    if (['POST', 'PUT', 'PATCH'].includes(req.method)) {
        if (!req.body) req.body = {}
        req.body.tenant_id = req.user.tenant_id
    }

    next()
}
