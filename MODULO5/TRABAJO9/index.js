require("rootpath")();
const express = require('express');
const app = express();
const morgan = require('morgan');
const config = require("./src/config/config.json");

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(morgan('tiny'));
morgan(':method :url :status :res[content-length] - :response-time ms');
  


app.get("/", function (req, res) {
    res.send("ALPHA-SILICON");
});
// PERSONA
const personaCont = require("./src/controller/personaController.js");
app.use("/api/persona",personaCont);
// CURSO
const cursoCont = require("./src/controller/cursoController.js");
app.use("/api/cursos",cursoCont);
// MATERIA
const materiaCont = require("./src/controller/materiaController.js");
app.use("/api/materias",materiaCont);

// SEDE
const sedeCont = require("./src/controller/sedeController.js");
app.use("/api/sedes",sedeCont);

// USUARIO
const usuarioCont = require("./src/controller/usuarioController.js");
app.use("/api/usuarios",usuarioCont);


/*
const userCont = require("userController.js");
app.use("/api/usuario",userCont);
*/

app.listen(config.server.port, function (err) {
    if (err) {
        console.log(err);
    } else {
        console.log(`Server iniciado en puerto:${config.server.port}`);
    }
});
