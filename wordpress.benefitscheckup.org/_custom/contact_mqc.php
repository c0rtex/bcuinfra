
<script type="text/javascript">
var axel = Math.random() + "";
var a = axel * 10000000000000;
document.write('<iframe src="https://4381487.fls.doubleclick.net/activityi;src=4381487;type=NewTe0;cat=Conta0;ord=1;num=' + a + '?" width="1" height="1" frameborder="0" style="display:none"></iframe>');
</script>
<noscript>
<iframe src="https://4381487.fls.doubleclick.net/activityi;src=4381487;type=NewTe0;cat=Conta0;ord=1;num=1?" width="1" height="1" frameborder="0" style="display:none"></iframe>
</noscript>
<?PHP
$_SESSION['CID'] = 0;
require_once('displaycontent.php');

$src = '';
$sr = 1;
$content_title_override = '';
$mode = 'show';
$program_id = 127;
$zip = 0;
$county = '';
$city = '';
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

echo "
     <div class='span7' id='printContent'>  
	<section id='summary'>  	
       
        <div class='whitewell'>
      

                    <legend><i class='icon-list-alt '></i> What Happens Next</legend>   
<div>
                       <p>Fill out this form if you would like a Benefits Advisor, who is a licensed insurance agent, to call you to discuss your coverage options. This service is available at no charge to you, you only pay for the insurance you purchase, and your information will not be given to any outside parties. A representative of Aon Retiree Health Exchange&#0153; will return your call within one business day.</p>                    
                

	</div>			                   
               
       
        </div>
    </section>
	<section id='contact'>  	
        <div class='body-header-wrapper'>	<h2><i class='icon-user-md '></i> Contact Aon Retiree Health Exchange&#0153; </h2>	
            
            <div style='display: none; width: 620px; height: 0px; float: none;'></div>
        </div>
        
";
//get contact form and display
if (isset($_GET['CID'])) {
$_SESSION['CID'] = $_GET['CID'];
}
require_once "screening_user_body.php";
echo "
    </section>
";  
//affinity tracking

$tty = 'Dial 711';
$phone = '1-800-975-9655';
if (isset($_SESSION['CID'])) {

//
if ($_SESSION['CID'] == '27') {
$tty = '888-555-OUCH';
$phone = '800-555-OUCH';
}

//
if ($_SESSION['CID'] == '381') {
$tty = '888-555-1212';
$phone = '800-555-1212';
}
//apple
if ($_SESSION['CID'] == '111111-1') {
$tty = '888-111-1111';
$phone = '877-111-1111';
}

//Sample Partner
if ($_SESSION['CID'] == '00-0') {
$tty = '888-555-1212';
$phone = '800-555-1212';
}
//Sample Partner
if ($_SESSION['CID'] == '2') {
$tty = '888-555-1212';
$phone = '800-555-1212';
}

}
else {
$tty = 'Dial 711';
$phone = '1-800-975-9655';
}

echo '
</div> <!--span8-->
<div class="span4">
<div class="well sidebar-nav" >
        <legend><i class="icon-list-alt "></i> Resources</legend>
        <ol class="nav nav-list">
            <li class="active"><a href="#summary"><i class="icon-file"></i> Summary </a></li>
	      	<!--li class=""><a href="#contact"><i class="icon-user-md"></i> Contact A Licensed Insurance Agent </a></li -->
		<li class=""><a href="#consent"><i class="icon-ok"></i>Terms & Conditions</a></li>
            <li><a data-toggle="modal" role="button" href="#" onClick="javascript:PrintDivMMM();"><i class="icon-print "></i> Print a Copy</a></form></li>
        </ol><br>	
<div >
<div class="well">
<div align=left>
       <img src="/cf/img/womanwithheadset2.jpg" alt="Speak to a Licensed Insurance Agent" />
       <p>If you'."'".'d like to speak to a licensed insurance agent from <strong>Aon Retiree Health Exchange&#0153;</strong>, call: '.$phone.' (TTY Dial '.$tty.').</p>
       <p> Hours: Monday-Friday, 7 a.m. - 10 p.m. (CST). Closed on holidays.</p>
       <p><a href="https://www.mymedicarematters.org/about/ncoa-mymedicarematters-aon-hewitt-navigators/" target="_new">Learn more</a> about Aon Retiree Health Exchange and why NCOA recommends them.</p>
</p>
</div>
</div><!--close sidebarnav-->	

</div></div>
';
?>