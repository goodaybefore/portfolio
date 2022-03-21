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
-- Table structure for table `activity`
--

DROP TABLE IF EXISTS `activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `activity` (
  `ac_num` int NOT NULL AUTO_INCREMENT,
  `ac_tr_num` int NOT NULL,
  `ac_me_id` varchar(20) DEFAULT NULL,
  `ac_title` varchar(50) DEFAULT NULL,
  `ac_mca_name` varchar(45) DEFAULT NULL,
  `ac_sca_name` varchar(45) DEFAULT NULL,
  `ac_address` varchar(50) DEFAULT NULL,
  `ac_address_detail` varchar(50) DEFAULT NULL,
  `ac_start_date` date DEFAULT NULL,
  `ac_end_date` date DEFAULT NULL,
  `ac_contents` longtext,
  `ac_color` varchar(10) DEFAULT NULL,
  `ac_with` varchar(100) DEFAULT NULL,
  `ac_op_name` varchar(10) NOT NULL,
  `ac_del` varchar(2) DEFAULT NULL,
  `del_date` date DEFAULT NULL,
  PRIMARY KEY (`ac_num`),
  KEY `FK_trip_TO_activity_1` (`ac_tr_num`),
  KEY `FK_open_range_TO_activity_1_idx` (`ac_op_name`),
  KEY `FK_member_TO_activity_1_idx` (`ac_me_id`),
  CONSTRAINT `FK_member_TO_activity_1` FOREIGN KEY (`ac_me_id`) REFERENCES `member` (`me_id`),
  CONSTRAINT `FK_open_range_TO_activity_1` FOREIGN KEY (`ac_op_name`) REFERENCES `open_range` (`op_name`),
  CONSTRAINT `FK_trip_TO_activity_1` FOREIGN KEY (`ac_tr_num`) REFERENCES `trip` (`tr_num`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity`
--

LOCK TABLES `activity` WRITE;
/*!40000 ALTER TABLE `activity` DISABLE KEYS */;
INSERT INTO `activity` VALUES (1,7,'qwer','호텔 알마2','숙박','호텔','충북 청주시 흥덕구 풍년로205번길 27-1','호텔 알마','2022-03-12','2022-03-13','<p><span style=\"background-color: rgb(255, 255, 0);\"><b>히노끼탕</b></span>이 있다</p><p><u>스타일러</u>도 있음.</p>',NULL,'S2','전체공개',NULL,NULL),(2,7,'qwer','힐링 자연림','힐링','자연','전북 남원시 대나무길 3','대나무숲','2022-03-13','2022-03-13','<p>완전</p><p>힐링가능 !!!</p>',NULL,'엄마, 아빠, 동생','전체공개',NULL,NULL);
/*!40000 ALTER TABLE `activity` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-03-21 11:01:48
