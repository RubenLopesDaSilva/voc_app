const mongoose = require('mongoose');

const groupSchema = mongoose.Schema({
    _id: { type: String, require: true },
    name: { type: String, require: true },
    userId: { type: String, require: true },
    words: { type: Array, require: true },
}, { versionKey: false })