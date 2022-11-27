const fs = require('fs');
let rawdata = fs.readFileSync('./personas.json');

console.log(`¿Qué sucede cuando utilizamos JSON.stringify? \n`, JSON.stringify(rawdata));

console.log(`¿Qué sucede cuando utilizamos JSON.parse? \n`, JSON.parse(rawdata));

/*
1 - Cuando utilizamos JSON.stringify..
JSON.stringify() toma un objeto javascript y lo convierte en una cadena de texto json, por consola se ve:  "{"type":"Buffer","data":[123,10,32,32,34,112,101,114,115,111,110,97,115,34,32,58,91...."
2- Cuando utilizamos JSON.parse? Por que?
El método JSON.parse() analiza una cadena de texto JSON, y convertirá a JavaScript object, por consola muestra un objeto javascript
*/

