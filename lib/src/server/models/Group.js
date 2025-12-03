const mongoose = require('mongoose');

const groupSchema = mongoose.Schema({
    name: { type: String, require: true },
    userId: { type: String, require: true },
    words: { type: Array, require: true },
}, { versionKey: false })

module.exports = mongoose.model('Group', groupSchema)