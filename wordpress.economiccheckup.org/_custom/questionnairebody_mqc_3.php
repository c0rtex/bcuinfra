<div id="printContent" class="span8"> 
<center><img alt="MedicareQuickCheck" title="Medicare QuickCheck Logo" src="/wp-content/uploads/2013/12/Medicare-QuickCheck.jpg"></center> 
<?php 
require_once('util/affinity_click.php');
require_once('displaycontent_mqc.php');
//function mqc3Script (){
//wp_enqueue_script( 'mqc-js-3' ); //include mqc_v3.js
//}

//add_action( 'wp_enqueue_scripts', 'mqc3Script' );

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
  //document.getElementById("msg").innerHTML="Greetings " + fname
 	if ($section == 'basics'){
       window.location.href = '#income'; //This will open Google in a new window.
  } else if ($section == 'income') {
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
<form name="mqcForm3" id="mqcForm3" action="/cf/mqcprocess_subset75.cfm" method="post" > 
<?php  require_once('section_mqc_3.php');  ?>
<button class="btnbtn-large btn " id="view_results" type="submit" value="View Your Report" onClick="if(!endForm) { ga('send', 'event', 'mqc', 'MQC Tool Completions', 'viewreport'); ga('mmm.send', 'event', 'mqc', 'MQC Tool Completions', 'viewreport'); endForm=true; }"><i class="icon-chevron-right"></i><i class="icon-chevron-right"></i> View Your Report </button>
</div> 
<!--span8-->
<div class="span4">
   	<div class="well sidebar-nav" >
        <legend><i class="icon-list-alt "></i> Sections </legend>
        <ol class="nav nav-list">
            <li class="active"><a href="#basics"><i class="icon-pencil "></i> Basics <span style="display: none;" id="status-basics">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="icon-check "></i><em><strong>Done</strong></em></span></a></li>
            <li class=""><a href="#health"><i class="icon-medkit "></i>  Your Health Insurance Coverage <span style="display: none;" id="status-employment">&nbsp;&nbsp;<i class="icon-check "></i><em><strong>Done</strong></em></span></a></li>
            <li class=""><a href="#optional"><i class="icon-file "></i> A Few More Questions <span style="display: none;" id="status-interested">&nbsp;&nbsp;&nbsp;<i class="icon-check "></i><em><strong>Done</strong></em></span></a></li>	
	</ol><br>
        <legend><i class="icon-file-alt "></i> Resources</legend>
        <ol class="nav nav-list">
            <li><a data-toggle="modal" role="button" href="#gettingstarted"><i class="icon-question-sign "></i> Getting Started </a></li>
	     <li><a data-toggle="modal" role="button" target="_new" href="https://www.mymedicarematters.org/get-help/glossary/"><i class="icon-book "></i> Glossary of Terms </a></li>
	     <!-- <a data-toggle="modal" role="button" href="#print"><i class="icon-print "></i> Print A Copy </a> -->

            <li><a data-toggle="modal" role="button" href="#" onClick="javascript:PrintDiv();"><i class="icon-print "></i> Print a Copy</a></li>
            <!--li><a data-toggle="modal" role="button" href="#referafriend"><i class="icon-link "></i> Refer A Friend </a></li -->
        </ol>		
    </div>	  
</div>
<input type="hidden" name="pgno" value="1">
<input type="hidden" name="qno" value="32">
<input type="hidden" name="aflist" value="o-mqc_client,s-mqc_zipcode,n-mqc_birth_month,n-mqc_birth_day,n-mqc_birth_year,o-mqc_marital,o-mqc_gender,c-mqc_insurance_not_listed,y-mqc_receive_hsa,y-mqc_health_insurance,y-mqc_health_insurance_creditable,y-mqc_medicare,c-mqc_not_receiving_parta,c-mqc_prison,c-mqc_live_outside_us,c-mqc_helpmedicaid,c-mqc_belongmsp,c-mqc_receivinglis,c-mqc_receivingspap,c-mqc_noprogramhelp,c-mqc_dontknow,c-mqc_receivingrrb,c-mqc_receivingtricare,c-mqc_recvetben,c-mqc_govben,c-mqc_livenursingfacility,c-mqc_renaldisease,c-mqc_als,c-mqc_noneofabove,c-mqc_receivingparta,c-mqc_not_eligible_parta,c-mqc_receivingparb,c-mqc_receivepartd,c-verysatisfied,c-satisfied,c-somewhatdissatisfied,c-verydissatisfied,c-mqc_healthneedschange,c-mqc_troubleaccessingcare,c-mqc_moving,c-mqc_situationplanner,c-mqc_situationconfident,c-mqc_situationhappy,c-mqc_situationoverwhelmed,c-mqc_situationchallenge,c-mqc_situation_noneofabove,c-mqc_situationmedicare,c-mqc_plandiscontinued,c-mqc_provideroutofnetwork,c-mqc_costsbigproblem,c-mqc_costsmodproblem,c-mqc_costsminorproblem,c-mqc_costsnotproblem,c-mqc_cobra,c-mqc_large_employer,c-mqc_small_employer,c-mqc_dontknowcoverage,c-mqc_originalmedicare,c-mqc_medhealthplan,c-mqc_justenrolled,c-mqc_medicare_drug_plan,c-mqc_medigap,c-mqc_income_over,c-mqc_income_range1,c-mqc_income_range2,c-mqc_income_range3,c-mqc_income_under,c-mqc_income_retire_over,c-mqc_income_retire_range1,c-mqc_income_retire_range2,c-mqc_income_retire_range3,c-mqc_income_retire_under,c-mqc_employer_money,c-mqc_employer_choose,c-mqc_i_choose,c-mqc_covers_healthcare_and_drugs,c-mqc_covers_healthcare_no_drugs,c-mqc_covers_two_medicare_plans,y-mqc_employer_insurance,y-mqc_retiree_plan,c-mqc_receivingsnp,c-mqc_lifestyle,c-mqc_medicare_enroll_within_3_months,c-mqc_medicare_enroll_past_3_months,c-mqc_none_apply,c-mqc_medicare_enroll_within_1_year_yes,c-mqc_not_sure_medicare_qualify,c-mqc_medicare_enroll_age_65,c-mqc_medicare_enroll_disability_no,c-mqc_medicare_enroll_disability_yes,c-mqc_medicare_enroll_within_1_year_no,c-rec_ak_seniorbenefits,c-rec_de_dpap,c-rec_in_hoosierrx,c-rec_ma_prescriptionadvantage,c-rec_md_spdap,c-rec_me_del_and_rxplus,c-rec_mo_rxplan,c-rec_mt_bigskyrx,c-rec_nj_paad,c-rec_nv_seniorrx,c-rec_ny_epic,c-rec_or_pdap_2,c-rec_pa_pace_pacenet,c-rec_ri_ripae,c-rec_vt_vpharm_and_healthyvermonters,c-rec_wa_pdp,c-rec_wi_seniorcare,c-mqc_receiving_ssi,c-mqc_receiving_ssdi,c-mqc_receiving_ssi_retirement,c-mqc_helpmedicaid_az,c-mqc_helpmedicaid_ca,c-mqc_helpmedicaid_ct,c-mqc_helpmedicaid_il,c-mqc_helpmedicaid_ky,c-mqc_helpmedicaid_ma,c-mqc_helpmedicaid_me,c-mqc_helpmedicaid_mo,c-mqc_helpmedicaid_pa,c-mqc_helpmedicaid_tn,c-mqc_helpmedicaid_wi,c-mqc_helpmedicaid_wy,c-mqc_group_insurance_self,c-mqc_group_insurance_spouse,c-mqc_former_employer_retiree_benefit,c-mqc_individual_insurance,c-mqc_other_insurance,c-mqc_insurance_type_none,c-mqc_employees_lt_20_self,c-mqc_employees_gt_20_self,c-mqc_employees_gt_100_self,c-mqc_employees_dont_know,c-mqc_employees_gt_100_spouse,c-mqc_employees_dont_know_spouse,c-mqc_employees_gt_20_spouse,c-mqc_employees_lt_20_spouse,c-satisfied_no,c-satisfied_yes,c-mqc_originalmedicare,c-mqc_medhealthplan,c-mqc_justenrolled,c-mqc_dontknowcoverage">
<input type="hidden" name="page" value="20">
<input type="hidden" name="continue" value="2">

<?php 
if (isset($_GET['screeningID'])) {
echo '<input type="hidden" name="screeningID" value="'.$_GET['screeningID'].'">';
}
if (isset($_SESSION['click_id'])){
echo '<input type="hidden" name="click_id" value="'.$_SESSION['click_id'].'">';
}
if (isset($_SESSION['CID'])){
echo '<input type="hidden" name="CID" value="'.$_SESSION['CID'].'">';
}
if (isset($_SESSION['PID'])){
echo '<input type="hidden" name="PID" value="'.$_SESSION['PID'].'">';
}
//get needed info text for popup

$neededInfo = apply_filters('the_content', get_post_field('post_content', 3484));
?>
</form>
<div id="gettingstarted" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="Getting Started" aria-hidden="true" style="display: none;">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">Close <i class="icon-remove"></i></button>
    <div><h2>Getting Started</h2></div>
  </div>
  <div class="modal-body">
<?php 
//needed info text from wordpress
echo $neededInfo;
?>	
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

<?php
$neededMedicareInfo = apply_filters('the_content', get_post_field('post_content', 3421));

echo $neededMedicareInfo;
?>

</div> 
  </div>

  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
  </div>
</div>



<script type="text/javascript" src="/_custom/util/js/questionnaireFunc.js">
</script>



<script type="text/javascript">

//Lynna Cekova; moving the birth year field on the next row
$("label[id='label_mqc_birth_year']").before ("<br/>");

//Lynna Cekova; show the # of days in a month based on the month and year

birthDay (); //upon load

$("#mqc_birth_month").change (function (){ //upon change

birthDay ();

})

function birthDay (){


$("#mqc_birth_day").children().show(); //to accomodate accidentally selecting June and changing to July

if ($("#mqc_birth_month").val() != ""){

var month = $("#mqc_birth_month").val();
var days = daysInMonth (month, 2014); //2014 is temp; the actual year will depend on the year select field


console.log(days);

if (days < "31"){

$("#mqc_birth_day").children('option[value="31"]').hide();


if (days < "30"){


$("#mqc_birth_day").children('option[value="30"]').hide();


if (days < "30"){
$("#mqc_birth_day").children('option[value="29"]').hide();
}


}

}


}

}


function daysInMonth(month, year) {
    return new Date(year, month, 0).getDate();
}



//Lynna Cekova: dislpay state-specific information (and validate the zip code) when the user has typed five symbols
//hide all Medicaid options (Q. 6 additional)
$("#mqc_health_insurance_coverage .checkbox").hide();
$("#mqc_health_insurance_coverage :input").removeAttr("checked");
$("#tr_mqc_helpmedicaid").show(); //show the generic Medicaid one
$("#tr_mqc_helpmedicaid .checkbox").show();
//show the "not listed" option
             $("#tr_mqc_insurance_not_listed").show(); 
             $("#tr_mqc_insurance_not_listed .checkbox").show();
              $("#tr_mqc_receivingtricare").show(); 
             $("#tr_mqc_receivingtricare .checkbox").show();
              $("#tr_mqc_insurance_none_of_the_above").show(); 
             $("#tr_mqc_insurance_none_of_the_above .checkbox").show();
              $("#tr_mqc_govben").show(); 
             $("#tr_mqc_govben .checkbox").show();
              $("#tr_mqc_receivingrrb").show(); 
             $("#tr_mqc_receivingrrb .checkbox").show();
 

//hide all state-specific programs for Q.9
$("#mqc_medicareadditional .checkbox").hide();
$("#mqc_medicareadditional :input").removeAttr("checked");
//show all Q.9 options that show anyway
             $("#tr_mqc_receivinglis").show(); 
             $("#tr_mqc_receivinglis .checkbox").show();
              $("#tr_mqc_receiving_ssi").show(); 
             $("#tr_mqc_receiving_ssi .checkbox").show();
              $("#tr_mqc_receiving_ssid").show(); 
             $("#tr_mqc_receiving_ssdi .checkbox").show();
              $("#tr_mqc_receiving_ssi_retirement").show(); 
             $("#tr_mqc_receiving_ssi_retirement .checkbox").show();
             $("#tr_mqc_noneofabove").show(); 
             $("#tr_mqc_noneofabove .checkbox").show();
               $("#tr_mqc_belongmsp").show(); 
             $("#tr_mqc_belongmsp .checkbox").show();
              $("#tr_mqc_receiving_ssdi").show(); 
             $("#tr_mqc_receiving_ssdi .checkbox").show();
 
//variables used for the keyup, so that the zip error is only activated when the user finishes typing
var timer;
var timeout = 1000;


$("#mqc_zipcode").on( 'keyup', function () {

 clearTimeout(timer);


if ($("#mqc_zipcode").val().length == 5) {

$("#invalidZipNum").remove();
invalidZipMQC3();

}

else {

 timer = setTimeout(function(){

if ($("#invalidZipNum").length <=0){ //so that the message is not entered upon every keystroke

invalidZipMQC3Num ();
}

}, timeout);
}

});



//Lynna Cekova: inputs to validate upon submit
var inputsText = { "select_mqc_client": "Form Completion", "mqc_zipcode": "Zip Code", "mqc_birth_month": "Birth Month", "mqc_birth_year": "Birth Year", "mqc_birth_day": "Birth Day", "select_mqc_marital": "Marital Status" };

var inputsCheckboxRadio = { "mqc_medicareadditional": "This field", "mqc_coveragesatisfaction_2": "This field", "mqc_medicare_enroll_situation": "This field", "mqc_health_insurance": "This field", "mqc_receive_hsa": "This field", "mqc_circumstance": "This field", "mqc_income": "This field", "mqc_describesituation": "This field"}; //removed "mqc_income_retired" from here upon Chansopine's request




//Lynna Cekova MQC3 form: QUESTION 5 and derivatives: show derivatives (-1, which depends on a derivative) if medicare, hide if not, and show a modal window if medicare not planned


if( $('input:radio[name=mqc_medicare_enroll_situation]:checked').val() == 'mqc_medicare_enroll_disability_yes' || $('input:radio[name=mqc_medicare_enroll_situation]:checked').val() == 'mqc_medicare_enroll_disability_no'){

$("#mqc_medicaretype_2").show();
inputsCheckboxRadio["mqc_medicaretype_2"] = "This field";
$("#mqc_medicarecoverage").show();
inputsCheckboxRadio["mqc_medicarecoverage"] = "This field";
}

else {

$("#mqc_medicaretype_2").hide();
$("#mqc_medicaretype_2").prev(".alert").remove()
$("#mqc_medicaretype_2 :input").removeAttr("checked");
delete inputsCheckboxRadio.mqc_medicaretype_2;

$("#mqc_medicarecoverage").hide();
$("#mqc_medicarecoverage").prev(".alert").remove()
delete inputsCheckboxRadio.mqc_medicarecoverage;
$("#mqc_medicarecoverage :input").removeAttr("checked");

$("#mqc_additionalplans").hide();
$("#mqc_additionalplans").prev(".alert").remove();
delete inputsCheckboxRadio.mqc_additionalplans;
$("#mqc_additionalplans :input").removeAttr("checked");

}


if( $('input:radio[name=mqc_medicarecoverage]:checked').val() == 'mqc_originalmedicare'){
$("#mqc_additionalplans").show();
inputsCheckboxRadio["mqc_additionalplans"] = "This field";
}

else {

$("#mqc_additionalplans").hide();
$("#mqc_additionalplans").prev(".alert").remove();
delete inputsCheckboxRadio.mqc_additionalplans;
}

//upon change

$("input:radio[name=mqc_medicare_enroll_situation]").change (function(){

if( $('input:radio[name=mqc_medicare_enroll_situation]:checked').val() == 'mqc_medicare_enroll_disability_yes' || $('input:radio[name=mqc_medicare_enroll_situation]:checked').val() == 'mqc_medicare_enroll_disability_no'){


$("#mqc_medicaretype_2").show();
inputsCheckboxRadio["mqc_medicaretype_2"] = "This field";
$("#mqc_medicarecoverage").show();
inputsCheckboxRadio["mqc_medicarecoverage"] = "This field";

}

else {


$("#mqc_medicaretype_2").hide();
$("#mqc_medicaretype_2").prev(".alert").remove()
$("#mqc_medicaretype_2 :input").removeAttr("checked");
delete inputsCheckboxRadio.mqc_medicaretype_2;

$("#mqc_medicarecoverage").hide();
$("#mqc_medicarecoverage").prev(".alert").remove()
delete inputsCheckboxRadio.mqc_medicarecoverage;
$("#mqc_medicarecoverage :input").removeAttr("checked");

$("#mqc_additionalplans").hide();
$("#mqc_additionalplans").prev(".alert").remove();
delete inputsCheckboxRadio.mqc_additionalplans;
$("#mqc_additionalplans :input").removeAttr("checked");


}

if( $('input:radio[name=mqc_medicare_enroll_situation]:checked').val() == 'mqc_medicare_enroll_within_1_year_no' || $('input:radio[name=mqc_medicare_enroll_situation]:checked').val() == 'mqc_not_sure_medicare_qualify'|| $('input:radio[name=mqc_medicare_enroll_situation]:checked').val() == 'mqc_medicare_enroll_age_65'){

$("#medicareInfo").modal('show');
}

})


$("input:radio[name=mqc_medicarecoverage]").change (function(){

if( $('input:radio[name=mqc_medicarecoverage]:checked').val() == 'mqc_originalmedicare'){
$("#mqc_additionalplans").show();
inputsCheckboxRadio["mqc_additionalplans"] = "This field";
}

else {

$("#mqc_additionalplans").hide();
$("#mqc_additionalplans").prev(".alert").remove();
delete inputsCheckboxRadio.mqc_additionalplans;
$("#mqc_additionalplans :input").removeAttr("checked");
}

})


//Lynna Cekova, MQC3, Q.6 (other health insurance) and derivatives


if( $('input:radio[name=mqc_health_insurance]:checked').val() == 'n'){

$("#mqc_health_insurance_type").hide();
$("#mqc_health_insurance_type").prev(".alert").remove();
$("#mqc_health_insurance_type :input").removeAttr("checked");
delete inputsCheckboxRadio.mqc_health_insurance_type;
$("#mqc_number_employees_self").hide();
$("#mqc_number_employees_self").prev(".alert").remove();
$("#mqc_number_employees_self :input").removeAttr("checked");
delete inputsCheckboxRadio.mqc_number_employees_self;
$("#mqc_number_employees_spouse").hide();
$("#mqc_number_employees_spouse").prev(".alert").remove();
$("#mqc_number_employees_spouse :input").removeAttr("checked");
delete inputsCheckboxRadio.mqc_number_employees_spouse;
$("#mqc_health_insurance_creditable").hide();
$("#mqc_health_insurance_creditable").prev(".alert").remove();
$("#mqc_health_insurance_creditable :input").removeAttr("checked");
delete inputsCheckboxRadio.mqc_health_insurance_creditable;
$("#mqc_health_insurance_coverage").hide();
$("#mqc_health_insurance_coverage").prev(".alert").remove();
$("#mqc_health_insurance_coverage :input").removeAttr("checked");
delete inputsCheckboxRadio.mqc_health_insurance_coverage;

}
else {

$("#mqc_health_insurance_type").show();
inputsCheckboxRadio["mqc_health_insurance_type"] = "This field";
$("#mqc_health_insurance_coverage").show();
inputsCheckboxRadio["mqc_health_insurance_coverage"] = "This field";
}

//upon change

$("input:radio[name=mqc_health_insurance]").change (function(){

if( $('input:radio[name=mqc_health_insurance]:checked').val() == 'n'){

$("#mqc_health_insurance_type").hide();
$("#mqc_health_insurance_type").prev(".alert").remove();
$("#mqc_health_insurance_type :input").removeAttr("checked");
delete inputsCheckboxRadio.mqc_health_insurance_type;
$("#mqc_number_employees_self").hide();
$("#mqc_number_employees_self").prev(".alert").remove();
$("#mqc_number_employees_self :input").removeAttr("checked");
delete inputsCheckboxRadio.mqc_number_employees_self;
$("#mqc_number_employees_spouse").hide();
$("#mqc_number_employees_spouse").prev(".alert").remove();
$("#mqc_number_employees_spouse :input").removeAttr("checked");
delete inputsCheckboxRadio.mqc_number_employees_spouse;
$("#mqc_health_insurance_creditable").hide();
$("#mqc_health_insurance_creditable").prev(".alert").remove();
$("#mqc_health_insurance_creditable :input").removeAttr("checked");
delete inputsCheckboxRadio.mqc_health_insurance_creditable;
$("#mqc_health_insurance_coverage").hide();
$("#mqc_health_insurance_coverage").prev(".alert").remove();
$("#mqc_health_insurance_coverage :input").removeAttr("checked");
delete inputsCheckboxRadio.mqc_health_insurance_coverage;}

else {

$("#mqc_health_insurance_type").show();
inputsCheckboxRadio["mqc_health_insurance_type"] = "This field";
$("#mqc_health_insurance_coverage").show();
inputsCheckboxRadio["mqc_health_insurance_coverage"] = "This field";
}

})

if( $('input:checkbox[name=mqc_group_insurance_self]:checked').val() == 'y'){

$("#mqc_number_employees_self").show();
inputsCheckboxRadio["mqc_number_employees_self"] = "This field";
}

else {

$("#mqc_number_employees_self").hide();
$("#mqc_number_employees_self").prev(".alert").remove();
$("#mqc_number_employees_self :input").removeAttr("checked");
delete inputsCheckboxRadio.mqc_number_employees_self;
}

//upon change

$("input:checkbox[name=mqc_group_insurance_self]").change (function(){

if( $('input:checkbox[name=mqc_group_insurance_self]:checked').val() == 'y'){

$("#mqc_number_employees_self").show();
inputsCheckboxRadio["mqc_number_employees_self"] = "This field";
}

else {

$("#mqc_number_employees_self").hide();
$("#mqc_number_employees_self").prev(".alert").remove();
$("#mqc_number_employees_self :input").removeAttr("checked");
delete inputsCheckboxRadio.mqc_number_employees_self;
}



})


if( $('input:checkbox[name=mqc_group_insurance_spouse]:checked').val() == 'y'){

$("#mqc_number_employees_spouse").show();
inputsCheckboxRadio["mqc_number_employees_spouse"] = "This field";
}

else {

$("#mqc_number_employees_spouse").hide();
$("#mqc_number_employees_spouse").prev(".alert").remove();
$("#mqc_number_employees_spouse :input").removeAttr("checked");
delete inputsCheckboxRadio.mqc_number_employees_spouse;
}

//upon change

$("input:checkbox[name=mqc_group_insurance_spouse]").change (function(){

if( $('input:checkbox[name=mqc_group_insurance_spouse]:checked').val() == 'y'){

$("#mqc_number_employees_spouse").show();
inputsCheckboxRadio["mqc_number_employees_spouse"] = "This field";
}

else {

$("#mqc_number_employees_spouse").hide();
$("#mqc_number_employees_spouse").prev(".alert").remove();
$("#mqc_number_employees_spouse :input").removeAttr("checked");
delete inputsCheckboxRadio.mqc_number_employees_spouse;
}



})


if( $('input:checkbox[name=mqc_group_insurance_spouse]:checked').val() == 'y'
|| $('input:checkbox[name=mqc_group_insurance_self]:checked').val() == 'y'
|| $('input:checkbox[name=mqc_former_employer_retiree_benefit]:checked').val() == 'y'
|| $('input:checkbox[name=mqc_individual_insurance]:checked').val() == 'y'
|| $('input:checkbox[name=mqc_cobra]:checked').val() == 'y'

){

$("#mqc_health_insurance_creditable").show();
inputsCheckboxRadio["mqc_health_insurance_creditable"] = "This field";
}
else {
$("#mqc_health_insurance_creditable").hide();
$("#mqc_health_insurance_creditable").prev(".alert").remove();
$("#mqc_health_insurance_creditable :input").removeAttr("checked");
delete inputsCheckboxRadio.mqc_health_insurance_creditable;
}


$("#mqc_health_insurance_type :input").change (function(){



if( $('input:checkbox[name=mqc_group_insurance_spouse]:checked').val() == 'y'
|| $('input:checkbox[name=mqc_group_insurance_self]:checked').val() == 'y'
|| $('input:checkbox[name=mqc_former_employer_retiree_benefit]:checked').val() == 'y'
|| $('input:checkbox[name=mqc_individual_insurance]:checked').val() == 'y'
|| $('input:checkbox[name=mqc_cobra]:checked').val() == 'y'

){

$("#mqc_health_insurance_creditable").show();
inputsCheckboxRadio["mqc_health_insurance_creditable"] = "This field";
}
else {
$("#mqc_health_insurance_creditable").hide();
$("#mqc_health_insurance_creditable").prev(".alert").remove();
$("#mqc_health_insurance_creditable :input").removeAttr("checked");
delete inputsCheckboxRadio.mqc_health_insurance_creditable;
}

if ($(this).attr("id") == "mqc_insurance_type_none"){
if( $('input:checkbox[name=mqc_insurance_type_none]:checked').val() == 'y'){



$("#mqc_health_insurance_type :input").each(function (index, element){
   if ($(this).attr("id") != "mqc_insurance_type_none"){
    $(this).prop("checked", false);
}

});


//take care the events triggered by checking/unchecking other boxes that are not automatically triggered by dynamic unchecking


$("#mqc_number_employees_self").hide();
$("#mqc_number_employees_self").prev(".alert").remove();
$("#mqc_number_employees_self :input").removeAttr("checked");
delete inputsCheckboxRadio.mqc_number_employees_self;


$("#mqc_number_employees_spouse").hide();
$("#mqc_number_employees_spouse").prev(".alert").remove();
$("#mqc_number_employees_spouse :input").removeAttr("checked");
delete inputsCheckboxRadio.mqc_number_employees_spouse;

$("#mqc_health_insurance_creditable").hide();
$("#mqc_health_insurance_creditable").prev(".alert").remove();
$("#mqc_health_insurance_creditable :input").removeAttr("checked");
delete inputsCheckboxRadio.mqc_health_insurance_creditable;
}
}
else {

$('input:checkbox[name=mqc_insurance_type_none]').prop("checked", false);


}




})



//Lynna Cekova, question code=mqc_health_insurance_coverage, taking care of the "None of the above" case

$("#mqc_health_insurance_coverage :input").change (function(){


if ($(this).attr("id") == "mqc_insurance_none_of_the_above"){
if( $('input:checkbox[name=mqc_insurance_none_of_the_above]:checked').val() == 'y'){



$("#mqc_health_insurance_coverage :input").each(function (index, element){
   if ($(this).attr("id") != "mqc_insurance_none_of_the_above"){
    $(this).prop("checked", false);
}

})
}
}
else {

$('input:checkbox[name=mqc_insurance_none_of_the_above]').prop("checked", false);
}
})



//Lynna Cekova, MQC3, Q.7 and derivative (HSA)


if( $('input:radio[name=mqc_receive_hsa]:checked').val() == 'y'){

$("#mqc_receive_hsa_source").show();
inputsCheckboxRadio["mqc_receive_hsa_source"] = "This field";
}

else {
$("#mqc_receive_hsa_source").hide();
$("#mqc_receive_hsa_source").prev(".alert").remove();
$("#mqc_receive_hsa_source :input").removeAttr("checked");
delete inputsCheckboxRadio.mqc_receive_hsa_source;
}

$("input:radio[name=mqc_receive_hsa]").change (function(){

if( $('input:radio[name=mqc_receive_hsa]:checked').val() == 'y'){

$("#mqc_receive_hsa_source").show();
inputsCheckboxRadio["mqc_receive_hsa_source"] = "This field";
}

else {
$("#mqc_receive_hsa_source").hide();
$("#mqc_receive_hsa_source").prev(".alert").remove();
$("#mqc_receive_hsa_source :input").removeAttr("checked");
delete inputsCheckboxRadio.mqc_receive_hsa_source;
}


})

//Lynna Cekova. Q. 9 and 10, taking care of the "noneofabove" case



$("#mqc_medicareadditional :input").change (function(){


if ($(this).attr("id") == "mqc_noneofabove"){
if( $('input:checkbox[name=mqc_noneofabove]:checked').val() == 'y'){



$("#mqc_medicareadditional :input").each(function (index, element){
   if ($(this).attr("id") != "mqc_noneofabove"){
    $(this).prop("checked", false);
}

})
}
}
else {

$('input:checkbox[name=mqc_noneofabove]').prop("checked", false);
}
})


$("#mqc_circumstance :input").change (function(){


if ($(this).attr("id") == "mqc_none_apply"){
if( $('input:checkbox[name=mqc_none_apply]:checked').val() == 'y'){



$("#mqc_circumstance :input").each(function (index, element){
   if ($(this).attr("id") != "mqc_none_apply"){
    $(this).prop("checked", false);
}

})
}
}
else {

$('input:checkbox[name=mqc_none_apply]').prop("checked", false);
}
})







//all inputs to validate, including the initially hidden ones
var inputs = {"inputsText": inputsText, "inputsCheckboxRadio": inputsCheckboxRadio};

</script>
<script type="text/javascript">
var axel = Math.random() + "";
var a = axel * 10000000000000;
document.write('<iframe src="https://4381487.fls.doubleclick.net/activityi;src=4381487;type=searc942;cat=medic080;ord=1;num=' + a + '?" width="1" height="1" frameborder="0" style="display:none"></iframe>');
</script>
<noscript>
<iframe src="https://4381487.fls.doubleclick.net/activityi;src=4381487;type=searc942;cat=medic080;ord=1;num=1?" width="1" height="1" frameborder="0" style="display:none"></iframe>
</noscript>
<!-- End of DoubleClick Floodlight Tag: Please do not remove -->
