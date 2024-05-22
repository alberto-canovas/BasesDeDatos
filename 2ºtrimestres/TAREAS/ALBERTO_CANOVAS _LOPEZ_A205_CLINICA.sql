--ALBERTO CANOVAS LOPEZ A205_CLINICA MARIADB

USE A205_CLINICA;
DROP TABLE IF EXISTS INGRESO;
DROP TABLE IF EXISTS MEDICO;
CREATE TABLE MEDICO(
    codigo int PRIMARY KEY,
    nombre varchar(255),
    apellidos varchar(255),
    especialidad varchar(255),
    telefono varchar(20)
    );
    
DROP TABLE IF EXISTS PACIENTE;
CREATE TABLE PACIENTE(
    codigo int PRIMARY KEY,
    nombre varchar(255),
    apellidos varchar(255),
    fechanac date,
    telefono varchar(20),
    direccion varchar(255),
    poblacion varchar(255),
    provincia varchar(255),
    codPostal varchar(255));
 
    
-- DROP TABLE IF EXISTS INGRESO;
CREATE TABLE INGRESO(
    codigo int PRIMARY KEY,
    habitacion varchar(255),
    cama varchar(255),
    fecha date,
    codPaciente int,
    codMedico int,
	FOREIGN KEY (codMedico) REFERENCES MEDICO(codigo),
    FOREIGN KEY (codPaciente) REFERENCES PACIENTE (codigo));
    