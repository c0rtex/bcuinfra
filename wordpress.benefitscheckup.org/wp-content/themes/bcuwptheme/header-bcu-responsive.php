<!doctype html>

<?php $dev_url = "" ?> 

<!--[if lt IE 7]><html <?php language_attributes(); ?> class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if (IE 7)&!(IEMobile)]><html <?php language_attributes(); ?> class="no-js lt-ie9 lt-ie8"><![endif]-->
<!--[if (IE 8)&!(IEMobile)]><html <?php language_attributes(); ?> class="no-js lt-ie9"><![endif]-->
<!--[if gt IE 8]><!--> <html <?php language_attributes(); ?> class="no-js"><!--<![endif]-->

	<head>
		<meta charset="utf-8">

		
		<meta name="language" content="en-US" />
		<meta name="lang" content="en" />

		<!-- Google Chrome Frame for IE -->
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

		<!-- mobile meta -->
		<meta name="HandheldFriendly" content="True">
		<meta name="MobileOptimized" content="320">
		<meta name="viewport" content="width=device-width, initial-scale=1.0"/>

		<!-- icons & favicons -->
		<link rel="shortcut icon" href="/favicon.ico"/>
		


  	<link rel="pingback" href="<?php bloginfo('pingback_url'); ?>"  >
  	<link rel="canonical" href="<?php echo get_page_link($page_id); ?>"  >
  	<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  	   <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  	   <!--[if lt IE 9]>
  	     <script src="//oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
  	     <script src="//oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
  	<![endif]-->
  	
		  
		<?php //wp_head(); ?>
		
		<!--<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.5.0/jquery.min.js"></script>-->
				  <?php //add most of this to enqueue during clean-up ?>
				         
				  		<!-- Need to upgrade WordPress so it gets a newer version of jQuery to work with Bootstrap -->
			  	  <script src="<?php echo $dev_url; ?>/wp-content/themes/bootswatch/bootstrap/js/jquery.js"></script>
			  	   <!--<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.5.0/jquery.min.js"></script>-->
			      <script type="text/javascript" src="<?php echo $dev_url; ?>/wp-content/themes/bootswatch/bootstrap/js/jquery.validate.js"></script>
			      <script type="text/javascript" src="<?php echo $dev_url; ?>/wp-content/themes/bootswatch/bootstrap/js/bootstrap.js"></script>
			      <script type="text/javascript" src="<?php echo $dev_url; ?>/wp-content/themes/bootswatch/bootstrap/js/scrolltofixed.js"></script>
				  <link href="https://fonts.googleapis.com/css?family=PT+Sans&v1" rel="stylesheet" type="text/css">
				  <script src="<?php echo $dev_url; ?>/cf/ValidationFunctions.js"></script>
				  <script src="<?php echo $dev_url; ?>/cf/scripts.js"></script>
				  <!--<script src="<?php echo $dev_url; ?>/cf/textResize.js"></script>-->
				  <script src="<?php echo get_stylesheet_directory_uri() ?>/responsive/js/bootstrap.min.js"></script>
				  <!--<script src="<?php echo get_stylesheet_directory_uri() ?>/mqc.js"></script>	-->			
					<link href="<?php echo get_stylesheet_directory_uri() ?>/responsive/css/bootstrap.min.css" rel="stylesheet" type="text/css">
					
					<link href="<?php echo get_stylesheet_directory_uri() ?>/bcu.css" rel="stylesheet" type="text/css">
				  <script type="text/javascript">
				 
				  	$(function() {
				  		$.get("https://www.benefitscheckup.org/cf/populateWPheader.cfm");
				  	});
				  	
				 
				  
				  </script>	
				  <?php if (!is_page("getsnap")) {?>
				  <script src="<?php echo get_template_directory_uri(); ?>/snap.js"></script>
				  <?php } ?>
		
	<script>
dataLayer = [{
        'partner_id': '0',
        'partner_name': '',
        'subset_id': '0',
        'state': '',
}];
</script>
	
        <title><?php bloginfo('title'); ?></title>

		
		<?php
		/* 
		 * 	Add this to support sites with sites with threaded comments enabled.
		 */
			if ( is_singular() && get_option( 'thread_comments' ) )
				wp_enqueue_script( 'comment-reply' );
		
			//wp_head();
			
			//wp_get_archives('type=monthly&format=link');
		?>
		
		<script type="text/javascript">
		
		  var _gaq = _gaq || [];
		  _gaq.push(['_setAccount', 'UA-2674020-2']);
		  _gaq.push(['_setDomainName', 'benefitscheckup.org']);
		  _gaq.push(['_trackPageview']);
		
		  (function() {
		    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
		    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
		    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
		  })();
		
		</script>
		
		


            <!-- move into mqc.js? only if it's used in the mqc files and not the ecu files -->
            <!--
            <script src="<?php echo get_template_directory_uri(); ?>/application.js"></script>
            <script src="<?php echo get_template_directory_uri(); ?>/ecu.js"></script>
	    <script src="<?php echo $dev_url; ?>/cf/js/infinite-rotator.js" type="text/javascript"></script>
 	    <script src="<?php echo get_template_directory_uri(); ?>/ecu_liveonly.js"></script>-->
		
	     <link rel="stylesheet" href="<?php echo $dev_url ?>/wp-content/themes/bootswatch/bootstrap/css/font-awesome.css">		
	</head>

	<body <?php body_class(); ?> data-spy="scroll" data-target=".sidebar-nav">


<!-- Google Tag Manager -->
<noscript><iframe src="//www.googletagmanager.com/ns.html?id=GTM-PHJ4LQ"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'//www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-PHJ4LQ');</script>
<!-- End Google Tag Manager -->



  	<div class="container" id="top-bar">
    	<div class="row">
    		<div id="top-logo" class="span12">
  				<a target="_blank" href="http://www.ncoa.org"><img src="<?php echo get_template_directory_uri(); ?>/images/ncoa-logo-top.png" alt="National Council on Aging" title="National Council on Aging" alt="National Council on Aging" /></a>
    		</div>
        </div>    
   </div>
   
	<div class="container" id="header">
    	<div class="row-fluid">    
    		<div id="header_logo" class="span5">
	              <a href="/" class="block"><img src="<?php echo get_template_directory_uri(); ?>/images/logos/bcu.png" title="BenefitsCheckUp" alt="BenefitsCheckUp" /><!--<img src="/wp-content/uploads/2011/11/bcu_10th-anni-logo.png" title="BenefitsCheckUp" alt="BenefitsCheckUp" />--></a>                  
	     	</div>	     		
            
             <?php if (is_page('getsnap')) {?><div class="span7 statistics" id="logo" ><p style="font-size: 0.75em;"><img src="/cf/img/partners/seniorhunger/logo.gif" title="NCOA's Senior SNAP Initiative, in partnership with the Walmart Foundation" alt="NCOA's Senior SNAP Initiative, in partnership with the Walmart Foundation" align="right">We have helped more than <strong>1 million people</strong>
             find over <strong>$1.1 billion</strong> in SNAP benefits.</p>
                 </div><?php } else { ?><div class="span5 statistics" id="logo" ><p><?php $header_callout = $wpdb->get_row('SELECT post_content FROM wp_benefitscheckup.wp_posts WHERE ID = 2185'); 
             	echo $header_callout->post_content;?></p>
                 </div>  
             <?php } ?>
    	</div>
     </div>
	
	<?php if (!is_page("getsnap")) {?>
	<div class="container navbar" id="main-nav">
		<div class="navbar-inner">           
	        <div class="container" >
				<div id="main-nav" class="navbar row-fluid">
		           <ul id="home-nav" role="navigation" >
		           <?php // insert wp_menu_nav here  ?>
<?php 

if (isset ($_GET['partner_id'])) $partnerIdVar = $_GET['partner_id']; 
else $partnerIdVar = 0;

if (isset ($_GET['sc_partner_id'])) $scPartnerIdVar = $_GET['sc_partner_id']; 
else $scPartnerIdVar = 0;

?>	

		               <li><a href="/?sc_partner_id=<?php echo $scPartnerIdVar; ?>" <?php if (is_front_page()) echo "class='current'"; ?>>Home</a></li>
		               <li><a href="/find-help?sc_partner_id=<?php echo $scPartnerIdVar; ?>" <?php if (is_page("find-help")) echo "class='current'"; ?>>Find Help</a></li>
		               <li><a href="/about-us?sc_partner_id=<?php echo $scPartnerIdVar; ?>" <?php if (is_page("about-us")) echo "class='current'"; ?>>About Us</a></li>	
		               <li><a href="/our-sponsors?sc_partner_id=<?php echo $scPartnerIdVar; ?>" <?php if (is_page("our-sponsors")) echo "class='current'"; ?>>Our Sponsors</a></li>				
		               <li><a href="/news?sc_partner_id=<?php echo $scPartnerIdVar; ?>" <?php if (is_page("news")) echo "class='current'"; ?>>News</a></li>
		               <li><a href="http://www.ncoa.org/Donate" class="" target="_blank">Donate</a></li>
		           </ul>
	           </div>	
	       </div>
		</div>
	</div>
	<?php } ?>
     
   <div class="container">     
