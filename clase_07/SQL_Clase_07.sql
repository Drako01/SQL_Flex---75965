CREATE DATABASE IF NOT EXISTS coderhouse3;
USE  coderhouse2;

CREATE TABLE alumnos (
	id_alumno INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    apellido VARCHAR(40) NOT NULL,
    email VARCHAR (100) UNIQUE DEFAULT NULL,
    dni INT UNIQUE NOT NULL,
    telefono VARCHAR (20) UNIQUE DEFAULT NULL,
    nacionalidad VARCHAR (30) DEFAULT "Argentina",
    fecha_inscripcion TIMESTAMP,
    instituto VARCHAR (100) DEFAULT NULL,
    edad INT NOT NULL
)DEFAULT CHARSET=utf8mb4;

SET GLOBAL local_infile = 1;
SHOW GLOBAL VARIABLES LIKE "local_infile";
SHOW VARIABLES LIKE 'secure_file_priv';


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/alumnos.csv'
INTO TABLE alumnos
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;








