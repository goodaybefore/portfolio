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
-- Table structure for table `board`
--

DROP TABLE IF EXISTS `board`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `board` (
  `bd_num` int NOT NULL AUTO_INCREMENT,
  `bd_title` varchar(50) NOT NULL,
  `bd_contents` longtext,
  `bd_me_id` varchar(20) DEFAULT NULL,
  `bd_date` datetime DEFAULT NULL,
  `bd_op_name` varchar(10) DEFAULT NULL,
  `bd_type` varchar(10) NOT NULL,
  `bd_del_member` varchar(20) DEFAULT NULL,
  `bd_mod_member` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`bd_num`),
  KEY `bd_me_id_idx` (`bd_me_id`),
  KEY `bd_op_name_idx` (`bd_op_name`),
  CONSTRAINT `bd_me_id` FOREIGN KEY (`bd_me_id`) REFERENCES `member` (`me_id`),
  CONSTRAINT `bd_op_name` FOREIGN KEY (`bd_op_name`) REFERENCES `open_range` (`op_name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board`
--

LOCK TABLES `board` WRITE;
/*!40000 ALTER TABLE `board` DISABLE KEYS */;
INSERT INTO `board` VALUES (1,'[겅G]','ㅎㅇㅎㅇ','asdf','2022-02-22 11:37:55','전체공개','notice',NULL,NULL),(2,'qqw','eqw','asdf','2022-02-22 11:38:50','전체공개','notice',NULL,NULL),(3,'[2022-02-22] 오늘의 공지입니다','공지','asdf','2022-02-22 12:02:41','전체공개','notice',NULL,NULL),(4,'[2022-02-22] 오늘의 두번째 공지 입니다','두번째\r\n공지\r\n입니다','asdf','2022-02-22 14:41:40','전체공개','notice',NULL,NULL),(5,'공지사항 첫번째','첫번째\r\n공\r\n지\r\n사항입니다','asdf','2022-02-24 12:23:50','전체공개','notice',NULL,NULL),(6,'공지사항 두번째','공지사항 두번째\r\n공지사항 두번째공지사항 두번째','asdf','2022-02-24 12:24:19','전체공개','notice',NULL,NULL),(7,'공지사항 세번째','공지사항 세번째공지사항 세번째공지사항 세번째공지사항 세번째\r\n공지사항 세번째공지사항 세번째공지사항 세번째공지사항 세번째\r\n공지사항 세번째\r\n공지사항 세번째\r\n공지사항 세번째\r\n','asdf','2022-02-24 12:24:38','전체공개','notice',NULL,NULL);
/*!40000 ALTER TABLE `board` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-03-07  0:28:44
