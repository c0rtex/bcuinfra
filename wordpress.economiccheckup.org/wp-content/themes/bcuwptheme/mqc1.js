//file included in the mqc1 questionnaire

//Lynna Cekova: for triggering "change" upon dynamically checking or unchecking checkbox
/*
jQuery.propHooks.checked = {
    set: function (el, value) {
        if (el.checked !== value) {
            el.checked = value;
            $(el).trigger('change');
        }
    }
};

*/

//Lynna Cekova; show the # of days in a month based on the month and year

birthDay (); //upon load

$("#mqc_birth_month").change (function (){ //upon change

birthDay ();

})

//Lynna Cekova: take care of "none of the above" cases


$("#mqc_health_insurance_type_aep :input").change (function(){

noneCheckbox ("mqc_health_insurance_type_aep", $(this), "mqc_insurance_type_none");

})

$("#mqc_health_insurance_cover_aep :input").change (function(){

noneCheckbox ("mqc_health_insurance_cover_aep", $(this), "mqc_insurance_none_of_the_above");

})

$("#mqc_medicareadditional_aep :input").change (function(){

noneCheckbox ("mqc_medicareadditional_aep", $(this), "mqc_noneofabove");

})

$("#mqc_circumstance_aep :input").change (function(){

noneCheckbox ("mqc_circumstance_aep", $(this), "mqc_none_apply");

})


$("#mqc_medicaretype :input").change (function(){

//console.log ("registers change");

depCheckbox ("mqc_medicaretype", $(this), "mqc_receivingparta",  $("#mqc_not_receiving_parta,#mqc_not_eligible_parta"));

})





//Lynna Cekova: dislpay state-specific information (and validate the zip code) when the user has typed five symbols
//Code in this file is for checks upon submit; the mqc.js file has the code for zip validation-based questions
//hide all Medicaid options

$("#mqc_health_insurance_cover_aep .checkbox").hide();
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
 



//Lynna Cekova, show medicare types only if 

//console.log ("TESTING");
medicareAdditional ();


$("input:radio[name=mqc_medicare_enroll_situation]").change (function(){


medicareAdditional ();

});




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



//Lynna Cekova: dislpay state-specific information (and validate the zip code) when the user has typed five symbols
//Code in this file is for checks upon submit; the mqc.js file has the code for zip validation-based questions
//hide all Medicaid options
$("#mqc_health_insurance_cover_aep .checkbox").hide();


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
$("#mqc_medicareadditional_aep .checkbox").hide();

//show all options that show anyway
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
 

$("input:radio[name=mqc_medicare_enroll_situation]").change (function(){

if( $('input:radio[name=mqc_medicare_enroll_situation]:checked').val() == 'mqc_medicare_enroll_within_1_year_no' || $('input:radio[name=mqc_medicare_enroll_situation]:checked').val() == 'mqc_not_sure_medicare_qualify'){

$("#medicareInfo").modal('show');
}

})


function medicareAdditional (){


if( $('input:radio[name=mqc_medicare_enroll_situation]:checked').val() == 'mqc_medicare_enroll_disability_yes' || $('input:radio[name=mqc_medicare_enroll_situation]:checked').val() == 'mqc_medicare_enroll_age_65'){

$("#mqc_medicaretype").show();
}

else {

$("#mqc_medicaretype").hide();
$("#mqc_medicaretype").prev(".alert").remove()
$("#mqc_medicaretype :input").removeAttr("checked");

}




}




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
healthInsSelf();
insCreditable ();
})

$("input:checkbox[name=mqc_former_employer_retiree_benefit]").change (function(){
//console.log ("gets to retiree change at all");
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

//generic, no answers
$("#mqc_health_insurance_type_aep").hide();
$("#mqc_health_insurance_type_aep").prev(".alert").remove();
$("#mqc_health_insurance_type_aep :input").removeAttr("checked");
//delete inputsCheckboxRadio.mqc_health_insurance_type;
$("#mqc_number_employees_self_aep").hide();
$("#mqc_number_employees_self_aep").prev(".alert").remove();
$("#mqc_number_employees_self_aep :input").removeAttr("checked");
//delete inputsCheckboxRadio.mqc_number_employees_self;
$("#mqc_number_employees_spouse_aep").hide();
$("#mqc_number_employees_spouse_aep").prev(".alert").remove();
$("#mqc_number_employees_spouse_aep :input").removeAttr("checked");
//delete inputsCheckboxRadio.mqc_number_employees_spouse;
$("#mqc_health_ins_creditable_aep").hide();
$("#mqc_health_ins_creditable_aep").prev(".alert").remove();
$("#mqc_health_ins_creditable_aep :input").removeAttr("checked");
//delete inputsCheckboxRadio.mqc_health_ins_creditable;
$("#mqc_health_insurance_cover_aep").hide();
$("#mqc_health_insurance_cover_aep").prev(".alert").remove();
$("#mqc_health_insurance_cover_aep :input").removeAttr("checked");
$("#mqc_retiree_plan_select").hide();
$("#mqc_retiree_plan_select").prev(".alert").remove();
$("#mqc_retiree_plan_select :input").removeAttr("checked");



if( $('input:radio[name=mqc_health_insurance]:checked').val() == 'n'){

$("#mqc_health_insurance_type_aep").hide();
$("#mqc_health_insurance_type_aep").prev(".alert").remove();
$("#mqc_health_insurance_type_aep :input").removeAttr("checked");
//delete inputsCheckboxRadio.mqc_health_insurance_type;
$("#mqc_number_employees_self_aep").hide();
$("#mqc_number_employees_self_aep").prev(".alert").remove();
$("#mqc_number_employees_self_aep :input").removeAttr("checked");
//delete inputsCheckboxRadio.mqc_number_employees_self;
$("#mqc_number_employees_spouse_aep").hide();
$("#mqc_number_employees_spouse_aep").prev(".alert").remove();
$("#mqc_number_employees_spouse_aep :input").removeAttr("checked");
//delete inputsCheckboxRadio.mqc_number_employees_spouse;
$("#mqc_health_ins_creditable_aep").hide();
$("#mqc_health_ins_creditable_aep").prev(".alert").remove();
$("#mqc_health_ins_creditable_aep :input").removeAttr("checked");
//delete inputsCheckboxRadio.mqc_health_ins_creditable;
$("#mqc_health_insurance_cover_aep").hide();
$("#mqc_health_insurance_cover_aep").prev(".alert").remove();
$("#mqc_health_insurance_cover_aep :input").removeAttr("checked");
//delete inputsCheckboxRadio.mqc_health_insurance_coverage;
//console.log ("It is N");
$("#mqc_retiree_plan_select").hide();
$("#mqc_retiree_plan_select").prev(".alert").remove();
$("#mqc_retiree_plan_select :input").removeAttr("checked");


}
else {

//console.log ("It is Y");
$("#mqc_health_insurance_type_aep").show();
//inputsCheckboxRadio["mqc_health_insurance_type_aep"] = "This field";
$("#mqc_health_insurance_cover_aep").show();
//inputsCheckboxRadio["mqc_health_insurance_coverage"] = "This field";
}

}

function healthInsSpouse (){

if( $('input:checkbox[name=mqc_group_insurance_spouse]:checked').val() == 'y'){

$("#mqc_number_employees_spouse_aep").show();
//inputsCheckboxRadio["mqc_number_employees_spouse"] = "This field";
}

else {

$("#mqc_number_employees_spouse_aep").hide();
$("#mqc_number_employees_spouse_aep").prev(".alert").remove();
$("#mqc_number_employees_spouse_aep :input").removeAttr("checked");
//delete inputsCheckboxRadio.mqc_number_employees_spouse;
}

}


function healthInsSelf (){


if( $('input:checkbox[name=mqc_group_insurance_self]:checked').val() == 'y'){

$("#mqc_number_employees_self_aep").show();
//inputsCheckboxRadio["mqc_number_employees_self_aep"] = "This field";
}

else {

$("#mqc_number_employees_self_aep").hide();
$("#mqc_number_employees_self_aep").prev(".alert").remove();
$("#mqc_number_employees_self_aep :input").removeAttr("checked");
//delete inputsCheckboxRadio.mqc_number_employees_self;
}

}

function retireeBenefit () {

if ( $('input:checkbox[name=mqc_former_employer_retiree_benefit]:checked').val() == 'y' ){

//console.log ("gets to retiree change to show at all");
$("#mqc_retiree_plan_select").show();

}

else {

//console.log ("gets to retiree change to hide at all");
$("#mqc_retiree_plan_select").hide();
$("#mqc_retiree_plan_select").prev(".alert").remove();
$("#mqc_retiree_plan_select :input").removeAttr("checked");
}


}

function insCreditable (){

if ( $('input:checkbox[name=mqc_former_employer_retiree_benefit]:checked').val() == 'y' || $('input:checkbox[name=mqc_group_insurance_spouse]:checked').val() == 'y' || $('input:checkbox[name=mqc_group_insurance_self]:checked').val() == 'y' || $('input:checkbox[name=mqc_individual_insurance]:checked').val() == 'y' || $('input:checkbox[name=mqc_cobra]:checked').val() == 'y' ){


$("#mqc_health_ins_creditable_aep").show();

}

else {
$("#mqc_health_ins_creditable_aep").hide();

$("#mqc_health_ins_creditable_aep .radio").each(function (index, element){
   if ($(this).is(":hidden")){
//console.log ("YES");
//console.log ($(this));
$(this).find(":input").removeAttr("checked");
}
});


}

}










