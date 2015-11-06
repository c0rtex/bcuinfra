
		<?php 

$subsetID = '75';
require_once('soap_client_old.php');

$shipContent_arrayObject = $soapClient->getShipContentObject('10001');
echo "<pre>";
echo "SHIP content";
print_r ($shipContent_arrayObject);
?>
		
						
		
	
