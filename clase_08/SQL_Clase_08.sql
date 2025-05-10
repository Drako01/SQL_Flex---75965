
-- Sintaxis basica de una Funcion

/*
CREATE FUNCTION nombre_funcion (parametro1 tipo_de_dato, parametro2 tipo_de_dato)
RETURNS tipo_de_dato
DETERMINISTIC
BEGIN
	-- lógica
    RETURN resultado;
END;
*/
/*
CREATE TABLE notas(
	id INT AUTO_INCREMENT PRIMARY KEY,
    alumno_id INT,
    parcial1 DECIMAL(5,2),
    parcial2 DECIMAL(5,2),
    final DECIMAL(5,2)
);
*/
DELIMITER //

CREATE FUNCTION calcular_promedio(
	p1 DECIMAL(5,2),
    p2 DECIMAL(5,2),
    p3 DECIMAL(5,2)
)
RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
	DECLARE promedio DECIMAL(5,2);
    SET promedio = (p1 + p2 + p3) / 3;
    RETURN promedio;
END//

DELIMITER ;

-- Insertamos Notas en la Tabla Notas

INSERT INTO notas (alumno_id, parcial1, parcial2, final) 
VALUES
	(1, 7.50, 8.00, 9.00),
    (2, 5.00, 6.50, 7.00),
    (3, 9.00, 10.00, 9.50);

-- Como usamos la Funcion???

SELECT 
	id,
    alumno_id,
    parcial1,
    parcial2,
    final,
    calcular_promedio(parcial1, parcial2, final) AS promedio
FROM notas;

-- Usar funcio por fuera de una Tabla
SELECT calcular_promedio(8, 5, 3) AS promedio;

-- Stored Procedure (Realiza operaciones Complejas)

-- Sintaxis de un SP
/*
DELIMITER //

CREATE PROCEDURE nombre_procedimiento(
	IN parametro1 tipo_dato,
    IN parametro2 tipo_dato
)
BEGIN
	-- Bloque de codigo SQL que quiero que se ejecute en el SP
END //

DELIMITER ;
*/

-- Como llamamos a un SP??? 
/*
	CALL nombre_procedimiento(valor1, valor2);
*/

DELIMITER //

CREATE PROCEDURE agregar_alumno (
	IN p_nombre VARCHAR(30),
    IN p_apellido VARCHAR(40),
    IN p_email VARCHAR(100),
    IN p_dni INT,
    IN p_telefono VARCHAR(20),
    IN p_edad INT
)
BEGIN
	INSERT INTO alumnos (
		nombre, apellido, email, dni, telefono, edad
    )
    VALUES (
		p_nombre, p_apellido, p_email, p_dni, p_telefono, p_edad
    );        
END //

DELIMITER ;

-- Como lo usamos?

CALL agregar_alumno('Juan', 'Perez', 'juanperez@mail.com', 12345678, '1166665555', 20);


-- Crear el mismo SP pero con logica condicional


DELIMITER //

CREATE PROCEDURE AgregarAlumnoSP (
	IN p_nombre VARCHAR(30),
    IN p_apellido VARCHAR(40),
    IN p_email VARCHAR(100),
    IN p_dni INT,
    IN p_telefono VARCHAR(20),
    IN p_edad INT,
    IN p_nacionalidad VARCHAR(30),
    IN p_instituto VARCHAR(60)
)
BEGIN
	DECLARE v_nacionalidad VARCHAR(30);
    DECLARE v_instituto VARCHAR(60);
    
    -- Condicional para Nacionalidad
    IF p_nacionalidad IS NULL OR p_nacionalidad = '' THEN
		SET v_nacionalidad = "Argentina";
	ELSE
		SET v_nacionalidad = p_nacionalidad;
	END IF;
    
    -- Condicional para Instituto
    IF p_instituto IS NULL OR p_instituto = '' THEN
		SET v_instituto = "CoderHouse";
	ELSE 
		SET v_instituto = p_instituto;
	END IF;
    
	INSERT INTO alumnos (
		nombre, apellido, email, dni, telefono, edad, nacionalidad, instituto
    )
    VALUES (
		p_nombre, p_apellido, p_email, p_dni, p_telefono, p_edad, v_nacionalidad, v_instituto
    );        
END //

DELIMITER ;

-- Como usarlo??

CALL AgregarAlumnoSP('Pedro', 'Lopez', 'pedrito@mail.com', 23232323, '1155554444', 30, '', '');

CALL AgregarAlumnoSP('Romina', 'Etchegaray', 'romina@mail.com', 66555444, '222555444', 25, NULL, NULL);

CALL AgregarAlumnoSP('Romina Lorena', 'Garcia', 'romina2@mail.com', 55666333, '335555666', 25, 'Ururguay', 'Mi Instituto');

-- SP para cargar notas

ALTER TABLE notas ADD COLUMN materia VARCHAR(50) NULL;

DELIMITER //

CREATE PROCEDURE RegistrarNotasSP (
	IN p_alumno_id INT , 
    IN p_parcial1 DECIMAL(5,2), 
    IN p_parcial2 DECIMAL(5,2), 
    IN p_final DECIMAL(5,2), 
    IN p_materia VARCHAR(50)
)
BEGIN
	INSERT INTO notas (alumno_id, parcial1, parcial2, final, materia) 
	VALUES (p_alumno_id, p_parcial1, p_parcial2, p_final, p_materia);
END //

DELIMITER ;

-- Lo usamos

CALL RegistrarNotasSP(7, 7.50, 8.00, 9.00, 'SQL');

CALL RegistrarNotasSP(8, 8.50, 8.50, 10.00, 'SQL');

-- SP para actualizar el email solo si el alumno existe
DELIMITER //

CREATE PROCEDURE ActualizarEmailSoloSiElAlumnoExisteSP(
	IN p_id_alumno INT,
    IN p_nuevo_email VARCHAR(100)
)
BEGIN
	IF EXISTS (SELECT 1 FROM alumnos WHERE id_alumno = p_id_alumno) THEN
		UPDATE alumnos 
        SET email = p_nuevo_email
        WHERE id_alumno = p_id_alumno;
	ELSE
		SELECT 'El Alumno no Existe' AS mensaje;
    END IF;
END //

DELIMITER ;

-- Lo usamos 
CALL ActualizarEmailSoloSiElAlumnoExisteSP(4, 'nuevoemaildealejandro@mail.com');

CALL ActualizarEmailSoloSiElAlumnoExisteSP(1, 'nuevoemaildealejandro@mail.com'); -- Devuelve el mensaje 'El Alumno no Existe'

-- SP usando WHILE
DELIMITER //

CREATE PROCEDURE ListarAlumnoSP()
BEGIN
	DECLARE contador INT DEFAULT 1;
    DECLARE max_id INT;
    
    -- Obtener el ID maximo
    SELECT MAX(id_alumno) INTO max_id FROM alumnos;
    
    -- Buclue para recorrer Alumnos
    WHILE contador <= max_id DO
		-- Verifico si el alumno existe
        IF EXISTS (SELECT 1 FROM alumnos WHERE id_alumno = contador) THEN
			SELECT * FROM alumnos WHERE id_alumno = contador;
		END IF;
        
        -- Incrementar contador en cada vuelta
        SET contador = contador + 1;
	END WHILE;
END //

DELIMITER ;

CALL ListarAlumnoSP();
