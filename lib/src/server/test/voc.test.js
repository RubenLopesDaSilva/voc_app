const { query, body } = require('express-validator');
const voc = require('../controllers/voc')
const Word = require('../models/word')
const mongoose = require('mongoose')
const Group = require('../models/group')

jest.mock('../models/word')
jest.mock('../models/group')

//Word
describe('Fonction getAllWords', () => {

    let req, res, next;

    beforeEach(() => {

        req = {};

        res = {
            status: jest.fn().mockReturnThis(),
            json: jest.fn()
        };

        next = jest.fn();
    })

    afterEach(() => {
        jest.clearAllMocks();
    });

    test('doit retourner tous les mots avec status 200', async () => {
        const fakeWords = [
            { trad: { 'fr': 'rire' }, userId: '1', phonetics: { 'fr': 'rire' } },
            { trad: { 'fr': 'bonjour' }, userId: '1', phonetics: { 'fr': 'bonjour' } }
        ];

        Word.find.mockResolvedValue(fakeWords);

        await voc.getAllWords(req, res, next);

        expect(Word.find).toHaveBeenCalled();
        expect(res.status).toHaveBeenCalledWith(200);
        expect(res.json).toHaveBeenCalledWith(fakeWords);
        expect(next).not.toHaveBeenCalled();
    });

    test('doit appeler next avec une erreur si Word.find échoue', async () => {
        const error = new Error('DB error')

        Word.find.mockRejectedValue(error);

        await voc.getAllWords(req, res, next)

        expect(next).toHaveBeenCalled();
        expect(error.statusCode).toBe(500);
    })
});

describe('Fonction getAllWordsBy', () => {
    let req, res, next;

    beforeEach(() => {

        req = { query: {} };

        res = {
            status: jest.fn().mockReturnThis(),
            json: jest.fn()
        };

        next = jest.fn();
    })

    afterEach(() => {
        jest.clearAllMocks();
    })

    test('doit retourner tous les mots selon la liste avec status 200', async () => {
        const mockIds = ['64ebd1f6e1d0b7a1c1d9a111', '64ebd1f6e1d0b7a1c1d9a112']
        req.query.listeId = mockIds
        const objectIds = mockIds.map(Id => new mongoose.Types.ObjectId(Id));

        const mockWords = [
            { trad: { 'fr': 'rire' }, userId: '1', phonetics: { 'fr': 'rire' } },
            { trad: { 'fr': 'bonjour' }, userId: '1', phonetics: { 'fr': 'bonjour' } },]
        Word.find.mockResolvedValue(mockWords);

        await voc.getAllWordsById(req, res, next);

        expect(Word.find).toHaveBeenCalledWith({
            _id: {
                $in: objectIds
            }
        });
        expect(res.status).toHaveBeenCalledWith(200)
        expect(res.json).toHaveBeenCalledWith(mockWords)
    });

    test('doit appeler next avec une erreur si Word.find échoue', async () => {
        const mockIds = ['64ebd1f6e1d0b7a1c1d9a111'];
        req.query.listeId = mockIds;

        const mockError = new Error('Database error');
        Word.find.mockRejectedValue(mockError);

        await voc.getAllWordsById(req, res, next);

        expect(next).toHaveBeenCalledWith(expect.objectContaining({
            message: 'Database error',
            statusCode: 500
        }));
    });

    test('doit retourner statusCode 400, si listeId est vide', async () => {
        req.query.listeId = [];

        await voc.getAllWordsById(req, res, next);

        expect(res.status).toHaveBeenCalledWith(400);
        expect(res.json).toHaveBeenCalledWith({ error: "No IDs provided" });
    });

    test('doit retourner statusCode 400, si pas d\'ids valides', async () => {
        const mockIds = ['1', '2']
        req.query.listeId = mockIds

        await voc.getAllWordsById(req, res, next)

        expect(res.status).toHaveBeenCalledWith(400)
        expect(res.json).toHaveBeenCalledWith({ error: "No valid IDs provided" })

    });
});

describe('Fonction addWord', () => {
    let req, res, next;

    beforeEach(() => {
        req = { body: { trad: { 'fr': 'rire' }, userId: '1', phonetics: { 'fr': 'rire' } } }

        res = {
            status: jest.fn().mockReturnThis(),
            json: jest.fn()
        };

        next = jest.fn()
    });

    afterEach(() => {
        jest.clearAllMocks();
    })

    test('doit retourner statusCode 201 et créer un mot', async () => {
        const saveMock = jest.fn().mockResolvedValue(req.body);

        // Mock du constructeur Word pour renvoyer l'objet avec save
        Word.mockImplementation(() => ({
            ...req.body,
            save: saveMock
        }));

        await voc.addWord(req, res, next);

        expect(saveMock).toHaveBeenCalled(); // vérifie que save a été appelé
        expect(res.status).toHaveBeenCalledWith(201);
        expect(res.json).toHaveBeenCalledWith(expect.objectContaining(req.body));
    });
    test('doit retourner statusCode 500 et envoyer une erreur', async () => {
        const mockError = new Error('Database error');

        // On simule save() qui échoue
        Word.mockImplementation(() => ({
            save: jest.fn().mockRejectedValue(mockError)
        }));

        await voc.addWord(req, res, next);

        expect(next).toHaveBeenCalledWith(expect.objectContaining({
            message: 'Database error',
            statusCode: 500
        }));
    });
});

describe('Fonction delWord', () => {
    let req, res, next;

    beforeEach(() => {
        req = { params: {} }
        res = {
            status: jest.fn().mockReturnThis(),
            json: jest.fn()
        }

        next = jest.fn()
    });

    afterEach(() => {
        jest.clearAllMocks()
    });

    test('doit retourner statusCode 200 et supprimer le mot', async () => {
        req.params.wordId = '64ebd1f6e1d0b7a1c1d9a111'
        const mockWord = { trad: { 'fr': 'rire' }, userId: '1', phonetics: { 'fr': 'rire' } }

        Word.findByIdAndDelete.mockResolvedValue(mockWord)

        await voc.delWord(req, res, next)

        expect(Word.findByIdAndDelete).toHaveBeenCalledWith(req.params.wordId)
        expect(res.status).toHaveBeenCalledWith(200)
        expect(res.json).toHaveBeenCalledWith(mockWord)
    });

    test('doit retourner statusCode 500 si findByIdAndDelete a un problème', async () => {
        req.params.wordId = '64ebd1f6e1d0b7a1c1d9a111'

        Word.findByIdAndDelete.mockRejectedValue(new Error('DB error'));

        await voc.delWord(req, res, next);

        expect(res.status).toHaveBeenCalledWith(500)
        expect(res.json).toHaveBeenCalledWith({ err: 'Could not fetch word' })
    });

    test('doit retourner statusCode 500 si l\'id n\'est pas valide', async () => {
        req.params.wordId = null

        await voc.delWord(req, res, next);

        expect(res.status).toHaveBeenCalledWith(500);
        expect(res.json).toHaveBeenCalledWith({ message: 'Not a valid id' })
    });
});

//Group
describe('Fonction getAllGroups', () => {
    let req, res, next;

    beforeEach(() => {
        req = {}

        res = {
            status: jest.fn().mockReturnThis(),
            json: jest.fn()
        }

        next = jest.fn()
    });

    afterEach(() => {
        jest.clearAllMocks()
    });

    test('doit retourner statusCode 200 et la liste de groupes', async () => {
        const mockGroups = [
            { name: 'test1', words: ['1', '2'], userId: '1' },
            { name: 'test2', words: ['3', '4'], userId: '1' }
        ];

        Group.find.mockResolvedValue(mockGroups)

        await voc.getAllGroups(req, res, next);

        expect(Group.find).toHaveBeenCalled();
        expect(res.status).toHaveBeenCalledWith(200);
        expect(res.json).toHaveBeenCalledWith(mockGroups);
        expect(next).not.toHaveBeenCalled()
    });
    test('doit retourner statusCode 500 avec une erreur', async () => {
        const error = new Error('DB error');

        Group.find.mockRejectedValue(error)

        await voc.getAllGroups(req, res, next);

        expect(next).toHaveBeenCalled();
        expect(error.statusCode).toBe(500)
    });
});

describe('Fonction getAllGroupsByUserId', () => {
    let req, res, next;

    beforeEach(() => {
        req = { query: { userId: '1' } }
        res = {
            status: jest.fn().mockReturnThis(),
            json: jest.fn()
        }
        next = jest.fn()
    });

    afterEach(() => {
        jest.clearAllMocks()
    });

    test('doit retourner statusCode 200 et une liste de groupes', async () => {
        const mockGroups = [{ name: 'test1', words: ['1', '2'], userId: '1' },
        { name: 'test2', words: ['3', '4'], userId: '1' }];

        Group.find.mockResolvedValue(mockGroups);

        await voc.getAllGroupsByUserId(req, res, next)

        expect(Group.find).toHaveBeenCalledWith({
            userId: req.query.userId
        });
        expect(next).not.toHaveBeenCalled()
        expect(res.status).toHaveBeenCalledWith(200);
        expect(res.json).toHaveBeenCalledWith(mockGroups);
    });

    test('doit retourner statusCode 500 et liste vide, si userId est null', async () => {
        req.query.userId = null
        const mockError = new Error('DB error')

        Group.find.mockRejectedValue(mockError)

        await voc.getAllGroupsByUserId(req, res, next);

        expect(next).toHaveBeenCalledWith(expect.objectContaining({
            message: 'DB error',
            statusCode: 500
        }))
    });
});

describe('Fonction getGroupById', () => {
    let req, res, next;

    beforeEach(() => {
        req = { params: { id: '1' } },
            res = {
                status: jest.fn().mockReturnThis(),
                json: jest.fn()
            }
        next = jest.fn()
    });

    afterEach(() => {
        jest.clearAllMocks()
    });

    test('doit retourner statusCode 200 et le groupe en question', async () => {
        const group = { name: 'test1', words: ['1', '2', '3'], userId: '1' }
        Group.findOne.mockResolvedValue(group);

        await voc.getGroupById(req, res, next);

        expect(next).not.toHaveBeenCalled()
        expect(res.status).toHaveBeenCalledWith(200)
        expect(res.json).toHaveBeenCalledWith(group)
    });

    test('doit retourner statusCode 500, si Group.find échoue', async () => {
        const mockError = new Error('DB error');

        Group.findOne.mockRejectedValue(mockError)

        await voc.getGroupById(req, res, next);

        expect(next).toHaveBeenCalledWith(mockError);
        expect(res.status).toHaveBeenCalledWith(500)
        expect(res.json).toHaveBeenCalledWith({ message: 'Could not fetch Group' })
    });

    test('doit retourner statusCode 500, si id est null', async () => {
        req.params.id = null

        await voc.getGroupById(req, res, next);

        expect(res.status).toHaveBeenCalledWith(500);
        expect(res.json).toHaveBeenCalledWith({ message: 'Not a valid id' })
    });
});

describe('Fonction addGroup', () => {
    let req, res, next;

    beforeEach(() => {
        req = { body: { name: 'test1', userId: '1', words: ['1', '2', '3'] } }
        res = {
            status: jest.fn().mockReturnThis(),
            json: jest.fn()
        }
        next = jest.fn()
    });

    afterEach(() => {
        jest.clearAllMocks()
    })

    test('doit retourner statusCode 201 et créer un groupe', async () => {
        const saveMock = jest.fn().mockResolvedValue(req.body)

        Group.mockImplementation(() => ({
            ...req.body,
            save: saveMock
        }));

        await voc.addGroup(req, res, next);

        expect(saveMock).toHaveBeenCalled()
        expect(res.status).toHaveBeenCalledWith(201);
        expect(res.json).toHaveBeenCalledWith(expect.objectContaining(req.body));
    });

    test('doit retourner 500, si save échoue', async () => {
        const mockError = new Error('DB error')

        Group.mockImplementation(() => ({
            save: jest.fn().mockRejectedValue(mockError)
        }));

        await voc.addGroup(req, res, next);

        expect(next).toHaveBeenCalledWith(expect.objectContaining({
            message: 'DB error',
            statusCode: 500
        }));
    });
});

describe('Fonction delGroup', () => {
    let req, res, next;

    beforeEach(() => {
        req = { params: {} }
        res = {
            status: jest.fn().mockReturnThis(),
            json: jest.fn()
        }
        next = jest.fn()
    });

    afterEach(() => {
        jest.clearAllMocks()
    });

    test('doit retourner statusCode 200 et supprime le groupe', async () => {
        req.params.groupId = '1'
        const mockGroup = { name: 'test', userId: '1', words: ['1', '2', '3'] }

        Group.findByIdAndDelete.mockResolvedValue(mockGroup)

        await voc.delGroup(req, res, next)

        expect(Group.findByIdAndDelete).toHaveBeenCalledWith(req.params.groupId)
        expect(res.status).toHaveBeenCalledWith(200)
        expect(res.json).toHaveBeenCalledWith(mockGroup)
    });
    test('doit retourner statusCode 500 si findByIdAndDelete a un problème', async () => {
        req.params.groupId = '1'

        Group.findByIdAndDelete.mockRejectedValue(new Error('DB error'))

        await voc.delGroup(req, res, next)

        expect(res.status).toHaveBeenCalledWith(500)
        expect(res.json).toHaveBeenCalledWith({ message: 'Could not fetch Group' })
    });
    test('doit retourner statusCode 500 si id non valide',async () => {
        req.params.groupId = null

        await voc.delGroup(req,res,next)

        expect(res.status).toHaveBeenCalledWith(500)
        expect(res.json).toHaveBeenCalledWith({message:'Not a valid id'})
    })
});