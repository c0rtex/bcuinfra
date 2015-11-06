<?php
 
function parseIt ($xmlString){

$xmlStringObject = simplexml_load_string($xmlString);


$id = $xmlStringObject->id;
$firstName = $xmlStringObject->first_name;
$lastName = $xmlStringObject->last_name;
$externalId = $xmlStringObject->external_id;
$responseStatus = $xmlStringObject["status"]; //gotten like this because it is an attr of the the root of the xml object; else $responseRequestId = $xmlStringObject->response->attributes()->request_id;
//$responseStatus = $xmlStringObject->response->attributes()->status;
//$responseRequestId = $xmlStringObject->response->attributes()->request_id;
$responseRequestId = $xmlStringObject["request_id"];

//echo "<br/>";
//echo "Response status is: "+$responseStatus;


if ($responseStatus=='error') {

//return "error";
return array('status'=>'error');
}

else if ($responseStatus=='success'){

//return "success";
return array('status'=>'success','id'=>$id);
}

else {
//return "otherError";
return array('status'=>'error');

}


}

?>
