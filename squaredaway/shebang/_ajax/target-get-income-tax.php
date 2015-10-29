<?php
	include('connect.php');
	$hh = intval($_POST['hh_earnings']);
	$married = $_POST['married'];
	$retired = $_POST['retired'];
	$field = 'ret_single';
	if ($married && $retired){
		$field = 'ret_married';
	} else if ($married && !$retired){
		$field = 'work_married';
	} else if (!$married && !$retired){
		$field = 'work_single';
	}
	$query = "SELECT $field FROM pln_target_income_tax WHERE hh_earnings = $hh";
	//echo $query;
	$result = mysql_query($query);
	$row = mysql_fetch_array($result);
	echo $row[0];
	mysql_close();