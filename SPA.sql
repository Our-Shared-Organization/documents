-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: spasalon
-- ------------------------------------------------------
-- Server version	8.0.40

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
-- Table structure for table `booking`
--

DROP TABLE IF EXISTS `booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking` (
  `bookingid` int NOT NULL AUTO_INCREMENT,
  `bookinguserlogin` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bookingserviceid` int DEFAULT NULL,
  `bookingmasterlogin` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bookingstart` datetime NOT NULL,
  `bookingfinish` datetime DEFAULT NULL,
  `bookingstatus` enum('booked','confirmed','in_progress','completed','cancelled') COLLATE utf8mb4_unicode_ci NOT NULL,
  `bookingbookedat` datetime NOT NULL,
  PRIMARY KEY (`bookingid`),
  KEY `fk_booking_user` (`bookinguserlogin`),
  KEY `fk_booking_service` (`bookingserviceid`),
  KEY `fk_booking_master` (`bookingmasterlogin`),
  CONSTRAINT `fk_booking_master` FOREIGN KEY (`bookingmasterlogin`) REFERENCES `users` (`userlogin`) ON UPDATE CASCADE,
  CONSTRAINT `fk_booking_service` FOREIGN KEY (`bookingserviceid`) REFERENCES `service` (`serviceid`) ON UPDATE CASCADE,
  CONSTRAINT `fk_booking_user` FOREIGN KEY (`bookinguserlogin`) REFERENCES `users` (`userlogin`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking`
--

LOCK TABLES `booking` WRITE;
/*!40000 ALTER TABLE `booking` DISABLE KEYS */;
INSERT INTO `booking` VALUES (1,'client1',1,'master1','2024-12-20 10:00:00','2024-12-20 11:00:00','completed','2024-12-19 15:30:00'),(2,'client2',3,'master2','2024-12-20 14:00:00','2024-12-20 15:30:00','booked','2024-12-19 16:45:00'),(3,'client3',5,'master3','2024-12-21 11:00:00','2024-12-21 12:00:00','confirmed','2024-12-20 09:15:00'),(4,'client1',2,'master1','2024-12-22 16:00:00','2024-12-22 16:45:00','booked','2024-12-20 10:20:00'),(5,'client2',4,'master2','2025-10-27 15:26:37','2025-10-27 16:56:37','booked','2025-10-26 20:29:40');
/*!40000 ALTER TABLE `booking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `categoryid` int NOT NULL AUTO_INCREMENT,
  `categoryname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `categorydescription` text COLLATE utf8mb4_unicode_ci,
  `categorystatus` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`categoryid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Массаж','Расслабляющий и лечебный массаж',1),(2,'Спа-процедуры','Уходовые процедуры для тела',1),(3,'Уход за лицом','Косметические процедуры для лица',1),(4,'Маникюр и педикюр','Уход за ногтями',1);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_category`
--

DROP TABLE IF EXISTS `master_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `master_category` (
  `mcid` int NOT NULL AUTO_INCREMENT,
  `mcmasterlogin` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mccategoryid` int NOT NULL,
  PRIMARY KEY (`mcid`),
  KEY `fk_mc_user` (`mcmasterlogin`),
  KEY `fk_mc_category` (`mccategoryid`),
  CONSTRAINT `fk_mc_category` FOREIGN KEY (`mccategoryid`) REFERENCES `category` (`categoryid`) ON UPDATE CASCADE,
  CONSTRAINT `fk_mc_user` FOREIGN KEY (`mcmasterlogin`) REFERENCES `users` (`userlogin`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_category`
--

LOCK TABLES `master_category` WRITE;
/*!40000 ALTER TABLE `master_category` DISABLE KEYS */;
INSERT INTO `master_category` VALUES (1,'master1',1),(2,'master1',2),(3,'master2',2),(4,'master2',3),(5,'master3',4);
/*!40000 ALTER TABLE `master_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rating`
--

DROP TABLE IF EXISTS `rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rating` (
  `ratingid` int NOT NULL AUTO_INCREMENT,
  `ratinguserlogin` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ratingmasterlogin` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ratingtext` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `ratingstars` int NOT NULL DEFAULT '5',
  PRIMARY KEY (`ratingid`),
  KEY `fk_rating_user` (`ratinguserlogin`),
  KEY `fk_rating_master` (`ratingmasterlogin`),
  CONSTRAINT `fk_rating_master` FOREIGN KEY (`ratingmasterlogin`) REFERENCES `users` (`userlogin`) ON UPDATE CASCADE,
  CONSTRAINT `fk_rating_user` FOREIGN KEY (`ratinguserlogin`) REFERENCES `users` (`userlogin`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rating`
--

LOCK TABLES `rating` WRITE;
/*!40000 ALTER TABLE `rating` DISABLE KEYS */;
INSERT INTO `rating` VALUES (1,'client1','master1','Отличный массажист, очень профессионально!',5),(2,'client2','master2','Приятная атмосфера, качественные процедуры',4),(3,'client3','master3','Аккуратная работа, внимательный мастер',5);
/*!40000 ALTER TABLE `rating` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `roleid` int NOT NULL AUTO_INCREMENT,
  `rolename` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`roleid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'client'),(2,'master'),(3,'manager');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service`
--

DROP TABLE IF EXISTS `service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service` (
  `serviceid` int NOT NULL AUTO_INCREMENT,
  `servicename` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `servicedescription` text COLLATE utf8mb4_unicode_ci,
  `serviceduration` int NOT NULL DEFAULT '0',
  `serviceprice` decimal(5,2) NOT NULL DEFAULT '0.00',
  `servicecategoryid` int NOT NULL,
  `servicestatus` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`serviceid`),
  KEY `fk_service_category` (`servicecategoryid`),
  CONSTRAINT `fk_service_category` FOREIGN KEY (`servicecategoryid`) REFERENCES `category` (`categoryid`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service`
--

LOCK TABLES `service` WRITE;
/*!40000 ALTER TABLE `service` DISABLE KEYS */;
INSERT INTO `service` VALUES (1,'Расслабляющий массаж','Общий расслабляющий массаж всего тела',60,250.00,1,1),(2,'Лечебный массаж','Массаж для снятия мышечного напряжения',45,200.00,1,1),(3,'Спа-обертывание','Обертывание с морскими водорослями',90,350.00,2,1),(4,'Чистка лица','Профессиональная чистка кожи лица',60,180.00,3,1),(5,'Классический маникюр','Уход за ногтями и кожей рук',60,120.00,4,1),(6,'SPA-педикюр','Расслабляющий уход для ног',75,150.00,4,1),(7,'SPA-обертывание','Обертывание с морскими водорослями',90,350.00,2,1);
/*!40000 ALTER TABLE `service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `userlogin` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `usersurname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `userphone` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  `usersex` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `userroleid` int NOT NULL DEFAULT '1',
  `userpassword` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `userstatus` tinyint(1) NOT NULL DEFAULT '1',
  `useremail` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `userspecialization` text COLLATE utf8mb4_unicode_ci,
  `userexperience` int DEFAULT NULL,
  PRIMARY KEY (`userlogin`),
  KEY `fk_user_role` (`userroleid`),
  CONSTRAINT `fk_user_role` FOREIGN KEY (`userroleid`) REFERENCES `role` (`roleid`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('client1','Анна','Иванова','79151234567','female',1,'pass123',1,'anna@mail.ru',NULL,NULL),('client2','Мария','Петрова','79157654321','female',1,'pass123',1,'maria@mail.ru',NULL,NULL),('client3','Сергей','Сидоров','79159876543','male',1,'pass123',1,'sergey@mail.ru',NULL,NULL),('manager1','Ирина','Николаева','79150001122','female',3,'pass123',1,'irina@mail.ru',NULL,NULL),('master1','Елена','Кузнецова','79151112233','female',2,'pass123',1,'elena@mail.ru','Массажист',5),('master2','Ольга','Смирнова','79154445566','female',2,'pass123',1,'olga@mail.ru','Косметолог',3),('master3','Дмитрий','Васильев','79157778899','male',2,'pass123',1,'dmitry@mail.ru','Мастер маникюра',4),('йцу','йцу','qwe','123123','male',2,'qwe123',1,'qwe@gmail.com',NULL,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-27  8:02:14
