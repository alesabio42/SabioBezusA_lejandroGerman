'use strict';
let jsonData = require('./personas.json');
console.log(JSON.stringify(jsonData));
//console.log(JSON.parse(jsonData));

/*
1- Cuando utilizamos JSON.stringify...
El método JSON.stringify() convierte un valor de JavaScript en una cadena JSON.
2- Cuando utilizamos JSON.parse? Porque?
Nos da error. Porque JSON.parse() no soporta comas finales en el objeto.
*/