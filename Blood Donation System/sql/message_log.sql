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
-- Table structure for table `message_log`
--

CREATE TABLE IF NOT EXISTS `message_log` (
  `donor_id` int(11) NOT NULL,
  `Message` varchar(1000) NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `message_log`
--

INSERT INTO `message_log` (`donor_id`, `Message`, `time`) VALUES
(7, 'We are in urgent need of blood of type B-.', '2015-04-29 18:40:29'),
(3, 'We are in urgent need of blood of type O+.', '2015-04-29 18:40:29'),
(9, 'We are in urgent need of blood of type O+.', '2015-04-29 18:40:29'),
(16, 'We are in urgent need of blood of type O+.', '2015-04-29 18:40:29');

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
