<?php
set_error_handler("bcu_error_handler");
PEAR::setErrorHandling(PEAR_ERROR_CALLBACK, 'pear_error_handler');

$GLOBALS['db'] = DB::connect(DATABASE."://".DB_USER.":".DB_PASSWORD."@".DB_HOST."/".DB_NAME);
if(PEAR::isError($GLOBALS['db'])) 
{
	exit("cannot connect to the database");
}
?>