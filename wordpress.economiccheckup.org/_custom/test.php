<?php


function get_web_page($url) {
    $options = array (CURLOPT_RETURNTRANSFER => true, // return web page
    CURLOPT_HEADER => true, // don't return headers
    CURLOPT_FOLLOWLOCATION => true, // follow redirects
    CURLOPT_ENCODING => "", // handle compressed
    CURLOPT_USERAGENT => "Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2 GTB5", // who am i
    CURLOPT_AUTOREFERER => true, // set referer on redirect
    CURLOPT_CONNECTTIMEOUT => 120, // timeout on connect
    CURLOPT_TIMEOUT => 120, // timeout on response
    CURLOPT_MAXREDIRS => 10,
    CURLOPT_SSL_VERIFYPEER => false,
    CURLOPT_SSLVERSION => 3,
    CURLOPT_SSL_VERIFYHOST => 0 );
    $ch = curl_init ( $url );
    curl_setopt_array ( $ch, $options );
    $content = curl_exec ( $ch );
    $err = curl_errno ( $ch );
    $errmsg = curl_error ( $ch );
    $header = curl_getinfo ( $ch );
    $httpCode = curl_getinfo ( $ch, CURLINFO_HTTP_CODE );

    curl_close ( $ch );

    $header ['errno'] = $err;
    $header ['errmsg'] = $errmsg;
    $header ['content'] = $content;
    echo $err;
    echo $errmsg;
    echo $content;
    return $header ['content'];
}

$response = get_web_page("https://ahnleads-prod.aon.com/create");
#$response = get_web_page("https://www.newcitymedia.net");
$resArr = array();
$resArr = json_decode($response);
//echo "<pre>"; print_r($resArr); echo "</pre>";
#echo "DONE $response";
//phpinfo();

$ch = curl_init();

curl_setopt($ch, CURLOPT_URL,"https://ahnleads-prod.aon.com/create");
#curl_setopt($ch, CURLOPT_URL,"https://www.newcitymedia.net");
curl_setopt($ch, CURLOPT_POST, 1);
curl_setopt($ch, CURLOPT_POSTFIELDS,
            "profile_id=ncoa-api&shared_lead=2&username=ncoa_prod&password=95wndflkfhJajaia%24Z8&first_name=test&last_name=test&birthdate=1949-03-04&address_1=ncoa+address&city=ncoa+city&state_province=NY&zip_postal_code=11234&phone_number=%28111%29222-4444&electronic_address=test%40test.com");

// in real life you should use something like:
// curl_setopt($ch, CURLOPT_POSTFIELDS, 
//          http_build_query(array('postvar1' => 'value1')));

// receive server response ...
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

$server_output = curl_exec ($ch);

print "response:".$server_output;

curl_close ($ch);

// further processing ....
if ($server_output == "OK") { echo "OK "; } else { echo "BAD"; echo $server_output; }




?>
