<?php
/*$xmlString = '<response status="success" request_id="2323422">

  <id>3432325</id>

  <first_name>John</first_name>

  <last_name>Doe</last_name>

  <external_id>A923992</external_id>

</response>'; */

$xmlString = '<response status="error" request_id="2323422">

  <first_name>John</first_name>

  <last_name>Doe</last_name>

  <external_id>A923992</external_id>
<errors>
<error code="" field="">Failed City Check</error>
</errors>

</response>'; 

 
$xmlStringObject = simplexml_load_string($xmlString);


$id = $xmlStringObject->id;
$firstName = $xmlStringObject->first_name;
$lastName = $xmlStringObject->last_name;
$externalId = $xmlStringObject->external_id;
$responseStatus = $xmlStringObject["status"]; //gotten like this because it is an attr of the the root of the xml object; else $responseRequestId = $xmlStringObject->response->attributes()->request_id;
$responseRequestId = $xmlStringObject["request_id"];

print "id:   $id\n";
print "<br>";
print "\nFirst Name:   $firstName";
print "<br>";
print "Last Name:   $lastName";
print "<br>";
print "External Id:   $externalId";
print "<br>";
print "Response Status:   $responseStatus";
print "<br>";
print "Response request_id:   $responseRequestId";

print "<br>";
print "<br>";

if ($responseStatus=='error') {


print "Errors:";
print "<br>";

foreach ($xmlStringObject->errors->error as $error) {

print "Error: $error";
print "<br>";

}





}


print "<br>";
print " The original xml object as loaded by simplexml_load_string(): <pre>"; var_dump($xmlStringObject); echo "</pre>";

?>
