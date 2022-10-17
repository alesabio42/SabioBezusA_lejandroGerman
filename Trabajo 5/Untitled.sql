-- 1.	Lista el apellido de todos los empleados.
SELECT apellido FROM empleados
-- 2.	Lista el apellido de los empleados eliminando los apellidos que estén repetidos.
SELECT DISTINCT apellido FROM empleados;
-- 3.	Lista todas las columnas de la tabla empleados.
SELECT * FROM empleados;
-- 4.	Lista el nombre y apellido de todos los empleados.
SELECT nombre, apellido FROM empleados;
-- 5.	Lista el cuit/cuil de los departamentos de los empleados que aparecen en la tabla empleados.
SELECT cuil_cuit FROM empleados;
-- 6.	Lista el nombre y apellido de los empleados en una única columna.
SELECT CONCAT_WS(' ', nombre, apellido) FROM empleados;
-- 7.	Lista el nombre y apellido de los empleados en una única columna, convirtiendo todos los caracteres en mayúscula.
SELECT UPPER(CONCAT_WS('  ', nombre, apellido)) FROM empleados;
-- 8.	Lista el nombre y apellido de los empleados en una única columna, convirtiendo todos los caracteres en minúscula.
SELECT LOWER(CONCAT_WS('  ', nombre, apellido)) FROM empleados;
-- 9.	Lista el nombre de los departamentos y el valor del presupuesto actual ordenado de forma ascendente.
SELECT nombre, presupuesto FROM departamentos order by presupuesto asc;
-- 10.	Lista el nombre de todos los departamentos ordenados de forma ascendente.
SELECT nombre FROM departamentos order by nombre asc;
-- 11.	Lista el nombre de todos los departamentos ordenados de forma descendente.
SELECT nombre FROM departamentos order by nombre desc;
-- 12.	Lista el apellido y el nombre de todos los empleados, ordenados de forma alfabética tendiendo en cuenta en primer lugar su apellido y luego su nombre.
SELECT apellido, nombre FROM empleados ORDER BY apellido asc, nombre asc;
-- 13.	Devuelve una lista con el nombre y el presupuesto, de los 3 departamentos que tienen mayor presupuesto.
SELECT nombre, presupuesto FROM departamentos  order by presupuesto desc LIMIT 3;
-- 14.	Devuelve una lista con el nombre y el presupuesto, de los 3 departamentos que tienen menor presupuesto.
SELECT nombre, presupuesto FROM departamentos  order by presupuesto asc LIMIT 3;
-- 15.	Devuelve una lista con el nombre de los departamentos y el presupuesto, de aquellos que tienen un presupuesto mayor o igual a $150000.
select nombre, presupuesto from departamentos where presupuesto >=150000;
-- 16.	Devuelve una lista con el nombre de los departamentos y el presupuesto, de aquellos que tienen un presupuesto entre $100000 y $200000. Sin utilizar el operador BETWEEN.
select nombre, presupuesto from departamentos where presupuesto > 100000 and presupuesto < 200000;
-- 17.	Devuelve una lista con el nombre de los departamentos que no tienen un presupuesto entre $100000 y $200000. Sin utilizar el operador BETWEEN.
select nombre from departamentos where not (presupuesto > 100000 and  presupuesto < 200000);
-- 18.	Devuelve una lista con el nombre de los departamentos que tienen un presupuesto entre $100000 y $200000. Utilizando el operador BETWEEN.
select nombre from departamentos where presupuesto between 100000 and 200000
-- 19.	Devuelve una lista con el nombre de los departamentos que no tienen un presupuesto entre $100000 y $200000. Utilizando el operador BETWEEN.
select nombre from departamentos where not (presupuesto between 100000 and 200000);
-- 20.	Devuelve un listado con los empleados y los datos de los departamentos donde trabaja cada uno.
select emp.NOMBRE, emp.APELLIDO, depto.NOMBRE, depto.PRESUPUESTO, depto.ESTADO
	from empleados as emp
    inner join departamentos as depto
		on emp.idemplaedo =  depto.iddepartamento
        order by apellido, nombre ASC;
-- 21.	Devuelve un listado con los empleados y los datos de los departamentos donde trabaja cada uno. Ordena el resultado, en primer lugar por el nombre del departamento (en orden alfabético) y en segundo lugar por apellido y el nombre de los empleados.
select emp.NOMBRE, emp.APELLIDO, depto.NOMBRE, depto.PRESUPUESTO, depto.ESTADO
	from empleados as emp
    inner join departamentos as depto
		on emp.id_departamento =  depto.iddepartamento
        order by depto.NOMBRE asc, emp.APELLIDO asc, emp.NOMBRE asc;
-- 22. Devuelve un listado con el código y el nombre del departamento, solamente de aquellos departamentos que tienen empleados.

-- 23.	Devuelve el nombre del departamento donde trabaja el empleado que tiene el cuit 27-38382980-3.
select depto.NOMBRE
	from departamentos as depto
		inner join empleados as emp
		on emp.id_departamento = depto.iddepartamento
	where emp.cuil_cuit = '27-38382980-3';
-- 24.	Devuelve el nombre del departamento donde trabaja el empleado Pepe Ruiz.
select depto.NOMBRE
	from departamentos as depto
		inner join empleados as emp
		on emp.id_departamento = depto.iddepartamento
	where emp.nombre = 'Pepe' and emp.apellido = 'Ruiz';
-- 25.	Devuelve un listado con los datos de los empleados que trabajan en el departamento de I+D. Ordena el resultado alfabéticamente.
select emp.idemplaedo, emp.cuil_cuit, emp.nombre, emp.apellido, emp.id_departamento, emp.estado
	from departamentos as depto
		inner join empleados as emp
		on emp.id_departamento = depto.iddepartamento
	where depto.nombre ='I+D';
-- 26.	Devuelve un listado con los datos de los empleados que trabajan en el departamento de Sistemas, Contabilidad o I+D. Ordena el resultado alfabéticamente.
select emp.idemplaedo, emp.cuil_cuit, emp.nombre, emp.apellido, emp.id_departamento, emp.estado
	from departamentos as depto
		inner join empleados as emp
		on emp.id_departamento = depto.iddepartamento
	where depto.nombre ='I+D' or depto.nombre ='Contabilidad' or depto.nombre ='Sistemas'
    order by depto.nombre;
-- 27.	Devuelve una lista con el nombre de los empleados que tienen los departamentos que no tienen un presupuesto entre $100000 y $200000.
select emp.idemplaedo, emp.cuil_cuit, emp.nombre, emp.apellido, emp.id_departamento, emp.estado
	from departamentos as depto
		inner join empleados as emp
		on emp.id_departamento = depto.iddepartamento
where not (depto.presupuesto > 100000 and  depto.presupuesto < 200000);