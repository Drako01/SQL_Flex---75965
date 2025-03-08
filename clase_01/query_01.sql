CREATE DATABASE IF NOT EXISTS coderhouse;
USE coderhouse;

CREATE TABLE alumnos (
	id_alumno INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    apellido VARCHAR(40) NOT NULL,
    email VARCHAR (100) UNIQUE DEFAULT NULL,
    dni INT UNIQUE NOT NULL,
    telefono VARCHAR (20) UNIQUE DEFAULT NULL,
    nacionalidad VARCHAR (30) DEFAULT "Argentina"
);

DROP TABLE alumnos;

INSERT INTO alumnos(nombre, apellido, email, dni, telefono)
VALUES 
("Alejandro", "Di Stefano", "alejandro@mail.com", 22233355, "115555666");

SELECT * FROM alumnos;