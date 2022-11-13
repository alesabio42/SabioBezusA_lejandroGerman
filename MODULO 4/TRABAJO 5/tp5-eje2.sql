-- 1.	Devuelve un listado con todos los pedidos que se han realizado. Los pedidos deben estar ordenados por la fecha de realización, mostrando en primer lugar los pedidos más recientes.
SELECT * FROM pedidos ORDER BY fecha DESC;
-- 2.	Devuelve todos los datos de los dos pedidos de mayor valor.
SELECT * FROM pedidos ORDER BY cantidad DESC LIMIT 2;
-- 3.	Devuelve un listado con los identificadores de los clientes que han realizado algún pedido. Tenga en cuenta que no debe mostrar identificadores que estén repetidos.
SELECT DISTINCT id_cliente FROM pedidos;
-- 4.	Devuelve un listado de todos los pedidos que se realizaron durante el año 2022, cuya cantidad total sea superior a $500.
SELECT * FROM pedidos 
	WHERE fecha BETWEEN '2022-01-01' AND '2022-12-31' AND cantidad>500;
-- 5.	Devuelve un listado con el nombre y apellido de los vendedores que tienen una comisión entre 0.05 y 0.11.
SELECT nombre, apellido FROM vendedores WHERE comisión BETWEEN 0.05 AND 0.11;
-- 6.	Devuelve el valor de la comisión de mayor valor que existe en la tabla vendedores.
SELECT comisión FROM vendedores ORDER BY comisión DESC LIMIT 1;
-- 7.	Devuelve el identificador, nombre y primer apellido de aquellos clientes cuyo cuitcuil no es NULL. El listado deberá estar ordenado alfabéticamente por apellido y nombre.
SELECT id, nombre, apellido FROM clientes WHERE cuitcuil IS NOT NULL;
-- 8.	Devuelve un listado de los nombres de los clientes que empiezan por “A” y terminan por “n” y también los nombres que empiezan por “P”. El listado deberá estar ordenado alfabéticamente.
SELECT nombre FROM clientes WHERE nombre LIKE 'A%n' OR nombre LIKE 'P%' ORDER BY nombre ASC;
-- 9.	Devuelve un listado de los nombres de los clientes que no empiezan por “A”. El listado deberá estar ordenado alfabéticamente.
SELECT nombre FROM clientes WHERE nombre NOT LIKE 'A%' ORDER BY nombre ASC;
-- 10.	Devuelve un listado con los nombres de los vendedores que terminan por “el” o “o”. Tenga en cuenta que se deberán eliminar los nombres repetidos.
SELECT nombre FROM vendedores WHERE nombre LIKE '%el' OR nombre LIKE '%o';
-- 11.	Devuelve un listado con el identificador, nombre y apellido de todos los clientes que han realizado algún pedido. El listado debe estar ordenado alfabéticamente y se deben eliminar los elementos repetidos.
SELECT DISTINCT C.id, C.nombre, C.apellido
FROM clientes C 
INNER JOIN pedidos P 
ON C.id=P.id_cliente 
ORDER BY C.apellido1 ASC;
-- 12.	Devuelve un listado que muestre todos los pedidos que ha realizado cada cliente. El resultado debe mostrar todos los datos de los pedidos y del cliente. El listado debe mostrar los datos de los clientes ordenados alfabéticamente.
SELECT * FROM pedidos as Ped 
INNER JOIN clientes as Clie
ON Ped.id_cliente = Clie.id 
ORDER BY Clie.apellido ASC;
-- 13.	Devuelve un listado que muestre todos los pedidos en los que ha participado un vendedor. El resultado debe mostrar todos los datos de los pedidos y de los vendedores. El listado debe mostrar los datos de los vendedores ordenados alfabéticamente.
SELECT * FROM pedidos as Ped 
INNER JOIN vendedores as Ven 
ON Ped.id_vendedor = Ven.id 
ORDER BY Ven.apellido ASC;
-- 14.	Devuelve un listado que muestre todos los clientes, con todos los pedidos que han realizado y con los datos de los vendedores asociados a cada pedido.
SELECT * FROM clientes as C 
INNER JOIN pedidos as P 
ON C.id = P.id_cliente 
INNER JOIN vendedores as Ven
ON Ven.id=P.id_vendedor;
-- 15.	Devuelve un listado de todos los clientes que realizaron un pedido durante el año 2022, cuyo monto esté entre $300 y $1000.
SELECT * FROM clientes as C 
INNER JOIN pedidos as P 
ON C.id=P.id_cliente
WHERE fecha BETWEEN '2022-01-01' AND '2022-12-31' AND (cantidad>=300 AND cantidad<=1000);
-- 16.	Devuelve el nombre y apellido de todos los vendedores que han participado en algún pedido realizado por María Santana.
SELECT V.nombre, V.apellido 
FROM vendedores as V 
INNER JOIN pedidos as P 
ON V.id=P.id_vendedor 
INNER JOIN clientes CL 
ON CL.id=P.id_cliente 
WHERE CL.nombre LIKE '%María%' AND CL.apellido LIKE '%Santana%';
-- 17.	Devuelve el nombre de todos los clientes que han realizado algún pedido con el vendedor Daniel Sáez.
SELECT C.nombre 
FROM clientes C 
INNER JOIN pedidos P 
ON C.id=P.id_cliente 
INNER JOIN vendedores V 
ON V.id=P.id_vendedor 
WHERE V.nombre LIKE '%Daniel%' AND V.apellido LIKE '%Sáez%';
-- 18.	Devuelve un listado con todos los clientes junto con los datos de los pedidos que han realizado. Este listado también debe incluir los clientes que no han realizado ningún pedido. El listado debe estar ordenado alfabéticamente por el apellido y nombre de los clientes.
SELECT * FROM clientes C 
LEFT JOIN pedidos P 
On C.id=P.id_cliente 
ORDER BY C.apellido, C.nombre;
-- 19.	Devuelve un listado con todos los vendedores junto con los datos de los pedidos que han realizado. Este listado también debe incluir los vendedores que no han realizado ningún pedido. El listado debe estar ordenado alfabéticamente por el apellido y nombre de los vendedores.
SELECT * FROM vendedores V 
LEFT JOIN pedidos P 
On V.id=P.id_vendedor 
ORDER BY V.apellido, V.nombre;
-- 20.	Devuelve un listado que solamente muestre los clientes que no han realizado ningún pedido.
SELECT * FROM clientes C 
LEFT JOIN pedidos P 
ON C.id=P.id_cliente 
WHERE P.id_cliente IS NULL;
-- 21.	Devuelve un listado que solamente muestre los vendedores que no han  realizado ningún pedido.
SELECT * FROM vendedores V
LEFT JOIN pedidos P 
on V.id=P.id_vendedor 
WHERE P.id IS NULL;
-- 22.	Devuelve un listado con los clientes que no han realizado ningún pedido y de los vendedores que no han participado en ningún pedido. Ordene el listado alfabéticamente por el apellido y el nombre. En el listado deberá diferenciar de algún modo los clientes y los vendedores.
SELECT * FROM clientes CL 
RIGHT JOIN pedidos P 
ON CL.id = P .id_cliente 
RIGHT JOIN vendedores V 
ON V.id=P.id_vendedor 
WHERE P.id 
IS NULL ORDER BY CL.apellido, CL.nombre, V.apellido, V.nombre;

-- 23.	Calcula la cantidad total que suman todos los pedidos que aparecen en la tabla pedido.
SELECT COUNT(*) FROM pedidos;
-- 24.	Calcula la cantidad media de todos los pedidos que aparecen en la tabla pedido.
SELECT AVG(cantidad) FROM pedidos;
-- 25.	Calcula el número total de vendedores distintos que aparecen en la tabla pedido.
SELECT  COUNT(DISTINCT id_vendedor) FROM pedidos;
-- 26.	Calcula el número total de clientes que aparecen en la tabla cliente.
SELECT COUNT(*) FROM clientes;
-- 27.	Calcula cuál es la mayor cantidad que aparece en la tabla pedido.
SELECT MAX(cantidad) FROM pedidos;
-- 28.	Calcula cuál es la menor cantidad que aparece en la tabla pedido.
SELECT MIN(cantidad) FROM pedidos;
-- 29.	Calcula cuál es el valor máximo de categoría para cada una de las ciudades que aparece en la tabla cliente.
SELECT MAX(categoría) AS maximo ,ciudad 
FROM clientes 
GROUP BY ciudad;
-- ERROR 30.	Calcula cuál es el máximo valor de los pedidos realizados durante el mismo día para cada uno de los clientes. Es decir, el mismo cliente puede haber realizado varios pedidos de diferentes cantidades el mismo día. Se pide que se calcule cuál es el pedido de máximo valor para cada uno de los días en los que un cliente ha realizado un pedido. Muestra el identificador del cliente, nombre, apellido, la fecha y el valor de la cantidad.
SELECT clientes.id, clientes.nombre, clientes.apellido, pedidos.fecha, MAX(pedidos.cantidad) 
FROM clientes 
INNER JOIN pedidos 
ON clientes.id = pedidos.id_cliente 
GROUP BY clientes.id, pedidos.fecha;

-- ERROR 31.	Calcula cuál es el máximo valor de los pedidos realizados durante el mismo día para cada uno de los clientes, teniendo en cuenta que sólo queremos mostrar aquellos pedidos que superen la cantidad de $2000 .
SELECT clientes.id, clientes.nombre, clientes.apellido, pedidos.fecha, MAX(pedidos.cantidad) 
FROM clientes 
INNER JOIN pedidos 
ON clientes.id = pedidos.id_cliente 
WHERE cantidad > 2000 
GROUP BY clientes.id, pedidos.fecha; 
-- 32.	Calcula el máximo valor de los pedidos realizados para cada uno de los vendedores durante la fecha 2021-08-17. Muestra el identificador del vendedor, nombre, apellido y total.
SELECT  ven.id, ven.nombre, ven.apellido, MAX(cantidad) 
FROM pedidos 
RIGHT JOIN vendedores as ven
ON pedidos.id_vendedor = ven.id WHERE fecha = '2021-08-17' GROUP BY ven.id;
-- 33.	Devuelve un listado con el identificador de cliente, nombre y apellido y el número total de pedidos que ha realizado cada uno de los clientes. Tenga en cuenta que pueden existir clientes que no han realizado ningún pedido. Estos clientes también deben aparecer en el listado indicando que el número de pedidos realizados es 0. 	 
SELECT clientes.id, clientes.nombre, clientes.apellido, COUNT(pedidos.id) 
FROM clientes 
LEFT JOIN pedidos 
ON clientes.id = pedidos.id_cliente 
GROUP BY clientes.id; 
-- 34.	Devuelve un listado con el identificador de cliente, nombre, apellido y el número total de pedidos que ha realizado cada uno de clientes durante el año 2020.
SELECT CL.id,CL.nombre,CL.apellido,COUNT(P.id)
FROM clientes CL
INNER JOIN pedidos P
ON P.id_cliente=CL.id 
WHERE YEAR (P.fecha)=2022	 
GROUP BY CL.id;
-- 35.	Devuelve cuál ha sido el pedido de máximo valor que se ha realizado cada año.
SELECT YEAR(fecha),MAX(cantidad) 
FROM pedidos 
GROUP BY YEAR(fecha);
-- 36.	Devuelve el número total de pedidos que se han realizado cada año.
SELECT YEAR(fecha),count(cantidad) 
FROM pedidos 
GROUP BY YEAR(fecha);
-- 37.	Devuelve un listado con todos los pedidos que ha realizado Adela Salas. (Sin utilizar INNER JOIN).
select * from pedidos where id_cliente = (select id from clientes where nombre = 'Adela' and apellido = 'Salas');
-- 38.	Devuelve el número de pedidos en los que ha participado el vendedor Daniel Sáe. (Sin utilizar INNER JOIN)
select count(*) from pedidos where id_vendedor = (Select id from vendedores where nombre = 'Daniel' and apellido = 'Sáez' );

-- 39.	Devuelve los datos del cliente que realizó el pedido más caro en el año 2020. (Sin utilizar INNER JOIN)
select * from clientes where id = (select id_cliente from pedidos where cantidad = (select MAX(cantidad) from pedidos where year(fecha) = 2020));
-- 40.	Devuelve la fecha y la cantidad del pedido de menor valor realizado por el cliente Pepe Ruiz Santana.
select fecha, cantidad 
from clientes 
inner join pedidos 
on clientes.id = pedidos.id_cliente 
where clientes.nombre = 'Pepe' and apellido = 'Ruiz' and pedidos.cantidad = (select MIN(cantidad) 
from clientes inner join pedidos on clientes.id = pedidos.id_cliente where clientes.nombre = 'Pepe' and apellido = 'Ruiz');
-- 41.	Devuelve un listado de los clientes que no han realizado ningún pedido. (Utilizando IN o NOT IN).
select * from clientes where id not in (select id_cliente from pedidos);
-- 42.	Devuelve un listado de los vendedores que no han realizado ningún pedido. (Utilizando IN o NOT IN).
select * from vendedores where id not in (select id_vendedor from pedidos);
-- 43.	Devuelve un listado de los clientes que no han realizado ningún pedido. (Utilizando EXISTS o NOT EXISTS).
select * from clientes 
where not exists (select id_cliente from pedidos where clientes.id = pedidos.id_cliente);
-- 44.	Devuelve un listado de los vendedores que no han realizado ningún pedido. (Utilizando EXISTS o NOT EXISTS).
select * from vendedores
where not exists (select id_vendedor from pedidos where vendedores.id = pedidos.id_vendedor);