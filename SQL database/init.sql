-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: studysmart
-- ------------------------------------------------------
-- Server version	9.0.1

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
-- Table structure for table `assignedby`
--

DROP TABLE IF EXISTS `assignedby`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assignedby` (
  `assignment_id` int NOT NULL,
  `course_id` int NOT NULL,
  PRIMARY KEY (`assignment_id`,`course_id`),
  CONSTRAINT `assignedby_ibfk_1` FOREIGN KEY (`assignment_id`) REFERENCES `assignment` (`assignment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assignedby`
--

LOCK TABLES `assignedby` WRITE;
/*!40000 ALTER TABLE `assignedby` DISABLE KEYS */;
INSERT INTO `assignedby` VALUES (1,1),(2,1),(3,5),(4,2),(5,3),(6,4),(7,5),(8,6),(9,7),(10,8);
/*!40000 ALTER TABLE `assignedby` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assignment`
--

DROP TABLE IF EXISTS `assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assignment` (
  `assignment_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text,
  `grade` double DEFAULT NULL,
  `max_grade` double DEFAULT NULL,
  `weight` double DEFAULT NULL,
  PRIMARY KEY (`assignment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assignment`
--

LOCK TABLES `assignment` WRITE;
/*!40000 ALTER TABLE `assignment` DISABLE KEYS */;
INSERT INTO `assignment` VALUES (1,'HW4','finish the homework before class',60,80,60),(2,'hw3','asndkasd',40,80,20),(3,'Hw1','homeworkone',80,100,25),(4,'Final Project','Build a full-stack application',90,100,40),(5,'Midterm','Chapter 1-5 coverage',85,100,30),(6,'Lab Report 1','Physics lab report',95,100,15),(7,'Essay 1','Analysis essay',88,100,20),(8,'Quiz 1','Chapter 1 quiz',92,100,10),(9,'Group Project','Team research project',87,100,25),(10,'Final Exam','Comprehensive exam',NULL,100,40);
/*!40000 ALTER TABLE `assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course` (
  `course_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `instructor` varchar(100) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  PRIMARY KEY (`course_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES (1,'CS-157A','Mike Wu','2024-08-14','2024-12-18'),(2,'MATH-33LA','John Smith','2024-01-08','2024-12-20'),(3,'PHYS-50','Sarah Johnson','2024-01-08','2024-12-20'),(4,'CS149','Sriram Rao','2024-01-08','2024-12-20'),(5,'CS-146','David Lee','2024-08-14','2024-12-18'),(6,'ENGL-1A','Emily Brown','2024-01-08','2024-12-20'),(7,'CHEM-1A','Michael Chen','2024-01-08','2024-12-20'),(8,'BIOL-10','Lisa Wong','2024-01-08','2024-12-20'),(9,'HIST-1A','Robert Taylor','2024-01-08','2024-12-20'),(10,'PSYCH-1','Amanda Garcia','2024-01-08','2024-12-20');
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enrolled`
--

DROP TABLE IF EXISTS `enrolled`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enrolled` (
  `user_id` varchar(50) NOT NULL,
  `course_id` int NOT NULL,
  PRIMARY KEY (`user_id`,`course_id`),
  KEY `course_id` (`course_id`),
  CONSTRAINT `enrolled_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `enrolled_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enrolled`
--

LOCK TABLES `enrolled` WRITE;
/*!40000 ALTER TABLE `enrolled` DISABLE KEYS */;
INSERT INTO `enrolled` VALUES ('domipo',1),('john_doe',2),('john_doe',3),('domipo',4),('jane_smith',4),('bob_wilson',5),('jane_smith',6),('bob_wilson',7),('john_doe',8),('jane_smith',9);
/*!40000 ALTER TABLE `enrolled` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `extracurricular`
--

DROP TABLE IF EXISTS `extracurricular`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `extracurricular` (
  `extracurricular_id` int NOT NULL AUTO_INCREMENT,
  `activity_name` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  PRIMARY KEY (`extracurricular_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `extracurricular`
--

LOCK TABLES `extracurricular` WRITE;
/*!40000 ALTER TABLE `extracurricular` DISABLE KEYS */;
INSERT INTO `extracurricular` VALUES (1,'Turkey Trot','Thanksgiving 10k running','2024-11-28','2024-11-28'),(2,'Turkey Trot','Thanksgiving 10k ','2024-12-05','2024-12-06'),(3,'Chess Club','Weekly chess meetings','2024-01-15','2024-12-15'),(4,'Coding Competition','Annual coding contest','2024-03-15','2024-03-16'),(5,'Math Club','Mathematics study group','2024-01-10','2024-12-10'),(6,'Debate Team','Competitive debating','2024-01-15','2024-12-15'),(7,'Music Band','College band practice','2024-01-15','2024-12-15'),(8,'Art Club','Creative arts group','2024-01-15','2024-12-15'),(9,'Science Club','Science experiments','2024-01-15','2024-12-15'),(10,'Sports Team','College athletics','2024-01-15','2024-12-15');
/*!40000 ALTER TABLE `extracurricular` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grade`
--

DROP TABLE IF EXISTS `grade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grade` (
  `grade_id` int NOT NULL AUTO_INCREMENT,
  `decimal_grade` double DEFAULT NULL,
  `letter_grade` varchar(255) NOT NULL,
  `date_recorded` date NOT NULL,
  PRIMARY KEY (`grade_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grade`
--

LOCK TABLES `grade` WRITE;
/*!40000 ALTER TABLE `grade` DISABLE KEYS */;
INSERT INTO `grade` VALUES (2,75,'C','2024-12-01'),(3,92,'A','2024-12-02'),(4,88.5,'B+','2024-12-03'),(5,99.25,'A','2024-12-04'),(6,78.5,'C+','2024-12-05'),(7,91,'A-','2024-12-06'),(8,86.5,'B','2024-12-07'),(9,93,'A','2024-12-08'),(10,89.5,'B+','2024-12-09');
/*!40000 ALTER TABLE `grade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gradeof`
--

DROP TABLE IF EXISTS `gradeof`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gradeof` (
  `grade_id` int NOT NULL,
  `course_id` int NOT NULL,
  PRIMARY KEY (`grade_id`,`course_id`),
  KEY `course_id` (`course_id`),
  CONSTRAINT `gradeof_ibfk_1` FOREIGN KEY (`grade_id`) REFERENCES `grade` (`grade_id`),
  CONSTRAINT `gradeof_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gradeof`
--

LOCK TABLES `gradeof` WRITE;
/*!40000 ALTER TABLE `gradeof` DISABLE KEYS */;
INSERT INTO `gradeof` VALUES (2,1),(3,2),(4,3),(5,4),(6,5),(7,6),(8,7),(9,8),(10,9);
/*!40000 ALTER TABLE `gradeof` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `involvedin`
--

DROP TABLE IF EXISTS `involvedin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `involvedin` (
  `user_id` varchar(50) NOT NULL,
  `extracurricular_id` int NOT NULL,
  PRIMARY KEY (`user_id`,`extracurricular_id`),
  KEY `extracurricular_id` (`extracurricular_id`),
  CONSTRAINT `involvedin_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `involvedin_ibfk_2` FOREIGN KEY (`extracurricular_id`) REFERENCES `extracurricular` (`extracurricular_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `involvedin`
--

LOCK TABLES `involvedin` WRITE;
/*!40000 ALTER TABLE `involvedin` DISABLE KEYS */;
INSERT INTO `involvedin` VALUES ('domipo',1),('husky',2),('john_doe',3),('jane_smith',4),('bob_wilson',5),('john_doe',6),('jane_smith',7),('bob_wilson',8),('john_doe',9),('bob_wilson',10);
/*!40000 ALTER TABLE `involvedin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `performs`
--

DROP TABLE IF EXISTS `performs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `performs` (
  `user_id` varchar(50) NOT NULL,
  `task_id` int NOT NULL,
  PRIMARY KEY (`user_id`,`task_id`),
  KEY `task_id` (`task_id`),
  CONSTRAINT `performs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `performs_ibfk_2` FOREIGN KEY (`task_id`) REFERENCES `task` (`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `performs`
--

LOCK TABLES `performs` WRITE;
/*!40000 ALTER TABLE `performs` DISABLE KEYS */;
INSERT INTO `performs` VALUES ('chihuahua',6),('domipo',17),('domipo',19),('domipo',21),('domipo',22),('john_doe',23),('jane_smith',24),('bob_wilson',25),('domipo',27),('domipo',28),('domipo',29);
/*!40000 ALTER TABLE `performs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resource`
--

DROP TABLE IF EXISTS `resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resource` (
  `id` int NOT NULL AUTO_INCREMENT,
  `task_id` int NOT NULL,
  `url` varchar(2083) DEFAULT NULL,
  `display_text` varchar(255) DEFAULT NULL,
  `type` varchar(20) DEFAULT 'link',
  PRIMARY KEY (`id`),
  KEY `task_id` (`task_id`),
  CONSTRAINT `resource_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `task` (`task_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resource`
--

LOCK TABLES `resource` WRITE;
/*!40000 ALTER TABLE `resource` DISABLE KEYS */;
INSERT INTO `resource` VALUES (7,7,'https://www.youtube.com/shorts/olr97t2xQ1A','How to deal with aggressive chihuahua','link'),(8,10,'https://www.youtube.com/','A youtube link','link'),(15,18,'https://www.gradescope.com/','your grade','link'),(16,18,'https://www.cengage.com/dashboard/home','math homework','link'),(17,23,'https://www.mathway.com','Math homework help','link'),(18,24,'https://www.khanacademy.org','Study materials','link'),(19,25,'https://www.github.com','Project repository','link'),(20,17,'https://www.youtube.com/watch?v=BZb-ozM2PWo','This is lecture video','video');
/*!40000 ALTER TABLE `resource` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `studies`
--

DROP TABLE IF EXISTS `studies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `studies` (
  `user_id` varchar(50) NOT NULL,
  `session_id` int NOT NULL,
  PRIMARY KEY (`user_id`,`session_id`),
  KEY `session_id` (`session_id`),
  CONSTRAINT `studies_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `studies_ibfk_2` FOREIGN KEY (`session_id`) REFERENCES `studysession` (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `studies`
--

LOCK TABLES `studies` WRITE;
/*!40000 ALTER TABLE `studies` DISABLE KEYS */;
INSERT INTO `studies` VALUES ('domipo',1),('domipo',2),('domipo',3),('domipo',4),('domipo',5),('domipo',6),('domipo',7),('domipo',8),('domipo',9),('domipo',10),('domipo',11),('domipo',12),('domipo',13),('domipo',14),('domipo',15),('domipo',16),('domipo',17),('domipo',18),('domipo',19),('domipo',20),('domipo',21),('domipo',22),('domipo',23),('domipo',24),('domipo',25),('domipo',26),('domipo',27),('domipo',28),('domipo',29),('domipo',30),('domipo',31),('domipo',32),('domipo',33),('domipo',34),('domipo',35),('domipo',36),('domipo',37),('domipo',38),('domipo',39),('domipo',40),('domipo',41),('domipo',42),('domipo',43),('domipo',44),('domipo',45),('domipo',46),('domipo',47),('domipo',48),('domipo',49),('domipo',50);
/*!40000 ALTER TABLE `studies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `studysession`
--

DROP TABLE IF EXISTS `studysession`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `studysession` (
  `session_id` int NOT NULL AUTO_INCREMENT,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `date_recorded` date NOT NULL,
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `studysession`
--

LOCK TABLES `studysession` WRITE;
/*!40000 ALTER TABLE `studysession` DISABLE KEYS */;
INSERT INTO `studysession` VALUES (1,'23:00:03','23:00:19','2024-12-02'),(2,'23:16:30','23:16:38','2024-12-02'),(3,'23:35:39','23:35:45','2024-12-02'),(4,'23:55:47','23:56:02','2024-12-02'),(5,'09:00:00','11:30:00','2024-12-02'),(6,'14:00:00','16:00:00','2024-12-02'),(7,'19:00:00','21:00:00','2024-12-01'),(8,'10:00:00','12:30:00','2024-12-01'),(9,'15:00:00','17:30:00','2024-11-30'),(10,'09:30:00','12:00:00','2024-11-29'),(11,'14:00:00','16:30:00','2024-11-29'),(12,'10:00:00','11:30:00','2024-11-28'),(13,'13:00:00','14:30:00','2024-11-27'),(14,'16:00:00','18:00:00','2024-11-27'),(15,'09:00:00','11:00:00','2024-11-25'),(16,'14:00:00','16:00:00','2024-11-25'),(17,'10:00:00','12:00:00','2024-11-24'),(18,'15:00:00','17:00:00','2024-11-24'),(19,'09:30:00','11:30:00','2024-11-23'),(20,'14:30:00','16:30:00','2024-11-23'),(21,'10:00:00','12:00:00','2024-11-22'),(22,'13:00:00','15:00:00','2024-11-21'),(23,'09:00:00','11:00:00','2024-11-18'),(24,'14:00:00','16:30:00','2024-11-18'),(25,'10:00:00','12:00:00','2024-11-17'),(26,'15:00:00','17:00:00','2024-11-17'),(27,'09:30:00','11:30:00','2024-11-16'),(28,'14:30:00','16:00:00','2024-11-16'),(29,'10:00:00','12:30:00','2024-11-15'),(30,'09:00:00','11:00:00','2024-11-11'),(31,'14:00:00','16:00:00','2024-11-11'),(32,'10:00:00','12:00:00','2024-11-10'),(33,'15:00:00','17:30:00','2024-11-10'),(34,'09:30:00','12:00:00','2024-11-09'),(35,'14:30:00','16:30:00','2024-11-09'),(36,'09:00:00','11:30:00','2024-11-04'),(37,'14:00:00','16:00:00','2024-11-04'),(38,'10:00:00','12:30:00','2024-11-03'),(39,'15:00:00','17:00:00','2024-11-03'),(40,'09:30:00','11:30:00','2024-11-02'),(41,'14:30:00','16:30:00','2024-11-02'),(42,'18:19:01','18:19:17','2024-12-03'),(43,'09:00:00','11:00:00','2024-12-03'),(44,'14:00:00','16:00:00','2024-12-03'),(45,'23:55:28','23:55:33','2024-12-05'),(46,'16:40:24','16:40:32','2024-12-06'),(47,'18:34:05','18:34:38','2024-12-16'),(48,'18:36:00','18:36:11','2024-12-16'),(49,'18:36:18','18:37:13','2024-12-16'),(50,'14:24:54','14:25:05','2024-12-17');
/*!40000 ALTER TABLE `studysession` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task`
--

DROP TABLE IF EXISTS `task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task` (
  `task_id` int NOT NULL AUTO_INCREMENT,
  `task_name` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `due_date` date NOT NULL,
  `priority` enum('Low','Medium','High') NOT NULL,
  `status` enum('Pending','Completed','Overdue') NOT NULL,
  `type` varchar(50) NOT NULL,
  `quick_note` varchar(255) DEFAULT NULL,
  `progress` int DEFAULT '0',
  PRIMARY KEY (`task_id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task`
--

LOCK TABLES `task` WRITE;
/*!40000 ALTER TABLE `task` DISABLE KEYS */;
INSERT INTO `task` VALUES (6,'Learn how to bark','bark continously','2024-11-20','Low','Completed','Group Project',NULL,100),(7,'Fight with chiahuahua','chihuahua is a b*tch','2024-11-21','High','Overdue','Assignment','why is the chihuahua so aggressive',50),(10,'testingTask','task task task tsaK KSI ','2024-11-21','Low','Overdue','Assignment','im working harrrddddd????',50),(17,'Final Demo Presentation CS-157A','Updated Task','2024-12-05','High','Overdue','Group Task','Updated note for demo',0),(18,'gRPC hash table program CS149','Complete the modification in java','2024-12-06','Medium','Completed','Personal Task','this is note',100),(19,'HW8 MATH-33LA','finish all problems','2024-12-09','Low','Overdue','Personal Task',NULL,0),(21,'Second Code review project CS157A','Finish 70% of all functional requirements','2024-11-21','High','Overdue','Group Task',NULL,0),(22,'Presentation demo','demo for group progject','2024-12-04','Low','Overdue','Group Task',NULL,0),(23,'Math Quiz 2','Chapter 3-4 quiz','2024-12-20','Medium','Pending','Exam',NULL,0),(24,'Physics Lab','Lab report 3','2024-12-18','High','Pending','Assignment',NULL,0),(25,'Study Group','Weekly meeting','2024-12-15','Low','Overdue','Group Task',NULL,0),(27,'Submit the report','Submit report for cs157a project','2024-12-16','Low','Overdue','Group Task',NULL,0),(28,'Final Exam CS-157A','this is final','2024-12-16','Medium','Overdue','Exam',NULL,0),(29,'Final Exam Math33LA','Online exam','2024-12-18','Medium','Pending','Exam',NULL,0);
/*!40000 ALTER TABLE `task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tasktodo`
--

DROP TABLE IF EXISTS `tasktodo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tasktodo` (
  `course_id` int NOT NULL,
  `task_id` int NOT NULL,
  PRIMARY KEY (`course_id`,`task_id`),
  KEY `task_id` (`task_id`),
  CONSTRAINT `tasktodo_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`),
  CONSTRAINT `tasktodo_ibfk_2` FOREIGN KEY (`task_id`) REFERENCES `task` (`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasktodo`
--

LOCK TABLES `tasktodo` WRITE;
/*!40000 ALTER TABLE `tasktodo` DISABLE KEYS */;
INSERT INTO `tasktodo` VALUES (1,17),(1,18),(2,23),(3,24),(4,25);
/*!40000 ALTER TABLE `tasktodo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `profile_created_date` date NOT NULL,
  `profilePicture` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('bob_wilson','bob@email.com','Bob Wilson','pass789','2024-11-03',NULL),('chihuahua','Chihuahua','chihua@shiba.com','123','2024-11-20',NULL),('chowmein','chowmein@gmail.com','Chow Mein','123456','2024-12-02',NULL),('corgi','corgiCorgi','corgi@gmail.com','123','2024-11-20',NULL),('domipo','domipo@gmail.com','minhphongdo','123','2024-10-14','uploads/illit-the-1st-mini-album-super-real-me-logo-banner-update-v0-5ke960h5avkc1.webp'),('friedRice','Fried Rice','friedrice@email.com','123','2024-12-02',NULL),('gerdnang','gerd nang','gerdnang@gmail.com','456','2024-12-02',NULL),('husky','hus@gmail.com','hushus','123','2024-12-05','uploads/bg,f8f8f8-flat,750x,075,f-pad,750x1000,f8f8f8.jpg'),('jane_smith','jane@email.com','Jane Smith','pass456','2024-11-02',NULL),('john_doe','john@email.com','John Doe','pass123','2024-11-01',NULL),('minh','minhphongdo','123@gmail.com','123','2024-10-22',NULL),('sampleUser','alice@gmail.com','Bobby','aaa','2024-12-05','uploads/bg,f8f8f8-flat,750x,075,f-pad,750x1000,f8f8f8.jpg'),('shiba','shibashiba','shiba-inu@gmail.com','123','2024-11-20',NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-17 19:22:48
