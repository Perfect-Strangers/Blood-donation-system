<?php
include 'connect.php';
include 'ChromePhp.php';
$d_id = mysqli_real_escape_string($conn,$_GET['d_id']);
ChromePhp::log($d_id);
$sql = "DELETE FROM `donor` WHERE `donor`.`D_id` = ".$d_id;
if ($conn->query($sql) === TRUE) {
	echo "Record deleted successfully!";
	ChromePhp::log("success");
}
else {
	echo "Delete error!";
	echo "Failed".$conn->error;
	ChromePhp::log("Failed: " + $conn->error);
}
?>