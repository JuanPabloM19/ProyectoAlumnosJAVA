-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema bdalumnos
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `bdalumnos` ;

-- -----------------------------------------------------
-- Schema bdalumnos
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bdalumnos` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `bdalumnos` ;

-- -----------------------------------------------------
-- Table `bdalumnos`.`facultad`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bdalumnos`.`facultad` ;

CREATE TABLE IF NOT EXISTS `bdalumnos`.`facultad` (
  `idfacultad` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idfacultad`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `bdalumnos`.`carrera`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bdalumnos`.`carrera` ;

CREATE TABLE IF NOT EXISTS `bdalumnos`.`carrera` (
  `idcarrera` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `facultad_idfacultad` INT NOT NULL, 
  PRIMARY KEY (`idcarrera`),
  INDEX `fk_carrera_facultad_idx` (`facultad_idfacultad` ASC) VISIBLE,
  CONSTRAINT `fk_carrera_facultad`
    FOREIGN KEY (`facultad_idfacultad`)
    REFERENCES `bdalumnos`.`facultad` (`idfacultad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `bdalumnos`.`alumno`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bdalumnos`.`alumno` ;

CREATE TABLE IF NOT EXISTS `bdalumnos`.`alumno` (
  `idalumno` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `registro` INT NULL DEFAULT NULL,
  `carrera_idcarrera` INT NOT NULL,
  PRIMARY KEY (`idalumno`),
  INDEX `fk_alumno_carrera1_idx` (`carrera_idcarrera` ASC) VISIBLE,
  CONSTRAINT `fk_alumno_carrera1`
    FOREIGN KEY (`carrera_idcarrera`)
    REFERENCES `bdalumnos`.`carrera` (`idcarrera`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `bdalumnos`.`materia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bdalumnos`.`materia`;

CREATE TABLE IF NOT EXISTS `bdalumnos`.`materia` (
  `idmateria` INT NOT NULL AUTO_INCREMENT,  -- Agregar AUTO_INCREMENT aquí
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idmateria`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `bdalumnos`.`materia_has_alumno`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bdalumnos`.`materia_has_alumno` ;

CREATE TABLE IF NOT EXISTS `bdalumnos`.`materia_has_alumno` (
  `materia_idmateria` INT NOT NULL,
  `alumno_idalumno` INT NOT NULL,
  `nota` INT NULL,
  `fecha` TIMESTAMP NOT NULL,
  PRIMARY KEY (`materia_idmateria`, `alumno_idalumno`, `fecha`),
  INDEX `fk_materia_has_alumno_alumno1_idx` (`alumno_idalumno` ASC) VISIBLE,
  INDEX `fk_materia_has_alumno_materia1_idx` (`materia_idmateria` ASC) VISIBLE,
  CONSTRAINT `fk_materia_has_alumno_materia1`
    FOREIGN KEY (`materia_idmateria`)
    REFERENCES `bdalumnos`.`materia` (`idmateria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_materia_has_alumno_alumno1`
    FOREIGN KEY (`alumno_idalumno`)
    REFERENCES `bdalumnos`.`alumno` (`idalumno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- Crear tabla usuario
CREATE TABLE IF NOT EXISTS `bdalumnos`.`usuario` (
  `idusuario` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `clave` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idusuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- Crear tabla docente
CREATE TABLE IF NOT EXISTS `bdalumnos`.`docente` (
  `iddocente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `usuario_idusuario` INT NOT NULL,
  PRIMARY KEY (`iddocente`),
  INDEX `fk_docente_usuario_idx` (`usuario_idusuario` ASC),
  CONSTRAINT `fk_docente_usuario`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `bdalumnos`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- Crear tabla intermedia materia_has_docente
CREATE TABLE IF NOT EXISTS `bdalumnos`.`materia_has_docente` (
  `materia_idmateria` INT NOT NULL,
  `docente_iddocente` INT NOT NULL,
  PRIMARY KEY (`materia_idmateria`, `docente_iddocente`),
  INDEX `fk_materia_has_docente_materia_idx` (`materia_idmateria` ASC),
  INDEX `fk_materia_has_docente_docente_idx` (`docente_iddocente` ASC),
  CONSTRAINT `fk_materia_has_docente_materia`
    FOREIGN KEY (`materia_idmateria`)
    REFERENCES `bdalumnos`.`materia` (`idmateria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_materia_has_docente_docente`
    FOREIGN KEY (`docente_iddocente`)
    REFERENCES `bdalumnos`.`docente` (`iddocente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- Insertar datos en la tabla facultad
INSERT INTO bdalumnos.facultad (nombre) VALUES
('Facultad de Ingenieria'),
('Facultad de Ciencias Sociales'),
('Facultad de Medicina');

-- Insertar datos en la tabla carrera
INSERT INTO bdalumnos.carrera (nombre, facultad_idfacultad) VALUES
('Ingenieria de Sistemas', 1),
('Ingenieria Civil', 1),
('Psicologia', 2),
('Medicina', 3);

-- Insertar datos en la tabla alumno
INSERT INTO bdalumnos.alumno (nombre, registro, carrera_idcarrera) VALUES
('Juan Perez', 12345, 1),
('Ana Gomez', 12346, 2),
('Carlos Lopez', 12347, 3),
('Lucia Torres', 12348, 4);

-- Insertar datos en la tabla materia
INSERT INTO bdalumnos.materia (idmateria, nombre) VALUES
(1, 'Matematicas I'),
(2, 'Fisica I'),
(3, 'Psicologia General'),
(4, 'Anatomia I');

-- Insertar datos en la tabla materia_has_alumno
INSERT INTO bdalumnos.materia_has_alumno (materia_idmateria, alumno_idalumno, nota, fecha) VALUES
(1, 1, 85, '2024-10-09 08:00:00'),
(2, 2, 78, '2024-10-09 08:00:00'),
(3, 3, 92, '2024-10-09 08:00:00'),
(4, 4, 88, '2024-10-09 08:00:00');

SELECT c.idcarrera, c.nombre, f.nombre AS facultad 
FROM carrera c 
JOIN facultad f ON c.facultad_idfacultad = f.idfacultad;

SELECT idmateria, nombre AS materia
FROM materia;

SELECT * FROM materia;

SELECT a.idalumno, a.nombre AS alumno, m.nombre AS materia, ma.nota, ma.fecha 
FROM alumno a 
JOIN materia_has_alumno ma ON a.idalumno = ma.alumno_idalumno 
JOIN materia m ON ma.materia_idmateria = m.idmateria;

SELECT * FROM alumno; 
SELECT * FROM materia; 
SELECT * FROM carrera; 
SELECT * FROM facultad; 

SELECT * FROM alumno WHERE registro = 12345;

-- Insertar algunos datos en usuario
INSERT INTO bdalumnos.usuario (nombre, clave) VALUES
('usuario1', 'clave1'),
('usuario2', 'clave2');

-- Insertar algunos datos en docente
INSERT INTO bdalumnos.docente (nombre, usuario_idusuario) VALUES
('Docente Juan', 1),
('Docente Maria', 2);

-- Insertar algunos datos en la tabla intermedia materia_has_docente
INSERT INTO bdalumnos.materia_has_docente (materia_idmateria, docente_iddocente) VALUES
(1, 1), -- Matemáticas I dictada por Docente Juan
(2, 1), -- Física I dictada por Docente Juan
(3, 2); -- Psicología General dictada por Docente María

SELECT * FROM materia_has_docente;
SELECT * FROM materia_has_alumno;

SELECT m.nombre AS materia, a.nombre AS alumno
FROM materia m
JOIN materia_has_docente md ON m.idmateria = md.materia_idmateria
JOIN docente d ON md.docente_iddocente = d.iddocente
JOIN materia_has_alumno ma ON m.idmateria = ma.materia_idmateria
JOIN alumno a ON ma.alumno_idalumno = a.idalumno
WHERE d.iddocente = 1;
