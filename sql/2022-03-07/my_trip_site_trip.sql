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
  `tr_ca_name` varchar(20) NOT NULL,
  `tr_ca_sort_name` varchar(20) NOT NULL,
  `tr_title` varchar(30) DEFAULT NULL,
  `tr_start_date` date DEFAULT NULL,
  `tr_end_date` date DEFAULT NULL,
  `tr_color` varchar(10) DEFAULT NULL,
  `tr_favorite` varchar(2) DEFAULT NULL,
  `tr_op_name` varchar(10) NOT NULL,
  `tr_del` varchar(2) NOT NULL DEFAULT 'N',
  `tr_charge` int DEFAULT '0',
  PRIMARY KEY (`tr_num`),
  KEY `FK_member_TO_trip_1` (`tr_me_id`),
  KEY `FK_spot_menu_TO_trip_1_idx` (`tr_sm_num`),
  KEY `FK_open_range_TO_trip_1_idx` (`tr_op_name`),
  CONSTRAINT `FK_member_TO_trip_1` FOREIGN KEY (`tr_me_id`) REFERENCES `member` (`me_id`),
  CONSTRAINT `FK_open_range_TO_trip_1` FOREIGN KEY (`tr_op_name`) REFERENCES `open_range` (`op_name`),
  CONSTRAINT `FK_spot_menu_TO_trip_1` FOREIGN KEY (`tr_sm_num`) REFERENCES `spot_menu` (`sm_num`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trip`
--

LOCK TABLES `trip` WRITE;
/*!40000 ALTER TABLE `trip` DISABLE KEYS */;
INSERT INTO `trip` VALUES (4,'qwer',1,'경기도','middle_category','새로운 trip','2022-03-05','2022-03-06',NULL,NULL,'트립메이트공개','N',0),(5,'qwer',1,'경상북도','middle_category','새로운 trip222','2022-03-05','2022-03-09',NULL,NULL,'전체공개','N',0),(6,'qwer',1,'수원시','small_category','경기도나들이','2022-03-01','2022-03-06',NULL,NULL,'전체공개','N',0),(7,'qwer',1,'성남시','small_category','이번주의 여행','2022-03-04','2022-03-04',NULL,NULL,'전체공개','N',0),(8,'qwer',1,'종로구','small_category','서울나들이','2022-03-04','2022-03-04',NULL,NULL,'전체공개','N',0),(9,'qwer',1,'청주시','small_category','오랜만에 청주','2022-03-01','2022-03-01',NULL,NULL,'전체공개','N',0),(10,'qwer',1,'성남시','small_category','2022-03-07 테스트','2022-03-07','2022-03-07',NULL,NULL,'전체공개','N',0),(11,'qwer',1,'청주시','small_category','시내놀러감','2022-03-09','2022-03-12',NULL,NULL,'전체공개','N',0),(12,'qwer',1,'강원도','middle_category','111','2022-03-07','2022-03-07',NULL,NULL,'전체공개','N',0),(13,'qwer',1,'경상남도','middle_category','file test','2022-03-04','2022-03-06',NULL,NULL,'전체공개','N',0),(14,'qwer',1,'서울특별시','middle_category','file test2','2022-01-05','2022-01-23',NULL,NULL,'전체공개','N',0),(15,'qwer',1,'제주특별자치도','middle_category','file test','2022-03-07','2022-03-07',NULL,NULL,'전체공개','N',0),(16,'qwer',1,'대구광역시','middle_category','file upload test','2022-03-07','2022-03-07',NULL,NULL,'전체공개','N',0);
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

-- Dump completed on 2022-03-07 13:07:30
