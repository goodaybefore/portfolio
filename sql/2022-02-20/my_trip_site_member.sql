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
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member` (
  `me_id` varchar(20) NOT NULL,
  `me_pw` varchar(255) NOT NULL,
  `me_name` varchar(10) NOT NULL,
  `me_gender` varchar(10) NOT NULL,
  `me_phone` varchar(13) NOT NULL,
  `me_email` varchar(50) NOT NULL,
  `me_birth` date DEFAULT NULL,
  `me_del` varchar(2) DEFAULT 'N',
  `me_nickname` varchar(20) DEFAULT NULL,
  `me_photo` varchar(255) DEFAULT NULL,
  `me_gr_name` varchar(10) NOT NULL,
  `me_intro` varchar(140) DEFAULT NULL,
  `me_membership` varchar(2) DEFAULT 'N',
  `me_op_num` int NOT NULL,
  `me_last_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `me_attend_num` int DEFAULT '1',
  PRIMARY KEY (`me_id`),
  KEY `FK_grade_TO_member_1` (`me_gr_name`),
  KEY `FK_open_range_TO_member_1` (`me_op_num`),
  CONSTRAINT `FK_open_range_TO_member_1` FOREIGN KEY (`me_op_num`) REFERENCES `open_range` (`op_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES ('asdf','$2a$10$qz0P9rbfWNvPr/ohDyXHzuQNfXEsj1HxsmsVllEjNObfBEcr/nrYK','asdf','male','011-1111-2222','goodaybefore@gmail.com','2022-01-06','N',NULL,NULL,'트립비기너',NULL,'N',1,'2022-02-17 12:55:16',1),('qwer','$2a$10$VIAdj0WuZmZ7bnO46ZWQme1WnUcX19/LTl2SXkpl3NSUuIFoyf2Xi','qwerty','female','010-7894-6514','goodaybefore@gmail.com','2022-01-06','N',NULL,NULL,'트립비기너',NULL,'N',1,'2022-02-17 12:58:05',1),('zxcv','$2a$10$qKmTE8EwTracmR.X5f29NOx0WFz8qyfE6faZYMBZvB5IxIVHNSYGS','zxcv','male','010-1111-1111','goodaybefore@gmail.com','2022-01-06','N',NULL,NULL,'트립비기너',NULL,'N',1,'2022-02-17 17:01:28',1);
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-02-21  1:15:30
