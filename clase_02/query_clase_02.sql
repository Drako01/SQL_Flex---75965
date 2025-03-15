USE coderhouse;
-- DDL Data Definition Language

CREATE DATABASE IF NOT EXISTS coderhouse;
CREATE TABLE coderhouse.alumnos (
	id_alumno INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    apellido VARCHAR(40) NOT NULL,
    email VARCHAR (100) UNIQUE DEFAULT NULL,
    dni INT UNIQUE NOT NULL,
    telefono VARCHAR (20) UNIQUE DEFAULT NULL,
    nacionalidad VARCHAR (30) DEFAULT "Argentina"
);

-- DROP TABLE coderhouse.alumnos;
ALTER TABLE coderhouse.alumnos ADD COLUMN fecha_inscripcion DATETIME DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE coderhouse.alumnos MODIFY COLUMN instituto VARCHAR(60) DEFAULT 'CoderHouse';


-- DML  Data Manipulatin Language

INSERT INTO alumnos(nombre, apellido, email, dni, telefono)
VALUES 
("Alejandro", "Di Stefano", "alejandro@mail.com", 22233355, "115555666");

INSERT INTO alumnos(nombre, apellido, email, dni, telefono)
VALUES 
("Juan", "Perez", "perez@mail.com", 113333666, "1166667777");
INSERT INTO alumnos(nombre, apellido, email, dni, telefono)
VALUES 
("Ivanna", "Muñoz", "ivana@mail.com", 33555888, "1166333777");


SELECT * FROM alumnos;

UPDATE coderhouse.alumnos SET instituto = 'CoderHouse', nacionalidad = 'Argentina';

SET SQL_SAFE_UPDATES = 0;
SET SQL_SAFE_UPDATES = 1;

DELETE FROM coderhouse.alumnos;
