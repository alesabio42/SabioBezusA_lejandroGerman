-- EJERCICIO 1 ------
  
  CREATE SCHEMA COLEGIO;
  
  -- CREAMOS LAS TABLAS 
CREATE TABLE IF NOT EXISTS `COLEGIO`.`ALUMNO` (
  `cod_matricula` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `DNI` CHAR(10) NOT NULL,
  `fechadenacimiento` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `ALUMNOcol` INT NOT NULL,
  PRIMARY KEY (`cod_matricula`));

CREATE TABLE IF NOT EXISTS `COLEGIO`.`PROFESOR` (
  `idPROFESOR` INT NOT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `especialidad` VARCHAR(45) NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPROFESOR`));

CREATE TABLE IF NOT EXISTS `COLEGIO`.`CURSO` (
  `cod_curso` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cod_curso`));

-- RELACIONAMOS LA TABLAS

CREATE TABLE IF NOT EXISTS `COLEGIO`.`PROFESOR_has_CURSO` (
  `PROFESOR_idPROFESOR` INT NOT NULL,
  `CURSO_cod_curso` INT NOT NULL,
  PRIMARY KEY (`PROFESOR_idPROFESOR`, `CURSO_cod_curso`),
  INDEX `fk_PROFESOR_has
  _CURSO_CURSO1_idx` (`CURSO_cod_curso` ASC) VISIBLE,
  INDEX `fk_PROFESOR_has_CURSO_PROFESOR1_idx` (`PROFESOR_idPROFESOR` ASC) VISIBLE,
  CONSTRAINT `fk_PROFESOR_has_CURSO_PROFESOR1`
    FOREIGN KEY (`PROFESOR_idPROFESOR`)
    REFERENCES `COLEGIO`.`PROFESOR` (`idPROFESOR`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PROFESOR_has_CURSO_CURSO1`
    FOREIGN KEY (`CURSO_cod_curso`)
    REFERENCES `COLEGIO`.`CURSO` (`cod_curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
      CREATE TABLE IF NOT EXISTS `COLEGIO`.`ALUMNO_has_CURSO` (
  `ALUMNO_cod_matricula` INT NOT NULL,
  `CURSO_cod_curso` INT NOT NULL,
  `id-alumnocurso` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id-alumnocurso`, `ALUMNO_cod_matricula`, `CURSO_cod_curso`),
  INDEX `fk_ALUMNO_has_CURSO_CURSO1_idx` (`CURSO_cod_curso` ASC) VISIBLE,
  INDEX `fk_ALUMNO_has_CURSO_ALUMNO1_idx` (`ALUMNO_cod_matricula` ASC) VISIBLE,
  CONSTRAINT `fk_ALUMNO_has_CURSO_ALUMNO1`
    FOREIGN KEY (`ALUMNO_cod_matricula`)
    REFERENCES `COLEGIO`.`ALUMNO` (`cod_matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ALUMNO_has_CURSO_CURSO1`
    FOREIGN KEY (`CURSO_cod_curso`)
    REFERENCES `COLEGIO`.`CURSO` (`cod_curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
CREATE TABLE IF NOT EXISTS `COLEGIO`.`ALUMNO_has_CURSO` (
  `ALUMNO_cod_matricula` INT NOT NULL,
  `CURSO_cod_curso` INT NOT NULL,
  `id-alumnocurso` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id-alumnocurso`, `ALUMNO_cod_matricula`, `CURSO_cod_curso`),
  INDEX `fk_ALUMNO_has_CURSO_CURSO1_idx` (`CURSO_cod_curso` ASC) VISIBLE,
  INDEX `fk_ALUMNO_has_CURSO_ALUMNO1_idx` (`ALUMNO_cod_matricula` ASC) VISIBLE,
  CONSTRAINT `fk_ALUMNO_has_CURSO_ALUMNO1`
    FOREIGN KEY (`ALUMNO_cod_matricula`)
    REFERENCES `COLEGIO`.`ALUMNO` (`cod_matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ALUMNO_has_CURSO_CURSO1`
    FOREIGN KEY (`CURSO_cod_curso`)
    REFERENCES `COLEGIO`.`CURSO` (`cod_curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- INTRODUCIMOS VALORES EN LAS TABLAS
  
INSERT INTO ALUMNO VALUES(1, 'alejandro sabio', 4208747,'20/07/1999' , 'alejandro@gmail.com',1);
INSERT INTO ALUMNO VALUES(2, 'alejandro bezus', 4208747,'20/07/1996' , 'alejandrosabio@gmail.com',2);
INSERT INTO ALUMNO VALUES(3, 'alejandro german', 4208747,'20/07/1995' , 'alejandrogerman@gmail.com',3);

INSERT INTO PROFESOR VALUES(1,'robertocarlos@gmail.com','contabilidad', 'Roberto Carlos');
INSERT INTO PROFESOR VALUES(2,'leomessi@gmail.com','futbol', 'Leo Messi');
INSERT INTO PROFESOR VALUES(3,'iniesta@gmail.com','penales', 'Andres Iniesta');

INSERT INTO PROFESOR VALUES(1,'robertocarlos@gmail.com','contabilidad', 'Roberto Carlos');
INSERT INTO PROFESOR VALUES(2,'leomessi@gmail.com','futbol', 'Leo Messi');
INSERT INTO PROFESOR VALUES(3,'iniesta@gmail.com','penales', 'Andres Iniesta');

INSERT INTO CURSO VALUES(1,'contabilidad');
INSERT INTO CURSO VALUES(2,'futbol');
INSERT INTO CURSO VALUES(3,'penales');


-- EJERCICIO 2