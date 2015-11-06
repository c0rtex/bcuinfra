<?php
$cfid = $_GET['cfid'];
$cftoken = $_GET['cftoken'];
if(isset($_GET['template']))
{
$template = $_GET['template'];
}
else
{
$template = "";
}
if( 1 == 1 ) //scrub user input to check for sql injection
{
$ch = curl_init("https://redesign.benefitscheckup.org/cf/cfKeepAlive.cfm?cfid=".$cfid."&cftoken=".$cftoken); //test url
curl_setopt($ch, CURLOPT_RETURNTRANSFER,true); // return into a variable
curl_setopt($ch, CURLOPT_HEADER, true);
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, TRUE);
curl_setopt($ch, CURLOPT_FOLLOWLOCATION, TRUE);
curl_setopt($ch, CURLOPT_POST, true);	
}
else
{
	echo "Invalid cfid cftoken";
	exit;
}

if ($template == "") {
//Keep CF Session Alive
	$page = curl_exec($ch);
	//$cookiejar = get_cookie($page);
	//curl_setopt($ch, CURLOPT_COOKIE, $cookiejar);
	//print_r(http_parse_headers($headers));
	echo $page;
	//echo $cookiejar
}
else {
$url = "https://redesign.benefitscheckup.org/cf/cfKeepAlive.cfm?cfid=".$cfid."&cftoken=".$cftoken."&template=".$template;
echo "<meta HTTP-EQUIV='REFRESH' content='0;url=$url'>";
//$ch = curl_init("https://redesign.benefitscheckup.org/cf/cfKeepAlive.cfm?cfid=".$cfid."&cftoken=".$cftoken."&template=".$template); //redirect somewheres
//$page = curl_exec($ch);
}
?>
