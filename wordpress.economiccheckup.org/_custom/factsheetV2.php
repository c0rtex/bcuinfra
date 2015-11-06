<?PHP
require_once('displaycontent.php');

$src = '';
$sr = 1;
$content_title_override = '';
$mode = 'show';
$program_id = 127;
$zip = 0;
$county = '';
$city = '0';
$state_id = '';
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

$query_programContent =
"
SELECT
program.program_id,
program.programcategory_id,
program.programgroup_id,
program.state_id,
program.program_code,
program.name_display_id,
program.desc_display_id, 
program.url,
dl2.language_id,
dl2.display_text as program_name,
dl1.display_text as program_desc
FROM
program
INNER JOIN display_language dl1 ON program.desc_display_id = dl1.display_id
INNER JOIN display_language dl2 ON program.name_display_id = dl2.display_id
and program.program_id = ".$program_id."
and dl2.language_id = 'EN'
limit 1
";
 $programContent_query = $bcudb->get_results($query_programContent);
 foreach ( $programContent_query as $progObj) :
	$program_name = $progObj->program_name;
	$program_desc = $progObj->program_desc;  
	$program_url = $progObj->url;     
//https://redesign.benefitscheckup.org/cf/frmDetails.cfm?prg_id=101-302-1023-FD-FD&src=elig&sr=1&county=DAKOTA&city=0&zip=55124*/
echo "
<script language='javascript'>
	function lookup(i) {
    	var d =open(i, 'Glossary', 'width=400,height=300,status=no,toolbar=no,menubar=no');
	}
</script>
     <div class='span8' id='printContent'>  
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
 require_once('factsheet/howhelp.php');					
 require_once('factsheet/entrypoint.php'); 
 require_once('factsheet/requiredmaterial.php');
 require_once('factsheet/appform.php');
 echo '				                   
                </fieldset>
            </form>
        </div>
    </section>
</div> <!--span8-->
<div class="span3">
   	<div class="well sidebar-nav" >
        <legend><i class="icon-list-alt "></i> Fact Sheet</legend>
        <ol class="nav nav-list">
            <li class=""><a href="#howhelp"><i class="icon-question-sign "></i> Program Description </a></li>
            <li class=""><a href="#moreinfo"><i class="icon-building "></i> Offices </a></li>
	     	<li class=""><a href="#materials"><i class="icon-check "></i> Required Materials </a></li>
';

if ($formcount > 0) {                      
echo '
            <li class=""><a href="#appforms"><i class="icon-file-alt "></i> Application Form(s) </a></li>
';
}
echo '
        </ol><br>
        <legend><i class="icon-file-alt "></i> Resources</legend>
        <ol class="nav nav-list">
';
$program_url = trim($program_url);
 if (!empty($program_url)){
 echo '	     <li><a href="'.$program_url.'" target="_blank"><i class="icon-link "></i> Program Website </a></li>';
 } 	
 if ($isOnlineApp){ 
  echo '	     <li><a href="'.$appLink.'" target="_blank"><i class="icon-laptop "></i> Online Form </a></li>';
 }
 echo '            <li><a data-toggle="modal" role="button" href="#" onClick="javascript:PrintDiv();"><i class="icon-print "></i> Printable Fact Sheet </a></li>';
echo '
        </ol>		
    </div>	  
</div>
';

 endforeach;
?>
