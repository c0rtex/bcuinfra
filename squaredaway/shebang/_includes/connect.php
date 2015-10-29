<?php
	define('DB_NAME', 'upstatement_squaredaway');

	/** MySQL database username */
	define('DB_USER', 'upstatement_sq');

	/** MySQL database password */
	define('DB_PASSWORD', 'hopic0ji');

	/** MySQL hostname */
	define('DB_HOST', 'localhost');
	
	mysql_connect(DB_HOST, DB_USER, DB_PASSWORD) or die(mysql_error());
	mysql_select_db(DB_NAME);
	
	

?>

