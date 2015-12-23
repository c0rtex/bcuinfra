jQuery(document).ready(function() {
//variables used for the keyup, so that the zip error is only activated when the user finishes typing
var zipTimer;
var zipTimeout = 1000;

//do the state specific info if there is already a zip (e.g. forwarded from triage)

if ($("#mqc_zipcode").val() != null) {
if ($("#mqc_zipcode").val().length == 5) {

console.log (" it is 3");

$("#invalidZipNum").remove();
invalidZipMQC3();

}

else {

console.log ("not 3");

}
}






$("#mqc_zipcode").on( 'keyup', function () {

console.log ("Zip test");

 clearTimeout(zipTimer);


if ($("#mqc_zipcode").val().length == 5) {

$("#invalidZipNum").remove();
invalidZipMQC3();

}

else {

 zipTimer = setTimeout(function(){

if ($("#invalidZipNum").length <=0){ //so that the message is not entered upon every keystroke

invalidZipMQC3Num ();
}

}, zipTimeout);
}

});



		  	var sidebar = $('.sidebar-nav-scroll');
		  	sidebar.scrollToFixed({
			marginTop: $('.navbar').outerHeight(true) + 50,
			zIndex: 999
		  	});
	
		  	var body_headers = $('.body-header');              
			body_headers.each(function(i) {
			var body_header = $(body_headers[i]);
			var next = body_headers[i + 1];
	
			/*body_header.scrollToFixed({
				marginTop: $('.navbar').outerHeight(true) ,
				limit: function() {
				var limit = 0;
				if (next) {
					limit = $(next).offset().top + $(this).outerHeight(true);
				} 
				return limit;
				},
					zIndex: 999
				}); */

			

				
			}); 
			// Define the function to validate the form on submission
			function validateText( inputsText ) {
				// Clear out all previous alerts
				$('.alert').remove();
				validated = 1;
				
				// Begin to check which fields need to filled in
				jQuery.each( inputsText, function( i, val ) {
					if( $( "#" + i ).val() == '') {
			  		$( "#" + i ).before('<div class="alert alert-danger"><i class="icon-warning-sign"></i> <strong>' + val + '</strong> is a required field.</div>');
			  		validated = 0;
			  	};
				});
			}
			
		function validate( inputsText, inputsCheckboxRadio ) {
				$('.alert').remove();
				validated = 1;

				jQuery.each( inputsText, function( i, val ) {
					if( $( "#" + i ).val() == '') {
			  		$( "#" + i ).before('<div class="alert alert-danger"><i class="icon-warning-sign"></i> <strong>' + val + '</strong> is a required field.</div>');
			  		validated = 0;
			  	};
				});
	
				
				// Begin to check which fields need to filled in
				jQuery.each( inputsCheckboxRadio, function( i, val ) {
//console.log (("#" + i));
                                //if( $("#" + i).find('input:checked').length > 0) {
                                if( ! $("#" + i).find('input:checked').length > 0) {
			  		$( "#" + i ).before('<div class="alert alert-danger"><i class="icon-warning-sign"></i> <strong>' + val + '</strong> is a required field.</div>');
			  		validated = 0;
			  	};
				});
			}

			
		
		
			// Start the validation on form submission
			$('#mqcForm').submit (function() {
				// Create an array of input IDs and their names for fields that cannot be blank
//console.log ("gets here");
				var inputsText = { "select_mqc_client": "Form Completion", "mqc_zipcode": "Zip Code", "mqc_birth_month": "Birth Month", "mqc_birth_year": "Birth Year", "mqc_birth_day": "Birth Day", "select_mqc_marital": "Marital Status" };
			
if( $('input:radio[name=mqc_medicare_enroll_situation]:checked').val() == 'mqc_medicare_enroll_within_1_year_no' || $('input:radio[name=mqc_medicare_enroll_situation]:checked').val() == 'mqc_not_sure_medicare_qualify'){
validated = 0;
//console.log ("ce medicare test");

                              $('.alert:not(.modal .alert)').remove(); //remove alerts that are not children of element with class modal
$("#medicareInfo").modal('show');

					$( "#mqc_medicare_enroll_situation" ).before('<div class="alert alert-danger"><i class="icon-warning-sign"></i>You must enter a valid response. Please try again.</div>');

}

else {
				

				validateText( inputsText );
}
				
				// Validate specific input parameters
				


if( $('#mqc_zipcode').val().length != 5 ) {
			          invalidZipMQC3Num ();					}

                                else {


invalidZipMQC3();//to take care of zips such as 11111 1aa11 etc.


}


				
				if( $('input:radio[name=mqc_outofpocket]:checked').val() == null) {
					$( "#mqc_outofpocket" ).before('<div class="alert alert-danger"><i class="icon-warning-sign"></i> <strong>This field</strong> is required</div>');
			  	validated = 0;
				}
			
				

				if( $('input:radio[name=mqc_coveragesatisfaction]:checked').val() == null) {
					$( "#mqc_coveragesatisfaction" ).before('<div class="alert alert-danger"><i class="icon-warning-sign"></i> <strong>This field</strong> is required</div>');
			  	validated = 0;
				}
	
				if( $('input:radio[name=mqc_medicarecoverage]:checked').val() == null) {
					$( "#mqc_medicarecoverage" ).before('<div class="alert alert-danger"><i class="icon-warning-sign"></i> <strong>This field</strong> is required</div>');
			  	validated = 0;
				}

                                if ($("input:checkbox[id=mqc_receivingrrb]:checked").val() == null && $("input:checkbox[id=mqc_receivingrrb]:checked").val() == null && $("input:checkbox[id=mqc_receivingtricare]:checked").val() == null && $("input:checkbox[id=mqc_recvetben]:checked").val() == null && $("input:checkbox[id=mqc_govben]:checked").val() == null && $("input:checkbox[id=mqc_livenursingfacility]:checked").val() == null && $("input:checkbox[id=mqc_renaldisease]:checked").val() == null && $("input:checkbox[id=mqc_als]:checked").val() == null && $("input:checkbox[id=mqc_noneofabove]:checked").val() == null) {
					$( "#mqc_situation" ).before('<div class="alert alert-danger"><i class="icon-warning-sign"></i> Please check at least one checkbox</div>');

			  	validated = 0;
}
                                if (($("input:checkbox[id=mqc_receivingrrb]:checked").val() != null || $("input:checkbox[id=mqc_receivingrrb]:checked").val() != null || $("input:checkbox[id=mqc_receivingtricare]:checked").val() != null || $("input:checkbox[id=mqc_recvetben]:checked").val() != null || $("input:checkbox[id=mqc_govben]:checked").val() != null || $("input:checkbox[id=mqc_livenursingfacility]:checked").val() != null || $("input:checkbox[id=mqc_renaldisease]:checked").val() != null || $("input:checkbox[id=mqc_als]:checked").val() != null) && $("input:checkbox[id=mqc_noneofabove]:checked").val() != null) {
					$( "#mqc_situation" ).before('<div class="alert alert-danger"><i class="icon-warning-sign"></i> Please select "None of these apply to me" only if you have not selected anything else"</div>');

			  	validated = 0;
}



//console.log("Medicare" + $('input:radio[name=mqc_medicare]:checked').val());
//console.log("Validated" + validated);
				
				if(validated == 0) {
					// Do not submission if the form fails validation
					$(".alert-danger")[0].scrollIntoView(true);
					$("#basics .well").prepend('<div class="alert alert-danger"><i class="icon-warning-sign"></i> We\'re sorry, but some responses are missing or were completed incorrectly. Please correct the problems where indicated below.</div>');
					return false;	
				}	
			});


			$('#mqcFormTriage').submit (function() {
//console.log ("triage gets here to submission at all")
				$('.alert').remove();
				validated = 1;


                 if( ! $("#mqc_medicare_enroll_situation").find('input:checked').length > 0) {
			  		$( "#mqc_medicare_enroll_situation" ).before('<div class="alert alert-danger"><i class="icon-warning-sign"></i>Please answer this question so that we can get you on the right path to helping you with your Medicare needs.  </div>');
			  		validated = 0;
}

else if(( $('input:radio[name=mqc_medicare_enroll_situation]:checked').val() == 'mqc_medicare_enroll_within_1_year_no' ))  {
validated = 0;

                              $('.alert:not(.modal .alert)').remove(); //remove alerts that are not children of element with class modal
$("#medicareInfo").modal('show');

					$( "#mqc_medicare_enroll_situation" ).before('<div class="alert alert-danger"><i class="icon-warning-sign"></i>You must enter a valid response. Please try again.</div>');

}

else if( $('input:radio[name=mqc_medicare_enroll_situation]:checked').val() == 'mqc_medicare_enroll_age_65' || $('input:radio[name=mqc_medicare_enroll_situation]:checked').val() == 'mqc_medicare_enroll_disability_yes' ){
validated = 0;

                              $('.alert:not(.modal .alert)').remove(); //remove alerts that are not children of element with class modal
$("#medicareInfo2").modal('show');

					$( "#mqc_medicare_enroll_situation" ).before('<div class="alert alert-danger"><i class="icon-warning-sign"></i>You must enter a valid response. Please try again.</div>');

}

else if(( $('input:radio[name=mqc_medicare_enroll_situation]:checked').val() == 'mqc_not_sure_medicare_qualify' ))  {
validated = 0;

$( "#mqc_medicare_enroll_situation" ).before('<div class="alert alert-danger"><i class="icon-warning-sign"></i>You must enter a valid response. Please try again.</div>');

console.log ("40 quarters");


f40qtr();


}


				if(validated == 0) {
					// Do not submission if the form fails validation
					$(".alert-danger")[0].scrollIntoView(true);
					$("#basics .well").prepend('<div class="alert alert-danger"><i class="icon-warning-sign"></i> We\'re sorry, but some responses are missing or were completed incorrectly. Please correct the problems where indicated below.</div>');
					return false;	
				}	



})

			// Start the validation on form submission
			$('#mqcForm3').submit (inputs, function() {
console.log ("get to the submit at all");
				// inputsText is an array of input IDs and their names for text fields that cannot be blank
		                var inputsText = inputs["inputsText"];	
                                var inputsCheckboxRadio = inputs["inputsCheckboxRadio"];
                                var questionnaireName = inputs["questionnaireName"];

//console.log ("inputscheckboxrdio in mqc.js");
//console.log (inputsCheckboxRadio["mqc_medicare_enroll_situation"]);
//console.log ("q name in mqc.js");
//console.log(questionnaireName);


				

//console.log("validate page" + inputsText);
//console.log("validate page first text" + inputsText["select_mqc_client"]);
//console.log("validate page" + inputsCheckboxRadio);
//console.log("validate page first checkbox" + inputsCheckboxRadio["mqc_medicareadditional"]);



if(( $('input:radio[name=mqc_medicare_enroll_situation]:checked').val() == 'mqc_medicare_enroll_within_1_year_no' || $('input:radio[name=mqc_medicare_enroll_situation]:checked').val() == 'mqc_not_sure_medicare_qualify'|| $('input:radio[name=mqc_medicare_enroll_situation]:checked').val() == 'mqc_medicare_enroll_age_65') && questionnaireName == "mqc3" )  {
validated = 0;

                              $('.alert:not(.modal .alert)').remove(); //remove alerts that are not children of element with class modal
$("#medicareInfo").modal('show');

					$( "#mqc_medicare_enroll_situation" ).before('<div class="alert alert-danger"><i class="icon-warning-sign"></i>You must enter a valid response. Please try again.</div>');

}

else if(( $('input:radio[name=mqc_medicare_enroll_situation]:checked').val() == 'mqc_medicare_enroll_within_1_year_no' ) && questionnaireName == "triage" )  {
validated = 0;

                              $('.alert:not(.modal .alert)').remove(); //remove alerts that are not children of element with class modal
$("#medicareInfo").modal('show');

					$( "#mqc_medicare_enroll_situation" ).before('<div class="alert alert-danger"><i class="icon-warning-sign"></i>You must enter a valid response. Please try again.</div>');

}


else {
//console.log ("Triage gets here at all");


				validate( inputsText, inputsCheckboxRadio );
				
				// Validate specific input parameters
				if( $('#mqc_zipcode').val().length != 5 ) {
			          invalidZipMQC3Num ();					}

                                else {


invalidZipMQC3();//to take care of zips such as 11111 1aa11 etc.


}

                                
}

				
				if(validated == 0) {
//Lynna Cekova: fix for showing the "This field is required" for question 9, since the answers get deleted after submit if there is an unanswered question -- temporary fix

//console.log ("TEST");
//$("#mqc_medicareadditional").prev(".alert").hide();
//			  		$("#mqc_medicareadditional").before('<div class="alert alert-danger"><i class="icon-warning-sign"></i> <strong> This field </strong> is a required field.</div>');



					// Do not submission if the form fails validation
					$(".alert-danger")[0].scrollIntoView(true);
					$("#basics .well").prepend('<div class="alert alert-danger"><i class="icon-warning-sign"></i> We\'re sorry, but some responses are missing or were completed incorrectly. Please correct the problems where indicated below.</div>');
					return false;	
				}	
			});


		  });

function f40qtr (){ //for the triage

$("#mqc_work_soc_sec_10yrs_40qtrs").prev(".alert").remove()
$("#basics .well").prev(".alert").remove();

if( $('input:radio[name=mqc_work_soc_sec_10yrs_40qtrs]:checked').val() == 'y'){

$("#ss1").modal('show');
}

else {

$("#ss2").modal('show');
}

}

function aonFloodlightCompareLink () {
   $(body).append('<!--Start of DoubleClick Floodlight Tag: Please do not removeActivity name of this tag: MQC Text Link to Aon CLICK URL of the webpage where the  tag is expected to be placed: https://medicarequickcheck.benefitscheckup.org/mqc-results-3/This tag must be placed between the <body> and </    body> tags, as close as possible to the opening tag.Creation Date: 07/11/2014--><script type="text/javascript">var axel = Math.random() + "";   var a = axel * 10000000000000;document.write(\'<img src="http://ad.doubleclick.net/activity;src=4381487;type=NewTe0;cat=MQCIc0;ord=1;num=\' +   a + \'?" width="1" height="1" alt=""/>\');</script><noscript><img src="http://ad.doubleclick.net/activity;src=4381487;type=NewTe0;cat=MQCIc0;   ord=1;num=1?" width="1" height="1" alt=""/></noscript><!-- End of DoubleClick Floodlight Tag: Please do not remove -->');

    }

function aonFloodlightRequestLink () {
   $(body).append('<!--Start of DoubleClick Floodlight Tag: Please do not removeActivity name of this tag: MQC Text Link to Contact Page CLICK URL of the webpage where the  tag is expected to be placed: https://medicarequickcheck.benefitscheckup.org/mqc-results-3/This tag must be placed between the <body> and </    body> tags, as close as possible to the opening tag.Creation Date: 07/11/2014--><script type="text/javascript">var axel = Math.random() + "";   var a = axel * 10000000000000;document.write(\'<img src="http://ad.doubleclick.net/activity;src=4381487;type=NewTe0;cat=MQCIc0;ord=1;num=\' +   a + \'?" width="1" height="1" alt=""/>\');</script><noscript><img src="http://ad.doubleclick.net/activity;src=4381487;type=NewTe0;cat=MQCIc0;   ord=1;num=1?" width="1" height="1" alt=""/></noscript><!-- End of DoubleClick Floodlight Tag: Please do not remove -->');

    }

function aonFloodlightRequestIcon () {
   $(body).append('<!--Start of DoubleClick Floodlight Tag: Please do not removeActivity name of this tag: MQC Icon Link to Contact Page CLICK URL of the webpage   where the tag is expected to be placed: https://medicarequickcheck.benefitscheckup.org/mqc-results-3/This tag must be placed between the <body> and </body> tags, as close as possible to the opening tag.Creation Date: 07/11/2014--><script type="text/javascript">var axel = Math.random() + "";var a = axel * 10000000000000;document.write(\'<img src="http://ad.doubleclick.net/activity;src=4381487;type=NewTe0;cat=MQCIc00;ord=1;       num=\' + a + \'?" width="1" height="1" alt=""/>\');</script><noscript><img src="http://ad.doubleclick.net/activity;src=4381487;type=NewTe0;     cat=MQCIc00;ord=1;num=1?" width="1" height="1" alt=""/></noscript><!-- End of DoubleClick Floodlight Tag: Please do not remove -->');

    }

function aonFloodlightCompareIcon () {
   $(body).append('<!--Start of DoubleClick Floodlight Tag: Please do not removeActivity name of this tag: MQC Icon Link to Aon CLICK URL of the webpage where the  tag is expected to be placed: https://medicarequickcheck.benefitscheckup.org/mqc-results-3/This tag must be placed between the <body> and </    body> tags, as close as possible to the opening tag.Creation Date: 07/11/2014--><script type="text/javascript">var axel = Math.random() + "";   var a = axel * 10000000000000;document.write(\'<img src="http://ad.doubleclick.net/activity;src=4381487;type=NewTe0;cat=MQCIc0;ord=1;num=\' +   a + \'?" width="1" height="1" alt=""/>\');</script><noscript><img src="http://ad.doubleclick.net/activity;src=4381487;type=NewTe0;cat=MQCIc0;   ord=1;num=1?" width="1" height="1" alt=""/></noscript><!-- End of DoubleClick Floodlight Tag: Please do not remove -->');

    }





  function PrintDiv() {    
        $("#printContent [id^=mqc_]").before("<br class='inPrint' />");
        var divToPrint = document.getElementById('printContent');
        var popupWin = window.open('', '_blank');
        popupWin.document.open();
        popupWin.document.write('<html><title>BenefitsCheckUp.org</title><body onload="window.print()">' + divToPrint.innerHTML + '</html>');
        popupWin.document.close();
        }

function PrintDivMMM() {    
        $("#printContent [id^=mqc_]").before("<br class='inPrint' />");
        var divToPrint = document.getElementById('printContent');
        var popupWin = window.open('', '_blank');
        popupWin.document.open();
       	popupWin.document.write('<html><title>BenefitsCheckUp.org</title><body onload="window.print()"><img id="logo" alt="" title="" src="/wp-content/themes/bcuwptheme/images/mmm-logo.png"><BR />' + divToPrint.innerHTML + '</html>');
        popupWin.document.close();
        }



        function PrintDivCanvasMMM(imgCanvasCount) {    
$("#imageToPrint").append('<img id="logo" alt="" title="" src="/wp-content/themes/bcuwptheme/images/mmm-logo.png">');
        var divToPrint = document.getElementById('printContent');
html2canvas($(divToPrint), {
    onrendered : function(canvas) {
    var img = canvas.toDataURL();
        if (imgCanvasCount == 1){  //avoiding repeated images
    // img now contains an IMG URL, you can do various things with it, but most simply:
        $('<img>',{src:img}).appendTo($('#imageToPrint'));
//console.log("In called func canvasImgCount: "+imgCanvasCount);
}
//document.getElementById('canvasImage').setAttribute('src',vara); 
//console.log("Canvas img printing: "+imgCanvas);
        divToPrint = document.getElementById('imageToPrint');
        var popupWin = window.open('', '_blank');
        popupWin.document.open();
       	popupWin.document.write('<html><title>BenefitsCheckUp.org</title><body onload="window.print()">' + divToPrint.innerHTML + '</html>');
        popupWin.document.close();
        }
        });
}




function invalidZipMQC3Num () {
	$( "#mqc_zipcode" ).before('<div id="invalidZipNum" class="alert alert-danger"><i class="icon-warning-sign"></i> <strong>Zip Code</strong> must be 5 digits.</div>');
			  	validated = 0;


}

function invalidZipMQC3 (){

console.log ("gets to the ajax at all");

//console.log("5");
//console.log("TEST");



       
$("#invalidZipLetters").remove();
$("#invalidZipReturn").remove();
$("#invalidZip").remove();

var threeDigits = $("#mqc_zipcode").val ().substring (0, 3);
//console.log ("three gidig" + threeDigits);
          if (threeDigits == "006" || threeDigits == "007" || threeDigits == "008" || threeDigits == "009" || threeDigits == "969"){

if ($('#invalidZip').length == 0){

                $('#mqc_zipcode').before('<div id="invalidZip" class="alert alert-danger"><i class="icon-warning-sign"></i> The zip code you entered is invalid. Please enter a zip code for the U.S. or District of Columbia.</div>');
}
validated = 0;
return false;
}

    $.ajax({
        type: 'post',
        async: false,
        url: '/_custom/questionnaire_mqc_3_stateDependent.php',
        data: {
            zip: $("#mqc_zipcode").val(),
        },
        success: function( data ) {
 
       processAjaxZipData (data);
        }
    });




}


function processAjaxZipData (data) {

console.log ("gets to the after ajax at all");

//hide all previous shown medicaid and mediareadditional options, show the generic upon error for 6 and immediately for 9, and the immediately the "not listed" option for 6 of MQC3 and q. 8 of MQC1
$("#mqc_health_insurance_coverage .checkbox").hide(); //Q. 6
$("#mqc_health_insurance_cover_ahn .checkbox").hide(); //MQC2 question
$("#mqc_health_insurance_cover_aep .checkbox").hide(); //MQC1 question
//$("#mqc_health_insurance_coverage :input").removeAttr("checked");
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
 
 
$("#mqc_medicareadditional .checkbox").hide(); //Q. 9 in MQC3 and 14 in MQC1
$("#mqc_medicareadditional_aep .checkbox").hide(); //MQC1 question
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
 

            if (!$.trim(data)){ //zip is numeric but not a valid zip; the check for a 5-digit zip is done earlier

console.log ("zip numeric etc."	);

                $('#mqc_zipcode').before('<div id="invalidZipLetters" class="alert alert-danger"><i class="icon-warning-sign"></i> You must enter a valid ZIP code. Please try again.</div>');

             $("#tr_mqc_helpmedicaid").show(); 
             $("#tr_mqc_helpmedicaid .checkbox").show();

validated = 0;


            }
            else { //valid zip


console.log ("gets to the after ajax, valid zip, at all");
console.log ("data: "+data);

            switch(data) //Q. 6, medicaid
{
case "AZ":
             $("#tr_mqc_helpmedicaid_az").show(); 
             $("#tr_mqc_helpmedicaid_az .checkbox").show();


  break;
case "CA":
             $("#tr_mqc_helpmedicaid_ca").show(); 
             $("#tr_mqc_helpmedicaid_ca .checkbox").show();
  break;
case "CT":

            console.log ("gets to the after ajax, CT");
             $("#tr_mqc_helpmedicaid_ct").show(); 
             $("#tr_mqc_helpmedicaid_ct .checkbox").show();
  break;
case "KY":
             $("#tr_mqc_helpmedicaid_ky").show(); 
             $("#tr_mqc_helpmedicaid_ky .checkbox").show();
  break;
case "IL":
             $("#tr_mqc_helpmedicaid_il").show(); 
             $("#tr_mqc_helpmedicaid_il .checkbox").show();
  break;
case "MA":
             $("#tr_mqc_helpmedicaid_ma").show(); 
             $("#tr_mqc_helpmedicaid_ma .checkbox").show();
  break;
case "ME":
             $("#tr_mqc_helpmedicaid_me").show(); 
             $("#tr_mqc_helpmedicaid_me .checkbox").show();
  break;
case "MO":
             $("#tr_mqc_helpmedicaid_mo").show(); 
             $("#tr_mqc_helpmedicaid_mo .checkbox").show();
  break;
case "PA":
             $("#tr_mqc_helpmedicaid_pa").show(); 
             $("#tr_mqc_helpmedicaid_pa .checkbox").show();
  break;
case "TN":
             $("#tr_mqc_helpmedicaid_tn").show(); 
             $("#tr_mqc_helpmedicaid_tn .checkbox").show();
  break;
case "WI":
             $("#tr_mqc_helpmedicaid_wi").show(); 
             $("#tr_mqc_helpmedicaid_wi .checkbox").show();
  break;
case "WY":
             $("#tr_mqc_helpmedicaid_wy").show(); 
             $("#tr_mqc_helpmedicaid_wy .checkbox").show();
  break;
default:
             $("#tr_mqc_helpmedicaid").show(); 
             $("#tr_mqc_helpmedicaid .checkbox").show();


}


hIUncheck ();


            switch(data) //Q. 9, medicareadditional
{
case "AK":
             $("#tr_rec_ak_seniorbenefits").show(); 
             $("#tr_rec_ak_seniorbenefits .checkbox").show();


  break;
case "DE":
             $("#tr_rec_de_dpap").show(); 
             $("#tr_rec_de_dpap .checkbox").show();
  break;
case "IN":
             $("#tr_rec_in_hoosierrx").show(); 
             $("#tr_rec_in_hoosierrx .checkbox").show();
  break;
case "MA":
             $("#tr_rec_ma_prescriptionadvantage").show(); 
             $("#tr_rec_ma_prescriptionadvantage .checkbox").show();
  break;
case "MD":
             $("#tr_rec_md_spdap").show(); 
             $("#tr_rec_md_spdap .checkbox").show();
  break;
case "ME":
             $("#tr_rec_me_del_and_rxplus").show(); 
             $("#tr_rec_me_del_and_rxplus .checkbox").show();
  break;
case "MO":
             $("#tr_rec_mo_rxplan").show(); 
             $("#tr_rec_mo_rxplan .checkbox").show();
  break;
case "MT":
             $("#tr_rec_mt_bigskyrx").show(); 
             $("#tr_rec_mt_bigskyrx .checkbox").show();
  break;
case "NJ":
             $("#tr_rec_nj_paad").show(); 
             $("#tr_rec_nj_paad .checkbox").show();
  break;
case "NV":
             $("#tr_rec_nv_seniorrx").show(); 
             $("#tr_rec_nv_seniorrx .checkbox").show();
  break;
case "NY":
            console.log ("gets to the after ajax, NY");
             $("#tr_rec_ny_epic").show(); 
             $("#tr_rec_ny_epic .checkbox").show();
  break;
case "OR":
             $("#tr_rec_or_pdap_2").show(); 
             $("#tr_rec_or_pdap_2 .checkbox").show();
  break;
case "PA":
             $("#tr_rec_pa_pace_pacenet").show(); 
             $("#tr_rec_pa_pace_pacenet .checkbox").show();
  break;
case "RI":
             $("#tr_rec_ri_ripae").show(); 
             $("#tr_rec_ri_ripae .checkbox").show();
  break;
case "VT":
             $("#tr_rec_vt_vpharm_and_healthyvermonters").show(); 
             $("#tr_rec_vt_vpharm_and_healthyvermonters .checkbox").show();
  break;
case "WA":
             $("#tr_rec_wa_pdp").show(); 
             $("#tr_rec_wa_pdp .checkbox").show();
  break;
case "WI":
             $("#tr_rec_wi_seniorcare").show(); 
             $("#tr_rec_wi_seniorcare .checkbox").show();
  break;
default:




}

medicareAdditionalUncheck ();







            }

         


}



function medicareAdditionalUncheck (){
//console.log("IN HERE");
$("#mqc_medicareadditional .checkbox").each(function (index, element){
   if ($(this).is(":hidden")){
//console.log ("YES");
//console.log ($(this));
$(this).find(":input").removeAttr("checked");
}
});
}


function hIUncheck (){
//console.log("IN HERE");
$("#mqc_health_insurance_coverage .checkbox").each(function (index, element){
   if ($(this).is(":hidden")){
//console.log ("YES");
//console.log ($(this));
$(this).find(":input").removeAttr("checked");
}
});

$("#mqc_health_insurance_cover_ahn .checkbox").each(function (index, element){ //for MQC2
   if ($(this).is(":hidden")){
//console.log ("YES");
//console.log ($(this));
$(this).find(":input").removeAttr("checked");
}
});
$("#mqc_health_insurance_cover_aep .checkbox").each(function (index, element){ //for MQC1
   if ($(this).is(":hidden")){
//console.log ("YES");
//console.log ($(this));
$(this).find(":input").removeAttr("checked");
}
});




}

function birthDayOption (theDay, theText){
var o = new Option(theText, theDay);
/// jquerify the DOM object 'o' so we can use the html method
$(o).html(theText);
$("#mqc_birth_day").append(o);

}




function birthDay (){


$("#mqc_birth_day").children().show(); //to accomodate accidentally selecting June and changing to July

//birthDayOption("29", "29");
//birthDayOption("30", "30");
//birthDayOption("31", "31");
$("#mqc_birth_day").children('option[value="29"]').remove(); //just hiding doesn't work in IE
$("#mqc_birth_day").children('option[value="30"]').remove(); //just hiding doesn't work in IE
$("#mqc_birth_day").children('option[value="31"]').remove(); //just hiding doesn't work in IE

if ($("#mqc_birth_month").val() != ""){

var month = $("#mqc_birth_month").val();
var days =  new Date("2016", month, 0).getDate();
//2014 is temp; the actual year will depend on the year select field

//console.log(days);


if (days >= "29"){

//$("#mqc_birth_day").children('option[value="31"]').remove(); //just hiding doesn't work in IE
birthDayOption("29", "29");


if (days >= "30"){
birthDayOption("30", "30");


//$("#mqc_birth_day").children('option[value="30"]').remove();


if (days >= "31"){
birthDayOption("31", "31");
//$("#mqc_birth_day").children('option[value="29"]').remove();
}


}

}


}

}

function noneCheckbox (questionID, currentCheckbox, noneCheckbox){

if (currentCheckbox.attr("id") == noneCheckbox){
if( $("input:checkbox[name=" + noneCheckbox + "]:checked").val() == "y"){


//console.log ("question input");
//console.log ("#" + questionID + " :input");

$("#" + questionID + " :input").each(function (index, element){
   if ($(this).attr("id") != noneCheckbox){
    $(this).prop("checked", false).trigger("change");
}
else {

    $(this).prop("checked", true);
}


});


}
}
else {

$("input:checkbox[name="+ noneCheckbox +"]").prop("checked", false);


}

}

function depCheckbox (questionID, currentCheckbox, rulerCheckbox, ruledCheckboxes){ //ruledCheckboxes is a jQuery selected set of several checkboxes

//console.log ("current: "+currentCheckbox.attr("id"));
//console.log ("ruler: "+rulerCheckbox);

if (currentCheckbox.attr("id") == rulerCheckbox){

//console.log ("ruler checked value: "+$("input:checkbox[name=" + rulerCheckbox + "]:checked").val());

if( $("input:checkbox[name=" + rulerCheckbox + "]:checked").val() == "y"){


//console.log ("question input");
//console.log ("#" + questionID + " :input");
//console.log ("ruler checkbox yes");

ruledCheckboxes.each(function (index, element){
    $(this).prop("checked", false).trigger("change");
//console.log ("ruled current checkbox: "+$(this));

});

}

}

//console.log ("the ruled ones :"+ ruledCheckboxes);

ruledCheckboxes.each(function (index, element){

//console.log ("current ruled box in the loop: "+$(this).attr("id"));

if ($(this).attr("id") == currentCheckbox.attr("id")){


if( $("input:checkbox[name=" + $(this).attr("id") + "]:checked").val() == "y"){ //id is the same as name

$("#"+rulerCheckbox).prop("checked", false).trigger("change");

}

}

});






}


