<?php 
        // create curl resource 
        $ch = curl_init(); 

        // set url 
        curl_setopt($ch, CURLOPT_URL, "https://secure.ssa.gov/i1020/start"); 

	curl_setopt($ch, CURLOPT_RETURNTRANSFER,true); // return into a variable
	curl_setopt($ch, CURLOPT_HEADER, true);
	curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
	curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, FALSE);
	curl_setopt($ch, CURLOPT_FOLLOWLOCATION, TRUE);
	curl_setopt($ch, CURLOPT_POST, true);
	curl_setopt($ch, CURLOPT_FRESH_CONNECT, 1);
	curl_setopt($ch, CURLOPT_SSLVERSION, 4);
	curl_setopt($ch,CURLOPT_FAILONERROR,true);
        //return the transfer as a string 
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1); 

        // $output contains the output string 
        $output = curl_exec($ch); 

        // close curl resource to free up system resources 
	echo "done<br>";
	echo 'Curl error: ' . curl_error($ch);
	echo 'Curl result: ' . $output;
        curl_close($ch);      
?>
