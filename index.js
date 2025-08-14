const envPath = `.env.${process.env.NODE_ENV || 'development'}`
require('dotenv').config({ path: envPath })

const express = require('express')
const app = express()

app.use(express.json({ limit: '10mb', extended: true }))
app.use(
    express.urlencoded({ limit: '10mb', extended: true, parameterLimit: 50000 })
)

const PORT = process.env.PORT || 4000

const cors = require('cors')
// const checkAndInsertSuperAdmin = require('./src/configs/check-super-admin')

app.use(
    cors({
        origin: '*',
        optionsSuccessStatus: 200,
    })
)

app.get('/', (req, res) => {
    return res.json({
        success: true,
        message: 'Backend is running well',
    })
})

app.use('/', require('./src/routers/index.router'))

// checkAndInsertSuperAdmin().then(() => {
//     app.listen(PORT, () => {
//         console.log(`🚀 Server running on port ${PORT}`)
//     })
// })

app.listen(PORT, () => {
    console.log(`🚀 Server running on port ${PORT}`)
})
