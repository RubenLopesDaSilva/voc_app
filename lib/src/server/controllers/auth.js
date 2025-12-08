const User = require('../models/user')
const { validationResult } = require("express-validator")
const bcrypt = require("bcryptjs")
const jwt = require("jsonwebtoken")

exports.signup = async (req, res, next) => {
    const errors = validationResult(req)
    if (!errors.isEmpty()) {
        const error = new Error('Validation failed')
        error.statusCode = 422
        error.data = errors.array()
        return next(error)
    }
    const email = req.body.email
    const userName = req.body.userName
    const password = req.body.password

   await bcrypt
        .hash(password, 12)
        .then(hashedPwd => {
            const user = new User({
                email: email,
                userName: userName,
                password: hashedPwd
            })
            return user.save()
        })
        .then(result => {
            res.status(201).json({
                message: 'User created successfully',
                user: { _id: result._id, email: result.email, userName: result.userName }
            })
        })
        .catch(err => {
            if (!err.statusCode) {
                err.statusCode = 500
            }
            next(err)
        })
}

exports.login = async(req, res, next) => {
    const email = req.body.email
    const password = req.body.password

   await User.findOne({ email: email })
        .then(user => {
            if (!user) {
                const error = new Error('User unknown')
                error.statusCode = 401
                throw error
            }
            loadedUser = user
            return bcrypt.compare(password, user.password)
        })
        .then(isEqual => {
            if (!isEqual) {
                const error = new Error('Wrong password!')
                error.statusCode = 401
                throw error
            }
            const token = jwt.sign({
                email: loadedUser.email,
                userName: loadedUser.userName,
                sub: loadedUser._id.toString()
            }, 'somesupersecretsecret', { expiresIn: '1h' }
            )
            res.status(200).json({ token: token })
        })
        .catch(err => {
            if (!err.statusCode) {
                err.statusCode = 500
            }
            next(err)
        })
}

exports.getAllUsers = async (req, res, next) => {
   await User
        .find()
        .then(result => {
            res.status(200).json(result)
        }).catch(err => {
            if (!err.statusCode) {
                err.statusCode = 500
            }
            next(err)
        })
}