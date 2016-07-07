<?php

class Logger
{	
	var $logFile;
	var $handle;
	
	function Logger($logFile)
	{
		$this->logFile = $logFile;
		$this->handle = fopen ($logFile, "w"); //Creates FILE
	}
	
	function write($str) 
	{
		fwrite($this->handle, $str);	
		if(QA)
		{
			//echo $str;
		}	   
    }
    
    function close()
    {
    	fclose($this->handle);
    }
}
?>