-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- DESARROLLADORES DATABASE

-- Dixiana Maria Gomez Medrano 
-- Rodrigo Vidal Canales 

-- Schema ProyectoZoologico
-- -----------------------------------------------------
-- BD  ProyectoZoologico
-- las tablas son las siguentes 
-- Usuarios 
-- Visitas 
-- Itinerarios
-- Habitats 
-- Especies 
-- Animales 

-- -----------------------------------------------------
-- Schema ProyectoZoologico
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ProyectoZoologico` DEFAULT CHARACTER SET utf8 ;
USE `ProyectoZoologico` ;

-- -----------------------------------------------------
-- Table `ProyectoZoologico`.`Usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ProyectoZoologico`.`Usuarios` (
  `Cedula` INT NOT NULL,
  `Nombre` VARCHAR(50) NOT NULL,
  `Puesto` VARCHAR(45) NOT NULL,
  `Telefono` TEXT NOT NULL,
  `Estado` VARCHAR(15) NOT NULL DEFAULT 'Activo',
  PRIMARY KEY (`Cedula`),
  CONSTRAINT `chk_EstadoCliente` CHECK (`estado` = 'Activo' OR `estado` = 'Inactivo'),
  CONSTRAINT `chk_puestoUsua` CHECK (`puesto` = 'Administrador'
									OR `puesto` = 'Suplente'))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ProyectoZoologico`.`Habitats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ProyectoZoologico`.`Habitats` (
  `NumHabitat` INT NOT NULL AUTO_INCREMENT,
  `NomHabitat` VARCHAR(50) NOT NULL,
  `Clima` VARCHAR(50) NOT NULL,
  `Vegetacion` VARCHAR(50) NOT NULL,
  `EstadoHabitat` VARCHAR(15) NOT NULL DEFAULT 'Activo',
  PRIMARY KEY (`NumHabitat`),
  CONSTRAINT `chk_EstadoHabitat` CHECK (`EstadoHabitat` = 'Activo' OR `EstadoHabitat` = 'Inactivo'),
  UNIQUE INDEX `NomHabitat_UNIQUE` (`NomHabitat` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 001;


-- -----------------------------------------------------
-- Table `ProyectoZoologico`.`Especies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ProyectoZoologico`.`Especies` (
  `idEspecies` INT NOT NULL AUTO_INCREMENT,
  `NumHabitat` INT NOT NULL,
  `nomEspecie` VARCHAR(50) NOT NULL,
  `indiceVulnerabilidad` DOUBLE(5,2) NOT NULL,
  PRIMARY KEY (`idEspecies`),
  INDEX `FK_Habitats_idx` (`NumHabitat` ASC),
  CONSTRAINT `FK_Habitats`
    FOREIGN KEY (`NumHabitat`)
    REFERENCES `ProyectoZoologico`.`Habitats` (`NumHabitat`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Table `ProyectoZoologico`.`Animales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ProyectoZoologico`.`Animales` (
  `idAnimales` INT NOT NULL AUTO_INCREMENT,
  `idEspecie` INT NOT NULL,
  `NomComun` text  NOT NULL,
  `NomCientifico` TEXT NOT NULL,
  `Descripcion` TEXT NOT NULL,
  `Imagen` MEDIUMBLOB NULL,
  PRIMARY KEY (`idAnimales`),
  INDEX `FK_Especies_idx` (`idEspecie` ASC),
  CONSTRAINT `FK_Especies`
    FOREIGN KEY (`idEspecie`)
    REFERENCES `ProyectoZoologico`.`Especies` (`idEspecies`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
AUTO_INCREMENT = 01;


-- -----------------------------------------------------
-- Table `ProyectoZoologico`.`Itinerarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ProyectoZoologico`.`Itinerarios` (
  `Codigo` INT NOT NULL AUTO_INCREMENT,
  `NumHabitat` INT NOT NULL,
  `Duracion` text NOT NULL,
  `Longitud` DOUBLE(5,2) NOT NULL,
  `NumMaximo` INT NOT NULL,
  PRIMARY KEY (`Codigo`),
  INDEX `FK_Habitats_idx` (`NumHabitat` ASC),
  CONSTRAINT `FK_Habitats-totales`
    FOREIGN KEY (`NumHabitat`)
    REFERENCES `ProyectoZoologico`.`Habitats` (`NumHabitat`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
AUTO_INCREMENT = 00100;


-- -----------------------------------------------------
-- Table `ProyectoZoologico`.`Visitas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ProyectoZoologico`.`Visitas` (
  `NumVisita` INT NOT NULL AUTO_INCREMENT,
  `CedulaUsuario` INT NOT NULL,
  `CodigoItinerario` INT NOT NULL,
  `CantidadVisitas` INT NOT NULL,
  `Fecha` DATETIME NOT NULL,
  PRIMARY KEY (`NumVisita`),
  INDEX `FK_CodigoItinerario_idx` (`CodigoItinerario` ASC) ,
  INDEX `FK_CedulaUsuario_idx` (`CedulaUsuario` ASC) ,
  CONSTRAINT `FK_CodigoItinerario`
    FOREIGN KEY (`CodigoItinerario`)
    REFERENCES `ProyectoZoologico`.`Itinerarios` (`Codigo`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `FK_CedulaUsuario`
    FOREIGN KEY (`CedulaUsuario`)
    REFERENCES `ProyectoZoologico`.`Usuarios` (`Cedula`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
AUTO_INCREMENT = 1;


-- ------------------------------------------------------------ insert por default ------------------------------------------
-- insert users 
insert into usuarios values( 123,'admin','Administrador','85469535','Activo' );

-- insert habitats 
insert into habitats values(1,'ZONA NORTE','llvioso','Bosque de coníferas','Activo');

-- insert itinerario 
insert into Itinerarios values( 100,1,'15:00',20 ,15);
-- insert especie
insert into especies values ( 1,1,'mamiferos',55);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
