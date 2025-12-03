const mongoose = require("mongoose");

const wordSchema = mongoose.Schema({
    trad: {
        type: Object, require: true
    },
    userId: { type: String, require: true },
    definitions: { type: Object, require: false },
    phonetic: { type: Object, require: true }
}, { versionKey: false })

module.exports = mongoose.model('Word', wordSchema);