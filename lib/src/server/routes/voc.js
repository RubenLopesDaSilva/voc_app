const express = require('express');

const vocController = require("../controllers/voc")
const router = express.Router();

/**
 * @swagger
 * /voc/:
 *  get:
 *   tags :
 *    - Word
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
 *   tags:
 *    - Group
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
 *   tags:
 *    - Group
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
 *   tags :
 *    - Word
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
/**
 * @swagger
 * /voc/addW:
 *  post:
 *      tags :
 *       - Word
 *      summary: Ajoute un nouveau mot dans Mongo
 *      requestBody:
 *       required: true
 *       content:
 *        application/json:
 *         schema:
 *          type: object
 *          additionalProperties: true
 *      responses:
 *          201:
 *           description: Mot créer 
 */
router.post('/addW', vocController.addWord)
/**
 * @swagger
 * /voc/word/:wordId:
 *  delete:
 *      tags :
 *       - Word
 *      summary: Supprime le mot selon l'id donnée
 *      parameters:
 *       - name: wordId
 *         in: path
 *         required: true
 *         schema:
 *          type: string
 *      responses:
 *       200:
 *        description: Mot supprimée
 *        content:
           application/json:
            schema:
             $ref: '#/components/schemas/Word'
 */
router.delete('/word/:wordId', vocController.delWord)

/**
 * @swagger
 * /voc/addG:
 *  post:
 *      tags:
 *       - Group
 *      summary: Ajouter un groupe
 *      requestBody:
 *       required: true
 *       content:
 *          application/json:
 *           schema:
 *            type: object
 *            additionalProperties: true
 *      responses:
 *       201:
 *          descritpion: Groupe ajouté
 */
router.post('/addG', vocController.addGroup)
/**
 * @swagger
 * /voc/group/:groupId:
 *  delete:
 *      tags:
 *       - Group
 *      summary: Suppression d'un groupe
 *      parameters:
 *      - name: groupId
 *        in: path
 *        required: true
 *        schema:
 *          type: string
 *      responses:
 *       200:
 *          descritpion: Groupe supprimé
 *          content:
             application/json:
              schema:
               $ref: '#/components/schemas/Group'
 */
router.delete('/group/:groupId',vocController.delGroup)
module.exports = router;