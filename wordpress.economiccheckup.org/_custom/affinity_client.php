<?PHP

$url = "https://www.benefitscheckup.org/util/affinity.cfc?WSDL";
$affinityClient = new soapClient($url, array('cache_wsdl' => WSDL_CACHE_NONE));



?>
