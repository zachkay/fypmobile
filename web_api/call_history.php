<?php
$db = mysqli_connect('localhost','root','','budee');
if (!$db) 
{
    echo "Database connection failed";
}

$id = $_GET["id"];
$query = $db->query(" SELECT * FROM calculation_data WHERE user_id='$id'");
$result = array();

	while ($rowData = $query->fetch_assoc()) {
		$result[] = $rowData;
	}

    echo json_encode($result);
?>