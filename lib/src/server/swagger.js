const swaggerUi = require("swagger-ui-express")
const swaggerJsdoc = require("swagger-jsdoc")

const options = {
    definition: {
        openapi: "3.0.0",
        info: {
            title: "API du projet",
            version: "1.0.0",
            description: "Documentation de mon API Node.js avec Swagger",
        },
        servers: [
            {
                url:"http://localhost:3000"
            },
        ] ,
    },
    apis:["./routes/*.js"],
};

const swaggerSpec = swaggerJsdoc(options);

function swaggerDocs(app) {
    app.use("/api-docs",swaggerUi.serve,swaggerUi.setup(swaggerSpec));

    console.log("Swagger disponible")
}

module.exports = swaggerDocs;