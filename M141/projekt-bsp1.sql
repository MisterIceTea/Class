-- MySQL dump 10.17  Distrib 10.3.12-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: projekt-bsp1
-- ------------------------------------------------------
-- Server version	10.3.12-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `projekt-bsp1`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `projekt-bsp1` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `projekt-bsp1`;

--
-- Table structure for table `mitarbeiter`
--

DROP TABLE IF EXISTS `mitarbeiter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mitarbeiter` (
  `idmitarbeiter` int(11) NOT NULL,
  `name` varchar(25) NOT NULL,
  `projekt_idprojekt` int(11) NOT NULL,
  PRIMARY KEY (`idmitarbeiter`),
  KEY `fk_mitarbeiter_projekt_idx` (`projekt_idprojekt`),
  CONSTRAINT `fk_mitarbeiter_projekt` FOREIGN KEY (`projekt_idprojekt`) REFERENCES `projekt` (`idprojekt`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mitarbeiter`
--

LOCK TABLES `mitarbeiter` WRITE;
/*!40000 ALTER TABLE `mitarbeiter` DISABLE KEYS */;
INSERT INTO `mitarbeiter` VALUES (1,'Meier',1),(2,'Müller',1),(3,'Huber',2);
/*!40000 ALTER TABLE `mitarbeiter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projekt`
--

DROP TABLE IF EXISTS `projekt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projekt` (
  `idprojekt` int(11) NOT NULL,
  `bezeichnung` varchar(25) NOT NULL,
  `zieldatum` date NOT NULL,
  PRIMARY KEY (`idprojekt`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projekt`
--

LOCK TABLES `projekt` WRITE;
/*!40000 ALTER TABLE `projekt` DISABLE KEYS */;
INSERT INTO `projekt` VALUES (1,'neue App entwickeln','2019-07-24'),(2,'Flughafen bauen','2034-12-24');
/*!40000 ALTER TABLE `projekt` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-05-22  3:29:24
