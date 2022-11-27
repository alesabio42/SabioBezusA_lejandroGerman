const fs = require('fs');
const rawdata = fs.readFileSync('./departamentos.json', 'utf8');
var departamento = JSON.parse(rawdata);

const getEmpleado = (t,n,p) => {
    
    for(var i=0;i<departamento['departamentos'][1][t].length;i++){
        console.log(departamento['departamentos'][1][t][i][n]+' '+departamento['departamentos'][1][t][i][p]);
        }
}
getEmpleado('tecnologia','nombre','puesto');