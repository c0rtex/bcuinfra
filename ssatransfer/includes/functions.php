<?php
function reverse_direction($dir="")
{
	if($dir == "DESC")
	{
		return "ASC"; 
	}
	elseif($dir == "ASC")
	{
		return "DESC"; 
	}
	else //default to desc if no order
	{
		return "DESC"; 
	}
}

//function str_split($str,$length = 1) //used because this function only exists in php5
//{
//   if ($length < 1) return false;
 //  $strlen = strlen($str);
 //  $ret = array();
 //  for ($i = 0; $i < $strlen; $i += $length) {
///     $ret[] = substr($str,$i,$length);
//   }
//   return $ret;
//}

function is_Email($em)
{
    if (preg_match("/^(\w+((-\w+)|(\w.\w+))*)\@(\w+((\.|-)\w+)*\.\w+$)/",$em))
       return true;
    else return false;
}

function get_cookie($page)
{
	$cookiejar = "";
	preg_match_all("/Set\-Cookie\:.*?\;/", $page, $matches);
	foreach ($matches[0] as $cookie) 
	{
		$cookiejar .= str_replace("Set-Cookie: ", "", $cookie).' ';
	}
	return $cookiejar;
}

function pre($array) //used for debugging 
{
	echo "<pre>";
	print_r($array);
	echo "</pre>";
}

function redirect($url, $seconds)
{
	echo "<meta HTTP-EQUIV='REFRESH' content='$seconds;url=$url'>";	
	//echo "<BR><a href='$url'>You are being redirected</a>";
	exit;
}

function pear_error_handler($error)
{   	
	pre($error);   		  
}

function bcu_error_handler($errno, $errstr, $errfile, $errline)
{
	switch ($errno) 
	{
	case E_USER_ERROR:
    	echo "<strong>E_USER_ERROR</strong> [$errno] $errstr $errfile $errline<br />\n";
   		echo "  Fatal error in line $errline of file $errfile";
   		echo ", PHP " . PHP_VERSION . " (" . PHP_OS .")<br />\n";
   		echo "Aborting...<br />\n";
   		exit(1);
   	break;
  	case E_USER_WARNING:
   		echo "<strong>E_USER_WARNING</strong> [$errno] $errstr $errfile $errline<br />\n";
   	break;
  	case E_USER_NOTICE:
   		echo "<strong>E_USER_NOTICE</strong> [$errno] $errstr $errfile $errline<br />\n";
   	break;
  	case E_NOTICE:
   		//echo "<strong>E_NOTICE</strong> [$errno] $errstr $errfile $errline<br />\n";
  	break;
  	default:
   	//	echo "Unkown error type: [$errno] $errstr $errfile $errline<br />\n";
   	break;
	}
}
?>
