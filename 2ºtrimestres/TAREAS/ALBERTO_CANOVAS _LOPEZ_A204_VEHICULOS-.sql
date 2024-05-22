USE master
GO
DROP DATABASE IF EXISTS A204_VEHICULOS;
GO
CREATE DATABASE A204_VEHICULOS;
GO
USE A204_VEHICULOS;
GO

DROP TABLE IF EXISTS CLIENTE;
CREATE TABLE CLIENTE (
    codigo int PRIMARY KEY,
    nif varchar(10) ,
    nombre varchar(255),
    direccion varchar(255),
    ciudad varchar(255),
    telefono varchar(20)
    );
GO
DROP TABLE IF EXISTS COCHE;
CREATE TABLE COCHE(
    bastidor varchar(100)PRIMARY KEY,
    matricula varchar(15),
    marca varchar(255),
    modelo varchar(255),
    color varchar(255),
    precio decimal (10,2) ,
    codPropietario int, 
	FOREIGN KEY (codPropietario) REFERENCES CLIENTE(codigo));
GO
DROP TABLE IF EXISTS REVISION;
CREATE TABLE REVISION(

    codigo int PRIMARY KEY,
    filtro bit DEFAULT 1,
    aceite bit DEFAULT 1, 
    frenos bit DEFAULT 0,
    bastidor varchar(100),
    FOREIGN KEY (bastidor)REFERENCES COCHE (bastidor),
    fecha date);
