<!DOCTYPE html>
<html <?php language_attributes(); ?>>

<head>
        <meta charset="<?php bloginfo( 'charset' ); ?>">
        <title>EconomicCheckUp</title>
        <?php
			/* 
			 * 	Add this to support sites with sites with threaded comments enabled.
			 */
			if ( is_singular() && get_option( 'thread_comments' ) )
				wp_enqueue_script( 'comment-reply' );
		
				//wp_head();
				wp_get_archives('type=monthly&format=link');
		?>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="language" content="en-US" />
	<meta name="lang" content="en" />
        <meta name="description" content="EconomicCheckUp helps you find benefit programs that can help pay for medications, health care, food, utilities and more. All from a reliable and trusted source." />
	<meta name="keywords" content="benefit programs, prescription drug assistance, Medicare Part D, extra help, low income subsidy, LIS, Medicare Savings Programs, QMB, SLMB, QI, nutrition, food stamps, SNAP, supplemental nutrition assistance program,  energy assistance, LIHEAP, tax relief, reverse mortgage, foreclosure counseling, housing assistance, in-home services, transportation, educational assistance, employment and volunteer services." />
        <meta name="Copyright" content="Copyright NCOA 2013" />
	<!-- Speaking of Google, don't forget to set your site up: http://google.com/webmasters -->	
	<meta name="google-site-verification" content="" />

	<!-- This is the traditional favicon.
		 - size: 16x16 or 32x32
		 - transparency is OK
		 - see wikipedia for info on broswer support: http://mky.be/favicon/ -->	
	<link rel="shortcut icon" href="/favicon.ico"/>
	<!-- The is the icon for iOS's Web Clip.
		 - size: 57x57 for older iPhones, 72x72 for iPads, 114x114 for iPhone4's retina display (IMHO, just go ahead and use the biggest one)
		 - To prevent iOS from applying its styles to the icon name it thusly: apple-touch-icon-precomposed.png
		 - Transparency is not recommended (iOS will put a black BG behind the icon) -->
	<!-- REM - New links included from the SA header -->	 

	<?php
		
		/* echo '<link rel="stylesheet" href="'.get_bloginfo( 'stylesheet_directory' ).'/_css/print.css?v=2" type="text/css" media="print" />'; */
	
		$body_classes = 'site-page site-body ';
		if (is_single() || is_page()){
			echo '<link rel="stylesheet" href="'.get_bloginfo( 'stylesheet_directory' ).'/_css/article.css?v=2">';
			echo '<link rel="stylesheet" href="'.plugins_url('excel-upload/css/excel-upload.css').'">';
			$pi = get_post_info();
			$css = $pi->post_type.'-'.$pi->post_name.'.css';
			$parent_name = $pi->post_name;
			$css_files = array();
			$css_files[] = $css;
			if ($pi->post_parent != 0){
				//its a child post
				$parent = get_post_info($pi->post_parent);
				$css_files[] = $pi->post_type.'-'.$parent->post_name.'.css';
				$css_files[] = $pi->post_type.'-'.$parent->post_name.'-'.$pi->post_name.'.css';
				$parent_name = $parent->post_name;
			}
			$function_file = $_SERVER['DOCUMENT_ROOT'].'/wp-content/themes/shebang/functions-'.$parent_name.'.php';
			if (file_exists($function_file)){
				include($function_file);
			}
			foreach($css_files as $css){
				$php_css_path = $_SERVER['DOCUMENT_ROOT'].'/wp-content/themes/shebang/_css/'.$css;
				if (file_exists($php_css_path)){
					echo '<link rel="stylesheet" href="'.get_bloginfo( 'stylesheet_directory' ).'/_css/'.$css.'?v=2">';
				}
			}
			$body_classes = 'frame-page '.$pi->post_name;
			$body_classes .= ' post-type-'.$pi->post_type;
			$parent_slug = shebang_get_parent_slug($pi->ID);
  			
  	
		} 		
		
		if (is_home()){
			echo '<link rel="stylesheet" href="'.get_bloginfo( 'stylesheet_directory' ).'/_css/home.css?v=2">';
			$body_classes .= ' home front';

		} else {
			echo '<link rel="stylesheet" href="'.get_bloginfo( 'stylesheet_directory' ).'/_css/screen.css?v=2">';
		}
	?>
	
	<link  href="http://code.jquery.com/ui/1.10.0/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>
	<link rel='stylesheet' href='/wp-content/plugins/upstatement-admin/upstatement-admin.css?ver=3.3.1'> 	
	<!-- REM - END New links included from the SA header -->	 
		 
	<link rel="apple-touch-icon" href="/wp-content/themes/shebang/images/custom_icon.png"/>
 
	<link rel="stylesheet" href="/wp-content/themes/shebang/_css/font-awesome.css">
	<link rel="stylesheet" href="/wp-content/themes/shebang/_css/style.css">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=PT+Sans&v1">		
	<link rel="stylesheet" href="/wp-content/themes/shebang/_css/bootstrap_esi.min.css">
	<link rel="stylesheet" href="/wp-content/themes/shebang/_css/bootstrap_esi.min.css">
	<link rel="stylesheet" type="text/css" media="all" href="<?php bloginfo( 'stylesheet_url' ); ?>" />
	<!--<link rel="stylesheet" type="text/css" media="all" href="/wp-content/themes/shebang/_css/BCU-WP-style.css" /> -->
	<!--[if IE 6]><link rel="stylesheet" type="text/css" href="wp-content/themes/shebang/_css/ie6.css" /><![endif]-->
	<!--[if IE 8]><link rel="stylesheet" type="text/css" href="wp-content/themes/shebang/_css/ie8.css" /><![endif]-->
	<link rel="stylesheet" href="/wp-content/themes/shebang/_css/bootstrap_responsive.css">
	<link rel="stylesheet" href="/wp-content/themes/shebang/_css/pongos.css">
	
	<!-- REM - Adding a new css sheet for tweaks to get the demo to work properly -->
	<link rel="stylesheet" href="/wp-content/themes/shebang/_css/FORDEMO.css">
	
    <!-- REM - These have to live in the header because some calculators do not include the footer where the rest of the JS is... -->
   	<!-- <script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
	<script src="http://code.jquery.com/jquery-migrate-1.0.0.js"></script>
	<script src="http://cdn.jquerytools.org/1.2.7/all/jquery.tools.min.js"></script> -->
	<script src="/wp-content/themes/shebang/js/jquery.min.js"></script>
	<script src="/wp-content/themes/shebang/js/jquery.tools.min.js"></script>
	<script src="/wp-content/themes/shebang/js/modernizr.js"></script>		 
        <script src="/wp-content/themes/shebang/js/ecu_liveonly.js"></script>

<script>
dataLayer = [{
        'partner_id': '0',
        'partner_name': '',
        'subset_id': '0',
        'state': '',       
}];
</script>
</head>

<body>
<!-- Google Tag Manager -->
<noscript><iframe src="//www.googletagmanager.com/ns.html?id=GTM-PHJ4LQ"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'//www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-PHJ4LQ');</script>
<!-- End Google Tag Manager -->

	
<!-- #ada508 shortcuts 
<div id="ada508">  
	<strong>Shortcut Navigation:</strong> 
	<ul> 
		<li><a href="#content" accesskey="p" title="Skip to page content">Page Content</a></li> 
		<li><a href="#topNav" accesskey="n" title="Skip to main navigation menu">Site Navigation</a></li>

		<li><a href="#search" accesskey="s" title="Skip to search">Search</a></li> 
		<li><a href="#footer" accesskey="f" title="Skip to footer (ctrl/alt + f)">Footer</a></li> 
	</ul> 
</div> 
--> 

<div class="container-fluid">
    	<div id="header" class="row-fluid" style="height:0px;">
    		<div class="span12">
    			<a href="http://www.ncoa.org" target="_blank"><img id="topbar" alt="National Council on Aging" 
    				title="National Council on Aging" src="/wp-content/themes/shebang/_images/_logos/ncoa_top.png" /></a><BR>
    		</div>
     	</div>
        <div id="header" class="container">
    	<div class="row-fluid">    
	        <div class="span5" >
	        	<a href="http://www.economiccheckup.org/" ><img src="/wp-content/themes/shebang/_images/_logos/ECU-PNG-Logo-2015.png" 
	        		title="EconomicCheckUp - A Holistic Approach to Helping Older Adults in Need" alt="EconomicCheckUp" id="logo"/></a>
	      	</div>
       	<div class="span6 statistics" id="logo" style="margin-left: -70px;"  ><br>Since 2010, we’ve helped thousands of older adults find work, budget their money, 
       		and save on daily expenses.
        </div>
</div>
	</div><!--end header -->
<br/>

	<?php 
	$_home = '';
	if ($_SERVER['REQUEST_URI']=='/esi-home/'){$_home = 'current_tab';}
	$_spq = '';
	if ($_SERVER['REQUEST_URI']=='/esi-questions/'){$_spq = 'current_tab';}
	$_help = '';
	if ($_SERVER['REQUEST_URI']=='/esi-find-help/'){$_help = 'current_tab';}
	$_about = '';
	if ($_SERVER['REQUEST_URI']=='/esi-about/'){$_about = 'current_tab';}
	$_news = '';
	if ($_SERVER['REQUEST_URI']=='/esi-news/'){$_news = 'current_tab';}
		
	?>
	
	<div id="main-nav" class="navbar row-fluid">
		<ul id="home-nav" class="row-fluid">
			<li id="esi-home" class="span2"><a class="<?php echo $_home; ?>" href="http://www.economiccheckup.org/">Home</a></li>
			<li id="esi-spq" class="span2"><a href="http://www.economiccheckup.org/esi-questions" class="<?php echo $_spq; ?>">My&nbsp;CheckUp</a></li>
		    <li id="esi-help" class="span2"><a href="http://www.economiccheckup.org/esi-find-help" class="<?php echo $_help; ?>">Resources</a></li>
			<li id="esi-about" class="span2"><a href="http://www.economiccheckup.org/esi-about" class="<?php echo $_about; ?>">About Us</a></li>				
			<li id="esi-news" class="span2"><a href="http://www.economiccheckup.org/esi-news" class="<?php echo $_news; ?>">News</a></li>
			<li id="esi-donate" class="span2"><a href="http://www.ncoa.org/Donate" class="" target="_blank">Donate</a></li>
		</ul>	
	</div><!--end main nav --> 
		
	<!-- /* REM 2013-09-13: This is hidden for now since we don't want users inadvertently navigating off to other parts of the site. */ 
		<div id="breadcrumbs">
			<p>
				<?php
					if(function_exists('bcn_display'))
					{
					    bcn_display();
					}
				?>
			</p>
		</div> --> <!--end breadcrumbs --> 
	
	<!-- /* REM 2013-09-13: We're opening a top-level container here to wrap the content of the body of the pages - this might let us 'cheat' the reformat for
		the mockup demo */ -->
	
	<div id="page">
		<div id="content" >
		<!-- ++++++++++ BODY CONTENT STARTS HERE ++++++++++ -->
