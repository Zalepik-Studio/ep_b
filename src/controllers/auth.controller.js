const { user } = require('../models/index')
const argon = require('argon2')
const jwt = require('jsonwebtoken')
const errorhandler = require('../helpers/errorhandler.helper')

module.exports = {
    login: async (req, res) => {
        try {
            const { username, password } = req.body
            const users = await user.findOne({
                where: {
                    username: username,
                },
            })
            if (!users) {
                throw Error('auth_no_username')
            }
            const verify = await argon.verify(users.password, password)
            if (!verify) {
                throw Error('auth_wrong_password')
            }
            const token = jwt.sign(
                { id: users.id, tenant_id: users.tenant_id },
                process.env.APP_SECRET
            )
            return res.json({
                success: true,
                message: 'Login successfully',
                results: { token: token, user_id: users.id },
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },

    register: async (req, res) => {
        try {
            const { username, password } = req.body
            const checkUsername = await user.findOne({
                where: {
                    username: username,
                },
            })
            if (checkUsername) {
                throw Error('auth_duplicate_username')
            }
            const hashedPassword = await argon.hash(password)
            const data = {
                ...req.body,
                password: hashedPassword,
            }

            const users = await user.create(data)

            const token = jwt.sign(
                { id: users.id, tenant_id: users.tenant_id },
                process.env.APP_SECRET
            )
            return res.json({
                success: true,
                message: 'Register successfully',
                results: { token: token, user_id: users.id },
            })
        } catch (err) {
            return errorhandler(res, err)
        }
    },
}
