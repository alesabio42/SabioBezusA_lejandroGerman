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

var cursoDb = {};


cursoDb.getAll = function (funCallback) {
    connection.query("SELECT * FROM cursos where estado >=1", function (err, result, fields) {
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

cursoDb.getByIdCurso = function (idcurso,funCallback) {
    connection.query("SELECT * FROM cursos WHERE idcurso=?",idcurso, function (err, result, fields) {
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
                    message: `No se encontro el curso ${curso.idcurso}`
                });
            }
            
        }
    });
}

cursoDb.create = function (curso, funCallback) {
    var query = 'INSERT INTO cursos (nombre,descripcion,estado) VALUES (?,?,?)'
    var dbParams = [curso.nombre, curso.descripcion, curso.estado];
    connection.query(query, dbParams, function (err, result, fields) {
        if (err) {
            if(err.code == 'ER_DUP_ENTRY'){
                funCallback({
                    message: `Ya existe la curso con el nombre ${curso.nombre}`,
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
                message: `Se creo la curso ${curso.descripcion} ${curso.nombre}`,
                detail: result
            });
        }
    });
}

/**
 * 
 * @param {*} idcurso 
 * @param {*} curso 
 * @param {*} funCallback 
 *         retorna:
 *              code = 1 (EXITO)
 *              code = 2 (NOT FOUND) (NO encontro elemento)
 *              code = 3 (ERROR)
 * 
 */
cursoDb.update = function (idcurso, curso, funCallback) {
    var query = 'UPDATE cursos SET nombre = ?, descripcion = ?, estado = ? WHERE idcurso = ?'
    var dbParams = [curso.nombre, curso.descripcion, curso.estado, idcurso];
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
                    message: `No se encontro la curso ${idcurso}`,
                    detail: result
                });
            } else {
                funCallback({
                    code:1,
                    message: `Se modifico la curso ${curso.nombre}, ${curso.descripcion} `,
                    detail: result
                });
            }
        }
    });
}


cursoDb.delete = function(idcurso,funCallback){
    var query = 'DELETE FROM cursos WHERE idcurso = ?'
    connection.query(query, idcurso, function (err, result, fields) {
        if (err) {
            funCallback({
                message: "Surgio un problema, contactese con un administrador. Gracias",
                detail: err
            });
            console.error(err);
        } else {
            if (result.affectedRows == 0) {
                funCallback(undefined,{
                    message: `No se encontro la curso ${idcurso}`,
                    detail: result
                });
            } else {
                funCallback(undefined,{
                    message: `Se elimino la curso ${idcurso}`,
                    detail: result
                });
            }
        }
    });
}

/**
 *  
 * @param {*} idcurso 
 * @param {*} funCallback
 *         retorna:
 *              code = 1 (EXITO)
 *              code = 2 (NOT FOUND) (NO encontro elemento)
 *              code = 3 (ERROR)
 * 
 */

cursoDb.logdelete = function (idcurso, funCallback) {
    connection.query("UPDATE cursos SET estado = 0 WHERE idcurso = ?",idcurso, function (err, result, fields) {
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
                    message: `No se encontro el id  ${idcurso} de la curso`,
                    detail: result
                }); 
            } else {
         //       console.error(err);
                    funCallback({
                    code:1,
                    message: `Se modificó el estado (eliminación lógica) del curso id ${idcurso}`,
                    detail: result
                }); 
            }
        }
    });
}

module.exports = cursoDb;