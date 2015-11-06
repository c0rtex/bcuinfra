<?php

function getCurlResponse ($postfields, $url){

//$postfields = array('profile_id'=>'ncoa-api','shared_lead'=>'2', 'username'=>'ncoa1', 'password'=>'ncoapswd', 'first_name'=>'Jane', 'last_name'=>'Smith', 'birthdate'=>'1944-01-23', 'address_1'=>'17 Test St.', 'city'=>'San Francisco', 'state_province'=>'CA', 'zip_postal_code'=>'94114', 'phone_number'=>'(123)456-7890');

//$string=implode(",", $postfields);
//echo $string;

//echo "LA LA LA";

$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, $url);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
//curl_setopt($ch, CURLOPT_HEADER, false);
curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
curl_setopt($ch, CURLOPT_POST, 1);
curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($postfields));
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 2);
curl_setopt($ch, CURLOPT_FRESH_CONNECT, 1);
//curl_setopt($ch, CURLOPT_SSLVERSION, 3);
//curl_setopt($ch, CURLOPT_SSL_CIPHER_LIST, 'TLSv1');
$result = false;

$result = curl_exec($ch);

//echo '<br/>';
//echo '<br/>';
//echo (http_build_query($postfields));
//echo '<br/>';
//echo '<br/>';
//echo $result;

//if(curl_exec($ch) === false)
//{

    //echo 'Curl error: ' . curl_error($ch);
//}
//else
//{
//echo '<br/>';
//echo '<br/>';
    //echo 'Operation completed without any errors';
//}

curl_close($ch);

return $result;

}

?>
