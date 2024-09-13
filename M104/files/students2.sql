-- phpMyAdmin SQL Dump
-- version 3.5.3
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Nov 26, 2012 at 07:41 PM
-- Server version: 5.5.28
-- PHP Version: 5.4.8

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

CREATE DATABASE students;
USE students;

--
-- Database: `students`
--

-- --------------------------------------------------------

--
-- Table structure for table `schueler`
--

CREATE TABLE IF NOT EXISTS `schueler` (
  `ID` int(11) NOT NULL DEFAULT '0',
  `Nachname` varchar(50) DEFAULT NULL,
  `Vorname` varchar(50) DEFAULT NULL,
  `Schuhgroesse` float DEFAULT NULL,
  `Koerpergroesse` float DEFAULT NULL,
  `Zeugnisdurchschnitt` float DEFAULT NULL,
  `DVNote` float DEFAULT NULL,
  `Haarfarbe` varchar(50) DEFAULT NULL,
  `Augenfarbe` varchar(50) DEFAULT NULL,
  `Lieblingsband` varchar(50) DEFAULT NULL,
  `Lieblingsfach` varchar(50) DEFAULT NULL,
  `Alter` tinyint(4) DEFAULT NULL,
  `Fuehrerschein` tinyint(1) DEFAULT NULL,
  `Brille` tinyint(1) DEFAULT NULL,
  `Geschlecht` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `schueler`
--

INSERT INTO `schueler` (`ID`, `Nachname`, `Vorname`, `Schuhgroesse`, `Koerpergroesse`, `Zeugnisdurchschnitt`, `DVNote`, `Haarfarbe`, `Augenfarbe`, `Lieblingsband`, `Lieblingsfach`, `Alter`, `Fuehrerschein`, `Brille`, `Geschlecht`) VALUES
(1, 'Müller', 'Fritz', 43, 180, 3.5, 5, 'dunkel-blond', 'grün', 'Westernhagen', 'Deutsch', 18, 0, 0, 'm'),
(2, 'Merkel', 'Martin', 40, 179, 3, 5, 'blondrot', 'grün', 'Westernhagen', 'DV', 19, 1, 0, 'm'),
(3, 'Maier', 'Edmund', 41, 172, 3.5, 5, 'braun', 'blau', 'ACDC', 'DV', 18, 1, 1, 'm'),
(4, 'Huber', 'Bastian', 43, 176, 3.9, 6, 'braun', 'braun', 'ACDC', 'DV', 17, 0, 0, 'm'),
(5, 'Schmitt', 'Hasan', 42, 177, 4.9, 3, 'blond', 'grün', 'ACDC', 'DV', 17, 0, 1, 'm'),
(6, 'Schmidt', 'Ottmar', 40, 191, 4.5, 2, 'braunrot', 'graugrün', 'Backstreet Boys', 'Englisch', 19, 1, 0, 'm'),
(7, 'Berger', 'Friedolin', 45, 194, 4.3, 6, 'schwarz', 'graugrün', 'Heino', 'Geschichte', 18, 1, 1, 'm'),
(8, 'Brunner', 'Gotthilf', 41, 176, 5.7, 6, 'schwarz', 'grau', 'Udo Jürgens', 'Geschichte', 19, 1, 0, 'm'),
(9, 'Bausch', 'Martha', 39, 173, 2.5, 2, 'dunkelbraun', 'blau', 'Metallica', 'Englisch', 20, 0, 1, 'w'),
(10, 'Tuberkol', 'Gerda', 38, 178, 2.7, 1, 'dunkelblond', 'braun', 'Slayer', 'Geschichte', 21, 1, 0, 'w'),
(11, 'Metz', 'Mahmut', 39, 165, 5.9, 3, 'hellblond', 'grün', 'Slayer', 'Deutsch', 19, 1, 1, 'w'),
(12, 'Langenbach', 'Sandra', 37, 168, 5.1, 5, 'hellbraun', 'grünblau', 'Slayer', 'Deutsch', 18, 0, 0, 'w'),
(13, 'Kauder', 'Angela', 40, 170, 5.4, 5, 'schwarz', 'blau', 'Westernhagen', 'DV', 19, 1, 0, 'w'),
(14, 'Schröder', 'Doro', 39, 171, 5.4, 4, 'grau', 'grün', 'Slayer', 'DV', 21, 1, 0, 'w'),
(15, 'Stoiber', 'Angela', 31, 179, 4.2, 6, 'gelb', 'rot', 'Slayer', 'Deutsch', 26, 1, 0, 'w');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
