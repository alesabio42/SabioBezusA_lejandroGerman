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

var usuarioDb = {};


usuarioDb.getAll = function (funCallback) {
    connection.query("SELECT * FROM usuarios where estado >=1", function (err, result, fields) {
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

usuarioDb.getByidusuario = function (idusuario,funCallback) {
    connection.query("SELECT * FROM usuarios WHERE idusuario=?",idusuario, function (err, result, fields) {
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
                    message: "No se encontro la usuario"
                });
            }
            
        }
    });
}

usuarioDb.create = function (usuario, funCallback) {
    var query = 'INSERT INTO usuarios (nickname, email, password, estado) VALUES (?,?,?,?)'
    var dbParams = [usuario.nickname, usuario.email, usuario.password, usuario.estado];
    connection.query(query, dbParams, function (err, result, fields) {
        if (err) {
            if(err.code == 'ER_DUP_ENTRY'){
                funCallback({
                    message: `Ya existe la usuario con el idusuario ${usuario.nickname}`,
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
                message: `Se creo la usuario ${usuario.nickname}`,
                detail: result
            });
        }
    });
}

/**
 * 
 * @param {*} idusuario 
 * @param {*} usuario 
 * @param {*} funCallback 
 *         retorna:
 *              code = 1 (EXITO)
 *              code = 2 (NOT FOUND) (NO encontro elemento)
 *              code = 3 (ERROR)
 * 
 */

usuarioDb.update = function (idusuario, usuario, funCallback) {
    var query = 'UPDATE usuarios SET nickname = ?, email = ?,  password = ?, estado = ? WHERE idusuario = ?'
    var dbParams = [usuario.nickname, usuario.email, usuario.password, usuario.estado, idusuario];
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
                    message: `No se encontro la usuario ${idusuario}`,
                    detail: result
                });
            } else {
                funCallback({
                    code:1,
                    message: `Se modifico la usuario ${usuario.nickname}`,
                    detail: result
                });
            }
        }
    });
}


usuarioDb.delete = function(idusuario,funCallback){
    var query = 'DELETE FROM usuarios WHERE idusuario = ?'
    connection.query(query, idusuario, function (err, result, fields) {
        if (err) {
            funCallback({
                message: "Surgio un problema, contactese con un administrador. Gracias",
                detail: err
            });
            console.error(err);
        } else {
            if (result.affectedRows == 0) {
                funCallback(undefined,{
                    message: `No se encontro la usuario ${idusuario}`,
                    detail: result
                });
            } else {
                funCallback(undefined,{
                    message: `Se elimino la usuario ${idusuario}`,
                    detail: result
                });
            }
        }
    });
}

/**
 *  
 * @param {*} idusuario 
 * @param {*} funCallback
 *         retorna:
 *              code = 1 (EXITO)
 *              code = 2 (NOT FOUND) (NO encontro elemento)
 *              code = 3 (ERROR)
 * 
 */
usuarioDb.logdelete = function (idusuario, funCallback) {
    connection.query("UPDATE usuarios SET estado = 0 WHERE idusuario = ?",idusuario, function (err, result, fields) {
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
                    message: `No se encontro el id  ${idusuario} de la usuario`,
                    detail: result
                }); 
            } else {
         //       console.error(err);
                    funCallback({
                    code:1,
                    message: `Se modifico estado del usuario con el id ${idusuario}`,
                    detail: result
                }); 
            }
        }
    });
}

module.exports = usuarioDb;