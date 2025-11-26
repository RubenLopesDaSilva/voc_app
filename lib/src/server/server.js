const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
const vocRoutes = require("./routes/voc")

const app = express()
app.use(cors());
app.use(express.json());

const dbUri = "mongodb://localhost:27017/vocapp"
mongoose.connect(dbUri)
    .then(result => {
        app.listen(3000);
        console.log('connected to db')
    }).catch(err => { console.error(err) })

app.use((req, res, next) => {
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, PATCH, DELETE');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization');

    next()
})

app.use('/voc', vocRoutes)

app.use((error, req, res, next) => {
    const status = error.status || 500
    const message = error.message
    const data = error.data
    res.status(status).json({ message: message, data: data })
})

