-- MySQL dump 10.14  Distrib 5.5.37-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: flugplatz
-- ------------------------------------------------------
-- Server version	5.5.37-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `flugplatz`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `flugplatz` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `flugplatz`;

--
-- Table structure for table `flug`
--

DROP TABLE IF EXISTS `flug`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flug` (
  `FlugId` int(11) NOT NULL AUTO_INCREMENT,
  `Pilot` int(11) NOT NULL,
  `Flugzeug` int(11) NOT NULL,
  `AnzPassagiere` int(11) NOT NULL,
  `StartFlugplatz` varchar(10) COLLATE latin1_general_ci NOT NULL,
  `ZielFlgplatz` varchar(10) COLLATE latin1_general_ci NOT NULL,
  `Datum` date NOT NULL,
  PRIMARY KEY (`FlugId`),
  KEY `fk_flug_pilot_idx` (`Pilot`),
  KEY `fk_flug_flugzeug1_idx` (`Flugzeug`),
  KEY `fk_flug_flugplatz1_idx` (`StartFlugplatz`),
  KEY `fk_flug_flugplatz2_idx` (`ZielFlgplatz`),
  CONSTRAINT `fk_flug_flugplatz1` FOREIGN KEY (`StartFlugplatz`) REFERENCES `flugplatz` (`ICAO_Code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_flug_flugplatz2` FOREIGN KEY (`ZielFlgplatz`) REFERENCES `flugplatz` (`ICAO_Code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_flug_flugzeug1` FOREIGN KEY (`Flugzeug`) REFERENCES `flugzeug` (`FlugzeugId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_flug_pilot` FOREIGN KEY (`Pilot`) REFERENCES `pilot` (`PilotId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flug`
--

LOCK TABLES `flug` WRITE;
/*!40000 ALTER TABLE `flug` DISABLE KEYS */;
INSERT INTO `flug` VALUES (1,1,1,2,'LFSB','LSGG','2008-10-10'),(2,2,1,2,'LFSB','LSZG','2008-10-12'),(3,2,2,2,'LSGG','LSZG','2008-10-12'),(4,3,1,0,'LFSB','LSZG','2008-10-12'),(5,7,3,3,'LSZB','LFSB','2008-10-13'),(6,4,3,0,'LSZB','LSZG','2008-10-13'),(7,6,4,2,'LSGG','LFSB','2008-10-13'),(8,6,4,5,'LFSB','LSZG','2008-10-15'),(9,6,3,2,'LFSB','LSGG','2008-10-18'),(10,6,2,2,'LSZB','LFSB','2008-10-18'),(11,5,1,1,'LSZG','LFSB','2008-10-18');
/*!40000 ALTER TABLE `flug` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flugplatz`
--

DROP TABLE IF EXISTS `flugplatz`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flugplatz` (
  `ICAO_Code` varchar(10) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Bezeichnung` varchar(50) COLLATE latin1_general_ci NOT NULL,
  PRIMARY KEY (`ICAO_Code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flugplatz`
--

LOCK TABLES `flugplatz` WRITE;
/*!40000 ALTER TABLE `flugplatz` DISABLE KEYS */;
INSERT INTO `flugplatz` VALUES ('LFSB','Basel'),('LSGG','Genf'),('LSZB','Bern'),('LSZG','Grenchen');
/*!40000 ALTER TABLE `flugplatz` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flugzeug`
--

DROP TABLE IF EXISTS `flugzeug`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flugzeug` (
  `FlugzeugId` int(11) NOT NULL AUTO_INCREMENT,
  `Hersteller` varchar(50) COLLATE latin1_general_ci NOT NULL,
  `Typ` varchar(50) COLLATE latin1_general_ci NOT NULL,
  `Kennzeichen` varchar(50) COLLATE latin1_general_ci NOT NULL,
  `Laenge` double NOT NULL,
  `Spannweite` double NOT NULL,
  PRIMARY KEY (`FlugzeugId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flugzeug`
--

LOCK TABLES `flugzeug` WRITE;
/*!40000 ALTER TABLE `flugzeug` DISABLE KEYS */;
INSERT INTO `flugzeug` VALUES (1,'Cessna','C-208','HB-CCW',11.46,15.88),(2,'Cessna','C-182','HB-CAD',8.84,10.97),(3,'Piper','PA-36','HB-PPR',8.39,11.82),(4,'Piper','PA-28','HB-PAS',7.52,11.8);
/*!40000 ALTER TABLE `flugzeug` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ort`
--

DROP TABLE IF EXISTS `ort`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ort` (
  `OrtId` int(11) NOT NULL AUTO_INCREMENT,
  `PLZ` varchar(50) COLLATE latin1_general_ci NOT NULL,
  `Ortschaft` varchar(50) COLLATE latin1_general_ci NOT NULL,
  PRIMARY KEY (`OrtId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ort`
--

LOCK TABLES `ort` WRITE;
/*!40000 ALTER TABLE `ort` DISABLE KEYS */;
INSERT INTO `ort` VALUES (1,'4147','Aesch'),(2,'4000','Basel'),(3,'4148','Pfeffingen'),(4,'4142','Münchenstein');
/*!40000 ALTER TABLE `ort` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pilot`
--

DROP TABLE IF EXISTS `pilot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pilot` (
  `PilotId` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) COLLATE latin1_general_ci NOT NULL,
  `Vorname` varchar(50) COLLATE latin1_general_ci NOT NULL,
  `Strasse` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Ort` int(11) NOT NULL,
  PRIMARY KEY (`PilotId`),
  KEY `fk_pilot_ort1_idx` (`Ort`),
  CONSTRAINT `fk_pilot_ort1` FOREIGN KEY (`Ort`) REFERENCES `ort` (`OrtId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pilot`
--

LOCK TABLES `pilot` WRITE;
/*!40000 ALTER TABLE `pilot` DISABLE KEYS */;
INSERT INTO `pilot` VALUES (1,'Meier','Klaus','Bürenstrasse 8',1),(2,'Müller','Peter','Hausenstrasse 122',1),(3,'Blattner','Alexander','Güterstrasse 12',4),(4,'Blattner','Claudia','Güterstrasse 12',4),(5,'Stalder','Maia','Bahnhofstrasse 10',1),(6,'Senn','Monika','Baselstrasse 111',3),(7,'Degen','Katharina','Hauptstrasse 1',2);
/*!40000 ALTER TABLE `pilot` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-06-02 23:29:37
