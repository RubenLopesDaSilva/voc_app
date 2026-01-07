const auth = require('../controllers/auth');
const User = require('../models/user');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');
const { validationResult } = require('express-validator');

jest.mock('../models/user');
jest.mock('jsonwebtoken');
jest.mock('bcryptjs');
jest.mock('express-validator');

describe('Auth Controller - login', () => {
    let req, res, next;

    beforeEach(() => {
        req = { body: { email: 'test@test.com', password: 'hashed', userName: 'TestUser' } };
        res = {
            status: jest.fn().mockReturnThis(),
            json: jest.fn()
        }
        next = jest.fn()
    });

    afterEach(() => {
        jest.clearAllMocks();
    });

    test('doit retourner status 200 et le token si le login est correcte', async () => {
        const mockUser = { email: 'test@test.com', password: 'hashed', userName: 'TestUser', _id: '1' };
        User.findOne.mockResolvedValue(mockUser);
        bcrypt.compare.mockResolvedValue(true);
        jwt.sign.mockReturnValue('mockToken');

        await auth.login(req, res, next);

        expect(res.status).toHaveBeenCalledWith(200);
        expect(res.json).toHaveBeenCalledWith({ token: 'mockToken' });
    });

    test('doit appeller la fonction next et status 500 if l\'utilisateur n\'est pas trouvée', async () => {
        const mockError = new Error('DB error')
        User.findOne.mockRejectedValue(mockError);

        await auth.login(req, res, next);

        expect(next).toHaveBeenCalledWith(expect.objectContaining({
            message: 'DB error',
            statusCode: 500
        }));
    });

    test('doit retourner status 401 et jette une erreur si l\'utilisateur est inconnu', async () => {
        const mockUser = null
        User.findOne.mockResolvedValue(mockUser)

        await auth.login(req, res, next)

        expect(next).toHaveBeenCalledWith(expect.objectContaining({
            message: 'User unknown',
            statusCode: 401,
        }))
    })

    test('doit retourner status 401 et jette une erreur si le mot de passe n\'est pas le même', async () => {
        const mockUser = { _id: '1', email: 'test@test.com', password: '1234' }
        User.findOne.mockResolvedValue(mockUser);
        bcrypt.compare.mockResolvedValue(false)

        await auth.login(req, res, next)

        expect(next).toHaveBeenCalledWith(expect.objectContaining({
            message: 'Wrong password!',
            statusCode: 401
        }))
    })
})
describe('Auth Controller - signUp', () => {
    let req, res, next;

    beforeEach(() => {
        req = { body: { email: 'test@test.com', userName: 'TestUser', password: '1234' } };
        res = {
            status: jest.fn().mockReturnThis(),
            json: jest.fn()
        }
        next = jest.fn()
    });

    afterEach(() => {
        jest.clearAllMocks();
    });

    test('doit retourner status 422 et appelle next si la validation échoue', async () => {
        validationResult.mockReturnValue({
            isEmpty: () => false,
            array: () => [{ message: 'Validation failed' }]
        });

        await auth.signup(req, res, next);

        expect(next).toHaveBeenCalledWith(expect.objectContaining({
            message: 'Validation failed',
            statusCode: 422,
            data: [{ message: 'Validation failed' }]
        }));
    });

    test('doit retourner status 201 et créer un utilisateur si les identifiants sont valides', async () => {
        validationResult.mockReturnValue({
            isEmpty: () => true,
        });
        bcrypt.hash.mockResolvedValue('hashed');

        const mockUser = {
            _id: '1',
            email: 'test@test.com',
            userName: 'TestUser',
            save: jest.fn().mockReturnValue({
                _id: '1',
                email: 'test@test.com',
                userName: 'TestUser',
            })
        };

        User.mockImplementation(() => mockUser);

        await auth.signup(req, res, next)

        expect(bcrypt.hash).toHaveBeenCalledWith('1234', 12);
        expect(mockUser.save).toHaveBeenCalled()
        expect(res.status).toHaveBeenCalledWith(201);
        expect(res.json).toHaveBeenCalledWith({
            message: 'User created successfully',
            user: { _id: '1', email: 'test@test.com', userName: 'TestUser' }
        })
    });

    test('doit retourner status 500 et appeller next si le hashage ou la sauvegarde échoue', async () => {
        validationResult.mockReturnValue({
            isEmpty: () => true
        });

        bcrypt.hash.mockRejectedValue(new Error('Hash error'))

        await auth.signup(req, res, next);

        expect(next).toHaveBeenCalledWith(expect.objectContaining({
            message: 'Hash error',
            statusCode: 500
        }))
    })
})