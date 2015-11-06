<?php
/*
Template Name:  MedicareQuickCheck full page (view original)
*/
?>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=9; IE=8; IE=7; IE=EDGE" />
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

<script type="text/javascript">
        var _gaq = _gaq || [];
         var pluginUrl = 
        '//www.google-analytics.com/plugins/ga/inpage_linkid.js';
        _gaq.push(['_require', 'inpage_linkid', pluginUrl]);
        _gaq.push(['_setAccount', 'UA-44844277-1']);
        _gaq.push(['_setDomainName', 'benefitscheckup.org']);  (ie benefitscheckup.org with NO WWW if that is the domain name )
        _gaq.push(['_setAllowLinker', true]);
        _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();
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
	              <a href="http://www.mymedicarematters.org" target="_blank"><img src="https://wwww.benefitscheckup.org/cf/images/my_medicare_matters_logo.png" alt="My Medicare Matters" title="My Medicare Matters"></a>
	            </div>
	          </div>
            <div class="content row-fluid">
            	<div class="row-fluid" id="outercontainer">

<div id="page" class="subpage <?php if(isset($_GET['fullWidth'])){echo "layout-noRightCol";} else { echo "layout-default";} ?>"><!-- "page" id should remain on every page, swap or extend the "layout-default" class for alternate layouts (class="subpage layout-noRightCol" or class="forum layout-default" -->

<div id="content" class="span12">
   			
<?php if ( ! is_page( 'Home' ) ) {; ?>
<!-- If page is not home page, show page_wrapper -->
     <div class="page_wrapper">
<?php } ?>
<?php if(have_posts()) : ?>
	<?php while(have_posts()) : the_post(); ?>
		<?php 
			the_content();	
			//$temp = get_the_content(); 
			//echo wpautop($temp);?>	
	<?php endwhile; ?>

<?php endif; ?>

<?php if ( ! is_page( 'Home' )  ) {; ?>
<!-- If page is not home page, show page_wrapper --> 
      </div><!--end page_wrapper -->
<?php } ?>

</div><!-- end content -->

</div>
		
</div>

<div class="span12" id="footer_div">

		    <div id="footer_logo">
		        <a target="_new" href="http://www.ncoa.org/"><img src="/cf/images/ncoa_logo.png" alt="NCOA" title="NCOA"></a>
		    </div>

		    <div id="footer_right">
		        <ul id="footer_links">
		            <li>
		                <a target="_new" href="https://www.mymedicarematters.org/about/">About This Site</a>
		            </li>
		            <li class="footer_divider">|</li>
		            <li>
		                <a target="_new" href="https://www.mymedicarematters.org/privacy-policydisclaimers/">Privacy Policy</a>
		            </li>
		            <li class="footer_divider">|</li>
		            <li>
		                <a target="_new" href="https://www.mymedicarematters.org/get-help/contact-us/">Contact Us</a>
		            </li>
		            <li class="footer_divider">|</li>
		            <li>
		                <a target="_new" href="https://www.mymedicarematters.org/get-help/faq/">FAQs</a>
		            </li>
		            <li class="footer_divider">|</li>
		            <li>
		                <a target="_new" href="https://www.mymedicarematters.org/get-help/glossary/">Glossary</a>
		            </li>
		        </ul>

		        <ul id="socialnetwork_links">
		            <li>
		                <a target="_new" href="https://www.facebook.com" id="facebook_link"></a>
		            </li>
		            <li>
		                <a target="_new" href="https://www.twitter.com" id="twitter_link"></a>
		            </li>
		            <li>
		                <a target="_new" href="https://www.pinterest.com" id="pinterest_link"></a>
		            </li>
		            <li>
		                <a target="_new" href="https://www.mysocialnetwork.com" id="socialnetwork_link"></a>
		            </li>
		        </ul>
		    </div>
		</div><!-- #footer -->           
<?PHP require('mqc_tracking.htm'); ?>
<script type="text/javascript">
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new
Date();a=s.createElement(o),
 
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-2674020-10', 'benefitscheckup.org');
  ga('send', 'pageview');

</script>
</body>
</html>

