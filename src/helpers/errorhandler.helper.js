const { Sequelize } = require('sequelize')

const errorhandler = (res, err) => {
    console.error(err)

    const authErrors = {
        unauthorized: 401,
        auth_wrong_password: 400,
        auth_no_email: 404,
        auth_no_username: 404,
    }

    for (const key in authErrors) {
        if (err?.message?.includes(key)) {
            return res.status(authErrors[key]).json({
                success: false,
                message: key,
            })
        }
    }

    if (err instanceof Sequelize.BaseError) {
        const status = 400

        return res.status(status).json({
            success: false,
            message: 'Database error',
            type: err.name,
            detail: err.parent?.detail || err.message,
        })
    }

    return res.status(500).json({
        success: false,
        message: 'Error: Internal server error',
        error: err.message,
    })
}

module.exports = errorhandler
