<!doctype html>

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
		<link rel="apple-touch-icon" href="<?php echo get_template_directory_uri(); ?>/library/images/apple-icon-touch.png">
		<link rel="icon" href="<?php echo get_template_directory_uri(); ?>/favicon.png">
		<!--[if IE]>
			<link rel="shortcut icon" href="<?php echo get_template_directory_uri(); ?>/favicon.ico">
		<![endif]-->
		


  	<link rel="pingback" href="<?php bloginfo('pingback_url'); ?>" >
  	<link rel="canonical" href="<?php echo get_page_link($page_id); ?>"  >
  	<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  	   <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  	   <!--[if lt IE 9]>
  	     <script src="//oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
  	     <script src="//oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
  	<![endif]-->
  	
<title><?php bloginfo('name'); ?></title>
		<?php wp_head(); ?>
<!--- Lynna Cekova: <title> after wp_head because otherwise the title is automatic from WP --->
		
		<?php //add most of this to enqueue during clean-up ?>
		        
  			<!-- Need to upgrade WordPress so it gets a newer version of jQuery to work with Bootstrap -->
  			<script src="/wp-content/themes/bootswatch/bootstrap/js/jquery.js"></script>
            <script type="text/javascript" src="/wp-content/themes/bootswatch/bootstrap/js/jquery.validate.js"></script>
            <script type="text/javascript" src="/wp-content/themes/bootswatch/bootstrap/js/bootstrap.js"></script>
            <script type="text/javascript" src="/wp-content/themes/bootswatch/bootstrap/js/scrolltofixed.js"></script>

<?php // prevent form submission ?>
<script type="text/javascript">
jQuery(document).ready(function($){
  $('#esiForm').bind("keyup keypress", function(e) {
    var code = e.keyCode || e.which; 
    if (code  == 13) {               
      e.preventDefault();
      return false;
    }
  });
});
</script>

<script type="text/javascript">
$(document).ready(function() {

if ( $(window).width() <= 700) {      
$("#logo.statistics").hide();

} 
})
</script>
            <!-- move into mqc.js? only if it's used in the mqc files and not the ecu files -->
            <script src="<?php echo get_template_directory_uri(); ?>/application.js"></script>
            <script src="<?php echo get_template_directory_uri(); ?>/ecu.js"></script>
		<script src="https://www.benefitscheckup.org/cf/js/infinite-rotator.js" type="text/javascript"></script>
 <script src="<?php echo get_template_directory_uri(); ?>/ecu_liveonly.js"></script>
		
	     <link rel="stylesheet" href="/wp-content/themes/bootswatch/bootstrap/css/font-awesome.css">
<script>
dataLayer = [{
        'partner_id': '77',
        'partner_name': 'NCOA Economic Security Initiative',
        'subset_id': '63',
        'state': '',       
}];
</script>		
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


    <button id="esiMenuToggleButton" class="btn"><span class="menuButtonESIText">Menu</span> </i> </button>
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
	              <a href="/esi-home/"><img src="/wp-content/uploads/2014/12/ECU-PNG-Logo-2015.png" title="EconomicCheckUp - A Holistic Approach to Helping Older Adults in Need" alt="EconomicCheckUp"  /></a>                  
	     	</div>
            <div class="span7 statistics" id="logo" ><p>Since 2010, we’ve helped thousands of older adults find work, budget their money, and save on daily expenses.</p>
                </div>  
    	</div>
     </div>
     
     <div class="container navbar" id="main-nav">
            <div class="navbar-inner">           
             <div class="container" >
      
         <!--<a class="btn btn-navbar" data-toggle="collapse" data-target="#home-nav" href="#homenavcollapse">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span></a>-->
        <!--<a class="brand" href="#">Project name</a>-->
       
      		
             <!-- <div id="homenavcollapse" class="nav-collapse collapse"> -->
		<div id="main-nav" class="navbar row-fluid">
                <ul id="home-nav nav" role="navigation" >
                <?php // insert wp_menu_nav here  ?>
                    <li><a href="/esi-home" <?php if (is_page("esi-home")) echo "class='current'"; ?>>Home</a></li>
                    <li><a href="/esi-questions" <?php if (is_page("esi-questions")) echo "class='current'"; ?>>My&nbsp;CheckUp</a></li>
		    		<li><a href="/esi-find-help" <?php if (is_page("esi-find-help")) echo "class='current'"; ?>>Resources</a></li>
                    <li><a href="/esi-about" <?php if (is_page("esi-about")) echo "class='current'"; ?>>About Us</a></li>				
                    <li><a href="/esi-news" <?php if (is_page("esi-news")) echo "class='current'"; ?>>News</a></li>
                    <li><a href="http://www.ncoa.org/Donate" class="" target="_blank">Donate</a></li>
                </ul>
                </div>	
            </div>
     </div>
     </div>

     
     <div class="container">     
