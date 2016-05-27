<?PHP
require_once('CachedSoapClient.php');
if (QA == 1){
$subdomain = 'redesign';
$esiprod = 0;
}
else
{
//prod values overwritten
$subdomain = 'www';
$esiprod = 0;
}

$url = "https://".$subdomain.".benefitscheckup.org/util/remotescreening_3_8.cfc?WSDL";

//cache or no cache
$soapClient = new CachedSoapClient($url, array('cache_wsdl' => WSDL_CACHE_NONE));
//$soapClient = new CachedSoapClient($url, array('cache_wsdl' => WSDL_CACHE_BOTH), $subsetID, doScreening);

?>
