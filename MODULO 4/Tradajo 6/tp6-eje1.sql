-- 1.	Agregar las entidades paises (id, nombre), provincias (id, nombre, idpais) y localidades (id,nombre, cp,id_provincia). Tener en cuenta que:
--       ●	En un país hay muchas provincias.
--       ●	En una provincia hay muchas localidades.

CREATE TABLE `paises` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `provincias` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `idpais` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_provincias_idpaisx` (`idpais`),
  CONSTRAINT `fk_provincias_idpaisx` FOREIGN KEY (`idpais`) REFERENCES `paises` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE TABLE `localidades` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `cp` int DEFAULT NULL,
  `id_provincia` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_localidades_provincias1_idx` (`id_provincia`),
  CONSTRAINT `fk_localidades_provincias1` FOREIGN KEY (`id_provincia`) REFERENCES `provincias` (`id`)
); 
-- 2.	Modificar la tabla empleados usando ALTER TABLE y agregar los campos:
--       ●	direccion (varchar)
--       ●	id_localidad (pk localidad) –Esta es un relación con la tabla localidades
--       ●	email
--       ●	telefono
--       ●	fecha_ingreso
--       ●	tms (timestamp)
ALTER TABLE `elsistema`.`empleados` 
ADD COLUMN `direccion` VARCHAR(45) NULL AFTER `estado`,
ADD COLUMN `email` VARCHAR(45) NULL AFTER `direccion`,
ADD COLUMN `telefono` VARCHAR(45) NULL AFTER `email`,
ADD COLUMN `fecha_ingreso` DATE NULL AFTER `telefono`,
ADD COLUMN `tms` TIMESTAMP NULL AFTER `fecha_ingreso`;

-- 3.	Modificar la tabla de departamentos usando ALTER TABLE y agregar los campos:
--       ●	gasto (double)
--       ●	tms (timestamp)
ALTER TABLE `elsistema`.`departamentos` 
ADD COLUMN `gasto` DOUBLE NULL AFTER `estado`,
ADD COLUMN `tms` TIMESTAMP NULL AFTER `gasto`;

-- 4.	Insertar 5 registros en cada tabla de: paises, provincias, localidades, departamentos, empleados.
INSERT INTO `paises` VALUES (1,'Argentina'),(2,'Paraguay'),(3,'Brasil'),(4,'Peru'),(5,'Bolivia'),(6,'Uruguay'),(7,'Venezuela');
INSERT INTO `provincias` VALUES (1,'Corrientes',1),(2,'Cordoba',1),(3,'Misiones',1),(4,'Chaco',1),(5,'Formosa',1);
INSERT INTO `localidades` VALUES (1,'Posadas',3300,3),(2,'Iguazu',NULL,3),(3,'Virasoro',3342,1),(4,'Eldorado',3380,3),(5,'Ituizango',NULL,1);
INSERT INTO `departamentos` VALUES (1,'Recursos Humanos',150000,1,100000,NULL),(2,'Fabrica',150000,1,80000,NULL),(3,'Contable',50000,0,30000,NULL),(4,'Compras',300000,1,290000,NULL),(5,'Organismos Externos',10000,0,9000,NULL);
INSERT INTO `empleados` VALUES (1,'27-45143343-3','Alejandro','Sabio',1,0,'Entre Rios 3456','alesa@gmail.com','3764567657','2021-01-01',NULL),
(2,'27-41121541-3','Santiago','Muller',5,1,'3 de Febrero 1454','santiago@hotmail.com','3765456789','2022-02-01',NULL),
(3,'27-41892158-3','Roberto','Stau',4,0,'Roque Perez 3453','stau@hotmail.com','3765657890','2022-05-01',NULL),
(4,'27-31671265-3','Carlos','Santa',3,1,'Tucuman 4532','carlos@hotmail.com','3765453445','2020-03-01',NULL),
(5,'27-21675581-3','Gustavo','Cruz',2,0,'Lavalle 455','gustavo@hotmail.com','3755432345','2020-02-01',NULL);


-- 5.	Modificar el nombre de la tabla “pedidos” por “movimientos”. RENAME TABLE
ALTER TABLE `elsistema`.`pedidos` 
RENAME TO  `elsistema`.`movimientos` ;

-- 6.	Agregar las entidades: ACLARACIÓN: hacer correr primero cajas e ir subiendo, si arranca con productos y se va bajando, tira error
--       ●	Productos (id, nombre, descripcion, id_marca fk, stock, precio, estado, tms)
CREATE TABLE `productos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  `id_marca` int DEFAULT NULL,
  `stock` int DEFAULT NULL,
  `precio` double DEFAULT NULL,
  `estado` varchar(45) DEFAULT NULL,
  `tms` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_productos_marcas1_idx` (`id_marca`),
  CONSTRAINT `fk_productos_marcas1` FOREIGN KEY (`id_marca`) REFERENCES `marcas` (`id`)
);

--       ●	Marcas (id, nombre, descripción, imagen, id_proveedor, estado, tms)
CREATE TABLE `marcas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `descripción` varchar(45) DEFAULT NULL,
  `imagen` blob,
  `id_proveedor` int DEFAULT NULL,
  `estado` varchar(45) DEFAULT NULL,
  `tms` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `proveedorFK_idx` (`id_proveedor`),
  CONSTRAINT `proveedorFK` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedores` (`id`)
);
--       ●	Proveedores (id, razon_social, nombre, apellido, naturaleza (fisica o juridica), cuit,id_localidad fk, estado,tms)
CREATE TABLE `proveedores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `razon_social` varchar(45) DEFAULT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `apellido` varchar(45) DEFAULT NULL,
  `naturaleza` varchar(45) DEFAULT NULL,
  `cuit` varchar(45) DEFAULT NULL,
  `id_localidades` int DEFAULT NULL,
  `estado` varchar(45) DEFAULT NULL,
  `tms` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_proveedores_localidades1_idx` (`id_localidades`),
  CONSTRAINT `fk_proveedores_localidades1` FOREIGN KEY (`id_localidades`) REFERENCES `localidades` (`id`)
);
--       ●	Cajas (id,horainicio(datatime),horacierre(datatime), estado, tms)
CREATE TABLE `cajas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `horainicio` datetime DEFAULT NULL,
  `horacierre` datetime DEFAULT NULL,
  `estado` varchar(45) DEFAULT NULL,
  `tms` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);
--       Notas: Muchos productos tienen una sola marca, o una marca tiene uno o muchos productos.
--       Un proveedor está en una localidad.

-- 7.	Insertar 5 registros en cada tabla del punto 6. Tener en cuenta que el script debe ejecutarse secuencialmente y no fallar.
INSERT INTO `productos` VALUES (1,'Camiseta','Boca',NULL,4,10000,'1',NULL),(2,'Pantalon','River',NULL,1,10000,'0',NULL),(3,'Media','Nike',NULL,2,1000,'1',NULL),(4,'Musculosa','Racing',NULL,5,2000,'0',NULL),(5,'Short','Platense',NULL,1,2000,'1',NULL);
INSERT INTO `marcas` VALUES (1,'Nike','Calidad',NULL,NULL,'0',NULL),(2,'Adidas','Buen precio',NULL,NULL,'1',NULL),(3,'Puma','Calidad Intermedia',NULL,3,'0',NULL),(4,'Crocs','Comodas',NULL,4,'0',NULL),(5,'Lacoste','Buen precio',NULL,9,'1',NULL);
INSERT INTO `proveedores` VALUES (1,'Nike SA','Sergio','Garrido','contractural','30-99225432-5',1,NULL,NULL),(2,'Puma SA','Tertien','Lopez','contractural','30-40392032-8',2,NULL,NULL),(3,'Adidas SA','Roberto','Fulge','contractural','25-3070808266-9',3,NULL,NULL),(4,'Nike SA','Roberto','Carlos','contractural','30-307080999-9',4,NULL,NULL),(5,'Lacoste sa','Juan','Carlos','contractural','30-45678909-9',3,NULL,NULL);
INSERT INTO `cajas` VALUES (1,'2022-05-04 09:00:00','2022-05-04 12:00:00','1',NULL),(2,'2022-05-24 08:00:00','2022-05-24 12:30:00','1',NULL),(3,'2022-10-29 07:00:00','2022-10-29 12:30:00','1',NULL),(4,'2022-10-29 11:00:00','2022-10-29 20:00:00','1',NULL),(5,'2022-10-29 17:00:00','2022-10-29 22:00:00','1',NULL);
-- 8.	Listar el nombre, presupuesto, gastos y diferencia(presupuesto-gasto) de todos los departamentos con estado activo o 1.
SELECT nombre, presupuesto, gasto, (presupuesto-gasto) as diferencia 
FROM elsistema.departamentos 
where estado=1;
-- VER 9.	Listar todas todas las localidades agrupadas por pais. En la vista se deberia ver el nombre del pais y el nombre de la localidad


-- 10.	Modificar (UPADTE):
--       ●	el telefono de un empleado cuando el id es igual a uno que hayan declarado. 
UPDATE `elsistema`.`empleados` SET `telefono` = '37567898765' WHERE (`idemplaedo` = '1');
--       ●	el fecha_ingreso y la localidad de otro empleado.
UPDATE `elsistema`.`empleados` SET `fecha_ingreso` = '2020-06-02', `id_departamento` = '3' WHERE (`idemplaedo` = '3');
