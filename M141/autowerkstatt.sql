-- MySQL dump 10.17  Distrib 10.3.22-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: autowerkstatt
-- ------------------------------------------------------
-- Server version	10.3.22-MariaDB

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
-- Current Database: `autowerkstatt`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `autowerkstatt` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `autowerkstatt`;

--
-- Table structure for table `tbl_Arbeit`
--

DROP TABLE IF EXISTS `tbl_Arbeit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_Arbeit` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) NOT NULL,
  `Preis` float NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Name_UNIQUE` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_Arbeit`
--

LOCK TABLES `tbl_Arbeit` WRITE;
/*!40000 ALTER TABLE `tbl_Arbeit` DISABLE KEYS */;
INSERT INTO `tbl_Arbeit` VALUES (1,'Ölwechsel',25),(2,'Staubsaugen',14.5),(3,'Service',244.5),(4,'Radwechsel',52.8);
/*!40000 ALTER TABLE `tbl_Arbeit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_Arbeitsgang`
--

DROP TABLE IF EXISTS `tbl_Arbeitsgang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_Arbeitsgang` (
  `tbl_Arbeit_ID` int(11) NOT NULL,
  `tbl_Rechnung_Rechnungsnummer` int(11) NOT NULL,
  `Menge` float NOT NULL,
  PRIMARY KEY (`tbl_Arbeit_ID`,`tbl_Rechnung_Rechnungsnummer`),
  KEY `fk_tbl_Arbeit_has_tbl_Rechnung_tbl_Arbeit1_idx` (`tbl_Arbeit_ID`),
  KEY `fk_tbl_Arbeit_has_tbl_Rechnung_tbl_Rechnung1_idx` (`tbl_Rechnung_Rechnungsnummer`),
  CONSTRAINT `fk_tbl_Arbeit_has_tbl_Rechnung_tbl_Arbeit1` FOREIGN KEY (`tbl_Arbeit_ID`) REFERENCES `tbl_Arbeit` (`ID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_Arbeit_has_tbl_Rechnung_tbl_Rechnung1` FOREIGN KEY (`tbl_Rechnung_Rechnungsnummer`) REFERENCES `tbl_Reparatur` (`Rechnungsnummer`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_Arbeitsgang`
--

LOCK TABLES `tbl_Arbeitsgang` WRITE;
/*!40000 ALTER TABLE `tbl_Arbeitsgang` DISABLE KEYS */;
INSERT INTO `tbl_Arbeitsgang` VALUES (1,1,2),(1,2,1),(2,1,1),(3,3,2),(4,3,2),(4,4,1);
/*!40000 ALTER TABLE `tbl_Arbeitsgang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_Fahrzeug`
--

DROP TABLE IF EXISTS `tbl_Fahrzeug`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_Fahrzeug` (
  `Fahrgestellnr` varchar(30) NOT NULL,
  `Kennzeichen` varchar(9) NOT NULL,
  `Automarke` varchar(45) NOT NULL,
  `tbl_Kunde_KdNummer` int(11) NOT NULL,
  PRIMARY KEY (`Fahrgestellnr`),
  UNIQUE KEY `Kennzeichen_UNIQUE` (`Kennzeichen`),
  KEY `fk_tbl_Fahrzeug_tbl_Kunde1_idx` (`tbl_Kunde_KdNummer`),
  CONSTRAINT `fk_tbl_Fahrzeug_tbl_Kunde1` FOREIGN KEY (`tbl_Kunde_KdNummer`) REFERENCES `tbl_Kunde` (`KdNummer`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_Fahrzeug`
--

LOCK TABLES `tbl_Fahrzeug` WRITE;
/*!40000 ALTER TABLE `tbl_Fahrzeug` DISABLE KEYS */;
INSERT INTO `tbl_Fahrzeug` VALUES ('11-22-33-44','BL 2','Ford',2),('12-34-56-78','BL 1','VW',1);
/*!40000 ALTER TABLE `tbl_Fahrzeug` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_Kunde`
--

DROP TABLE IF EXISTS `tbl_Kunde`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_Kunde` (
  `KdNummer` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) NOT NULL,
  `Vorname` varchar(45) NOT NULL COMMENT '	',
  `Strasse` varchar(45) NOT NULL,
  `Telefon` varchar(45) NOT NULL,
  `tbl_ort_OrtID` int(11) NOT NULL,
  PRIMARY KEY (`KdNummer`),
  KEY `tbl_Kunde_FK` (`tbl_ort_OrtID`),
  CONSTRAINT `tbl_Kunde_FK` FOREIGN KEY (`tbl_ort_OrtID`) REFERENCES `tbl_Ort` (`OrtID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_Kunde`
--

LOCK TABLES `tbl_Kunde` WRITE;
/*!40000 ALTER TABLE `tbl_Kunde` DISABLE KEYS */;
INSERT INTO `tbl_Kunde` VALUES (1,'Meier','Peter','Milchstrasse 1','012 345 67 89',2),(2,'Müller','Franz','Hauptstrasse 17','098 765 43 21',1);
/*!40000 ALTER TABLE `tbl_Kunde` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_Ort`
--

DROP TABLE IF EXISTS `tbl_Ort`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_Ort` (
  `OrtID` int(11) NOT NULL AUTO_INCREMENT,
  `PLZ` varchar(4) NOT NULL,
  `Ort` varchar(45) NOT NULL,
  PRIMARY KEY (`OrtID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_Ort`
--

LOCK TABLES `tbl_Ort` WRITE;
/*!40000 ALTER TABLE `tbl_Ort` DISABLE KEYS */;
INSERT INTO `tbl_Ort` VALUES (1,'4133','Pratteln'),(2,'4132','Muttenz');
/*!40000 ALTER TABLE `tbl_Ort` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_Reparatur`
--

DROP TABLE IF EXISTS `tbl_Reparatur`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_Reparatur` (
  `Rechnungsnummer` int(11) NOT NULL AUTO_INCREMENT,
  `km_Stand` int(11) NOT NULL,
  `Datum` date NOT NULL,
  `tbl_Fahrzeug_Fahrgestellnummer` varchar(30) NOT NULL,
  PRIMARY KEY (`Rechnungsnummer`),
  KEY `fk_tbl_Rechnung_tbl_Auto1_idx` (`tbl_Fahrzeug_Fahrgestellnummer`),
  CONSTRAINT `fk_tbl_Rechnung_tbl_Auto1` FOREIGN KEY (`tbl_Fahrzeug_Fahrgestellnummer`) REFERENCES `tbl_Fahrzeug` (`Fahrgestellnr`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_Reparatur`
--

LOCK TABLES `tbl_Reparatur` WRITE;
/*!40000 ALTER TABLE `tbl_Reparatur` DISABLE KEYS */;
INSERT INTO `tbl_Reparatur` VALUES (1,10000,'2013-08-18','11-22-33-44'),(2,15000,'2013-08-12','12-34-56-78'),(3,18000,'2013-08-19','11-22-33-44'),(4,20000,'2013-08-22','11-22-33-44');
/*!40000 ALTER TABLE `tbl_Reparatur` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-04-11 17:14:57
