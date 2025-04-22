const express = require('express');
const db = require('../utils/db');
const router = express.Router();

/**
 * @swagger
 * /iot:
 *   get:
 *     summary: Récupérer les données IoT
 *     responses:
 *       200:
 *         description: Liste des données IoT
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/Info'
 */
router.get('/', (req, res) => {
    const lastId = req.query.last_id;

    let sql;
    let params = [];

    if (lastId) {
        sql = 'SELECT * FROM infos WHERE id < ? ORDER BY timestamp desc LIMIT 20';
        params = [lastId];
    } else {
        sql = 'SELECT * FROM infos ORDER BY timestamp DESC LIMIT 20';
    }

    db.all(sql, params, (err, rows) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        res.json(rows);
    });
});


/**
 * @swagger
 * /iot:
 *   post:
 *     summary: Ajouter des données IoT
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/Info'
 *     responses:
 *       201:
 *         description: Données ajoutées avec succès
 */
router.post('/', (req, res) => {
    const { device_id, temperature, humidity, timestamp, type } = req.body;
    console.log(req.body);

    if (!device_id || !temperature || !humidity || !timestamp || !type) {
        return res.status(400).json({ error: 'Missing required fields' });
    }

    const query = 'INSERT INTO infos (device_id, temperature, humidity, timestamp, type) VALUES (?, ?, ?, ?, ?)';
    db.run(query, [device_id, temperature, humidity, timestamp, type], function (err) {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        res.status(201).json({
            id: this.lastID,
            device_id,
            temperature,
            humidity,
            timestamp,
            type
        });
    });
});

module.exports = router;