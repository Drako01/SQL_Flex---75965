-- Transacciones

-- Podemos hacer esto

INSERT INTO inscripciones (id_alumno, id_curso) VALUES (4,1);

DELIMITER //

CREATE PROCEDURE inscribir_alumnos_seguro(IN p_id_alumno INT, IN p_id_curso INT)
BEGIN 
	DECLARE existe_alumno INT DEFAULT 0;
    DECLARE existe_curso INT DEFAULT 0;
    DECLARE existe_inscripcion INT DEFAULT 0;
    
    -- Validar si existe el Alumno
    SELECT COUNT(*) INTO existe_alumno
    FROM alumnos
    WHERE id_alumno = p_id_alumno;
    
     -- Validar si existe el Curso
    SELECT COUNT(*) INTO existe_curso
    FROM cursos
    WHERE id_curso = p_id_curso;
    
    -- Si no existe el Alumno o el Curso, mostramos un mensaje de Error
    IF existe_alumno = 0 THEN
		SELECT '❌ El Alumno no existe.' AS message;
	ELSEIF existe_curso = 0 THEN 
		SELECT '❌ El Curso no existe.' AS message;
	ELSE 
		SELECT COUNT(*) INTO existe_inscripcion
        FROM inscripciones
        WHERE id_alumno = p_id_alumno AND id_curso = p_id_curso;
        
        IF existe_inscripcion > 0 THEN
			SELECT '⚠️ El Alumno ya esta Inscripto en este Curso.' AS message;
		ELSE 
			INSERT INTO inscripciones (id_alumno, id_curso)
            VALUES (p_id_alumno, p_id_curso);
            SELECT '✅ El Alumno esta Inscripto al Curso Correctamente.' AS message;
		END IF;
	END IF;    
END; 
//

DELIMITER ;
/*
START TRANSACTION;

CALL inscribir_alumnos_seguro(4,3);
CALL inscribir_alumnos_seguro(5,3);
CALL inscribir_alumnos_seguro(7,3);
CALL inscribir_alumnos_seguro(8,3);
CALL inscribir_alumnos_seguro(26,2);
CALL inscribir_alumnos_seguro(28,1);
CALL inscribir_alumnos_seguro(1,1);

COMMIT;
*/

SHOW CREATE TABLE inscripciones;

START TRANSACTION;
INSERT INTO inscripciones (id_alumno, id_curso) VALUES (4,1);
SAVEPOINT paso_1;

INSERT INTO inscripciones (id_alumno, id_curso) VALUES (20, 1);      
SAVEPOINT paso_2;  

INSERT INTO inscripciones (id_alumno, id_curso) VALUES (21,1);
SAVEPOINT paso_3;

INSERT INTO inscripciones (id_alumno, id_curso) VALUES (23,1);
SAVEPOINT paso_4;
      
INSERT INTO inscripciones (id_alumno, id_curso) VALUES (23,99);
ROLLBACK TO paso_4;

COMMIT;

-- BackUp (Copia de Seguridad)


/*
Comandos por consola

mysqldump -u usuario -p nombre_base_de_datos > respaldo.sql

Para Exportar
mysqldump -u root -p coderhouse2 > respaldo_coderhouse2.sql

Para Importar
mysql -u root -p coderhouse3 < backup.dump.sql

*/

/*
Crear archivo .bat para Automatizar Tarea

Que se llame backup.bat


@echo off
set fecha=%date:~10
mysqldump -u root -p coderhouse2 > "C:\backup\respaldo_coderhouse2.sql"

*/
