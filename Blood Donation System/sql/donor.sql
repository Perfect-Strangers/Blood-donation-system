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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=18 ;

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
(17, 'Manav Prajapati', 'AB+', 9409279463, 'Nadiad', '2015-01-14');

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
