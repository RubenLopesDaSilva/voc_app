const Group = require('../models/group')
const Word = require('../models/word')
const mongoose = require('mongoose')

//Word
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

exports.addWord = async (req, res, next) => {
    const word = new Word(req.body)
    await word.save()
    res.status(201).json(word)
}

exports.delWord = async (req, res, next) => {
    const id = req.params.wordId;
    if (id != null) {
        await Word
            .findByIdAndDelete(id)
            .then(result => {
                res.status(200).json(result)
            }).catch(err => {
                res.status(500).json({ err: 'Could not fetch word' })
            })
    } else {
        res.status(500).json({ message: 'Not a valid id' })
    }
}

//Group
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

exports.getGroupById = async (req, res, next) => {
    const id = req.params.id
    if (id != null) {
        await Group
            .findOne({})
            .then(result => {
                res.status(200).json(result)
            }).catch(err => {
                res.status(500).json({ message: 'Could not fetch Group' })
                next(err)
            })
    } else {
        res.status(500).json({ message: 'Not a valid id' })
    }
}

exports.addGroup = async (req, res, next) => {
    const group = new Group(req.body)
    await group.save()
    res.status(201).json(group)
}

exports.delGroup = async (req, res, next) => {
    const groupId = req.params.groupId
    if (groupId != null) {
        await Group
            .findByIdAndDelete(groupId)
            .then(result => {
                res.status(200).json(result);
            }).catch(err => {
                res.status(500).json({ message: 'Could not fetch Group' })
            })
    } else {
        res.status(500).json({ message: 'Not a valid id' })
    }
}