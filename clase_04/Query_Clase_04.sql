USE coderhouse;


CREATE INDEX idx_apellido ON alumnos(apellido);

-- VISTAS
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

-- Stored Procedures
DELIMITER //

CREATE PROCEDURE ObtenerInscripcionesPorDia()
BEGIN
	SELECT DATE(inscription_at) AS fecha, 
    COUNT(*) AS cantidad_inscripciones
    FROM inscripciones
    GROUP BY fecha
    ORDER BY fecha;
END //

DELIMITER ;


CALL ObtenerInscripcionesPorDia();

-- Triggers
CREATE TABLE cursos_inscripciones_count (
	id_curso INT PRIMARY KEY,
    cantidad_inscripciones INT DEFAULT 0,
    FOREIGN KEY (id_curso) REFERENCES cursos(id_curso)
);

DELIMITER //

CREATE TRIGGER after_inscription_insert
AFTER INSERT ON inscripciones
FOR EACH ROW
BEGIN
	DECLARE curso_count INT;
    SELECT cantidad_inscripciones INTO curso_count
    FROM cursos_inscripciones_count
    WHERE id_curso = NEW.id_curso;
    
    -- Validamos si existen los valores
    IF curso_count IS NULL THEN
		INSERT INTO cursos_inscripciones_count (id_curso, cantidad_inscripciones)
		VALUES (NEW.id_curso, 1);
    ELSE
		UPDATE cursos_inscripciones_count 
        SET cantidad_inscripciones = cantidad_inscripciones + 1
        WHERE id_curso = NEW.id_curso;
	END IF;
END //

DELIMITER ;

INSERT INTO inscripciones (id_alumno, id_curso) VALUES
	(22,2), (22,3);
    
-- Funciones
DELIMITER //

CREATE FUNCTION CantidadDeInscriptosCurso(idCurso INT) RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE cantidad INT;
    
    SELECT COUNT(*) INTO cantidad
    FROM inscripciones
    WHERE id_curso = idCurso;
    
    RETURN cantidad;    
END //

DELIMITER ;
