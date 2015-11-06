//file included in the mqc2 questionnaire



//Lynna Cekova; show the # of days in a month based on the month and year

birthDay (); //upon load

$("#mqc_birth_month").change (function (){ //upon change

birthDay ();

})


$("#mqc_health_insurance_type_ahn :input").change (function(){

noneCheckbox ("mqc_health_insurance_type_ahn", $(this), "mqc_insurance_type_none");

})



$("#mqc_circumstance_ahn :input").change (function(){

noneCheckbox ("mqc_circumstance_ahn", $(this), "mqc_none_apply");

})

$("#mqc_medicaretype_2 :input").change (function(){

//console.log ("registers change");

depCheckbox ("mqc_medicaretype_2", $(this), "mqc_receivingparta",  $("#mqc_not_receiving_parta,#mqc_not_eligible_parta"));

})



//Lynna Cekova: dislpay state-specific information (and validate the zip code) when the user has typed five symbols
//Code in this file is for checks upon submit; the mqc.js file has the code for zip validation-based questions
//hide all Medicaid options

console.log ("it is starting to hide the zip info");
$("#mqc_health_insurance_cover_ahn .checkbox").hide();
//$("#mqc_health_insurance_cover_ahn :input").removeAttr("checked");


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
 


//Lynna Cekova MQC form: QUESTIONS 4 and 5: show Q5 if medicare selected, hide and show a modal window if not

//upon page load

if( $('input:radio[name=mqc_medicare]:checked').val() == 'y'){
$("#mqc_medicare_enroll_no").hide();
$("input:radio[name=mqc_medicare_enroll_no]").prop("checked", false);
$("#mqc_medicare_enroll").show();

}
else if( $('input:radio[name=mqc_medicare]:checked').val() == 'n'){
$("#mqc_medicare_enroll").hide();
$("input:radio[name=mqc_medicare_enroll]").prop("checked", false);
$("#mqc_medicare_enroll_no").show();

}
else if( $('input:radio[name=mqc_medicare]:checked').val() == 'dontknow'){
$("#mqc_medicare_enroll_no").hide();
$("input:radio[name=mqc_medicare_enroll_no]").prop("checked", false);
$("#mqc_medicare_enroll").hide();
$("input:radio[name=mqc_medicare_enroll]").prop("checked", false);


}

//upon change

$("input:radio[name=mqc_medicare]").change (function(){

if( $('input:radio[name=mqc_medicare]:checked').val() == 'y'){

$("#mqc_medicare_enroll_no").hide();
$("input:radio[name=mqc_medicare_enroll_no]").prop("checked", false);
$("#mqc_medicare_enroll").show();
}
else if( $('input:radio[name=mqc_medicare]:checked').val() == 'n'){

$("#mqc_medicare_enroll").hide();
$("input:radio[name=mqc_medicare_enroll]").prop("checked", false);
$("#mqc_medicare_enroll_no").show();
}
else if( $('input:radio[name=mqc_medicare]:checked').val() == 'dontknow'){
$("#mqc_medicare_enroll_no").hide();
$("input:radio[name=mqc_medicare_enroll_no]").prop("checked", false);
$("#mqc_medicare_enroll").hide();
$("input:radio[name=mqc_medicare_enroll]").prop("checked", false);

}
})


$("input:radio[name=mqc_medicare_enroll_no]").change (function(){

if( $('input:radio[name=mqc_medicare_enroll_no]:checked').val() == 'mqc_medicare_enroll_within_1_year_no'){

$("#medicareInfo").modal('show');
}

else {

//do nothing for now
}
})




//Lynna Cekova MQC form: QUESTIONS 8, 9, 10

//upon page load

//hide the specific plan options by (Q9 and Q10 by default)
$("#mqc_additionalplans").hide();
$("#mqc_additionalplans").prev(".alert").remove();
$("#mqc_additionalplans :input").removeAttr("checked");

$("#mqc_medicarehealthplan_coverage").hide();
$("#mqc_medicarehealthplan_coverage").prev(".alert").remove();
$("#mqc_medicarehealthplan_coverage :input").removeAttr("checked");


if( $('input:radio[name=mqc_medicarecoverage]:checked').val() == 'mqc_medhealthplan'){

$("#mqc_additionalplans").hide();
$("#mqc_additionalplans").prev(".alert").remove();
$("#mqc_additionalplans :input").removeAttr("checked");

$("#mqc_medicarehealthplan_coverage").show();

}
else if( $('input:radio[name=mqc_medicarecoverage]:checked').val() == 'mqc_originalmedicare'){

$("#mqc_additionalplans").show();
$("#mqc_medicarehealthplan_coverage").hide();
$("#mqc_medicarehealthplan_coverage").prev(".alert").remove();
$("#mqc_medicarehealthplan_coverage :input").removeAttr("checked");

}


//upon change
$("input:radio[name=mqc_medicarecoverage]").change (function(){

if( $('input:radio[name=mqc_medicarecoverage]:checked').val() == 'mqc_medhealthplan'){

$("#mqc_additionalplans").hide();
$("#mqc_additionalplans").prev(".alert").remove();
$("#mqc_additionalplans :input").removeAttr("checked");

$("#mqc_medicarehealthplan_coverage").show();

}
else if( $('input:radio[name=mqc_medicarecoverage]:checked').val() == 'mqc_originalmedicare'){

$("#mqc_additionalplans").show();
$("#mqc_medicarehealthplan_coverage").hide();
$("#mqc_medicarehealthplan_coverage").prev(".alert").remove();
$("#mqc_medicarehealthplan_coverage :input").removeAttr("checked");

}
else {
$("#mqc_additionalplans").hide();
$("#mqc_additionalplans").prev(".alert").remove();
$("#mqc_additionalplans :input").removeAttr("checked");

$("#mqc_medicarehealthplan_coverage").hide();
$("#mqc_medicarehealthplan_coverage").prev(".alert").remove();
$("#mqc_medicarehealthplan_coverage :input").removeAttr("checked");


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
$("input:radio[name=mqc_work_situation]").prop("checked", false);


}
else if( $('input:radio[name=mqc_retiree_plan]:checked').val() == 'n'){

$("#mqc_retiree_plan_select").hide();
$("input:radio[name=mqc_retiree_plan_select]").prop("checked", false);
$("#mqc_work_situation").show();
}
else if( $('input:radio[name=mqc_retiree_plan]:checked').val() == 'dontknow'){

$("#mqc_retiree_plan_select").hide();
$("input:radio[name=mqc_retiree_plan_select]").prop("checked", false);
$("#mqc_work_situation").hide();
$("input:radio[name=mqc_work_situation]").prop("checked", false);
}

//Lynna Cekova, MQC CE QUESTION 8

//upon page load

if( $('input:checkbox[name=mqc_noneofabove]:checked').val() == 'y'){
$('#mqc_situation').find(':checkbox').each(function(){

//console.log($(this).prop("id"));
if ($(this).prop("name") != 'mqc_noneofabove'){
$(this).prop("checked", false);
}



})
}

if( $('input:checkbox[name=mqc_receivingrrb]:checked').val() == 'y'){

$("input:checkbox[name=mqc_noneofabove]").prop("checked", false);
}


if( $('input:checkbox[name=mqc_receivingtricare]:checked').val() == 'y'){

$("input:checkbox[name=mqc_noneofabove]").prop("checked", false);
}

if( $('input:checkbox[name=mqc_recvetben]:checked').val() == 'y'){

$("input:checkbox[name=mqc_noneofabove]").prop("checked", false);
}

if( $('input:checkbox[name=mqc_govben]:checked').val() == 'y'){

$("input:checkbox[name=mqc_noneofabove]").prop("checked", false);
}

if( $('input:checkbox[name=mqc_livenursingfacility]:checked').val() == 'y'){

$("input:checkbox[name=mqc_noneofabove]").prop("checked", false);
}

if( $('input:checkbox[name=mqc_renaldisease]:checked').val() == 'y'){

$("input:checkbox[name=mqc_noneofabove]").prop("checked", false);
}

if( $('input:checkbox[name=mqc_als]:checked').val() == 'y'){

$("input:checkbox[name=mqc_noneofabove]").prop("checked", false);
}




//upon change

$("input:checkbox[name=mqc_noneofabove]").change (function(){
if( $('input:checkbox[name=mqc_noneofabove]:checked').val() == 'y'){
$('#mqc_situation').find(':checkbox').each(function(){

//console.log($(this).prop("id"));
if ($(this).prop("name") != 'mqc_noneofabove'){
$(this).prop("checked", false);
}

   });

}

})

$("input:checkbox[name=mqc_receivingrrb]").change (function(){
if( $('input:checkbox[name=mqc_receivingrrb]:checked').val() == 'y'){

$("input:checkbox[name=mqc_noneofabove]").prop("checked", false);
}
})


$("input:checkbox[name=mqc_receivingtricare]").change (function(){
if( $('input:checkbox[name=mqc_receivingtricare]:checked').val() == 'y'){

$("input:checkbox[name=mqc_noneofabove]").prop("checked", false);
}
})

$("input:checkbox[name=mqc_recvetben]").change (function(){
if( $('input:checkbox[name=mqc_recvetben]:checked').val() == 'y'){

$("input:checkbox[name=mqc_noneofabove]").prop("checked", false);
}
})

$("input:checkbox[name=mqc_govben]").change (function(){
if( $('input:checkbox[name=mqc_govben]:checked').val() == 'y'){

$("input:checkbox[name=mqc_noneofabove]").prop("checked", false);
}
})

$("input:checkbox[name=mqc_livenursingfacility]").change (function(){
if( $('input:checkbox[name=mqc_livenursingfacility]:checked').val() == 'y'){

$("input:checkbox[name=mqc_noneofabove]").prop("checked", false);
}
})

$("input:checkbox[name=mqc_renaldisease]").change (function(){
if( $('input:checkbox[name=mqc_renaldisease]:checked').val() == 'y'){

$("input:checkbox[name=mqc_noneofabove]").prop("checked", false);
}
})

$("input:checkbox[name=mqc_als]").change (function(){
if( $('input:checkbox[name=mqc_als]:checked').val() == 'y'){

$("input:checkbox[name=mqc_noneofabove]").prop("checked", false);
}
})







//upon change
$("input:radio[name=mqc_retiree_plan]").change (function(){

if( $('input:radio[name=mqc_retiree_plan]:checked').val() == 'y'){
$("#mqc_retiree_plan_select").show();
$("#mqc_work_situation").hide();
$("input:radio[name=mqc_work_situation]").prop("checked", false);
}
else if( $('input:radio[name=mqc_retiree_plan]:checked').val() == 'n'){

$("#mqc_retiree_plan_select").hide();
$("#mqc_work_situation").show();
$("input:radio[name=mqc_retiree_plan_select]").prop("checked", false);
}
else if( $('input:radio[name=mqc_retiree_plan]:checked').val() == 'dontknow'){

$("#mqc_retiree_plan_select").hide();
$("#mqc_work_situation").hide();
$("input:radio[name=mqc_retiree_plan_select]").prop("checked", false);
$("input:radio[name=mqc_work_situation]").prop("checked", false);
}







})

//Lynna Cekova MQC form: QUESTIONS 19 and 20

//upon page load

if( $('input:checkbox[name=mqc_provideroutofnetwork]:checked').val() == 'y'){

$("#mqc_plan_network_problem").show();
}

else {

$("#mqc_plan_network_problem").hide();
$("#mqc_plan_network_problem").prev(".alert").remove();
$("#mqc_plan_network_problem :input").removeAttr("checked");

}

//upon change

$("input:checkbox[name=mqc_provideroutofnetwork]").change (function(){

if( $('input:checkbox[name=mqc_provideroutofnetwork]:checked').val() == 'y'){

$("#mqc_plan_network_problem").show();
}

else {

$("#mqc_plan_network_problem").hide();
$("#mqc_plan_network_problem").prev(".alert").remove();
$("#mqc_plan_network_problem :input").removeAttr("checked");

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


$("input:radio[name=mqc_medicare_enroll_situation]").change (function(){

if( $('input:radio[name=mqc_medicare_enroll_situation]:checked').val() == 'mqc_medicare_enroll_within_1_year_no' || $('input:radio[name=mqc_medicare_enroll_situation]:checked').val() == 'mqc_not_sure_medicare_qualify'){

$("#medicareInfo").modal('show');
}

})

//Lynna Cekova, MQC1, Q (other health insurance) and derivatives


healthInsuranceDepQ ();


//upon change

$("input:radio[name=mqc_health_insurance]").change (function(){

healthInsuranceDepQ ();

})

//self and spouse insurance options

healthInsSelf ();

healthInsSpouse ();

retireeBenefit ();


insCreditable ();

$("input:checkbox[name=mqc_group_insurance_spouse]").change (function(){
healthInsSpouse ();
insCreditable ();
})

$("input:checkbox[name=mqc_group_insurance_self]").change (function(){
//console.log ("records self at all");
healthInsSelf();
insCreditable ();
})

$("input:checkbox[name=mqc_former_employer_retiree_benefit]").change (function(){
retireeBenefit ();
insCreditable ();
})

$("input:checkbox[name=mqc_individual_insurance]").change (function(){
insCreditable ();
})

$("input:checkbox[name=mqc_cobra]").change (function(){
insCreditable ();
})




function healthInsuranceDepQ (){

//generic case
$("#mqc_health_insurance_type_ahn").hide();
$("#mqc_health_insurance_type_ahn").prev(".alert").remove();
$("#mqc_health_insurance_type_ahn :input").removeAttr("checked");
//delete inputsCheckboxRadio.mqc_health_insurance_type;
$("#mqc_number_employees_self_ahn").hide();
$("#mqc_number_employees_self_ahn").prev(".alert").remove();
$("#mqc_number_employees_self_ahn :input").removeAttr("checked");
//delete inputsCheckboxRadio.mqc_number_employees_self;
$("#mqc_number_employees_spouse_ahn").hide();
$("#mqc_number_employees_spouse_ahn").prev(".alert").remove();
$("#mqc_number_employees_spouse_ahn :input").removeAttr("checked");
//delete inputsCheckboxRadio.mqc_number_employees_spouse;
$("#mqc_health_ins_creditable_ahn").hide();
$("#mqc_health_ins_creditable_ahn").prev(".alert").remove();
$("#mqc_health_ins_creditable_ahn :input").removeAttr("checked");
//delete inputsCheckboxRadio.mqc_health_ins_creditable;
$("#mqc_health_insurance_cover_ahn").hide();
$("#mqc_health_insurance_cover_ahn").prev(".alert").remove();
$("#mqc_health_insurance_cover_ahn :input").removeAttr("checked");
$("#mqc_retiree_plan_select").hide();
$("#mqc_retiree_plan_select").prev(".alert").remove();
$("#mqc_retiree_plan_select :input").removeAttr("checked");


if( $('input:radio[name=mqc_health_insurance]:checked').val() == 'n'){

$("#mqc_health_insurance_type_ahn").hide();
$("#mqc_health_insurance_type_ahn").prev(".alert").remove();
$("#mqc_health_insurance_type_ahn :input").removeAttr("checked");
//delete inputsCheckboxRadio.mqc_health_insurance_type;
$("#mqc_number_employees_self_ahn").hide();
$("#mqc_number_employees_self_ahn").prev(".alert").remove();
$("#mqc_number_employees_self_ahn :input").removeAttr("checked");
//delete inputsCheckboxRadio.mqc_number_employees_self;
$("#mqc_number_employees_spouse_ahn").hide();
$("#mqc_number_employees_spouse_ahn").prev(".alert").remove();
$("#mqc_number_employees_spouse_ahn :input").removeAttr("checked");
//delete inputsCheckboxRadio.mqc_number_employees_spouse;
$("#mqc_health_ins_creditable_ahn").hide();
$("#mqc_health_ins_creditable_ahn").prev(".alert").remove();
$("#mqc_health_ins_creditable_ahn :input").removeAttr("checked");
//delete inputsCheckboxRadio.mqc_health_ins_creditable;
$("#mqc_health_insurance_cover_ahn").hide();
$("#mqc_health_insurance_cover_ahn").prev(".alert").remove();
$("#mqc_health_insurance_cover_ahn :input").removeAttr("checked");
$("#mqc_retiree_plan_select").hide();
$("#mqc_retiree_plan_select").prev(".alert").remove();
$("#mqc_retiree_plan_select :input").removeAttr("checked");

//delete inputsCheckboxRadio.mqc_health_insurance_cover_ahn;
//console.log ("It is N");

}
else {

//console.log ("It is Y");
$("#mqc_health_insurance_type_ahn").show();
//inputsCheckboxRadio["mqc_health_insurance_type_ahn"] = "This field";
$("#mqc_health_insurance_cover_ahn").show();
//inputsCheckboxRadio["mqc_health_insurance_cover_ahn"] = "This field";
}

}


function healthInsSpouse (){

if( $('input:checkbox[name=mqc_group_insurance_spouse]:checked').val() == 'y'){

$("#mqc_number_employees_spouse_ahn").show();
//inputsCheckboxRadio["mqc_number_employees_spouse"] = "This field";
}

else {

$("#mqc_number_employees_spouse_ahn").hide();
$("#mqc_number_employees_spouse_ahn").prev(".alert").remove();
$("#mqc_number_employees_spouse_ahn :input").removeAttr("checked");
//delete inputsCheckboxRadio.mqc_number_employees_spouse;
}

}


function healthInsSelf (){


if( $('input:checkbox[name=mqc_group_insurance_self]:checked').val() == 'y'){

$("#mqc_number_employees_self_ahn").show();
//inputsCheckboxRadio["mqc_number_employees_self_ahn"] = "This field";
//console.log ("inside self show");
}

else {

//console.log ("inside self hide");

$("#mqc_number_employees_self_ahn").hide();
$("#mqc_number_employees_self_ahn").prev(".alert").remove();
$("#mqc_number_employees_self_ahn :input").removeAttr("checked");
//delete inputsCheckboxRadio.mqc_number_employees_self;
}






}

function retireeBenefit () {

if ( $('input:checkbox[name=mqc_former_employer_retiree_benefit]:checked').val() == 'y' ){

$("#mqc_retiree_plan_select").show();

}

else {

$("#mqc_retiree_plan_select").hide();
$("#mqc_retiree_plan_select").prev(".alert").remove();
$("#mqc_retiree_plan_select :input").removeAttr("checked");
}


}

function insCreditable (){

if ( $('input:checkbox[name=mqc_former_employer_retiree_benefit]:checked').val() == 'y' || $('input:checkbox[name=mqc_group_insurance_spouse]:checked').val() == 'y' || $('input:checkbox[name=mqc_group_insurance_self]:checked').val() == 'y' || $('input:checkbox[name=mqc_individual_insurance]:checked').val() == 'y' || $('input:checkbox[name=mqc_cobra]:checked').val() == 'y' ){

console.log ("creditable ahn show");

$("#mqc_health_ins_creditable_ahn").show();

}

else {
$("#mqc_health_ins_creditable_ahn").hide();
console.log ("creditable ahn hide");

$("#mqc_health_ins_creditable_ahn .radio").each(function (index, element){
   if ($(this).is(":hidden")){
//console.log ("YES");
//console.log ($(this));
$(this).find(":input").removeAttr("checked");
}
});

}

}






