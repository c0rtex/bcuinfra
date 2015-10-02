<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>MedicareQuickCheck</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="language" content="en-US" />
	<meta name="lang" content="en" />
	<meta name="description" content="MedicareCheckUp helps you find benefit programs that can help pay for medications, health care, food, utilities and more. All from a reliable and trusted source." />
	<meta name="keywords" content="benefit programs, prescription drug assistance, Medicare Part D, extra help, low income subsidy, LIS, Medicare Savings Programs, QMB, SLMB, QI, nutrition, food stamps, SNAP, supplemental nutrition assistance program,  energy assistance, LIHEAP, tax relief, reverse mortgage, foreclosure counseling, housing assistance, in-home services, transportation, educational assistance, employment and volunteer services." />
	<meta name="Copyright" content="Copyright NCOA 2013" />

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.5.0/jquery.min.js"></script>
        <script src="/wp-content/themes/bootswatch/bootstrap/js/jquery.js"></script>
        <script type="text/javascript" src="/wp-content/themes/bootswatch/js/jquery-latest.js"></script>
        <script type="text/javascript" src="/wp-content/themes/bootswatch/bootstrap/js/jquery.validate.js"></script>
        <script type="text/javascript" src="/wp-content/themes/bootswatch/bootstrap/js/bootstrap.js"></script>
        <script src="/wp-content/themes/bootswatch/bootstrap/js/bootstrap-tooltip.js" type="text/javascript"></script>
        <script type="text/javascript" src="/wp-content/themes/bootswatch/js/scrolltofixed.js"></script>
        <script src="/wp-content/themes/bootswatch/bootstrap/js/application.js"></script>
	<script type="text/javascript" src="https://redesign.benefitscheckup.org/CFIDE/scripts/cfform.js"></script>
		
		<link rel="stylesheet" href="/cf/bootswatch/css/font-awesome.css">
		<link type="text/css" rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto">
		<link type="text/css" rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto+Condensed">
		<link href="/cf/bootswatch/bootstrap/css/mqc_style1.css" rel="stylesheet">
       	 	<link href="/cf/bootswatch/bootstrap/css/bootstrap_mqc.css" rel="stylesheet">
        	<link href="/cf/bootswatch/bootstrap/css/bootstrap-responsive.css" rel="stylesheet">
        
       
        
    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="/cf/bootswatch/bootstrap/js/html5shiv.js"></script>
    <![endif]-->

  <script>
  $(document).ready(function(){
    $("#commentForm").validate();
  });
  </script>
  </head>

  <body data-spy="scroll" data-target=".sidebar-nav">
		<script>
			$(document).ready(function() {
		  	var sidebar = $('.sidebar-nav');
		  	sidebar.scrollToFixed({
			marginTop: $('.navbar').outerHeight(true) + 50,
			zIndex: 999
		  	});
	
		  	var body_headers = $('.body-header');              
			body_headers.each(function(i) {
			var body_header = $(body_headers[i]);
			var next = body_headers[i + 1];
	
			body_header.scrollToFixed({
				marginTop: $('.navbar').outerHeight(true) ,
				limit: function() {
				var limit = 0;
				if (next) {
					limit = $(next).offset().top + $(this).outerHeight(true);
				} 
				return limit;
				},
					zIndex: 999
				});

			

				
			}); 
			// Define the function to validate the form on submission
			function validateForm( inputs ) {
				// Clear out all previous alerts
				$('.alert').remove();
				var validated = 1;
				
				// Begin to check which fields need to filled in
				jQuery.each( inputs, function( i, val ) {
					if( $( "#" + i ).val() == '') {
			  		$( "#" + i ).before('<div class="alert alert-danger"><i class="icon-warning-sign"></i> <strong>' + val + '</strong> is a required field.</div>');
			  		validated = 0;
			  	};
				});
			}
			
			
		
		
			// Start the validation on form submission
			$('#mqcForm').submit(function() {
				// Create an array of input IDs and their names for fields that cannot be blank
				var inputs = { "select_mqc_client": "Form Completion", "mqc_zipcode": "Zip Code", "mqc_birth_month": "Birth Month", "mqc_birth_year": "Birth Year", "mqc_birth_day": "Birth Day", "select_mqc_marital": "Marital Status" };
			
				

				validateForm( inputs );
				
				// Validate specific input parameters
				if( $('#mqc_zipcode').val().length != 5 ) {
					$( "#mqc_zipcode" ).before('<div class="alert alert-danger"><i class="icon-warning-sign"></i> <strong>Zip Code</strong> must be 5 digits</div>');
			  	validated = 0;
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


if( $('input:radio[name=mqc_medicare]:checked').val() == 'n'){
validated = 0;
$("#medicareInfo").modal('show');

}
				
				if(validated == 0) {
					// Do not submission if the form fails validation
					$(".alert-danger")[0].scrollIntoView(true);
					$("#basics .well").prepend('<div class="alert alert-danger"><i class="icon-warning-sign"></i> We\'re sorry, but some responses are missing or were completed incorrectly. Please correct the problems where indicated below.</div>');
					return false;	
				}	
			});
		  });

		</script>
		<div class="container-fluid">
        	<div id="header">
	            <div id="header_logo">
	              <a href="http://www.mymedicarematters.org" target="_blank"><img src="https://www.benefitscheckup.org/cf/images/my_medicare_matters_logo.png" alt="My Medicare Matters" title="My Medicare Matters"></a>
	            </div>
	          </div>
            <div class="content row-fluid">
            	<div class="row-fluid" id="outercontainer">
