const mongoose = require('mongoose')

const userSchema = new mongoose.Schema({
    _id: { type: String, require: true },
    email: { type: String, require: true },
    userName: { type: String, require: true },
    password: { type: String, require: true },
}, { versionKey: false })

module.exports = mongoose.model('User', userSchema);