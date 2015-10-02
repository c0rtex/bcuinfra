<?php

//$postfields = array('profile_id'=>'ncoa-api','shared_lead'=>'2', 'username'=>'ncoa1', 'password'=>'ncoapswd', 'first_name'=>'Jane', 'last_name'=>'Jones', 'birthdate'=>'1944-01-23','address_1'=>'17 Test St.', 'city'=>'San Francisco', 'state_province' => 'CA', 'zip_postal_code'=>'94114', 'phone_number'=>'(123)456-7890');

$postfields = array('profile_id'=>'ncoa-api','shared_lead'=>'2', 'username'=>'ncoa1', 'password'=>'ncoapswd', 'first_name'=>'radarsdadadtest', 'last_name'=>'arradradadarasdad', 'birthdate'=>'1923-01-23','address_1'=>'17 Test St.', 'city'=>'Oswego', 'state_province' => 'NY', 'zip_postal_code'=>'43214', 'phone_number'=>'(000)456-7890');



//$string=implode(",", $postfields);
//echo $string;

$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, 'https://ahnleads-qc.aon.com/create');
#curl_setopt($ch, CURLOPT_URL, 'https://www.newcitymedia.net');
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
//curl_setopt($ch, CURLOPT_HEADER, true);
curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
curl_setopt($ch, CURLOPT_POST, 1);
curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($postfields));
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 2);
$result = curl_exec($ch);
echo '<br/>';
echo '<br/>';
echo (http_build_query($postfields));
echo '<br/>';
echo '<br/>';
echo $result;

if(curl_exec($ch) === false)
{
    echo 'Curl error: ' . curl_error($ch);
}
else
{
echo '<br/>';
echo '<br/>';
    echo 'Operation completed without any errors';
}
curl_close($ch);

?>
