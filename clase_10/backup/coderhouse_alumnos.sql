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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-24 12:48:48
