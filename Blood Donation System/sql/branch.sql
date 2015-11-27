-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Apr 29, 2015 at 08:45 PM
-- Server version: 5.6.17
-- PHP Version: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `blood donation club`
--

-- --------------------------------------------------------

--
-- Table structure for table `branch`
--

CREATE TABLE IF NOT EXISTS `branch` (
  `B_Id` int(11) NOT NULL,
  `City` varchar(30) NOT NULL,
  PRIMARY KEY (`B_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `branch`
--

INSERT INTO `branch` (`B_Id`, `City`) VALUES
(1, 'Ahmedabad'),
(2, 'Nadiad'),
(3, 'Surat'),
(4, 'Pune'),
(5, 'Bombay'),
(6, 'Banglore'),
(7, 'Delhi');

DELIMITER $$
--
-- Events
--
CREATE DEFINER=`root`@`localhost` EVENT `Change_availability` ON SCHEDULE EVERY 2 SECOND STARTS '2014-01-01 00:00:00' ENDS '2020-04-05 00:00:00' ON COMPLETION PRESERVE DISABLE DO BEGIN
	call Change_availability();
END$$

DELIMITER ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
