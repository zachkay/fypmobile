<?php
include 'conn.php';

$id = $_POST['userid'];
$locA = $_POST['locA'];
$locB = $_POST['locB'];
$estDist = $_POST['estDist'];
$cType = $_POST['cType'];
$cVd = $_POST['cVd'];
$cIz = $_POST['cIz'];
$calcVd = $_POST['calcVd'];
$calcVdPercent = $_POST['calcVdPercent'];
$allowedVd = $_POST['allowedVd'];
$cQty = $_POST['cQty'];
$cPrice = $_POST['cPrice'];
$oPrice = $_POST['oPrice'];

$sqlmax = "SELECT max(id) FROM `user`";
$resultmax = mysqli_query($connect, $sqlmax);
$rowmax = mysqli_fetch_array($resultmax);

if ($rowmax[0] == null) {
    $idnomax = 1;
} else {
    $idnomax = $rowmax[0] + 1;
}

$query = "SELECT * FROM calculation_data WHERE user_id='$id' AND loc_a='$locA' AND loc_b='$locB' AND est_dist='$estDist' 
AND c_type='$cType' AND c_vd='$cVd' AND c_iz='$cIz' AND calc_vd='$calcVd' AND calc_vd_percent='$calcVdPercent' 
AND allowed_vd='$allowedVd' AND c_qty='$cQty' AND c_price='$cPrice' AND o_price='$oPrice'";

$result = mysqli_query($connect, $query);

if (mysqli_num_rows($result) > 0) {
    $json['value'] = 2;
    $json['message'] = ' Calculation data already saved ';
} else {
    $query = "INSERT INTO calculation_data (user_id, date, loc_a, loc_b, est_dist, c_type, c_vd, c_iz, calc_vd, calc_vd_percent, allowed_vd, c_qty, c_price, o_price) 
    VALUES ('$id',CURRENT_TIMESTAMP,'$locA','$locB','$estDist','$cType', '$cVd','$cIz','$calcVd','$calcVdPercent','$allowedVd','$cQty','$cPrice','$oPrice')";

    $inserted = mysqli_query($connect, $query);

    if ($inserted == 1) {

        $json['value'] = 1;
        $json['message'] = 'Calculation data successfully saved';
    } else {
        $json['value'] = 0;
        $json['message'] = 'Fail to save calculation data';
    }
}

echo json_encode($json);
mysqli_close($connect);
