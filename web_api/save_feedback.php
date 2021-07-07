<?php
include 'conn.php';

$name = $_POST['name'];
$email = $_POST['email'];
$subject = $_POST['subject'];
$feedback = $_POST['feedback'];

$sqlmax = "SELECT max(id) FROM `user`";
$resultmax = mysqli_query($connect, $sqlmax);
$rowmax = mysqli_fetch_array($resultmax);

if ($rowmax[0] == null) {
	$idnomax = 1;
} else {
	$idnomax = $rowmax[0] + 1;
}

$query = "INSERT INTO feedback ( date, name, email, subject, feedback) 
    VALUES (CURRENT_TIMESTAMP,'$locA','$name','$email','$subject', '$feedback')";

$inserted = mysqli_query($connect, $query);

if ($inserted == 1) {

	$json['value'] = 1;
	$json['message'] = 'Feedback sent';
} else {
	$json['value'] = 0;
	$json['message'] = 'Fail to send feedback';
}

echo json_encode($json);
mysqli_close($connect);
