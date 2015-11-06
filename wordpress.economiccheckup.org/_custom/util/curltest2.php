<?php

$postfields = array(urlencode('custom_1')=>urlencode('ncoa-api'), urlencode('Lead priority')=>urlencode('2'), urlencode('username')=>urlencode('ncoa1'), urlencode('password')=>urlencode('ncoapswd'), urlencode('first_name')=>urlencode('Samantha'), urlencode('last_name')=>urlencode('Huntley-Robinson'), urlencode('birthdate')=>urlencode('1944-01-23'), urlencode('address_1')=>urlencode('151 S. Davis St.'), urlencode('city')=>urlencode('San Francisco'), urlencode('state_province')=>urlencode('CA'), urlencode('zip_postal_code')=>urlencode('94114'), urlencode('phone_number')=>urlencode('(123)456-7890'));


//foreach($postfields as $key => $value)
//{
 // echo $key." has the value". $value;
//echo '<br>';
//}

$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, 'https://ahnleads-qc.aon.com/create');
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_HEADER, true);
curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
curl_setopt($ch, CURLOPT_POST, 1);
curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($postfields));
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 2);
$result = curl_exec($ch);
echo $result;

if(curl_exec($ch) === false)
{
    echo 'Curl error: ' . curl_error($ch);
}
else
{
    echo 'Operation completed without any errors';
}
curl_close($ch);

?>
