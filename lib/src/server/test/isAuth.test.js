const isAuth = require('../middleware/is-auth')
const jwt = require('jsonwebtoken');

jest.mock('jsonwebtoken')

describe('Auth Middleware', () => {
    let req, res, next;

    beforeEach(() => {
        req = { get: jest.fn() };
        res = {};
        next = jest.fn()
    });

    afterEach(() => {
        jest.clearAllMocks();
    });

    test('doit jetter 401 si il n\'y pas d\'Authorisation en tête', () => {
        req.get.mockReturnValue(undefined);

        try {
            isAuth(req, res, next)
        } catch (err) {
            expect(err.message).toBe('Not authenticated')
            expect(err.statusCode).toBe(401)
        }
    });

    test('doit jetter 401 si le token est manquant', () => {
        req.get.mockReturnValue('Bearer');

        try {
            isAuth(req, res, next);
        } catch (err) {
            expect(err.message).toBe('Token missing')
            expect(err.statusCode).toBe(401)
        }
    });

    test('doit jetter 500 si jwt.verify échoue', () => {
        req.get.mockReturnValue('Bearer invalidtoken')
        jwt.verify.mockImplementation(() => { throw new Error('jwt error') });

        try {
            isAuth(req, res, next)
        } catch (err) {
            expect(err.message).toBe('jwt error');
            expect(err.statusCode).toBe(500);
        }
    });

    test('doit jetter 401 si decodedToken est vide', () => {
        req.get.mockReturnValue('Bearer sometoken');
        jwt.verify.mockReturnValue(null);

        try {
            isAuth(req, res, next);
        } catch (err) {
            expect(err.message).toBe('Not authenticated');
            expect(err.statusCode).toBe(401);
        }
    });

    test('doit appeller next et instancier req.id si le token est valide', () => {
        const decoded = { sub: '123' };
        req.get.mockReturnValue('Bearer validtoken');
        jwt.verify.mockReturnValue(decoded);

        isAuth(req, res, next);

        expect(req.id).toBe('123');
        expect(next).toHaveBeenCalled();
    })
})