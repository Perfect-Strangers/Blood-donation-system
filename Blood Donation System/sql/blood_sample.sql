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
-- Table structure for table `blood_sample`
--

CREATE TABLE IF NOT EXISTS `blood_sample` (
  `Blood_Type` varchar(4) NOT NULL,
  `Branch_Id` int(11) NOT NULL,
  `Available` int(11) NOT NULL,
  `Requirement` int(11) NOT NULL DEFAULT '30',
  PRIMARY KEY (`Blood_Type`,`Branch_Id`),
  KEY `Branch_Id` (`Branch_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `blood_sample`
--

INSERT INTO `blood_sample` (`Blood_Type`, `Branch_Id`, `Available`, `Requirement`) VALUES
('A+', 1, 87, 20),
('A+', 2, 51, 20),
('A+', 3, 91, 20),
('A+', 4, 5, 20),
('A+', 5, 52, 20),
('A+', 6, 44, 20),
('A+', 7, 65, 20),
('A-', 1, 92, 10),
('A-', 2, 63, 10),
('A-', 3, 42, 10),
('A-', 4, 22, 10),
('A-', 5, 82, 10),
('A-', 6, 45, 10),
('A-', 7, 80, 10),
('AB+', 1, 64, 20),
('AB+', 2, 80, 20),
('AB+', 3, 9, 20),
('AB+', 4, 4, 20),
('AB+', 5, 93, 20),
('AB+', 6, 54, 20),
('AB+', 7, 91, 20),
('AB-', 1, 93, 10),
('AB-', 2, 93, 10),
('AB-', 3, 86, 10),
('AB-', 4, 51, 10),
('AB-', 5, 98, 10),
('AB-', 6, 35, 10),
('AB-', 7, 80, 10),
('B+', 1, 95, 20),
('B+', 2, 35, 20),
('B+', 3, 89, 20),
('B+', 4, 41, 20),
('B+', 5, 39, 20),
('B+', 6, 72, 20),
('B+', 7, 45, 20),
('B-', 1, 5, 10),
('B-', 2, 93, 10),
('B-', 3, 49, 10),
('B-', 4, 67, 10),
('B-', 5, 87, 10),
('B-', 6, 33, 10),
('B-', 7, 5, 10),
('O+', 1, 27, 30),
('O+', 2, 20, 30),
('O+', 3, 18, 30),
('O+', 4, 31, 30),
('O+', 5, 2, 30),
('O+', 6, 16, 30),
('O+', 7, 74, 30),
('O-', 1, 23, 10),
('O-', 2, 92, 10),
('O-', 3, 93, 10),
('O-', 4, 86, 10),
('O-', 5, 51, 10),
('O-', 6, 98, 10),
('O-', 7, 37, 10);

--
-- Triggers `blood_sample`
--
DROP TRIGGER IF EXISTS `Blood_scarcity`;
DELIMITER //
CREATE TRIGGER `Blood_scarcity` AFTER UPDATE ON `blood_sample`
 FOR EACH ROW BEGIN
	if(NEW.available < NEW.requirement) then
		insert into message_log (donor_id,message)
        	select d_id
            	,(select CONCAT('We are in urgent need of blood of type '
                                ,NEW.blood_type
                                ,'.'))
            	from donor
				where city = 
                	(select city from branch where b_id = NEW.branch_id)
                    and donor.blood_type = NEW.blood_type;

	END if; 
END
//
DELIMITER ;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `blood_sample`
--
ALTER TABLE `blood_sample`
  ADD CONSTRAINT `blood_sample_ibfk_1` FOREIGN KEY (`Branch_Id`) REFERENCES `branch` (`B_Id`);

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
