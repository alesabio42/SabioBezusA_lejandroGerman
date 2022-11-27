const fs = require('fs');
const rawdata = fs.readFileSync('./personas.json', 'utf8');
var persona = JSON.parse(rawdata);


function get2Nombre(arreglo){
    for(var i=0;i<arreglo['personas'].length;i++){
        if(arreglo['personas'][i]['Localidad']==='Posadas'){
            console.log('solución 1: ' +arreglo['personas'][i]['Nombre']+' '+arreglo['personas'][i]['Apellido']);
        }
        }
}
get2Nombre(persona);

const getNombre = (nombres) => {
    for(var i=0;i<nombres['personas'].length;i++){
        if(nombres['personas'][i]['Localidad']==='Posadas'){
            console.log('solución 2 (c/arrow function): ' + nombres['personas'][i]['Nombre']+' '+nombres['personas'][i]['Apellido']);
        }
        }
}
getNombre(persona);