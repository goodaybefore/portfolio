-- MySQL dump 10.13  Distrib 8.0.27, for Win64 (x86_64)
--
-- Host: localhost    Database: my_trip_site
-- ------------------------------------------------------
-- Server version	8.0.27

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
-- Table structure for table `trip`
--

DROP TABLE IF EXISTS `trip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trip` (
  `tr_num` int NOT NULL AUTO_INCREMENT,
  `tr_me_id` varchar(20) NOT NULL,
  `tr_sm_num` int NOT NULL,
  `tr_sc_num` int NOT NULL,
  `tr_title` varchar(30) DEFAULT NULL,
  `tr_start_date` date DEFAULT NULL,
  `tr_end_date` date DEFAULT NULL,
  `tr_color` varchar(10) DEFAULT NULL,
  `tr_favorite` varchar(2) DEFAULT NULL,
  `tr_or_num` int NOT NULL,
  `tr_del` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`tr_num`),
  KEY `FK_member_TO_trip_1` (`tr_me_id`),
  KEY `FK_spot_menu_TO_trip_1` (`tr_sm_num`),
  KEY `FK_small_category_TO_trip_1` (`tr_sc_num`),
  KEY `FK_open_range_TO_trip_1` (`tr_or_num`),
  CONSTRAINT `FK_member_TO_trip_1` FOREIGN KEY (`tr_me_id`) REFERENCES `member` (`me_id`),
  CONSTRAINT `FK_open_range_TO_trip_1` FOREIGN KEY (`tr_or_num`) REFERENCES `open_range` (`op_num`),
  CONSTRAINT `FK_small_category_TO_trip_1` FOREIGN KEY (`tr_sc_num`) REFERENCES `small_category` (`sc_num`),
  CONSTRAINT `FK_spot_menu_TO_trip_1` FOREIGN KEY (`tr_sm_num`) REFERENCES `spot_menu` (`sm_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trip`
--

LOCK TABLES `trip` WRITE;
/*!40000 ALTER TABLE `trip` DISABLE KEYS */;
/*!40000 ALTER TABLE `trip` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-02-18  1:30:27
