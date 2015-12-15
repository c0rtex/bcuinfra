<?PHP
require_once('CachedSoapClient.php');
if (QA == 1){
$subdomain = 'redesign';
$esiprod = 0;
}
else
{
$subdomain = 'www';
$esiprod = 1;
}

$url = "https://".$subdomain.".benefitscheckup.org/util/remotescreening_3_7.cfc?WSDL";

//cache or no cache
//$soapClient = new CachedSoapClient($url, array('cache_wsdl' => WSDL_CACHE_NONE));
$soapClient = new CachedSoapClient($url, array('cache_wsdl' => WSDL_CACHE_BOTH), $subsetID, doScreening);

?>
