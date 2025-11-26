const express = require('express');

const vocController = require("../controllers/voc")
const router = express.Router();

router.get('/', vocController.getAllGroups)
router.get('/search', vocController.getAllGroupsByUserId)
router.get('/searchW', vocController.getAllWordsById)


module.exports = router;