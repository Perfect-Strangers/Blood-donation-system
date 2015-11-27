-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Apr 29, 2015 at 10:24 PM
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

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `Change_availability`()
    NO SQL
BEGIN
	update blood_sample set available = (rand()*100);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Set_requirements`()
    MODIFIES SQL DATA
BEGIN
update blood_sample set requirement = 20 where blood_type in ('A+','B+','AB+');

update blood_sample set requirement = 10 where blood_type in ('O-','A-','B-','AB-');

update blood_sample set requirement = 30 where blood_type = 'O+';
END$$

DELIMITER ;

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
('A+', 1, 84, 20),
('A+', 2, 42, 20),
('A+', 3, 58, 20),
('A+', 4, 64, 20),
('A+', 5, 45, 20),
('A+', 6, 34, 20),
('A+', 7, 36, 20),
('A-', 1, 77, 10),
('A-', 2, 78, 10),
('A-', 3, 58, 10),
('A-', 4, 57, 10),
('A-', 5, 10, 10),
('A-', 6, 79, 10),
('A-', 7, 64, 10),
('AB+', 1, 82, 20),
('AB+', 2, 19, 20),
('AB+', 3, 50, 20),
('AB+', 4, 91, 20),
('AB+', 5, 7, 20),
('AB+', 6, 63, 20),
('AB+', 7, 94, 20),
('AB-', 1, 81, 10),
('AB-', 2, 21, 10),
('AB-', 3, 62, 10),
('AB-', 4, 46, 10),
('AB-', 5, 45, 10),
('AB-', 6, 85, 10),
('AB-', 7, 93, 10),
('B+', 1, 7, 20),
('B+', 2, 58, 20),
('B+', 3, 70, 20),
('B+', 4, 77, 20),
('B+', 5, 72, 20),
('B+', 6, 30, 20),
('B+', 7, 34, 20),
('B-', 1, 80, 10),
('B-', 2, 97, 10),
('B-', 3, 46, 10),
('B-', 4, 38, 10),
('B-', 5, 51, 10),
('B-', 6, 44, 10),
('B-', 7, 66, 10),
('O+', 1, 99, 30),
('O+', 2, 95, 30),
('O+', 3, 78, 30),
('O+', 4, 6, 30),
('O+', 5, 96, 30),
('O+', 6, 62, 30),
('O+', 7, 22, 30),
('O-', 1, 23, 10),
('O-', 2, 48, 10),
('O-', 3, 72, 10),
('O-', 4, 16, 10),
('O-', 5, 65, 10),
('O-', 6, 76, 10),
('O-', 7, 87, 10);

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
            	,(select CONCAT('We are running out of the availablity of '
                                ,NEW.blood_type
                                ,' type blood. Donate blood and help us save some one's life.'))
            	from donor
				where city = 
                	(select city from branch where b_id = NEW.branch_id)
                    and donor.blood_type = NEW.blood_type;

	END if; 
END
//
DELIMITER ;

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

-- --------------------------------------------------------

--
-- Table structure for table `donor`
--

CREATE TABLE IF NOT EXISTS `donor` (
  `D_Id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Donor ID',
  `Name` varchar(50) NOT NULL,
  `Blood_type` varchar(4) NOT NULL,
  `Contact_no` bigint(20) NOT NULL,
  `City` varchar(30) NOT NULL,
  `Last_donated` date NOT NULL,
  PRIMARY KEY (`D_Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=23 ;

--
-- Dumping data for table `donor`
--

INSERT INTO `donor` (`D_Id`, `Name`, `Blood_type`, `Contact_no`, `City`, `Last_donated`) VALUES
(1, 'Jay Panchal', 'A+', 9687026156, 'Ahmedabad', '2014-04-02'),
(2, 'Milan Patel', 'AB+', 8866196141, 'Ahmedabad', '2015-04-25'),
(3, 'Ronak Patel', 'O+', 9978984767, 'Ahmedabad', '2014-10-06'),
(4, 'Rajat Khandelwal', 'O-', 9712487756, 'Pune', '2014-07-17'),
(5, 'Riken Mehta', 'A+', 9429728752, 'Surat', '2014-07-09'),
(6, 'Ruchit Dalwadi', 'B+', 760003006, 'Surat', '2014-12-10'),
(7, 'Chinmay Mahanta', 'B-', 9662325558, 'Delhi', '2014-12-17'),
(8, 'Abhishek Yadav', 'A-', 7405498804, 'Delhi', '2015-02-11'),
(9, 'Suraj Patel', 'O+', 9173451123, 'Ahmedabad', '2013-05-15'),
(10, 'Jay Shah', 'B+', 9979782410, 'Surat', '2014-11-11'),
(11, 'Vaishali Jhalani', 'AB-', 8306885565, 'Jaipur', '2013-09-18'),
(12, 'Priyash Agrawal', 'AB+', 8905487928, 'Delhi', '2015-04-14'),
(13, 'Jayam Modi', 'O-', 9429474440, 'Surat', '2014-12-10'),
(14, 'Aditya Tiwari', 'B+', 9978889748, 'Pune', '2014-12-17'),
(15, 'Siddharth Seth', 'O-', 9016819350, 'Delhi', '2015-02-17'),
(16, 'Kamal Gevariya', 'O+', 8460087596, 'Surat', '2015-04-05'),
(17, 'Manav Prajapati', 'AB+', 9409279463, 'Nadiad', '2015-01-14'),
(19, 'Jethalal', 'O+', 9123131231, 'Ahmedabad', '2014-04-01'),
(20, 'Shaival Chokshi', 'B+', 9234172134, 'Ahmedabad', '2014-04-12'),
(22, 'Champak Chacha', 'B+', 9123176512, 'Surat', '2013-04-02');

--
-- Triggers `donor`
--
DROP TRIGGER IF EXISTS `New_donor`;
DELIMITER //
CREATE TRIGGER `New_donor` AFTER INSERT ON `donor`
 FOR EACH ROW BEGIN
update blood_sample set available = available+1 
	where (blood_type,branch_id) = (select blood_type,B_Id from donor,branch 
		where D_Id = (select MAX(d_id) from donor) 
        	and branch.city = donor.city);
END
//
DELIMITER ;

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
(17, 'We are running out of the availablity of AB+ type blood. Donate blood and help us save some one''s life.', '2015-04-29 20:23:16'),
(20, 'We are running out of the availablity of B+ type blood. Donate blood and help us save some one''s life.', '2015-04-29 20:23:16');

-- --------------------------------------------------------

--
-- Table structure for table `operator`
--

CREATE TABLE IF NOT EXISTS `operator` (
  `O_Id` int(11) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `Password` varchar(10) NOT NULL,
  `Contact_no` int(11) NOT NULL,
  `City` varchar(30) NOT NULL,
  PRIMARY KEY (`O_Id`),
  UNIQUE KEY `O_Id` (`O_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
