<?PHP
if (isset($_GET["subset_id"])){
$subsetID = htmlspecialchars($_GET["subset_id"]);
}
else {
 $subsetID = 79;
}
require_once('soap_client.php');
require_once('displaycontent_mqc_4.php');

$src = '';
$sr = 1;
$content_title_override = '';
$mode = 'show';
$program_id = 127;
$zip = 10022;
$county = 'New York';
$city = 'New York';
$state_id = 'NY';
$lang = 'EN';
// Set Program ID
if(isset($_GET['program_id']) and ($_GET['program_id'] != '')){$program_id = $_GET['program_id'];}
// Set language
if(isset($_GET['lang']) and ($_GET['lang'] != '')){$language = $_GET['lang'];}
else {$language = 'EN';}
// Set zip
if(isset($_GET['zip']) and ($_GET['zip'] != '')){$zip = $_GET['zip'];}
// Set state
//$qry_getSTATE = "select state_id from zip where zipcode= ".$zip;
//$state_id = mysql_query($qry_getSTATE);
// Set county
if(isset($_GET['county']) and ($_GET['county'] != '')){$county = $_GET['county'];}
// Set city
if(isset($_GET['city']) and ($_GET['city'] != '')){$city = $_GET['city'];}
$passMode = 'screen';
$passNumber = 0;
// Set passCounty
if(isset($county) and ($county != '0')){ $passCounty = $county;}
else {$passCounty = '';}
// Set passState
if(isset($_GET['state_id']) and ($_GET['state_id'] != '')){$state_id = $_GET['state_id'];}
if(isset($state_id)){ $passState = $state_id;}		
else{ $passState = '';}
// Set passZip
if(isset($zip) and strcmp($zip, '0') and strcmp($zip, '00000')){$passZip = $zip;}		
else{ $passZip = '';}
// Get Program Row
//echo "Program ID for testing:".$program_id;
//Session ID
if(isset($_SESSION['screeningID'])){$screeningID = $_SESSION['screeningID'];}
if(isset($_GET['screeningID'])){$screeningID = $_GET['screeningID'];}
//shadow ID
$shadowID = 0;
if(isset($_SESSION['shadowID'])){$shadowID = $_SESSION['shadowID'];}
if(isset($_GET['shadowID'])){$shadowID = $_GET['shadowID'];}

$programContent_query = $soapClient->getProgramContent($program_id);
//$programContent_query = restructureWSArray($programContent_query);
 foreach ( $programContent_query as $progObj) :
	$program_name = $progObj["PROGRAM_NAME"];
	$program_desc = $progObj["PROGRAM_DESC"];  
	$program_url = $progObj["URL"];     
//https://redesign.benefitscheckup.org/cf/frmDetails.cfm?prg_id=101-302-1023-FD-FD&src=elig&sr=1&county=DAKOTA&city=0&zip=55124*/
echo "
<script language='javascript'>
	function lookup(i) {
    	var d =open(i, 'Glossary', 'width=400,height=300,status=no,toolbar=no,menubar=no');
	}
</script>
     <div class='span8'>  
	<section id='factsheet'>  	
        <div class='body-header-wrapper'>	<h2><i class='icon-book '></i> Fact Sheet </h2>	
            <div class='body-header' style='z-index: 999; position: static; top: 251.5px;'>
                <div class='body-header-inner'>
                    <div class=''>
                            
                    </div>
                </div>
            </div>
            <div style='display: none; width: 620px; height: 0px; float: none;'></div>
        </div>
        <div class=''>
            <h4></h4>
        </div>
        <div class=''>
            <form class='whitewell'>
                <fieldset>
                    <legend><i class='icon-list-alt '></i> ".$program_name."</legend>                       
";  
             
 require_once('factsheet/howhelp_mqc_4.php');					
 require_once('factsheet/entrypoint_mqc_4.php'); 
 require_once('factsheet/requiredmaterial_mqc_4.php');
 require_once('factsheet/appform_mqc_4.php');
 echo '				                   
                </fieldset>
            </form>
        </div>
    </section>
</div> <!--span8-->

<div class="span3">
   	<div class="well sidebar-nav" >
        <legend><i class="icon-list-alt "></i> Your Fact Sheet</legend>
        <ol class="nav nav-list">
            <li class=""><a href="#howhelp"><i class="icon-question-sign "></i> General Information </a></li>
            <li class=""><a href="#moreinfo"><i class="icon-building "></i> Offices </a></li>
	     	<li class=""><a href="#materials"><i class="icon-check "></i> Required Materials </a></li>
';
  
    
 if ($formcount > 0){
 echo '	     <li class=""><a href="#appforms"><i class="icon-file-alt "></i> Application Form(s) </a></li>';
 } 
echo '
        </ol><br>
        <legend><i class="icon-file-alt "></i> Resources</legend>
        <ol class="nav nav-list">
';
 if ($program_url !== ''){
 echo '	     <li><a href="'.$program_url.'" target="_blank"><i class="icon-link "></i> Program Website </a></li>';
 } 	
 if ($isOnlineApp){ 
  echo '	     <li><a href="'.$appLink.'" target="_blank"><i class="icon-laptop "></i> Online Form </a></li>';
 }
 echo '            ';
 if(isset($screeningID)){echo '            <li><a data-toggle="modal" role="button" href="/mqc-results?screeningID='.$screeningID.'&shadowID='.$shadowID.'"><i class="icon-circle-arrow-left "></i> Back to Your Report </a></li>';
 }
echo '
        </ol>		
    </div>	  
</div>
';
 endforeach;
?>
