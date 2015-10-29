<?php
	define('DB_NAME', 'squaredaway_local');

	/** MySQL database username */
	define('DB_USER', 'root');

	/** MySQL database password */
	define('DB_PASSWORD', 'root');

	/** MySQL hostname */
	define('DB_HOST', 'localhost');
	
	mysql_connect(DB_HOST, DB_USER, DB_PASSWORD) or die(mysql_error());
	mysql_select_db(DB_NAME);
	
	

?>

