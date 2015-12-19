 


<div class="span8" id="printContent">  
<?php
require_once('_custom/soap_client.php');
//echo '<h3>testing</h3>';
$summarytext = '<p>Below is the information you wanted to learn more about. Click on the name of each program for a description of the benefits, contact information, and application forms (if available). 
</p>
<p>Want to find out if you qualify for these programs and other helpful benefits in your area? Complete a <a href="/cf/frmwelcome2.cfm?subset_id=0&partner_id=0&sc_partner_id=0">Full BenefitsCheckUp Questionnaire</a> to get a personalized report.</p>';
$screeningID = $_GET['screeningID'];
//echo "<br/>";
//echo "<b>Unique ID: ".$screeningID."</b>";
//echo "<br/>";


?>

<h2>BenefitsCheckUp Report</h2>
<?php
echo $summarytext;


?>

<br/>
</section>
<?PHP
require_once('report/report_calculations.php');					 
?>		

	


<div class="printButton printReport">
            <form><a data-toggle="modal" role="button" class="btn btn-large" href="#" onClick="javascript:PrintDiv();"><i class="icon-print "></i> Print Your Report</a></form>
</div>


 
    
</div> <!--span8-->
<div class="span4">
   	<div class="well sidebar-nav " style="z-index: 999; position: static; width:220px; top: 191px;">
        <legend><i class="icon-list-alt "></i> Sections</legend>
        <ol class="nav nav-list">
	    <li id="health_li" class=""><a href="#health"><i class="icon-ambulance "></i> Medicaid/Health </a></li>
            <li id="money_li"  class=""><a href="#money"><i class="icon-money "></i> Income Assistance </a></li>
	    <li id="rx_li" class=""><a href="#rx"><i class="icon-medkit "></i> Prescription Assistance </a></li>
            <li id="nutrition_li" class=""><a href="#nutrition"><i class="icon-heart "></i> Nutrition Assistance </a></li>
            <li id="food_li" class=""><a href="#food"><i class="icon-coffee "></i> Food/Meal Supplements </a></li>
            <li id="tax_li" class=""><a href="#tax"><i class="icon-building "></i> Property Tax Relief </a></li>
            <li id="veteran_li" class=""><a href="#veteran"><i class="icon-user "></i> Veteran Assistance</a></li>
        </ol><BR>

        <legend><i class="icon-file-alt "></i> Resources</legend>
        <ol class="nav nav-list"><form>	
        	<li><a data-toggle="modal" role="button" href="mailto:support@benefitscheckup.org" target="_blank"><i class="icon-edit "></i> Send Us Your Feedback</a></li>
            <li><a data-toggle="modal" role="button" href="#" onClick="PrintDiv();"><i class="icon-print "></i> Printable Report</a></li>
		<br/>
        	<li><a data-toggle="modal" role="button" href="/cf/frmwelcome2.cfm?subset_id=0&partner_id=0&sc_partner_id=0" target="_blank"><i class="icon-check "></i>Full BenefitsCheckUp Questionnaire</a></li>
        </form></ol>	
    </div>	  
</div>
<div id="learnmore" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="Learn More" aria-hidden="true" style="display: none;">
  <div class="modal-header" style="border:none;">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">Close <i class="icon-remove"></i></button>
  </div>
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
  </div>
</div>
