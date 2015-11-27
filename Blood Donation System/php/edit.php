<?php
include 'connect.php';
include 'ChromePhp.php';
$d_id = mysqli_real_escape_string($conn,$_GET['d_id']);
$name = mysqli_real_escape_string($conn,$_GET['name']);
$blood = mysqli_real_escape_string($conn,$_GET['blood_type']);
$contact = mysqli_real_escape_string($conn,$_GET['contact_no']);
$city = mysqli_real_escape_string($conn,$_GET['city']);
$last = mysqli_real_escape_string($conn,$_GET['last_donated']);
$sql = "update donor set name='$name',blood_type='$blood',contact_no=$contact,city='$city',last_donated='$last' where d_id=$d_id";
ChromePhp::log($sql);
if ($conn->query($sql) === TRUE) {
	echo "Record updated successfully!";
	ChromePhp::log("success");
}
else {
	echo "Update error!";
	ChromePhp::log("Failed: " . $conn->error);
}
?>