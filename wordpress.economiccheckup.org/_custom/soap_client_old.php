<?PHP

$url = "https://redesign.benefitscheckup.org/util/remotescreening_3_3.cfc?WSDL";
//cache or no cache
$soapClient = new SoapClient($url, array('cache_wsdl' => WSDL_CACHE_NONE));
//$soapClient = new SoapClient($url, array('cache_wsdl' => WSDL_CACHE_BOTH));

//Lynna Cekova: restructure the array returned by the ws, so that keys (db columns) go with the respective values for each question
function restructureWSArray ($sectionQuestion_wsArray){

$wsArrayTitles = $sectionQuestion_wsArray->columnList;
$wsArrayData = $sectionQuestion_wsArray->data;
//echo "<pre>";
//print_r ($wsArrayData);

$sectionQuestion_wsArray2 = array(); //reuse the variable for the array that will hold arrays with keys and values for the db fields

foreach ($wsArrayData as $questionArray):
$questionArrayKeys = array();
for ($i=0; $i<count($questionArray); $i++) {
$questionArrayKeys[$wsArrayTitles[$i]] = $questionArray[$i]; //this assumes same number of entries in $wsArrayTitles and $questionArray. Considering the titles are db column titles and the other array is the record data, that is indeed the case

}
$sectionQuestion_wsArray2[] = $questionArrayKeys;

endforeach;

//echo "<pre>";
//print_r ($sectionQuestion_wsArray);

return $sectionQuestion_wsArray2;



}


?>
