const mongoose = require("mongoose");

const wordSchema = mongoose.Schema({
    _id: { type: String, require: true },
    trad: {
        type: Object, require: true
    },
    userId: { type: String, require: true },
    definitions: { type: Object, require: false },
    phonetic: { type: Object, require: true }
}, { versionKey: false })

module.exports = mongoose.model('Word', wordSchema);