require("rootpath")();
const express = require('express');
const app = express();

const materiaDb = require("../datasource/materiaDB.js");


app.get('/', getAll);

app.get('/:idmaterias', getByIdMaterias);

app.post('/', create);

app.put('/:idmaterias', update);

app.delete('/del/:idmaterias', eliminar);

app.delete('/:idmaterias', eliminacionlogica);

// Metododo para listar todas las materias 
function getAll(req, res) {
    materiaDb.getAll(function (err, result) {
        if (err) {
            res.status(500).send(err);
        } else {
            res.json(result);
        }
    });
}
// Metodo para buscar materias por su dni
function getByIdMaterias(req, res) {
    materiaDb.getByIdMaterias(req.params.idmaterias,function (err, result) {
        if (err) {
            res.status(500).send(err);
        } else {
            res.json(result);
        }
    });
}
// Metodo para agregar materiaas
function create(req, res) {
    materiaDb.create(req.body, function (err, result) {
        if (err) {
            res.status(500).send(err);
        } else {
            res.json(result);
        }
    });
}
// Metodo para modificar materiaas
function update(req, res) {
    materiaDb.update(req.params.idmaterias, req.body, function (result) {
        if (result.code == 3) {
            res.status(500).send(err);
        } else if (result.code == 2) {
            res.status(404).json(result);
        } else {
            res.json(result);
        }
    });
}
// Metodo par eliminar fisicmente materias de la base de datos
function eliminar(req, res) {
    materiaDb.delete(req.params.idmaterias,  function (err, result) {
        if (err) {
            res.status(500).send(err);
        } else {
            if (result.detail.affectedRows == 0) {
                res.status(404).json(result);
            } else {
                res.json(result);
            }
        }
    });
}
// Metodo par eliminar materias cambiando el estado a 0
function eliminacionlogica(req, res) {
    materiaDb.logdelete(req.params.idmaterias, function (result) {
        if (result.code == 3) {
            res.status(500).send(err);
        } else if (result.code == 2) {
                res.status(404).json(result);  
        } else if (result.code == 1) {      
            res.json(result);
        }
    });
}

module.exports = app;