-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: coderhouse
-- ------------------------------------------------------
-- Server version	8.0.41

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary view structure for view `view_categoria_mas_cursos`
--

DROP TABLE IF EXISTS `view_categoria_mas_cursos`;
/*!50001 DROP VIEW IF EXISTS `view_categoria_mas_cursos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_categoria_mas_cursos` AS SELECT 
 1 AS `nombre_categoria`,
 1 AS `cantidad_cursos`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_alumnos`
--

DROP TABLE IF EXISTS `vista_alumnos`;
/*!50001 DROP VIEW IF EXISTS `vista_alumnos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_alumnos` AS SELECT 
 1 AS `nombre`,
 1 AS `apellido`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_cantidad_alumnos_curso`
--

DROP TABLE IF EXISTS `view_cantidad_alumnos_curso`;
/*!50001 DROP VIEW IF EXISTS `view_cantidad_alumnos_curso`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_cantidad_alumnos_curso` AS SELECT 
 1 AS `nombre_curso`,
 1 AS `cantidad_alumnos`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_inscripciones_alumnos`
--

DROP TABLE IF EXISTS `view_inscripciones_alumnos`;
/*!50001 DROP VIEW IF EXISTS `view_inscripciones_alumnos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_inscripciones_alumnos` AS SELECT 
 1 AS `id_alumno`,
 1 AS `nombre_completo`,
 1 AS `email`,
 1 AS `id_curso`,
 1 AS `nombre_curso`,
 1 AS `inscription_at`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_alumno_completa`
--

DROP TABLE IF EXISTS `view_alumno_completa`;
/*!50001 DROP VIEW IF EXISTS `view_alumno_completa`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_alumno_completa` AS SELECT 
 1 AS `nombre`,
 1 AS `apellido`,
 1 AS `email`,
 1 AS `instituto`,
 1 AS `nombre_curso`,
 1 AS `inscription_at`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `view_categoria_mas_cursos`
--

/*!50001 DROP VIEW IF EXISTS `view_categoria_mas_cursos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_categoria_mas_cursos` AS select `cat`.`nombre_categoria` AS `nombre_categoria`,count(`cur`.`id_curso`) AS `cantidad_cursos` from (`categoria` `cat` left join `cursos` `cur` on((`cur`.`id_categoria` = `cat`.`id_categoria`))) group by `cat`.`id_categoria` order by `cantidad_cursos` desc limit 1 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_alumnos`
--

/*!50001 DROP VIEW IF EXISTS `vista_alumnos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_alumnos` AS select `alumnos`.`nombre` AS `nombre`,`alumnos`.`apellido` AS `apellido` from `alumnos` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_cantidad_alumnos_curso`
--

/*!50001 DROP VIEW IF EXISTS `view_cantidad_alumnos_curso`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_cantidad_alumnos_curso` AS select `c`.`nombre_curso` AS `nombre_curso`,count(`i`.`id_alumno`) AS `cantidad_alumnos` from (`cursos` `c` left join `inscripciones` `i` on((`c`.`id_curso` = `i`.`id_curso`))) group by `c`.`id_curso`,`c`.`nombre_curso` order by `cantidad_alumnos` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_inscripciones_alumnos`
--

/*!50001 DROP VIEW IF EXISTS `view_inscripciones_alumnos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_inscripciones_alumnos` AS select `a`.`id_alumno` AS `id_alumno`,concat(`a`.`nombre`,' ',`a`.`apellido`) AS `nombre_completo`,`a`.`email` AS `email`,`c`.`id_curso` AS `id_curso`,`c`.`nombre_curso` AS `nombre_curso`,`i`.`inscription_at` AS `inscription_at` from ((`inscripciones` `i` join `alumnos` `a` on((`i`.`id_alumno` = `a`.`id_alumno`))) join `cursos` `c` on((`i`.`id_curso` = `c`.`id_curso`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_alumno_completa`
--

/*!50001 DROP VIEW IF EXISTS `view_alumno_completa`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_alumno_completa` AS select `a`.`nombre` AS `nombre`,`a`.`apellido` AS `apellido`,`a`.`email` AS `email`,`a`.`instituto` AS `instituto`,`c`.`nombre_curso` AS `nombre_curso`,`i`.`inscription_at` AS `inscription_at` from ((`inscripciones` `i` join `alumnos` `a` on((`i`.`id_alumno` = `a`.`id_alumno`))) join `cursos` `c` on((`i`.`id_curso` = `c`.`id_curso`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Dumping events for database 'coderhouse'
--

--
-- Dumping routines for database 'coderhouse'
--
/*!50003 DROP FUNCTION IF EXISTS `calcular_promedio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `calcular_promedio`(
	p1 DECIMAL(5,2),
    p2 DECIMAL(5,2),
    p3 DECIMAL(5,2)
) RETURNS decimal(5,2)
    DETERMINISTIC
BEGIN
	DECLARE promedio DECIMAL(5,2);
    SET promedio = (p1 + p2 + p3) / 3;
    RETURN promedio;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `CantidadDeInscriptosCurso` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `CantidadDeInscriptosCurso`(idCurso INT) RETURNS int
    DETERMINISTIC
BEGIN
	DECLARE cantidad INT;
    
    SELECT COUNT(*) INTO cantidad
    FROM inscripciones
    WHERE id_curso = idCurso;
    
    RETURN cantidad;    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ActualizarEmailSoloSiElAlumnoExisteSP` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarEmailSoloSiElAlumnoExisteSP`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AgregarAlumnoSP` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AgregarAlumnoSP`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `agregar_alumno` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `agregar_alumno`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ListarAlumnoSP` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarAlumnoSP`()
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerInscripcionesPorDia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerInscripcionesPorDia`()
BEGIN
	SELECT DATE(inscription_at) AS fecha, 
    COUNT(*) AS cantidad_inscripciones
    FROM inscripciones
    GROUP BY fecha
    ORDER BY fecha;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RegistrarNotasSP` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RegistrarNotasSP`(
	IN p_alumno_id INT , 
    IN p_parcial1 DECIMAL(5,2), 
    IN p_parcial2 DECIMAL(5,2), 
    IN p_final DECIMAL(5,2), 
    IN p_materia VARCHAR(50)
)
BEGIN
	INSERT INTO notas (alumno_id, parcial1, parcial2, final, materia) 
	VALUES (p_alumno_id, p_parcial1, p_parcial2, p_final, p_materia);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-24 12:48:49
