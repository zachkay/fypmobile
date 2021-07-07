<?php
//include 'conn.php';
$db = mysqli_connect('localhost','root','','budee');
if (!$db) 
{
    echo "Database connection failed";
}

$breaker = $db->query(" SELECT * FROM breaker_size");
$cphase = $db->query(" SELECT * FROM cable_phase");
$ctype = $db->query(" SELECT * FROM cable_type");
$cspec = $db->query(" SELECT * FROM cable_spec");
//$list = array();
$list = [];

while ($rowdata= $breaker->fetch_assoc()) {
    $list["breaker"][] = $rowdata;
}
while ($rowdata= $cphase->fetch_assoc()) {
    $list["cphase"][] = $rowdata;
}
while ($rowdata= $ctype->fetch_assoc()) {
    $list["ctype"][] = $rowdata;
}
while ($rowdata= $cspec->fetch_assoc()) {
    $list["cspec"][] = $rowdata;
}
echo json_encode($list);

?>