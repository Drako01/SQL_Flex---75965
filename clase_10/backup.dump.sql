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
-- Table structure for table `alumnos`
--

DROP TABLE IF EXISTS `alumnos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alumnos` (
  `id_alumno` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) NOT NULL,
  `apellido` varchar(40) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `dni` int NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `nacionalidad` varchar(30) DEFAULT 'Argentina',
  `fecha_inscripcion` datetime DEFAULT CURRENT_TIMESTAMP,
  `instituto` varchar(60) DEFAULT 'CoderHouse',
  `edad` int DEFAULT NULL,
  PRIMARY KEY (`id_alumno`),
  UNIQUE KEY `dni` (`dni`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `telefono` (`telefono`),
  KEY `idx_apellido` (`apellido`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alumnos`
--

LOCK TABLES `alumnos` WRITE;
/*!40000 ALTER TABLE `alumnos` DISABLE KEYS */;
INSERT INTO `alumnos` VALUES (4,'Alejandro','Di Stefano','nuevoemaildealejandro@mail.com',22233355,'115555666','Argentina','2025-03-15 12:43:04','CoderHouse',49),(5,'Juan','Perez','perez@mail.com',113333666,'1166667777','Argentina','2025-03-15 12:43:04','CoderHouse',30),(7,'Marcela','Muñoz','ivana@mail.com',33555888,'1166333777','Argentina','2025-03-15 12:52:35','CoderHouse',20),(8,'Marcela','Perez','marce@mail.com',22686777,'12555666','Uruguaya','2025-03-15 12:53:52','CoderHouse',26),(15,'Marcelo','Perez','marcelo@gmail.com',55666677,'1254654','Uruguaya','2025-03-15 13:28:56','CoderHouse',29),(16,'Enzo','Godoy','enzo@mail.com',55996677,'1253354','Brasilero','2025-03-15 13:28:56','CoderHouse',22),(17,'Julian','Alvarez','julian@mail.com',55688677,'1251124','Peruano','2025-03-15 13:28:56','CoderHouse',33),(18,'Cristian','Diaz','cris@gmail.com',55222677,'1111654','Chileno','2025-03-15 13:28:56','CoderHouse',21),(19,'Raul','Leiva','raul@mail.com',55446677,'1251654','Chileno','2025-03-15 13:28:56','CoderHouse',31),(20,'Wanda','Nara','wandaylgante@mail.com',22444488,'4545454','Argentina','2025-03-15 13:28:56','CoderHouse',31),(21,'Romina','Baron','romy@mail.com',53333677,'1254154','Peruano','2025-03-15 13:28:56','CoderHouse',27),(22,'China','Suarez','chinaicardi@gmail.com',22686677,'19955666','Argentina','2025-03-15 13:29:43','CoderHouse',35),(23,'Adrian','Perez','Adrian@mail.com',55669997,'12154654','Uruguaya','2025-03-22 12:41:18','CoderHouse',29),(24,'Andres','Perez','Andres@mail.com',57866677,'12541654','Uruguaya','2025-03-22 12:41:18','CoderHouse',29),(25,'Adrian','Perez','Adrian@gmail.com',556699947,'121454654','Uruguaya','2025-03-22 12:42:18','CoderHouse',29),(26,'Andres','Perez','Andres@gmail.com',574866677,'125414654','Uruguaya','2025-03-22 12:42:18','CoderHouse',29),(27,'Juan','Perez','juanperez@mail.com',12345678,'1166665555','Argentina','2025-05-10 12:35:14','CoderHouse',20),(28,'Pedro','Lopez','pedrito@mail.com',23232323,'1155554444','Argentina','2025-05-10 13:01:37','CoderHouse',30),(29,'Romina','Etchegaray','romina@mail.com',66555444,'222555444','Argentina','2025-05-10 13:02:32','CoderHouse',25),(31,'Romina Lorena','Garcia','romina2@mail.com',55666333,'335555666','Ururguay','2025-05-10 13:03:40','Mi Instituto',25);
/*!40000 ALTER TABLE `alumnos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria` (
  `id_categoria` int NOT NULL AUTO_INCREMENT,
  `nombre_categoria` varchar(100) NOT NULL,
  PRIMARY KEY (`id_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES (1,'Base de Datos'),(2,'Programacion');
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cursos`
--

DROP TABLE IF EXISTS `cursos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cursos` (
  `id_curso` int NOT NULL AUTO_INCREMENT,
  `nombre_curso` varchar(50) NOT NULL,
  `duracion_curso` int DEFAULT '20',
  `id_categoria` int DEFAULT NULL,
  PRIMARY KEY (`id_curso`),
  KEY `fk_curso_categoria` (`id_categoria`),
  CONSTRAINT `fk_curso_categoria` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cursos`
--

LOCK TABLES `cursos` WRITE;
/*!40000 ALTER TABLE `cursos` DISABLE KEYS */;
INSERT INTO `cursos` VALUES (1,'SQL',20,1),(2,'JavaScript',20,2),(3,'Java',60,2),(4,'HTML',20,2),(5,'Data Analytics',120,1),(6,'React',60,2),(7,'Angular',80,2),(8,'Python',120,2),(9,'SQL nivel Basico',80,1),(10,'SQL nivel Intermedio',60,1),(11,'SQL nivel Avanzado',80,1),(12,'SQL Server',180,1);
/*!40000 ALTER TABLE `cursos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cursos_inscripciones_count`
--

DROP TABLE IF EXISTS `cursos_inscripciones_count`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cursos_inscripciones_count` (
  `id_curso` int NOT NULL,
  `cantidad_inscripciones` int DEFAULT '0',
  PRIMARY KEY (`id_curso`),
  CONSTRAINT `cursos_inscripciones_count_ibfk_1` FOREIGN KEY (`id_curso`) REFERENCES `cursos` (`id_curso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cursos_inscripciones_count`
--

LOCK TABLES `cursos_inscripciones_count` WRITE;
/*!40000 ALTER TABLE `cursos_inscripciones_count` DISABLE KEYS */;
INSERT INTO `cursos_inscripciones_count` VALUES (2,2),(3,1),(7,1),(12,1);
/*!40000 ALTER TABLE `cursos_inscripciones_count` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inscripciones`
--

DROP TABLE IF EXISTS `inscripciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inscripciones` (
  `id_alumno` int NOT NULL,
  `id_curso` int NOT NULL,
  `inscription_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_alumno`,`id_curso`),
  KEY `id_curso` (`id_curso`),
  CONSTRAINT `inscripciones_ibfk_1` FOREIGN KEY (`id_alumno`) REFERENCES `alumnos` (`id_alumno`),
  CONSTRAINT `inscripciones_ibfk_2` FOREIGN KEY (`id_curso`) REFERENCES `cursos` (`id_curso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inscripciones`
--

LOCK TABLES `inscripciones` WRITE;
/*!40000 ALTER TABLE `inscripciones` DISABLE KEYS */;
INSERT INTO `inscripciones` VALUES (4,1,'2023-03-22 13:10:38'),(4,2,'2025-03-29 13:13:26'),(4,3,'2025-03-22 13:10:38'),(4,7,'2025-04-05 13:22:02'),(4,12,'2025-04-05 13:22:02'),(8,1,'2023-03-22 13:10:38'),(8,2,'2025-03-22 13:10:38'),(19,1,'2025-03-22 13:10:38'),(21,1,'2023-03-22 13:10:38'),(21,4,'2025-03-22 13:10:38'),(22,1,'2023-03-22 13:10:38'),(22,2,'2025-03-29 13:14:56'),(22,3,'2025-03-29 13:14:56');
/*!40000 ALTER TABLE `inscripciones` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_inscription_insert` BEFORE INSERT ON `inscripciones` FOR EACH ROW BEGIN
	DECLARE existe INT;
	
    SELECT COUNT(*) INTO existe
    FROM inscripciones
    WHERE id_alumno = NEW.id_alumno AND id_curso = NEW.id_curso;
    
    -- Si ya existe
    IF existe > 0 THEN 
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El Alumno ya esta inscripto a este curso';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_inscription_insert` AFTER INSERT ON `inscripciones` FOR EACH ROW BEGIN
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
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tr_log_inscriptios` AFTER INSERT ON `inscripciones` FOR EACH ROW BEGIN
	INSERT INTO log_inscripciones (id_alumno, id_curso, fecha_inscripcion)
    VALUES (NEW.id_alumno, NEW.id_curso, NEW.inscription_at);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `log_inscripciones`
--

DROP TABLE IF EXISTS `log_inscripciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_inscripciones` (
  `id_log` int NOT NULL AUTO_INCREMENT,
  `id_alumno` int DEFAULT NULL,
  `id_curso` int DEFAULT NULL,
  `fecha_inscripcion` datetime DEFAULT NULL,
  `log_timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_log`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_inscripciones`
--

LOCK TABLES `log_inscripciones` WRITE;
/*!40000 ALTER TABLE `log_inscripciones` DISABLE KEYS */;
INSERT INTO `log_inscripciones` VALUES (1,4,12,'2025-04-05 13:22:02','2025-04-05 16:22:02'),(2,4,7,'2025-04-05 13:22:02','2025-04-05 16:22:02');
/*!40000 ALTER TABLE `log_inscripciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notas`
--

DROP TABLE IF EXISTS `notas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `alumno_id` int DEFAULT NULL,
  `parcial1` decimal(5,2) DEFAULT NULL,
  `parcial2` decimal(5,2) DEFAULT NULL,
  `final` decimal(5,2) DEFAULT NULL,
  `materia` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notas`
--

LOCK TABLES `notas` WRITE;
/*!40000 ALTER TABLE `notas` DISABLE KEYS */;
INSERT INTO `notas` VALUES (1,1,7.50,8.00,9.00,NULL),(2,2,5.00,6.50,7.00,NULL),(3,3,9.00,10.00,9.50,NULL),(4,1,7.50,8.00,9.00,NULL),(5,2,5.00,6.50,7.00,NULL),(6,3,9.00,10.00,9.50,NULL),(7,7,7.50,8.00,9.00,'SQL'),(8,8,8.50,8.50,10.00,'SQL');
/*!40000 ALTER TABLE `notas` ENABLE KEYS */;
UNLOCK TABLES;

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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-24 12:50:16
