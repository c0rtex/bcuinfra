<!doctype html>  

<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"> <!--<![endif]-->
<head>	
	<meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

  <title></title>
  <meta name="description" content="">
  <meta name="author" content="">

  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <!--<link rel="stylesheet" href="http://code.jquery.com/mobile/1.0a4.1/jquery.mobile-1.0a4.1.min.css">-->
  <link rel="stylesheet" href="<?php bloginfo( 'stylesheet_directory' ); ?>/_css/screen.css">
  <link rel="stylesheet" href="<?php bloginfo( 'stylesheet_directory' ); ?>/_css/style-jared.css?v=2">
  <link rel="stylesheet" href="<?php bloginfo( 'stylesheet_directory' ); ?>/_css/style-ari.css">
  <!-- TypeKit code -->
  <script type="text/javascript" src="http://use.typekit.com/kun2gxu.js"></script>
  <script type="text/javascript">try{Typekit.load();}catch(e){}</script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js" type="text/javascript"></script>
  <script src="<?php bloginfo( 'stylesheet_directory' ); ?>/js/modernizr.js"></script>

<?php
// GN addition to actually insert Google Analytics code!
global $gaf;
if(isset($gaf)) $gaf->spool_analytics();
?>


</head>

<body class="homepage hp-body">

	<!-- ================================= --> 
	
	<!-- ! Global Header				   --> 
	
	<!-- ================================= -->

	<header id="hp-hdr" class="hp-hdr">
		
			<!-- Logo -->
			<h1 class="hp-hdr-logo-container"><a href="#">
				<img class="hp-hdr-logo" src="<?php bloginfo('stylesheet_directory'); ?>/_images/sqa-logo-home.png" alt="Squared Away" />
			</a></h1>
	
			<!-- Navigation -->
			<nav class="hp-nav">
				<ul class="hp-nav-list">
					<li id="hp-nav-topics" class="hp-nav-item dropdown-trigger-hover"><a href="/topics/">
						Topics</a>
						<div class="dropdown-menu nav-dropdown-menu">
							<?php get_template_part('menu', 'topics'); ?>
						</div>
					</li>
					<li id="hp-nav-life-stage" class="hp-nav-item dropdown-trigger-hover"><a href="/life-stages/">
						Make a Plan</a>
						
					</li>
					<li id="hp-nav-tools" class="hp-nav-item dropdown-trigger-hover"><a href="/tools/">
						Tools</a>
						<div class="dropdown-menu nav-dropdown-menu">
							<ul class="menu">
								<li class="menu-item"><a href="/planners">Planners</a></li>
								<li class="menu-item"><a href="/calculators">Calculators</a></li>
								<li class="menu-item"><a href="/learn-more">Learn More</a></li>
								<li class="menu-item"><a href="/how-to">How To</a></li>
							</ul> <!-- /.menu -->
						</div>
					</li>
					<li id="hp-nav-about" class="hp-nav-item"><a href="/about/">
						About</a></li>
					<li id="hp-nav-login" class="hp-nav-item-btn"><a href="/wp-login.php">
						Login</a></li>
				</ul> <!-- /.hp-nav-list -->
			</nav> <!-- /.hp-nav -->
			

	</header> <!-- /.hp-hdr -->

<div id="site-container" class="hp-container">