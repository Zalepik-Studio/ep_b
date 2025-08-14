// check-super-admin.js
const db = require('./pg-client') // Ini pakai koneksi pg langsung

async function checkAndInsertSuperAdmin() {
    try {
        await db.query(`
            CREATE TABLE IF NOT EXISTS level_penggunas (
                id SERIAL PRIMARY KEY,
                nama_level VARCHAR(100) UNIQUE NOT NULL
            )
        `)

        const result = await db.query(
            'SELECT * FROM level_penggunas WHERE nama_level = $1',
            ['Super Admin']
        )

        if (result.rowCount === 0) {
            console.log('🟡 Super Admin belum ada. Menambahkan...')
            await db.query(
                'INSERT INTO level_penggunas (nama_level) VALUES ($1)',
                ['Super Admin']
            )
            console.log('✅ Super Admin berhasil ditambahkan.')
        } else {
            console.log('✅ Super Admin sudah ada.')
        }
    } catch (err) {
        console.error('❌ Error Super Admin:', err.message)
    }
}

module.exports = checkAndInsertSuperAdmin
