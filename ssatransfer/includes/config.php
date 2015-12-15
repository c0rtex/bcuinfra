<?php
define("QA", "1");			           // <-- 1 is qa, 0 is production
//define("DB_USER", "cfuser");			           // <-- mysql db user

date_default_timezone_set("America/Los_Angeles");

define("DB_USER", "ssauser");
define("DB_PASSWORD", "awe@CSEf1356qSdfv");               // <-- mysql db password
define("DB_HOST", "172.31.33.46");
define("DATABASE", "mysql");                // Database type
define("DB_NAME", "bcumigration");

define("ROOT_DIR", "/opt/bcu/apps/bcu_code/branch.benefitscheckup.org/code/ssatransfer/"); // root directory
define("WEB_URL",  "https://redesign.benefitscheckup.org/cf/system/"); //root web domain

define("INCLUDES_DIR", ROOT_DIR."includes/");					    // Install Folder
define("SMARTY_DIR", "/opt/bcu/progs/smarty/");		// Smarty Folder put into include path
define("LOG_DIR", "/opt/bcu/apps/bcu_code/other/lis-logs/");		// log directory
define("IMAGES_DIR", WEB_URL."../images/");  // <-- images directory of this site
//define("PEAR_DIR", ROOT_DIR."pear/");				 		// PEAR Folder put into include path
define("STYLESHEET", WEB_URL."css/.css");  // <-- css file for this site
define("JAVASCRIPT_DIR", WEB_URL."javascript/");  // <-- javascript directory for this site
define("CURDATE", date("Y-m-d h:i:s") ); 		// Current Date
define("ADMIN_EMAIL", ""); 	// Webmaster Email address

require_once(INCLUDES_DIR."SetupSmarty.php");  //load Smarty library
//require_once(INCLUDES_DIR."ErrorHandler.php");                 //* if this file not included, error reporting defaults off
require_once("PEAR.php");        //pear db put into include path
require_once("DB.php");        //pear db in the include path
require_once(INCLUDES_DIR."functions.php");           //reused functions
require_once(INCLUDES_DIR."engine.php");           //engine
?>
