<div class="span8"> 
<center><img alt="MedicareQuickCheck" title="Medicare QuickCheck Logo" src="/cf/img/MedicareQuickCheck_logo.gif"></center> 
<?php 
require_once('displaycontent_mqc.php');

//$screening_id = $_GET['Screening_id'];

if (isset($_POST['continue']))
{
	$continue = $_POST["continue"];
if ($continue == 2){
	require_once('processquestions.php');
	}
}
?>

<script>
function nextsection($section)
  {
  //var fname=prompt("Please enter your name:","Your name")
  //document.getElementById("msg").innerHTML="Greetings " + fname
 	if ($section == 'basics'){
       window.location.href = '#income'; //This will open Google in a new window.
  }
  else if ($section == 'income') {
       window.location.href = '#employment';
  }
   else if ($section == 'employment') {
       window.location.href = '#debt';
  }
   else if ($section == 'debt') {
       window.location.href = '#housing';
  }
 else if ($section == 'housing') {
       window.location.href = '#health';
  }
 else if ($section == 'health') {
       window.location.href = '#interested';
  }
  }
  
</script>
<script src="/cf/ValidationFunctions.js"></script>
<script src="/cf/scripts.js"></script>
<form name="mqcForm" id="mqcForm" action="/cf/mqcprocess.cfm" method="post" > 
<?php require_once('section_mqc.php') ?>
<button class="btn btn-large btn " id="view_results" type="submit" value="View Your Report" ><i class="icon-chevron-right"></i><i class="icon-chevron-right"></i> View Your Report </button>
</div> 
<!--span8-->
<div class="span4">
   	<div class="well sidebar-nav" >
        <legend><i class="icon-list-alt "></i> Sections </legend>
        <ol class="nav nav-list">
            <li class="active"><a href="#basics"><i class="icon-pencil "></i> Basics <span style="display: none;" id="status-basics">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="icon-check "></i><em><strong>Done</strong></em></span></a></li>
            <li class=""><a href="#health"><i class="icon-medkit "></i>  Your Medicare and Health Insurance Coverage <span style="display: none;" id="status-employment">&nbsp;&nbsp;<i class="icon-check "></i><em><strong>Done</strong></em></span></a></li>
            <li class=""><a href="#optional"><i class="icon-file "></i> A Few More Questions <span style="display: none;" id="status-interested">&nbsp;&nbsp;&nbsp;<i class="icon-check "></i><em><strong>Done</strong></em></span></a></li>
        </ol><br>
        <legend><i class="icon-file-alt "></i> Resources</legend>
        <ol class="nav nav-list">
            <li><a data-toggle="modal" role="button" href="#gettingstarted"><i class="icon-question-sign "></i> Getting Started </a></li>
	     <li><a data-toggle="modal" role="button" target="_new" href="https://www.mymedicarematters.org/get-help/glossary/"><i class="icon-book "></i> Glossary of Terms </a></li>
	     <!--li><a data-toggle="modal" role="button" href="#print"><i class="icon-print "></i> Print A Copy </a></li-->
            <!--li><a data-toggle="modal" role="button" href="#referafriend"><i class="icon-link "></i> Refer A Friend </a></li -->
        </ol>		
    </div>	  
</div>
<input type="hidden" name="pgno" value="1">
<input type="hidden" name="qno" value="32">
<input type="hidden" name="aflist" value="o-mqc_client,s-mqc_zipcode,n-mqc_birth_month,n-mqc_birth_day,n-mqc_birth_year,o-mqc_marital,o-mqc_gender,y-mqc_medicare,c-mqc_helpmedicaid,c-mqc_belongmsp,c-mqc_receivinglis,c-mqc_receivingspap,c-mqc_noprogramhelp,c-mqc_dontknow,c-mqc_receivingrrb,c-mqc_receivingtricare,c-mqc_recvetben,c-mqc_govben,c-mqc_livenursingfacility,c-mqc_renaldisease,c-mqc_als,c-mqc_noneofabove,c-mqc_receivingparta,c-mqc_receivingparb,c-mqc_receivepartd,c-verysatisfied,c-satisfied,c-somewhatdissatisfied,c-verydissatisfied,c-mqc_healthneedschange,c-mqc_troubleaccessingcare,c-mqc_moving,c-mqc_situationplanner,c-mqc_situationconfident,c-mqc_situationhappy,c-mqc_situationoverwhelmed,c-mqc_situationchallenge,c-mqc_noneofabove,c-mqc_plandiscontinued,c-mqc_provideroutofnetwork,c-mqc_costsbigproblem,c-mqc_costsmodproblem,c-mqc_costsminorproblem,c-mqc_costsnotproblem,c-mqc_asset_over,c-mqc_asset_range1,c-mqc_asset_range2,c-mqc_asset_range3,c-mqc_asset_under,c-mqc_cobra,c-mqc_large_employer,c-mqc_small_employer,c-mqc_dontknowcoverage,c-mqc_originalmedicare,c-mqc_medhealthplan,c-mqc_justenrolled,c-mqc_medicare_drug_plan,c-mqc_medigap,c-mqc_income_over,c-mqc_income_range1,c-mqc_income_range2,c-mqc_income_range3,c-mqc_income_under,c-mqc_employer_money,c-mqc_employer_choose,c-mqc_i_choose,c-mqc_covers_healthcare_and_drugs,c-mqc_covers_healthcare_no_drugs,c-mqc_covers_two_medicare_plans,y-mqc_employer_insurance,y-mqc_retiree_plan,c-mqc_receivingsnp,c-mqc_lifestyle">
<input type="hidden" name="page" value="20">
<input type="hidden" name="continue" value="2">

<?php 
if (isset($_GET['screeningID'])) {
echo '<input type="hidden" name="screeningID" value="'.$_GET['screeningID'].'">';
}
?>
</form>
<div id="gettingstarted" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="Getting Started" aria-hidden="true" style="display: none;">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">Close <i class="icon-remove"></i></button>
    <div><h2>Getting Started</h2></div>
  </div>
  <div class="modal-body">
<p>
Information You Will Need Before You Start Medicare QuickCheck:<br><br>

<ul><li>Medicare Card (if applicable)</li>
<li>Other health insurance cards (if applicable)</li>
<li>Current income and assets from all sources (excluding your home) for self and spouse</li></ul>
</p>	
  </div>

  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
  </div>
</div>


<div id="medicareInfo" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="Medicare Information aria-hidden="true" style="display: none;">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">Close <i class="icon-remove"></i></button>
    <div><h2>Medicare Information</h2></div>
  </div>
  <div class="modal-body">
<div class="alert alert-danger"><i class="icon-warning-sign"></i>

This Medicare QuickCheck tool is currently only available for people who have
Medicare.

</div> 
<p><a href="https://www.mymedicarematters.org/AboutMedicare/new-to-medicare-advice-for-your-situation/" target="_blank">Learn more</a> about enrolling in Medicare for the first time and get help
selecting your coverage.</p>                               
  </div>

  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
  </div>
</div>



<script type="text/javascript" src="/_custom/util/js/questionnaireFunc.js">
</script>



<script type="text/javascript">

//Lynna Cekova MQC form: QUESTIONS 4 and 5: show Q5 if medicare selected, hide and show a modal window if not

//upon page load

if( $('input:radio[name=mqc_medicare]:checked').val() == 'y'){

$("#mqc_medicaretype").show();
}
else if( $('input:radio[name=mqc_medicare]:checked').val() == 'n'){

$("#mqc_medicaretype").hide();
//$("#medicareInfo").modal('show');
}
else if( $('input:radio[name=mqc_medicare]:checked').val() == 'dontknow'){

$("#mqc_medicaretype").hide();
//$("#medicareInfo").modal('show');
}

//upon change

$("input:radio[name=mqc_medicare]").change (function(){

if( $('input:radio[name=mqc_medicare]:checked').val() == 'y'){

$("#mqc_medicaretype").show();
}
else if( $('input:radio[name=mqc_medicare]:checked').val() == 'n'){

$("#mqc_medicaretype").hide();
$("#medicareInfo").modal('show');
}
else if( $('input:radio[name=mqc_medicare]:checked').val() == 'dontknow'){

$("#mqc_medicaretype").hide();
//$("#medicareInfo").modal('show');
}
})




//Lynna Cekova MQC form: QUESTIONS 8, 9, 10

//upon page load

//hide the specific plan options by (Q9 and Q10 by default)
$("#mqc_additionalplans").hide();
$("#mqc_medicarehealthplan_coverage").hide();


if( $('input:radio[name=mqc_medicarecoverage]:checked').val() == 'mqc_medhealthplan'){

$("#mqc_additionalplans").hide();
$("#mqc_medicarehealthplan_coverage").show();

}
else if( $('input:radio[name=mqc_medicarecoverage]:checked').val() == 'mqc_originalmedicare'){

$("#mqc_additionalplans").show();
$("#mqc_medicarehealthplan_coverage").hide();
}


//upon change
$("input:radio[name=mqc_medicarecoverage]").change (function(){

if( $('input:radio[name=mqc_medicarecoverage]:checked').val() == 'mqc_medhealthplan'){

$("#mqc_additionalplans").hide();
$("#mqc_medicarehealthplan_coverage").show();

}
else if( $('input:radio[name=mqc_medicarecoverage]:checked').val() == 'mqc_originalmedicare'){

$("#mqc_additionalplans").show();
$("#mqc_medicarehealthplan_coverage").hide();
}
else {
$("#mqc_additionalplans").hide();
$("#mqc_medicarehealthplan_coverage").hide();

}
})

//Lynna Cekova MQC form: QUESTIONS 13, 14
//hide by default
$("#mqc_retiree_plan").hide();
$("#mqc_retiree_plan_select").hide();
$("#mqc_work_situation").hide();


if( $('input:radio[name=mqc_employer_insurance]:checked').val() == 'y'){

$("#mqc_retiree_plan").show();
}

else if( $('input:radio[name=mqc_employer_insurance]:checked').val() == 'n'){

$("#mqc_retiree_plan").hide();
$("#mqc_retiree_plan_select").hide();
$("#mqc_work_situation").hide();


}

else if( $('input:radio[name=mqc_employer_insurance]:checked').val() == 'dontknow'){

$("#mqc_retiree_plan").hide();
$("#mqc_retiree_plan_select").hide();
$("#mqc_work_situation").hide();

}

//upon change
$("input:radio[name=mqc_employer_insurance]").change (function(){


if( $('input:radio[name=mqc_employer_insurance]:checked').val() == 'y'){

$("#mqc_retiree_plan").show();
}

else if( $('input:radio[name=mqc_employer_insurance]:checked').val() == 'n'){

$("#mqc_retiree_plan").hide();
$("#mqc_retiree_plan_select").hide();
$("#mqc_work_situation").hide();


}

else if( $('input:radio[name=mqc_employer_insurance]:checked').val() == 'dontknow'){

$("#mqc_retiree_plan").hide();
$("#mqc_retiree_plan_select").hide();
$("#mqc_work_situation").hide();

}
})



//Lynna Cekova MQC form: QUESTIONS 14, 15 and asset question

//upon page load
//asset question upon page load
//hide by default
$("#mqc_incasset").hide();

//hide by default
$("#mqc_retiree_plan_select").hide();
$("#mqc_work_situation").hide();


if( $('input:radio[name=mqc_retiree_plan]:checked').val() == 'y'){
$("#mqc_retiree_plan_select").show();
$("#mqc_work_situation").hide();
}
else if( $('input:radio[name=mqc_retiree_plan]:checked').val() == 'n'){

$("#mqc_retiree_plan_select").hide();
$("#mqc_work_situation").show();
}
else if( $('input:radio[name=mqc_retiree_plan]:checked').val() == 'dontknow'){

$("#mqc_retiree_plan_select").hide();
$("#mqc_work_situation").hide();
}



//upon change
$("input:radio[name=mqc_retiree_plan]").change (function(){

if( $('input:radio[name=mqc_retiree_plan]:checked').val() == 'y'){
$("#mqc_retiree_plan_select").show();
$("#mqc_work_situation").hide();
}
else if( $('input:radio[name=mqc_retiree_plan]:checked').val() == 'n'){

$("#mqc_retiree_plan_select").hide();
$("#mqc_work_situation").show();
}
else if( $('input:radio[name=mqc_retiree_plan]:checked').val() == 'dontknow'){

$("#mqc_retiree_plan_select").hide();
$("#mqc_work_situation").hide();
}







})

//Lynna Cekova MQC form: QUESTIONS 19 and 20

//upon page load

if( $('input:checkbox[name=mqc_provideroutofnetwork]:checked').val() == 'y'){

$("#mqc_plan_network_problem").show();
}

else {

$("#mqc_plan_network_problem").hide();
}

//upon change

$("input:checkbox[name=mqc_provideroutofnetwork]").change (function(){

if( $('input:checkbox[name=mqc_provideroutofnetwork]:checked').val() == 'y'){

$("#mqc_plan_network_problem").show();
}

else {

$("#mqc_plan_network_problem").hide();
}

})

//asset


//upon change
$("input:radio[name=mqc_income]").change (function(){
if ( $('input:radio[name=mqc_income]:checked').val() == 'mqc_income_over') {

if ($('input:radio[name=mqc_outofpocket]:checked').val() == 'mqc_costsbigproblem'){ 
$("#mqc_incasset").show();
}
else if ($('input:radio[name=mqc_outofpocket]:checked').val() == 'mqc_costsmodproblem') {
$("#mqc_incasset").show();
}
else {
$("#mqc_incasset").hide();
}

}
else {
$("#mqc_incasset").show();
}

})

$("input:radio[name=mqc_outofpocket]").change (function(){
if( $('input:radio[name=mqc_outofpocket]:checked').val() == 'mqc_costsbigproblem')   {

if ( $('input:radio[name=mqc_income]:checked').val() == 'mqc_income_over') {
$("#mqc_incasset").show();
}


}
else if( $('input:radio[name=mqc_outofpocket]:checked').val() == 'mqc_costsmodproblem') {

if ( $('input:radio[name=mqc_income]:checked').val() == 'mqc_income_over') {
$("#mqc_incasset").show();
}


}

})
</script>

