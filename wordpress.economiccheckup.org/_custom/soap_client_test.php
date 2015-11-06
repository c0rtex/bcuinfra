<?PHP
require_once('CachedSoapClient.php');

$url = "https://redesign.benefitscheckup.org/util/remotescreening_3_3.cfc?WSDL";
//cache or no cache
//$soapClient = new CachedSoapClient($url, array('cache_wsdl' => WSDL_CACHE_NONE));
$soapClient = new CachedSoapClient($url, array('cache_wsdl' => WSDL_CACHE_BOTH), $subsetID, doScreening);

//Lynna Cekova: restructure the array returned by the ws, so that keys (db columns) go with the respective values for each question
function restructureWSArray ($sectionQuestion_wsArray){

    $wsArrayTitles = $sectionQuestion_wsArray->columnList;
    $wsArrayData = $sectionQuestion_wsArray->data;

    $sectionQuestion_wsArray2 = array(); //reuse the variable for the array that will hold arrays with keys and values for the db fields

    foreach ($wsArrayData as $key=>$value) {
        $newArrayRow = array();
        foreach ($value as $key1=>$value1) {
            $newArrayRow[$wsArrayTitles[$key1]] = $value1;
        }
        $sectionQuestion_wsArray2[$key] = $newArrayRow;
    }

    return $sectionQuestion_wsArray2;
}


?>
