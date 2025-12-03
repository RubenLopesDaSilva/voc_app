const express = require('express');

const vocController = require("../controllers/voc")
const router = express.Router();

/**
 * @swagger
 * /voc/:
 *  get:
 *   summary: Récupérer la liste de tous les mots de l'app
 *   responses:
 *    200:
 *     description: Liste des mots retournée 
 */
router.get('/', vocController.getAllWords)
/**
 * @swagger
 * /voc/group:
 *  get:
 *   summary: Récupérer la liste de tous les groupes de l'app
 *   responses: 
 *    200:
 *      description: Liste des groupes retournée
 */
router.get('/group', vocController.getAllGroups)
/**
 * @swagger
 * /voc/search:
 *  get:
 *   summary: Liste des groupes selon l'id de l'utilisateur
 *   parameters:
 *    - in: query
 *      name: userId
 *      schema:
 *       type: string
 *      required: true
 *      description: Id de l'utilisateur connecté
 *   responses:
 *    200:
 *     description: Liste retournée
 */
router.get('/search', vocController.getAllGroupsByUserId)
/**
 * @swagger
 * /voc/searchW:
 *  get:
 *   summary: Liste des mots selon une liste d'ids
 *   parameters:
 *    - in: query
 *      name: listeId
 *      schema:
 *       type: array
 *       items:
 *        type: string
 *       style: form
 *       explode: true
 *   responses:
 *    200:
 *     description: OK
 */
router.get('/searchW', vocController.getAllWordsById)


module.exports = router;