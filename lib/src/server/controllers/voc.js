const Group = require('../models/Group')
const Word = require('../models/Word')
const User = require('../models/User')
const { json } = require('express')


exports.getAllWords = (req, res, next) => {
    Word
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

exports.getAllWordsById = (req, res, next) => {
    Word
        .find({_id: req.query.id})
        .then(result => {
            res.status(200).json(result)
        }).catch(err => {
            if(!err.statusCode) {
                err.statusCode = 500;
            }
            next(err)
        })
}

exports.getAllGroups = (req, res, next) => {
    Group
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

exports.getAllGroupsByUserId = (req,res,next) => {
    Group
        .find({userId: req.query.userId})
        .then(result => {
            res.status(200).json(result)
        }).catch(err => {
            if(!err.statusCode) {
                err.statusCode = 500;
            }
            next(err)
        })
}
