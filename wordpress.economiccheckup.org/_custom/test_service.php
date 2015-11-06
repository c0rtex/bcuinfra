<?php
require_once('_custom/soap_client_test.php');
  $subsetId = $_GET['subset_id'];
  print_r(new DateTime);
  $query = $soapClient->getQuestionDependencies1($subsetId);
  print_r($query);
  print_r(new DateTime);
?>