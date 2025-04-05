-- Creacion de una vista basica
CREATE VIEW vista_alumnos AS 
SELECT nombre, apellido FROM alumnos;

-- Consultar una Vista
SELECT * FROM vista_alumnos;

-- Vistas Complejas (Usando JOIN)

CREATE VIEW view_inscripciones_alumnos AS
SELECT
	a.id_alumno,
    CONCAT(a.nombre, ' ', a.apellido) AS nombre_completo,
    a.email,
    c.id_curso,
    c.nombre_curso,
    i.inscription_at
FROM inscripciones i
JOIN alumnos a ON i.id_alumno = a.id_alumno
JOIN cursos c ON i.id_curso = c.id_curso;

SELECT * FROM view_inscripciones_alumnos;

CREATE VIEW view_alumno_completa AS
SELECT 
	nombre,
    apellido,
    email,
    instituto
FROM alumnos;

SELECT * FROM view_alumno_completa;

-- Eliminacion de una Vista

DROP VIEW view_alumno_completa;

-- Modificar o Actualizar una Vista con OR REPLACE

CREATE OR REPLACE VIEW view_alumno_completa AS
SELECT 
	a.nombre,
    a.apellido,
    a.email,
    a.instituto,
    c.nombre_curso,
    i.inscription_at
FROM inscripciones i
JOIN alumnos a ON i.id_alumno = a.id_alumno
JOIN cursos c ON i.id_curso = c.id_curso;

-- Ejecicios de Repaso

SELECT * FROM cursos;
-- Agregamos columna duracion
ALTER TABLE cursos ADD COLUMN duracion_curso INT DEFAULT 20;

UPDATE cursos SET duracion_curso = 60 WHERE id_curso = 3;
INSERT INTO cursos (nombre_curso, duracion_curso) VALUES
	("Data Analytics", 120),
    ("React", 60),
    ("Angular", 80),
    ("Python" ,120);

-- Mostrar todos los cursos que duren más de 20 horas.
SELECT 
	nombre_curso AS nombre, 
    duracion_curso AS duracion 
FROM cursos 
WHERE duracion_curso > 20;

-- Listar los alumnos cuyo apellido contenga la letra “z”.
SELECT * FROM alumnos;
SELECT * FROM alumnos WHERE UPPER(apellido) LIKE "%Z%";
SELECT * FROM alumnos WHERE LOWER(apellido) LIKE "%z%";
SELECT * FROM alumnos WHERE LOWER(apellido) LIKE "%ez%";
SELECT * FROM alumnos WHERE LOWER(email) LIKE "%gmail.com";
SELECT * FROM alumnos WHERE LOWER(email) LIKE "ma%";

-- Mostrar todos los cursos cuyo nombre empiece en “SQL”.
SELECT * FROM cursos;
INSERT INTO cursos (nombre_curso, duracion_curso) VALUES
	("SQL nivel Basico", 80),
    ("SQL nivel Intermedio", 60),
    ("SQL nivel Avanzado", 80),
    ("SQL Server" ,180);
    
SELECT * FROM cursos WHERE LOWER(nombre_curso) LIKE "SQL%";

-- Mostrar los primeros 3 cursos en orden alfabético.
SELECT * FROM cursos;
SELECT * FROM cursos
ORDER BY id_curso ASC
LIMIT 3;


-- Obtener el promedio de duración de los cursos por categoría.
CREATE TABLE categoria (
	id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre_categoria VARCHAR(100) NOT NULL
);
ALTER TABLE cursos ADD COLUMN id_categoria INT;
ALTER TABLE cursos
ADD CONSTRAINT fk_curso_categoria
FOREIGN KEY (id_categoria) REFERENCES categoria (id_categoria);

INSERT INTO categoria (nombre_categoria) VALUES
	("Base de Datos"),
    ("Programacion");
    
SELECT * FROM categoria;

SELECT 
	cat.nombre_categoria,
    ROUND(AVG(cur.duracion_curso)) AS promedio_duracion
 FROM cursos cur
 JOIN categoria cat ON cur.id_categoria = cat.id_categoria
 GROUP BY cat.nombre_categoria;
 
 -- Mostrar la categoría con más cursos asociados.
CREATE VIEW view_categoria_mas_cursos AS
SELECT
	cat.nombre_categoria,
    COUNT(cur.id_curso) AS cantidad_cursos
FROM categoria cat
LEFT JOIN cursos cur ON cur.id_categoria = cat.id_categoria
GROUP BY cat.id_categoria
ORDER BY cantidad_cursos DESC
LIMIT 1;

SELECT * FROM view_categoria_mas_cursos;

-- Crear un trigger que registre en un log cada vez que un alumno se inscribe.
CREATE TABLE log_inscripciones (
	id_log INT AUTO_INCREMENT PRIMARY KEY,
    id_alumno INT,
    id_curso INT,
    fecha_inscripcion DATETIME,
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //

CREATE TRIGGER tr_log_inscriptios
AFTER INSERT ON inscripciones
FOR EACH ROW
BEGIN
	INSERT INTO log_inscripciones (id_alumno, id_curso, fecha_inscripcion)
    VALUES (NEW.id_alumno, NEW.id_curso, NEW.inscription_at);
END //

DELIMITER ;
SELECT * FROM cursos;
SELECT * FROM inscripciones;
SELECT * FROM log_inscripciones;

INSERT INTO inscripciones (id_alumno, id_curso) VALUES
	(4,12),
    (4,7);
    
-- Listar los cursos junto con la cantidad de alumnos, ordenado de mayor a menor.
CREATE VIEW view_cantidad_alumnos_curso AS
SELECT
	c.nombre_curso,
    COUNT(i.id_alumno) AS cantidad_alumnos
FROM cursos c
LEFT JOIN inscripciones i ON c.id_curso = i.id_curso
GROUP BY c.id_curso, c.nombre_curso
ORDER BY cantidad_alumnos DESC;

SELECT * FROM view_cantidad_alumnos_curso;