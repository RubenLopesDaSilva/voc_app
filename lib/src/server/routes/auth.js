const express = require('express')

const authController = require('../controllers/auth')
const router = express.Router()

/**
 * @swagger
 * /auth/signup:
 *  put:
 *   summary: Créer un compte
 *   requestBody:
 *    required: true
 *    content:
 *     application/json:
 *      schema:
 *       type: object
 *       properties:
 *        email:
 *         type: string
 *        name:
 *         type: string
 *        password:
 *         type: string
 *   responses:
 *    201:
 *     description: Utilisateur créée
 */
router.put('/signup', authController.signup)
/**
 * @swagger
 * /auth/login:
 *  post:
 *      summary: Connecter dans l'app
 *      requestBody:
 *       required: true
 *       content: 
 *        application/json:
 *         schema:
 *          type: object
 *          properties:
 *           email:
 *            type: string
 *           password:
 *            type: string
 *       responses:
 *          200:
 *              description: Utilisateur connecté
 */
router.post('/login', authController.login)
/**
 * @swagger
 * /auth/user:
 *  get:
 *      summary: Récupérer la liste des utilisateurs
 *      responses:
 *          200:
 *              description: Liste d'utilisateurs retournée
 */
router.get('/user', authController.getAllUsers)

module.exports = router;