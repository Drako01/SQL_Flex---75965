SELECT * FROM coderhouse2.alumnos;

CREATE TABLE cursos(
	id_curso INT AUTO_INCREMENT PRIMARY KEY,
    nombre_curso VARCHAR(100),
    descripcion TEXT
);

CREATE TABLE inscripciones(
	id_inscripcion INT AUTO_INCREMENT PRIMARY KEY,
	id_alumno INT,
    id_curso INT,
    fecha_inscripcion DATE,
	FOREIGN KEY (id_alumno) REFERENCES alumnos(id_alumno),
    FOREIGN KEY (id_curso) REFERENCES cursos(id_curso)
);

CREATE TABLE auditoria_inscripciones(
	id_auditoria INT AUTO_INCREMENT PRIMARY KEY,
    id_inscripcion INT,
    accion VARCHAR(10),
    fecha_accion DATETIME
);

-- Creamos el Trigger para cada vez que se realice una inscripcion
DELIMITER //

CREATE TRIGGER after_insert_inscription
AFTER INSERT ON inscripciones
FOR EACH ROW
BEGIN
	INSERT INTO auditoria_inscripciones(id_inscripcion, accion, fecha_accion)
    VALUES (NEW.id_inscripcion, 'INSERT', NOW());
END //

DELIMITER ;

-- Creamos el Trigger para cada vez que se elimine una inscripcion
DELIMITER //

CREATE TRIGGER before_delete_inscription
BEFORE DELETE ON inscripciones
FOR EACH ROW
BEGIN
	INSERT INTO auditoria_inscripciones(id_inscripcion, accion, fecha_accion)
    VALUES (OLD.id_inscripcion, 'DELETE', NOW());
END //

DELIMITER ;

-- Creamos un Trigger para evitar que se modifique la fecha de inscripcion despues de ser registrada
DELIMITER //

CREATE TRIGGER before_update_inscription
BEFORE UPDATE ON inscripciones
FOR EACH ROW
BEGIN
	IF	NEW.fecha_inscripcion <> OLD.fecha_inscripcion THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se permite modificar la fecha de Inscripcion';
    END IF;
END //

DELIMITER ;


-- Vamos a probarlo

-- Creamos cursos
INSERT INTO cursos(nombre_curso, descripcion)
VALUES ('Base de Datos SQL', 'Curso de fundamentos de base de datos relacionales, usando MySQL y Workbench');

SELECT * FROM cursos;


-- Insertar una Inscripcion
INSERT INTO inscripciones (id_alumno, id_curso, fecha_inscripcion)
VALUES (18, 1, CURDATE());

INSERT INTO inscripciones (id_alumno, id_curso, fecha_inscripcion)
VALUES (19, 1, CURDATE());

SELECT * FROM inscripciones;

-- Verifico el Trigger de cada vez que se realice una inscripcion 
SELECT * FROM auditoria_inscripciones WHERE accion = 'INSERT';


-- Eliminar una Inscripcion
DELETE FROM inscripciones WHERE id_inscripcion = 1;

-- Verifico el Trigger de cada vez que se elimine una inscripcion
SELECT * FROM auditoria_inscripciones WHERE accion = 'DELETE';

INSERT INTO inscripciones (id_alumno, id_curso, fecha_inscripcion)
VALUES (20, 1, CURDATE());

-- Intentaremos actualizar la fecha de inscripcion
UPDATE inscripciones
SET fecha_inscripcion = DATE_ADD(CURDATE(), INTERVAL 1 DAY)
WHERE id_inscripcion = 3;



SELECT * FROM auditoria_inscripciones ORDER BY fecha_accion DESC;


--- Sublenguaje DCL (Data Control Language)
/*
	Las sentencia principales son:
    - GRANT : Para otorgar Privilegios
    - REVOKE : Para revocar privilegios
    - CREATE USER : Para crear usuarios
    - DROP USER : Para eliminar usuarios
*/

-- Creacion de Usuarios
/*
	CREATE USER 'nombre_usuario'@'localhost' IDENTIFIED BY 'password';
*/
CREATE USER 'profesor1'@'localhost' IDENTIFIED BY 'password123';

-- Permitir al profesor1 ver e insertar datos en la tabla inscripciones
GRANT SELECT, INSERT ON coderhouse2.inscripciones TO 'profesor1'@'localhost';

-- Permitir a profesor1 que pueda crear Triggers
GRANT TRIGGER ON coderhouse2.* TO 'profesor1'@'localhost';

-- Revocar permisos al profesor1, solo que no pueda insertar mas datos
REVOKE INSERT ON coderhouse2.inscripciones FROM 'profesor1'@'localhost';

-- Ver los permisos del Usuario
SHOW GRANTS FOR 'profesor1'@'localhost';

-- Eliminar a un Usuario
DROP USER 'profesor1'@'localhost';

-- --------------------------------------------------------------------------------------------


-- Ejercicio practico

CREATE USER 'profesor'@'localhost' IDENTIFIED BY 'password123';
-- Ver los permisos del Usuario
SHOW GRANTS FOR 'profesor'@'localhost';

-- Darle permisos para operar en toda la base de datos coderhouse2
GRANT ALL PRIVILEGES ON coderhouse2.* TO 'profesor'@'localhost';

-- Ejercicios
/*
Ejercicio 1
Cree una tabla llamada log_alumnos para registrar inserciones en la tabla alumnos.

Campos: id_log, id_alumno, accion, fecha_accion
Cree un trigger AFTER INSERT que registre en log_alumnos cada vez que se inserta un nuevo alumno.
*/

CREATE TABLE logs_alumnos (
	id_log INT AUTO_INCREMENT PRIMARY KEY,
    id_alumno INT,
    accion VARCHAR(20),
    fecha_accion DATETIME
);

-- Armamos el Trigger

DELIMITER //

CREATE TRIGGER after_insert_alumnos
AFTER INSERT ON alumnos
FOR EACH ROW
BEGIN
	INSERT INTO logs_alumnos(id_alumno, accion, fecha_accion)
    VALUES (NEW.id_alumno, 'INSERT' , NOW());
END //

DELIMITER ;

-- Probamos insertando un Alumno nuevo
INSERT INTO alumnos (nombre, apellido, email, dni, telefono, nacionalidad,fecha_inscripcion,instituto, edad)
VALUES ('Raul', 'Leiva', 'raul2@mail.com', 22111222, '1166665555', 'Argentino', NOW(), 'CoderHouse', 45);

/*
Ejercicio 2
	Cree un trigger BEFORE DELETE sobre la tabla inscripciones que impida eliminar registros 
	si la fecha de inscripción es anterior al día actual.
*/
DELIMITER //

CREATE TRIGGER before_delete_inscription_alert_date
BEFORE DELETE ON inscripciones
FOR EACH ROW
BEGIN
	IF OLD.fecha_inscripcion < CURDATE() THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se puede eliminar una inscripcion anterior al dia de hoy';    
    END IF;
END //

DELIMITER ;

