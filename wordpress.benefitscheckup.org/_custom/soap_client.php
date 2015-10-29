<?PHP
require_once('CachedSoapClient.php');

$url = "https://".$_SERVER['SERVER_NAME']."/util/remotescreening_3_7.cfc?WSDL";
//cache or no cache
//$soapClient = new CachedSoapClient($url, array('cache_wsdl' => WSDL_CACHE_NONE));
$soapClient = new CachedSoapClient($url, array('cache_wsdl' => WSDL_CACHE_BOTH), $subsetID, doScreening);

?>
