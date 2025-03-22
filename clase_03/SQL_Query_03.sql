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

CREATE TABLE cursos (
	id_curso INT PRIMARY KEY AUTO_INCREMENT,
    nombre_curso VARCHAR(50) NOT NULL
);

CREATE TABLE inscripciones (
	id_alumno INT,
    id_curso INT,
    inscription_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_alumno, id_curso),
    FOREIGN KEY (id_alumno) REFERENCES alumnos(id_alumno),
    FOREIGN KEY (id_curso) REFERENCES cursos(id_curso)
);


INSERT INTO cursos (nombre_curso) VALUES 
	("SQL"),
    ("JavaScript"),
	("Java"),
	("HTML");

INSERT INTO inscripciones (id_alumno, id_curso) VALUES
	(4,1),
    (4,3),
    (8,1),
    (8,2),
    (22,1),
	(21,1),
	(21,4),
	(19,1);


-- UNION de Tablas

-- INNER JOIN
SELECT a.nombre, a.apellido, a.dni, c.nombre_curso
	FROM alumnos a
    INNER JOIN inscripciones i ON a.id_alumno = i.id_alumno
    INNER JOIN cursos c ON i.id_curso = c.id_curso;

-- LEFT JOIN
SELECT a.nombre, a.apellido, a.dni, c.nombre_curso
	FROM alumnos a
    LEFT JOIN inscripciones i ON a.id_alumno = i.id_alumno
    LEFT JOIN cursos c ON i.id_curso = c.id_curso;
    
-- RIGHT JOIN
SELECT a.nombre, a.apellido, a.dni, c.nombre_curso
	FROM alumnos a
    RIGHT JOIN inscripciones i ON a.id_alumno = i.id_alumno
    RIGHT JOIN cursos c ON i.id_curso = c.id_curso;
    
-- UNION
-- LEFT JOIN
SELECT a.nombre, a.apellido, a.dni, c.nombre_curso
	FROM alumnos a
    LEFT JOIN inscripciones i ON a.id_alumno = i.id_alumno
    LEFT JOIN cursos c ON i.id_curso = c.id_curso
    
    UNION
    
SELECT a.nombre, a.apellido, a.dni, c.nombre_curso
	FROM alumnos a
    RIGHT JOIN inscripciones i ON a.id_alumno = i.id_alumno
    RIGHT JOIN cursos c ON i.id_curso = c.id_curso;
    
-- SELF JOIN
 -- SELECT a1.nombre AS alumno, a2.nombre AS tutor
 -- 	FROM alumnos a1
 --    JOIN alumnos a2 ON a1.tutor_id = a2.id_alumno;


-- Uso de LIKE y Comodines + REGEX
INSERT INTO alumnos(nombre, apellido, email, dni, telefono, nacionalidad, edad)
VALUES 
("Adrian", "Perez", "Adrian@mail.com", 55669997, "12154654", 'Uruguaya', 29),
("Andres", "Perez", "Andres@mail.com", 57866677, "12541654", 'Uruguaya', 29);

INSERT INTO alumnos(nombre, apellido, email, dni, telefono, nacionalidad, edad)
VALUES 
("Adrian", "Perez", "Adrian@gmail.com", 556699947, "121454654", 'Uruguaya', 29),
("Andres", "Perez", "Andres@gmail.com", 574866677, "125414654", 'Uruguaya', 29);


 SELECT nombre, apellido, dni, telefono, edad
 FROM alumnos 
 WHERE nombre LIKE "A%"
 ORDER BY nombre ASC;

 SELECT nombre, apellido, dni, telefono, edad , email
 FROM alumnos 
 WHERE email LIKE "%gmail.com"
 ORDER BY nombre ASC;

SELECT nombre, apellido, dni, telefono, edad , email FROM alumnos WHERE email REGEXP '^[a-z]+@[a-z]+\\.(com|net)$';


-- Subconsultas de SQL

SELECT nombre, edad
	FROM alumnos
    WHERE edad = (SELECT MAX(edad) FROM alumnos);
    
SELECT nombre, edad
	FROM alumnos
    WHERE edad = (SELECT MIN(edad) FROM alumnos);

SELECT nombre, edad, nacionalidad
	FROM alumnos
    WHERE (nacionalidad, edad) IN (
    SELECT nacionalidad, MIN(edad)
    FROM alumnos
    GROUP BY nacionalidad
    );

-- Funciones de Texto
SELECT UPPER(email) AS email_mayuscula, nombre, LOWER(apellido) AS Apellido, edad
	FROM alumnos
    WHERE edad > (SELECT AVG(edad) FROM alumnos);


SELECT a.nombre, a.apellido, i.inscription_at AS fecha_inscripcion
	FROM alumnos a
    INNER JOIN inscripciones i ON a.id_alumno = i.id_alumno
    WHERE i.inscription_at < DATE_SUB(NOW(), INTERVAL 1 YEAR);
    
-- DDL
TRUNCATE inscripciones;

-- No es recomendable porque puede ser Destructivo
RENAME TABLE alumnos TO estudiantes;
RENAME TABLE estudiantes TO alumnos;
