<?php
//echo " Program ID for testing: ".$program_id;
//echo " State ID for testing: ".$state_id;
//echo " City for testing: ".$city;
//echo " County for testing: ".$county;
//echo " Zip for testing: ".$zip;
$city = '';
$county = urlencode($county);
$urlstring = "https://redesign.benefitscheckup.org/cf/util/showep.cfm?program_id=".$program_id."&county=".$county."&state_id=".$state_id."&city=".$city."&zip=".$zip;
//echo $urlstring ;
$ch = curl_init("https://redesign.benefitscheckup.org/cf/util/showep.cfm?program_id=".$program_id."&county=".$county."&zip=".$zip."&state_id=".$state_id."&city=".$city.""); //test url
curl_setopt($ch, CURLOPT_RETURNTRANSFER,true); // return into a variable
curl_setopt($ch, CURLOPT_HEADER, false);
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, TRUE);
curl_setopt($ch, CURLOPT_FOLLOWLOCATION, TRUE);
curl_setopt($ch, CURLOPT_POST, true);
	$page = curl_exec($ch);
	if ($nodirectepoutput !== 1){
	echo $page;
	}
?>
