-- MySQL dump 10.13  Distrib 8.4.6, for Win64 (x86_64)
--
-- Host: mysql-whatever-livinitlarge-4d71.f.aivencloud.com    Database: spasalon_dev
-- ------------------------------------------------------
-- Server version	8.0.35

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '1543d9f2-985b-11f0-b1c0-ae2d1403823e:1-120,
a74a35f5-ad7f-11f0-ba6c-d6ec4f3314d1:1-66';

--
-- Table structure for table `booking`
--

DROP TABLE IF EXISTS `booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking` (
  `bookingId` int NOT NULL AUTO_INCREMENT,
  `bookingUserLogin` varchar(45) DEFAULT NULL,
  `bookingServiceId` int DEFAULT NULL,
  `bookingMasterId` int DEFAULT NULL,
  `bookingStart` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `bookingFinish` timestamp NULL DEFAULT NULL,
  `bookingStatus` enum('booked','confirmed','executing','finished','canceled') NOT NULL,
  `bookingBookedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`bookingId`),
  KEY `booking___fk` (`bookingUserLogin`),
  KEY `booking_service_serviceId_fk` (`bookingServiceId`),
  KEY `booking_master_masterId_fk` (`bookingMasterId`),
  CONSTRAINT `booking_master_masterId_fk` FOREIGN KEY (`bookingMasterId`) REFERENCES `master` (`masterId`) ON UPDATE CASCADE,
  CONSTRAINT `booking_service_serviceId_fk` FOREIGN KEY (`bookingServiceId`) REFERENCES `service` (`serviceId`) ON UPDATE CASCADE,
  CONSTRAINT `booking_user_userLogin_fk` FOREIGN KEY (`bookingUserLogin`) REFERENCES `user` (`userLogin`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Сеанс';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking`
--

LOCK TABLES `booking` WRITE;
/*!40000 ALTER TABLE `booking` DISABLE KEYS */;
/*!40000 ALTER TABLE `booking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `categoryId` int NOT NULL AUTO_INCREMENT,
  `categoryName` varchar(255) NOT NULL,
  `categoryDescription` text,
  `categoryStatus` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`categoryId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master`
--

DROP TABLE IF EXISTS `master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `master` (
  `masterId` int NOT NULL AUTO_INCREMENT,
  `masterUserLogin` varchar(45) NOT NULL,
  `masterSpecialization` text,
  `masterExperience` int NOT NULL DEFAULT '0' COMMENT 'Опыт работы в месяцах',
  `masterStatus` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`masterId`),
  KEY `master_user_userId_fk` (`masterUserLogin`),
  CONSTRAINT `master_user_userLogin_fk` FOREIGN KEY (`masterUserLogin`) REFERENCES `user` (`userLogin`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master`
--

LOCK TABLES `master` WRITE;
/*!40000 ALTER TABLE `master` DISABLE KEYS */;
INSERT INTO `master` VALUES (1,'testmasteruser','idk',5,1);
/*!40000 ALTER TABLE `master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_service`
--

DROP TABLE IF EXISTS `master_service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `master_service` (
  `msId` int NOT NULL AUTO_INCREMENT,
  `msMasterId` int NOT NULL,
  `msServiceId` int NOT NULL,
  PRIMARY KEY (`msId`),
  KEY `master_service_master_masterId_fk` (`msMasterId`),
  KEY `master_service_service_serviceId_fk` (`msServiceId`),
  CONSTRAINT `master_service_master_masterId_fk` FOREIGN KEY (`msMasterId`) REFERENCES `master` (`masterId`) ON UPDATE CASCADE,
  CONSTRAINT `master_service_service_serviceId_fk` FOREIGN KEY (`msServiceId`) REFERENCES `service` (`serviceId`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_service`
--

LOCK TABLES `master_service` WRITE;
/*!40000 ALTER TABLE `master_service` DISABLE KEYS */;
/*!40000 ALTER TABLE `master_service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rating`
--

DROP TABLE IF EXISTS `rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rating` (
  `ratingId` int NOT NULL AUTO_INCREMENT,
  `ratingUserLogin` varchar(45) NOT NULL,
  `ratingMasterId` int NOT NULL,
  `ratingText` text NOT NULL,
  `ratingStars` int NOT NULL DEFAULT '5',
  PRIMARY KEY (`ratingId`),
  UNIQUE KEY `ratingId` (`ratingId`),
  KEY `rating_master_masterId_fk` (`ratingMasterId`),
  KEY `rating_user_userLogin_fk` (`ratingUserLogin`),
  CONSTRAINT `rating_master_masterId_fk` FOREIGN KEY (`ratingMasterId`) REFERENCES `master` (`masterId`) ON UPDATE CASCADE,
  CONSTRAINT `rating_user_userLogin_fk` FOREIGN KEY (`ratingUserLogin`) REFERENCES `user` (`userLogin`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rating`
--

LOCK TABLES `rating` WRITE;
/*!40000 ALTER TABLE `rating` DISABLE KEYS */;
/*!40000 ALTER TABLE `rating` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `roleId` int NOT NULL AUTO_INCREMENT,
  `roleName` varchar(255) NOT NULL,
  PRIMARY KEY (`roleId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'guest');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service`
--

DROP TABLE IF EXISTS `service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service` (
  `serviceId` int NOT NULL AUTO_INCREMENT,
  `serviceName` varchar(255) NOT NULL,
  `serviceDescription` text,
  `serviceDuration` int NOT NULL DEFAULT '0' COMMENT 'В минутах',
  `servicePrice` decimal(5,2) NOT NULL DEFAULT '0.00',
  `serviceCategoryId` int NOT NULL,
  `serviceStatus` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`serviceId`),
  KEY `service_category_categoryId_fk` (`serviceCategoryId`),
  CONSTRAINT `service_category_categoryId_fk` FOREIGN KEY (`serviceCategoryId`) REFERENCES `category` (`categoryId`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service`
--

LOCK TABLES `service` WRITE;
/*!40000 ALTER TABLE `service` DISABLE KEYS */;
/*!40000 ALTER TABLE `service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `userLogin` varchar(45) NOT NULL,
  `userName` varchar(255) NOT NULL,
  `userSurname` varchar(255) NOT NULL,
  `userPhone` varchar(12) NOT NULL,
  `userSex` enum('male','female') NOT NULL,
  `userRoleId` int NOT NULL,
  `userPassword` text,
  `userStatus` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`userLogin`),
  KEY `user_role_roleId_fk` (`userRoleId`),
  CONSTRAINT `user_role_roleId_fk` FOREIGN KEY (`userRoleId`) REFERENCES `role` (`roleId`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('testmasteruser','mas','ter','+7800','male',1,'123',1);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-20 14:10:22
