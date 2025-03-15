USE coderhouse;

-- Sublenguages SQL
-- DDL Data Definition Language
-- DML  Data Manipulatin Language
-- DCL (Data Control Language) -- Controlar Permisos
-- TCL (Transaction Control Language) -- Controlar Transacciones

-- ------------------------------------------------------

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
ALTER TABLE coderhouse.alumnos ADD COLUMN instituto VARCHAR(60);
ALTER TABLE coderhouse.alumnos ADD COLUMN edad INT DEFAULT NULL;
ALTER TABLE coderhouse.alumnos MODIFY COLUMN instituto VARCHAR(60) DEFAULT 'CoderHouse';

-- DML  Data Manipulatin Language

-- INSERT INTO alumnos(nombre, apellido, email, dni, telefono)
-- VALUES 
-- ("Alejandro", "Di Stefano", "alejandro@mail.com", 22233355, "115555666");

-- INSERT INTO alumnos(nombre, apellido, email, dni, telefono)
-- VALUES 
-- ("Juan", "Perez", "perez@mail.com", 113333666, "1166667777");
-- INSERT INTO alumnos(nombre, apellido, email, dni, telefono)
-- VALUES 
-- ("Ivanna", "Muñoz", "ivana@mail.com", 33555888, "1166333777");

INSERT INTO alumnos(nombre, apellido, email, dni, telefono)
VALUES 
("Alejandro", "Di Stefano", "alejandro@mail.com", 22233355, "115555666"),
("Juan", "Perez", "perez@mail.com", 113333666, "1166667777"),
("Ivanna", "Muñoz", "ivana@mail.com", 33555888, "1166333777");
INSERT INTO alumnos(nombre, apellido, email, dni, telefono, edad)
VALUES 
("Marcela", "Muñoz", "ivana@mail.com", 33555888, "1166333777", 20);

INSERT INTO alumnos(nombre, apellido, email, dni, telefono, nacionalidad, edad)
VALUES 
("Marcela", "Perez", "marce@mail.com", 22686777, "12555666", 'Uruguaya', 20);

INSERT INTO alumnos(nombre, apellido, email, dni, telefono, nacionalidad, edad)
VALUES 
("Marcelo", "Perez", "marcelo@mail.com", 55666677, "1254654", 'Uruguaya', 29),
("Enzo", "Godoy", "enzo@mail.com", 55996677, "1253354", 'Brasilero', 22),
("Julian", "Alvarez", "julian@mail.com", 55688677, "1251124", 'Peruano', 33),
("Cristian", "Diaz", "cris@mail.com", 55222677, "1111654", 'Chileno', 21),
("Raul", "Leiva", "raul@mail.com", 55446677, "1251654", 'Chileno', 31),
("Wanda", "Nara", "wandaylgante@mail.com", 22444488, "4545454", 'Argentina', 31),
("Romina", "Baron", "romy@mail.com", 53333677, "1254154", 'Peruano', 27);

INSERT INTO alumnos(nombre, apellido, email, dni, telefono, nacionalidad, edad)
VALUES 
("China", "Suarez", "chinaicardi@mail.com", 22686677, "19955666", 'Argentina', 35);


SELECT * FROM alumnos;

UPDATE coderhouse.alumnos SET instituto = 'CoderHouse', nacionalidad = 'Argentina';

SET SQL_SAFE_UPDATES = 0;
SET SQL_SAFE_UPDATES = 1;

DELETE FROM coderhouse.alumnos;
UPDATE coderhouse.alumnos SET edad = 49 WHERE dni = '22233355';
UPDATE coderhouse.alumnos SET edad = 30 WHERE dni = '113333666';
UPDATE coderhouse.alumnos SET edad = 16 WHERE dni = '33555888';

SELECT nombre, apellido FROM alumnos WHERE edad >= 18;

DELETE FROM coderhouse.alumnos WHERE edad < 18; 

SELECT COUNT(*) AS alumnos_uruguayos FROM alumnos WHERE nacionalidad = 'Uruguaya';
SELECT COUNT(*) AS alumnos_argentinos FROM alumnos WHERE nacionalidad = 'Argentina';

SELECT SUM(edad) AS suma_total_de_edades_alumnos_argentinos FROM alumnos WHERE nacionalidad = 'Argentina';
SELECT AVG(edad) AS promedio_de_edades_alumnos_argentinos FROM alumnos WHERE nacionalidad = 'Argentina';

SELECT 
	COUNT(*) AS cantidad_alumnos,
	SUM(edad) AS suma_de_edades,
	AVG(edad) AS promedio_de_edades
FROM alumnos
WHERE nacionalidad = 'Argentina';

-- != (Desigual)


 SELECT id_alumno, nombre, apellido, dni, telefono, edad
 FROM alumnos 
 WHERE edad >= 18
 ORDER BY edad ASC;

 SELECT nombre, apellido, dni, telefono 
 FROM alumnos 
 WHERE edad >= 18
 ORDER BY apellido DESC;
 
 UPDATE coderhouse.alumnos SET edad = 26 WHERE id_alumno = 8;
 
SELECT 
MIN(edad) AS "Mas Joven", 
MAX(edad)  AS Mayor
FROM alumnos ;
 
 
SELECT nacionalidad, 
	MIN(edad) AS "Mas Joven", 
	MAX(edad)  AS "Mas Adulto"
	FROM alumnos 
GROUP BY nacionalidad;



SELECT nombre, apellido, dni, telefono 
FROM alumnos
ORDER BY apellido ASC
LIMIT 5;
