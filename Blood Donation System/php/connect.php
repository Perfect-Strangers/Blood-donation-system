<?php

//error_reporting(E_ALL ^ E_DEPRECATED);
/*$link=mysql_connect("172.37.4.133","root","") or die("Connection error in IP address!");
$f1=mysql_select_db("Blood Donation Club",$link) or die("Connection error in DB!");*/
$servername = "192.168.174.60";
//$servername = "172.37.4.122";
//$servername = "localhost";
$username = "root";
$password = "";
$dbname = "Blood Donation Club";
//$dbname = "blood";

$conn= new mysqli($servername, $username, $password, $dbname) or die("Connection error in IP address!");
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

?>