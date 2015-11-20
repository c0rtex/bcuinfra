<?PHP
require_once('CachedSoapClient.php');
if (QA = 0){
$subdomain 'www';
$esiprod = 1;
}
else
{
$subdomain 'redesign';
$esiprod = 0;
}

$url = "https://".$subdomain.".benefitscheckup.org/util/remotescreening_3_7.cfc?WSDL";
//cache or no cache
//$soapClient = new CachedSoapClient($url, array('cache_wsdl' => WSDL_CACHE_NONE));
$soapClient = new CachedSoapClient($url, array('cache_wsdl' => WSDL_CACHE_BOTH), $subsetID, doScreening);

?>
