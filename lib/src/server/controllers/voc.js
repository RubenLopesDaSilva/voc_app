const Group = require('../models/group')
const Word = require('../models/word')
const mongoose = require('mongoose')


exports.getAllWords = async (req, res, next) => {
    await Word
        .find()
        .then(result => {
            res.status(200).json(result)
        }).catch(err => {
            if (!err.statusCode) {
                err.statusCode = 500;
            }
            next(err)
        })
}

exports.getAllWordsById = async (req, res, next) => {
    let { listeId } = req.query

    if (!listeId || listeId.length === 0) {
        return res.status(400).json({ error: "No IDs provided" });
    }

    const objectIds = listeId.map(Id => new mongoose.Types.ObjectId(Id))

    await Word
        .find({
            _id: {
                $in: objectIds
            }
        })
        .then(result => {
            res.status(200).json(result)
        }).catch(err => {
            if (!err.statusCode) {
                err.statusCode = 500;
            }
            next(err)
        })
}

exports.getAllGroups = async (req, res, next) => {
    await Group
        .find()
        .then(result => {
            res.status(200).json(result)
        }).catch(err => {
            if (!err.statusCode) {
                err.statusCode = 500;
            }
            next(err)
        })
}

exports.getAllGroupsByUserId = async (req, res, next) => {
    await Group
        .find({ userId: req.query.userId })
        .then(result => {
            res.status(200).json(result)
        }).catch(err => {
            if (!err.statusCode) {
                err.statusCode = 500
            }
            next(err)
        })
}
