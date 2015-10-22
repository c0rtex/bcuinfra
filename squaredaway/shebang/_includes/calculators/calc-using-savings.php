<?php

	echo '<link rel="stylesheet" href="/wp-content/themes/shebang/_css/planner-savings-as-a-source-of-retirement-income.css?v=2">';
	
	$path = $_SERVER['DOCUMENT_ROOT'].'/wp-content/themes/shebang/_includes/draw-down/pg1-using-savings-graph.php';
	include($path);
	
	echo '<script type="text/javascript" src="/wp-content/scripts/jquery.total-storage.js"></script>';
	echo '<script type="text/javascript" src="/wp-content/themes/shebang/shebang.js"></script>';
	echo '<script type="text/javascript" src="/wp-content/themes/shebang/js/planner-savings-as-a-source-of-retirement-income-using-your-savings-in-retirement.js"></script>';
	
?>