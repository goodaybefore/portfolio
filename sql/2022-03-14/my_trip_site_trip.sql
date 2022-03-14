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
  `tr_mca_name` varchar(20) NOT NULL,
  `tr_sca_name` varchar(20) DEFAULT NULL,
  `tr_title` varchar(30) DEFAULT NULL,
  `tr_start_date` date DEFAULT NULL,
  `tr_end_date` date DEFAULT NULL,
  `tr_color` varchar(10) DEFAULT NULL,
  `tr_favorite` varchar(2) DEFAULT NULL,
  `tr_op_name` varchar(10) NOT NULL,
  `tr_del` varchar(2) NOT NULL DEFAULT 'N',
  `tr_charge` int DEFAULT '0',
  `tr_with` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`tr_num`),
  KEY `FK_member_TO_trip_1` (`tr_me_id`),
  KEY `FK_spot_menu_TO_trip_1_idx` (`tr_sm_num`),
  KEY `FK_open_range_TO_trip_1_idx` (`tr_op_name`),
  CONSTRAINT `FK_member_TO_trip_1` FOREIGN KEY (`tr_me_id`) REFERENCES `member` (`me_id`),
  CONSTRAINT `FK_open_range_TO_trip_1` FOREIGN KEY (`tr_op_name`) REFERENCES `open_range` (`op_name`),
  CONSTRAINT `FK_spot_menu_TO_trip_1` FOREIGN KEY (`tr_sm_num`) REFERENCES `spot_menu` (`sm_num`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trip`
--

LOCK TABLES `trip` WRITE;
/*!40000 ALTER TABLE `trip` DISABLE KEYS */;
INSERT INTO `trip` VALUES (1,'qwer',1,'강원도',NULL,'나의 첫번째 여행 - 강원도','2022-01-01','2022-01-07',NULL,NULL,'전체공개','N',0,NULL),(2,'qwer',1,'충청북도',NULL,'나의 두번째 여행 - 충북','2022-01-30','2022-02-01',NULL,NULL,'전체공개','N',0,NULL),(3,'qwer',1,'충청남도',NULL,'나의 세번째 여행 - 충남 당진','2022-02-04','2022-02-04',NULL,NULL,'트립메이트공개','N',0,NULL),(4,'qwer',1,'충청북도','청주시','나의 네번째 여행 - 충북 청주','2022-02-28','2022-02-28',NULL,NULL,'전체공개','N',0,NULL),(5,'qwer',1,'대전광역시',NULL,'나의 다섯번째 여행 - 대전','2022-03-07','2022-03-07',NULL,NULL,'전체공개','N',0,'동아리사람들'),(6,'qwer',1,'충청북도','충주시','7번쨰여행','2022-03-14','2022-03-14',NULL,NULL,'전체공개','N',0,'엄마, 아빠');
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

-- Dump completed on 2022-03-14 17:52:59
