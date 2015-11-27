<!DOCTYPE html>
<html>
	<head>
	<title>Blood System</title>
	<link rel="stylesheet" href="css/style.css"/>
	<link rel="icon" type="image/x-icon" href="images/favicon.ico"/>
	<script type="text/javascript" src="js/jquery-latest.min.js"></script>
	<script type="text/javascript" src="js/script.js"></script>
	</head>

	<body>
		<header>
			<h1 id="top_title">
				<image id="main_img" src="images/blood.png"/>
				<div id="title_text">Blood Donation System</div>
			</h1>
			<div class="button_div">
				<form method="GET" action=''>
					<button type="submit" id="update" name="update">Update</button>
				</form>
			</div>
		</header>
		<div class="operation">
			<div class="toggler">
				<button id="search">Search</button>
				<button id="add_entry">Add Entry</button>
				<!--<button id="edit_entry">Edit Entry</button>-->
			</div>
			<div class="search_tab">
				<div class="form-wrapper cf">
					<image id="search_icon" src="images/search.png"/>
					<form method="GET" action=''>
					<select type="text" class="select" name="by" required="true">
						<option selected="selected" disabled="true" value="">--Select by--</option>
						<option value="Name">Donor Name</option>
						<option value="City">Branch City</option>
						<option value="Blood_Type">Blood Type</option>
					</select>
					<input type="text" class="srch" name="query" placeholder="Search here..." required="true"/>
					<button type="submit" name="find">Search</button>
					</form>
				</div>
			</div>
			<div class="add_tab">
				<div class="form-wrapper cf">
					<form method="GET" id="add_form" action=''>
					<!--<input type="text" name="d_id" class="fields" placeholder="Donor ID" required="true"/>-->
					<input type="text" name="name" class="fields" placeholder="Name" required="true"/>
					<input type="text" name="blood_type" class="fields" placeholder="Blood Type" required="true"/>
					<input type="text" name="contact_no" class="fields" placeholder="Contact Number" required="true"/>
					<input type="text" name="city" class="fields" placeholder="City" required="true"/>
					<input type="text" name="last_donated" class="fields" placeholder="Last date when blood donated (YYYY-MM-DD)" required="true"/>
					<button type="submit" name="add">Add</button>
					<div class="result_title" id="add">Entry added successfully</div>
					</form>
				</div>
			</div>
		</div>
		<footer>
		  <p>All trademarks are properties of their respective owners. © 2015 - Jay Panchal & Milan Patel. All rights reserved.</p>
		</footer>
	</body>
	<div class="query_results" id="results_container">
	<?php
		include 'php/connect.php';
		include 'php/ChromePhp.php';
		if(isset($_GET['update']))
		{
			$sql = "CALL `Change_availability`()";
			$conn->query($sql);
		}
		/*else if(isset($_GET['add']))
		{
			$d_id = mysqli_real_escape_string($conn,$_GET['d_id']);
			$name = mysqli_real_escape_string($conn,$_GET['name']);
			$blood = mysqli_real_escape_string($conn,$_GET['blood_type']);
			$contact = mysqli_real_escape_string($conn,$_GET['contact_no']);
			$city = mysqli_real_escape_string($conn,$_GET['city']);
			$last = mysqli_real_escape_string($conn,$_GET['last_donated']);
			$sql = ("INSERT INTO `donor`(`d_id`, `name`, `blood_type`, `contact_no`, `city`, `last_donated`) VALUES('".$d_id."','".$name."','".$blood."','".$contact."','".$city."','".$last."')");
			if ($conn->query($sql) === TRUE) {
				echo "<div class='result_title'>New Record added successfully</div>";
			} 
			else {
				echo "<div class='result_title'>Error: ".$conn->error."</div>";
				//echo "Error: " . $sql . "<br>" . $conn->error;
			}
		}*/
		else if(isset($_GET['find']))
		{
			$by = mysqli_real_escape_string($conn,$_GET['by']);
			$query = mysqli_real_escape_string($conn,$_GET['query']);
			
			if($by == "Blood_Type") {
				$sql = "select b_id, City, available from branch, blood_sample where Branch_Id = b_id AND blood_type = '".$query."' order by b_id";
				$result = $conn->query($sql);
				if ($result->num_rows > 0) {
					echo "<div class='result_title'>Availability of ".$query." blood</div>";
					echo "<table class=\"results\">";
					echo "<tr><td>Branch ID</td><td>Availability</td></tr>";
					while($row = $result->fetch_assoc()) {
						echo "<tr><td>" . $row["b_id"]. "</td><td>" . $row["available"] ."</td></tr>";
					}
					echo "</table>";
				} 
				else {
					echo "<div class='result_title'>0 rows in result</div>";
				}
			}
			else if($by == "Name") {
				$sql = "select d_id, name, blood_type, contact_no, city, last_donated from donor where name = '" .$query. "'";
				$result = $conn->query($sql);
				if ($result->num_rows > 0) {
					echo "<div class='result_title'>Details of donor ".$query."</div>";
					echo "<form class='res_form' method='GET'><table class=\"results\">";
					echo "<tr><td>Donor ID</td><td>Name</td><td>Blood Type</td><td>Contact No.</td><td>City</td><td>Last Donated</td><td>Update/Delete</td></tr>";
					while($row = $result->fetch_assoc()) {
						//echo "<tr><td>" . $row["d_id"]. "</td><td>" . $row["name"]. "</td><td>" . $row["blood_type"] ."</td><td>" . $row["contact_no"] ."</td><td>" . $row["city"] ."</td><td>" . $row["last_donated"] ."</td></tr>";
						echo "<tr><td><span type='text' id='up_d_id' name='up_d_id'>" . $row["d_id"]. "</span></td><td><span contenteditable type='text' id='up_name' name='up_name'>" . $row["name"]. "</span></td><td><span contenteditable type='text' id='up_blood_type' name='up_blood_type'>" . $row["blood_type"] ."</span></td><td><span contenteditable type='text' id='up_contact_no' name='up_contact_no'>" . $row["contact_no"] ."</span></td><td><span contenteditable type='text' id='up_city' name='up_city'>" . $row["city"] ."</span></td><td><span contenteditable type='text' id='up_last_donated' name='up_last_donated'>" . $row["last_donated"] ."</span></td><td class=\"update_box\"><button class='done' name='done' type='submit' title='Update this entry'>&#10003</button><button class='delete' name='delete' type='submit' title='Delete this entry'>x</button></td></tr>";
					}
					echo "</form></table>";
				} 
				else {
					echo "<div class='result_title'>0 rows in result</div>";
				}
			}
			else {
				$sql = "select b_id, blood_type, available from branch, blood_sample where branch.b_id=blood_sample.branch_id and branch.city in (select city from branch where city='$query') order by b_id";
				$result = $conn->query($sql);
				if ($result->num_rows > 0) {
					echo "<div class='result_title'>Branches in the city ".$query." have below blood collection</div>";
					echo "<table class=\"results\">";
					echo "<tr><td>Branch ID</td><td>Blood Type</td><td>Availability</td></tr>";
					while($row = $result->fetch_assoc()) {
						echo "<tr><td>" . $row["b_id"]. "</td><td>" . $row["blood_type"]. "</td><td>" . $row["available"] ."</td></tr>";
					}
					echo "</table>";
				} 
				else {
					echo "<div class='result_title'>0 rows in result</div>";
				}
			}
		}
		$conn->close();
	?>
	</div>
</html>
