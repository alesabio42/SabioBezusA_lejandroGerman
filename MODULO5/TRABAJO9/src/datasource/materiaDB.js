const mysql = require('mysql');
const config = require("../config/config.json");

//conectarnos a nuestra DB
var connection = mysql.createConnection(config.database);

connection.connect((err) => {
    if (err) {
        console.log(err);
    } else {
        console.log("DB Conectada correctamente");
    }
});
//fin de conexion db

var materiaDb = {};

materiaDb.getAll = function (funCallback) {
    connection.query("SELECT * FROM materias where estado >=1", function (err, result, fields) {
        if (err) {
            funCallback({
                message: "Surgio un problema, contactese con un administrador. Gracias",
                detail: err
            });
            console.error(err);
        } else {
            funCallback(undefined, result);
        }
    });
}

materiaDb.getByIdMaterias = function (idmaterias,funCallback) {
    connection.query("SELECT * FROM materias WHERE idmaterias=?",idmaterias, function (err, result, fields) {
        if (err) {
            funCallback({
                message: "Surgio un problema, contactese con un administrador. Gracias",
                detail: err
            });
            console.error(err);
        } else {
            if(result.length>0){
                funCallback(undefined, result[0]);
            }else{
                funCallback({
                    message: "No se encontro la materia"
                });
            }
            
        }
    });
}

materiaDb.create = function (materia, funCallback) {
    var query = 'INSERT INTO materias (nombre,objetivo,plan_estudio,estado) VALUES (?,?,?,?)'
    var dbParams = [materia.nombre,materia.objetivo, materia.plan_estudio, materia.estado];
    connection.query(query, dbParams, function (err, result, fields) {
        if (err) {
            if(err.code == 'ER_DUP_ENTRY'){
                funCallback({
                    message: `Ya existe la materia con el nombre ${materia.nombre}`,
                    detail: err
                });
            }else{
                funCallback({
                    message: "Surgio un problema, contactese con un administrador. Gracias",
                    detail: err
                });
            }
            
            console.error(err);
        } else {
            funCallback(undefined, {
                message: `Se creo la materia ${materia.nombre} ${materia.objetivo}`,
                detail: result
            });
        }
    });
}

/**
 * 
 * @param {*} idmaterias 
 * @param {*} materia
 * @param {*} funCallback 
 *         retorna:
 *              code = 1 (EXITO)
 *              code = 2 (NOT FOUND) (NO encontro elemento)
 *              code = 3 (ERROR)
 * 
 */

materiaDb.update = function (idmaterias, materia, funCallback) {
    var query = 'UPDATE materias SET nombre = ?, objetivo = ?, plan_estudio = ?,  estado = ? WHERE idmaterias = ?'
    var dbParams = [materia.nombre, materia.objetivo, materia.plan_estudio, materia.estado, idmaterias];
    connection.query(query, dbParams, function (err, result, fields) {
        if (err) {
            funCallback({
                code:3,
                message: "Surgio un problema, contactese con un administrador. Gracias",
                detail: err
            });
            console.error(err);
        } else {
            if (result.affectedRows == 0) {
                funCallback({
                    code:2,
                    message: `No se encontro la materia ${idmaterias}`,
                    detail: result
                });
            } else {
                funCallback({
                    code:1,
                    message: `Se modifico la materia ${materia.nombre}`,
                    detail: result
                });
            }
        }
    });

}


materiaDb.delete = function(idmaterias,funCallback){
    var query = 'DELETE FROM materias WHERE idmaterias = ?'
    connection.query(query, idmaterias, function (err, result, fields) {
        if (err) {
            funCallback({
                message: "Surgio un problema, contactese con un administrador. Gracias",
                detail: err
            });
            console.error(err);
        } else {
            if (result.affectedRows == 0) {
                funCallback(undefined,{
                    message: `No se encontro la materia ${idmaterias}`,
                    detail: result
                });
            } else {
                funCallback(undefined,{
                    message: `Se elimino la materia ${idmaterias}`,
                    detail: result
                });
            }
        }
    });
}

/**
 *  
 * @param {*} idmaterias
 * @param {*} funCallback
 *         retorna:
 *              code = 1 (EXITO)
 *              code = 2 (NOT FOUND) (NO encontro elemento)
 *              code = 3 (ERROR)
 * 
 */

materiaDb.logdelete = function (idmaterias, funCallback) {
    connection.query("UPDATE materias SET estado = 0 WHERE idmaterias = ?", idmaterias, function (err, result, fields) {
        if (err) {
            funCallback({
                code:3,
                message: "Surgio un problema, contactese con un administrador. Gracias",
                detail: err
            }); 
            console.error(err);
        } else {
            if (result.affectedRows == 0) {
                funCallback({
                    code:2,
                    message: `No se encontro el id  ${idmaterias} de la materia`,
                    detail: result
                }); 
            } else {
         //       console.error(err);
                    funCallback({
                    code:1,
                    message: `Se modifico el estado (eliminación lógica) la materia con el id ${idmaterias}`,
                    detail: result
                }); 
            }
        }
    });
}

module.exports = materiaDb;