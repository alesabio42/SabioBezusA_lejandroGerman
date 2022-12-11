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

var sedeDb = {};


sedeDb.getAll = function (funCallback) {
    connection.query("SELECT * FROM sedes where estado >=1", function (err, result, fields) {
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

sedeDb.getByidsede = function (idsede,funCallback) {
    connection.query("SELECT * FROM sedes WHERE idsede=?", idsede, function (err, result, fields) {
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
                    message: "No se encontro la sede"
                });
            }
            
        }
    });
}

sedeDb.create = function (sede, funCallback) {
    var query = 'INSERT INTO sedes (nombre,direccion,localidad,cod_postal, telcontacto1, telcontacto2, estado) VALUES (?,?,?,?,?,?,?)'
    var dbParams = [sede.nombre, sede.direccion, sede.localidad, sede.cod_postal, sede.telcontacto1, sede.telcontacto2, sede.estado];
    connection.query(query, dbParams, function (err, result, fields) {
        if (err) {
            if(err.code == 'ER_DUP_ENTRY'){
                funCallback({
                    message: `Ya existe la sede con el nombre ${sede.nombre}`,
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
                message: `Se creo la sede ${sede.nombre}`,
                detail: result
            });
        }
    });
}

/**
 * 
 * @param {*} idsede 
 * @param {*} sede 
 * @param {*} funCallback 
 *         retorna:
 *              code = 1 (EXITO)
 *              code = 2 (NOT FOUND) (NO encontro elemento)
 *              code = 3 (ERROR)
 * 
 */
sedeDb.update = function (idsede, sede, funCallback) {
    var query = 'UPDATE sedes SET nombre = ?, direccion = ?,  localidad = ?, cod_postal = ?, telcontacto1 = ?, telcontacto2 = ?,estado = ?  WHERE idsede = ?'
    var dbParams = [sede.nombre, sede.direccion, sede.localidad, sede.cod_postal, sede.telcontacto1, sede.telcontacto1,sede.estado, idsede];
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
                    message: `No se encontro la sede ${idsede}`,
                    detail: result
                });
            } else {
                funCallback({
                    code:1,
                    message: `Se modifico la sede ${sede.nombre}`,
                    detail: result
                });
            }
        }
    });

}


sedeDb.delete = function(idsede,funCallback){
    var query = 'DELETE FROM sedes WHERE idsede = ?'
    connection.query(query, idsede, function (err, result, fields) {
        if (err) {
            funCallback({
                message: "Surgio un problema, contactese con un administrador. Gracias",
                detail: err
            });
            console.error(err);
        } else {
            if (result.affectedRows == 0) {
                funCallback(undefined,{
                    message: `No se encontro la sede ${idsede}`,
                    detail: result
                });
            } else {
                funCallback(undefined,{
                    message: `Se elimino la sede ${idsede}`,
                    detail: result
                });
            }
        }
    });
}

/**
 *  
 * @param {*} idsede 
 * @param {*} funCallback
 *         retorna:
 *              code = 1 (EXITO)
 *              code = 2 (NOT FOUND) (NO encontro elemento)
 *              code = 3 (ERROR)
 * 
 */
sedeDb.logdelete = function (idsede, funCallback) {
    connection.query("UPDATE sedes SET estado = 0 WHERE idsede = ?",idsede, function (err, result, fields) {
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
                    message: `No se encontro el id  ${idsede} de la sede`,
                    detail: result
                }); 
            } else {
         //       console.error(err);
                    funCallback({
                    code:1,
                    message: `Se modifico el estado de la sede con el id ${idsede}`,
                    detail: result
                }); 
            }
        }
    });
}

module.exports = sedeDb;