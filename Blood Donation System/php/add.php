<?php
include "connect.php";
include "ChromePhp.php";
$d_id = mysqli_real_escape_string($conn,$_GET['d_id']);
$name = mysqli_real_escape_string($conn,$_GET['name']);
$blood = mysqli_real_escape_string($conn,$_GET['blood_type']);
$contact = mysqli_real_escape_string($conn,$_GET['contact_no']);
$city = mysqli_real_escape_string($conn,$_GET['city']);
$last = mysqli_real_escape_string($conn,$_GET['last_donated']);
$sql = ("INSERT INTO `donor`(`d_id`, `name`, `blood_type`, `contact_no`, `city`, `last_donated`) VALUES('".$d_id."','".$name."','".$blood."','".$contact."','".$city."','".$last."')");
if ($conn->query($sql) === TRUE) {
	echo '<div class="result_title" id="add">Entry added successfully</div>';
} 
else {
	echo "<div class='result_title' id='add'>Error: ".$conn->error."</div>";
	//echo "Error: " . $sql . "<br>" . $conn->error;
}
?>