//file included in the mqc3 questionnaire

//Lynna Cekova; moving the birth year field on the next row
//$("label[id="label_mqc_birth_year"]").before ("<br/>");

//Lynna Cekova; show the # of days in a month based on the month and year

birthDay (); //upon load

$("#mqc_birth_month").change (function (){ //upon change

birthDay ();

})



//Lynna Cekova: dislpay state-specific information (and validate the zip code) when the user has typed five symbols
//Code in this file is for checks upon submit; the mqc.js file has the code for zip validation-based questions
//hide all Medicaid options (Q. 6 additional)

//console.log ("it is starting to hide the zip info");
$("#mqc_health_insurance_coverage .checkbox").hide();
//$("#mqc_health_insurance_coverage :input").removeAttr("checked");


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
 
hIUncheck();

//hide all state-specific programs for Q.9
$("#mqc_medicareadditional .checkbox").hide();

//$("#mqc_medicareadditional :input").removeAttr("checked");
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


medicareAdditionalUncheck (); //the function is in mqc.js
 


//Lynna Cekova: inputs to validate upon submit
var inputsText = { "select_mqc_client": "Form Completion", "mqc_zipcode": "Zip Code", "mqc_birth_month": "Birth Month", "mqc_birth_year": "Birth Year", "mqc_birth_day": "Birth Day", "select_mqc_marital": "Marital Status" };

var inputsCheckboxRadio = { "mqc_medicareadditional": "This field", "mqc_medicaretype_2": "This field", "mqc_coveragesatisfaction_2": "This field", "mqc_medicare_enroll_situation": "This field", "mqc_health_insurance": "This field", "mqc_receive_hsa": "This field", "mqc_circumstance": "This field", "mqc_income": "This field", "mqc_describesituation": "This field"}; //removed "mqc_income_retired" from here upon Chansopine"s request




//Lynna Cekova MQC3 form: QUESTION 5 and derivatives: show derivatives (-1, which depends on a derivative) if medicare, hide if not, and show a modal window if medicare not planned


if( $("input:radio[name=mqc_medicare_enroll_situation]:checked").val() == "mqc_medicare_enroll_disability_yes" || $("input:radio[name=mqc_medicare_enroll_situation]:checked").val() == "mqc_medicare_enroll_disability_no"){

//$("#mqc_medicaretype_2").show();
//inputsCheckboxRadio["mqc_medicaretype_2"] = "This field";
$("#mqc_medicarecoverage").show();
inputsCheckboxRadio["mqc_medicarecoverage"] = "This field";
}

else {

//$("#mqc_medicaretype_2").hide();
//$("#mqc_medicaretype_2").prev(".alert").remove()
//$("#mqc_medicaretype_2 :input").removeAttr("checked");
//delete inputsCheckboxRadio.mqc_medicaretype_2;

$("#mqc_medicarecoverage").hide();
$("#mqc_medicarecoverage").prev(".alert").remove()
delete inputsCheckboxRadio.mqc_medicarecoverage;
$("#mqc_medicarecoverage :input").removeAttr("checked");

$("#mqc_additionalplans").hide();
$("#mqc_additionalplans").prev(".alert").remove();
delete inputsCheckboxRadio.mqc_additionalplans;
$("#mqc_additionalplans :input").removeAttr("checked");

}


if( $("input:radio[name=mqc_medicarecoverage]:checked").val() == "mqc_originalmedicare"){
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

if( $("input:radio[name=mqc_medicare_enroll_situation]:checked").val() == "mqc_medicare_enroll_disability_yes" || $("input:radio[name=mqc_medicare_enroll_situation]:checked").val() == "mqc_medicare_enroll_disability_no"){


//$("#mqc_medicaretype_2").show();
//inputsCheckboxRadio["mqc_medicaretype_2"] = "This field";
$("#mqc_medicarecoverage").show();
inputsCheckboxRadio["mqc_medicarecoverage"] = "This field";

}

else {


//$("#mqc_medicaretype_2").hide();
//$("#mqc_medicaretype_2").prev(".alert").remove()
//$("#mqc_medicaretype_2 :input").removeAttr("checked");
//delete inputsCheckboxRadio.mqc_medicaretype_2;

$("#mqc_medicarecoverage").hide();
$("#mqc_medicarecoverage").prev(".alert").remove()
delete inputsCheckboxRadio.mqc_medicarecoverage;
$("#mqc_medicarecoverage :input").removeAttr("checked");

$("#mqc_additionalplans").hide();
$("#mqc_additionalplans").prev(".alert").remove();
delete inputsCheckboxRadio.mqc_additionalplans;
$("#mqc_additionalplans :input").removeAttr("checked");


}

if( $("input:radio[name=mqc_medicare_enroll_situation]:checked").val() == "mqc_medicare_enroll_within_1_year_no" || $("input:radio[name=mqc_medicare_enroll_situation]:checked").val() == "mqc_not_sure_medicare_qualify"|| $("input:radio[name=mqc_medicare_enroll_situation]:checked").val() == "mqc_medicare_enroll_age_65"){

$("#medicareInfo").modal("show");
}

})

$("#mqc_medicaretype_2 :input").change (function(){

//console.log ("registers change");

depCheckbox ("mqc_medicaretype_2", $(this), "mqc_receivingparta",  $("#mqc_not_receiving_parta,#mqc_not_eligible_parta"));

})





$("input:radio[name=mqc_medicarecoverage]").change (function(){

if( $("input:radio[name=mqc_medicarecoverage]:checked").val() == "mqc_originalmedicare"){
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


if( $("input:radio[name=mqc_health_insurance]:checked").val() == "n"){

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

if( $("input:radio[name=mqc_health_insurance]:checked").val() == "n"){

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

if( $("input:checkbox[name=mqc_group_insurance_self]:checked").val() == "y"){

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

if( $("input:checkbox[name=mqc_group_insurance_self]:checked").val() == "y"){

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


if( $("input:checkbox[name=mqc_group_insurance_spouse]:checked").val() == "y"){

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

if( $("input:checkbox[name=mqc_group_insurance_spouse]:checked").val() == "y"){

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


if( $("input:checkbox[name=mqc_group_insurance_spouse]:checked").val() == "y"
|| $("input:checkbox[name=mqc_group_insurance_self]:checked").val() == "y"
|| $("input:checkbox[name=mqc_former_employer_retiree_benefit]:checked").val() == "y"
|| $("input:checkbox[name=mqc_individual_insurance]:checked").val() == "y"
|| $("input:checkbox[name=mqc_cobra]:checked").val() == "y"

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



if( $("input:checkbox[name=mqc_group_insurance_spouse]:checked").val() == "y"
|| $("input:checkbox[name=mqc_group_insurance_self]:checked").val() == "y"
|| $("input:checkbox[name=mqc_former_employer_retiree_benefit]:checked").val() == "y"
|| $("input:checkbox[name=mqc_individual_insurance]:checked").val() == "y"
|| $("input:checkbox[name=mqc_cobra]:checked").val() == "y"

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
if( $("input:checkbox[name=mqc_insurance_type_none]:checked").val() == "y"){



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

$("input:checkbox[name=mqc_insurance_type_none]").prop("checked", false);


}




})



//Lynna Cekova, question code=mqc_health_insurance_coverage, taking care of the "None of the above" case

$("#mqc_health_insurance_coverage :input").change (function(){


if ($(this).attr("id") == "mqc_insurance_none_of_the_above"){
if( $("input:checkbox[name=mqc_insurance_none_of_the_above]:checked").val() == "y"){



$("#mqc_health_insurance_coverage :input").each(function (index, element){
   if ($(this).attr("id") != "mqc_insurance_none_of_the_above"){
    $(this).prop("checked", false);
}

})
}
}
else {

$("input:checkbox[name=mqc_insurance_none_of_the_above]").prop("checked", false);
}
})





//Lynna Cekova. Q. 9 and 10, taking care of the "noneofabove" case



$("#mqc_medicareadditional :input").change (function(){


if ($(this).attr("id") == "mqc_noneofabove"){
if( $("input:checkbox[name=mqc_noneofabove]:checked").val() == "y"){



$("#mqc_medicareadditional :input").each(function (index, element){
   if ($(this).attr("id") != "mqc_noneofabove"){
    $(this).prop("checked", false);
}

})
}
}
else {

$("input:checkbox[name=mqc_noneofabove]").prop("checked", false);
}
})


$("#mqc_circumstance :input").change (function(){


if ($(this).attr("id") == "mqc_none_apply"){
if( $("input:checkbox[name=mqc_none_apply]:checked").val() == "y"){



$("#mqc_circumstance :input").each(function (index, element){
   if ($(this).attr("id") != "mqc_none_apply"){
    $(this).prop("checked", false);
}

})
}
}
else {

$("input:checkbox[name=mqc_none_apply]").prop("checked", false);
}
})







//all inputs to validate, including the initially hidden ones
var inputs = {"questionnaireName": "mqc3", "inputsText": inputsText, "inputsCheckboxRadio": inputsCheckboxRadio};
