<?php
	//include('_includes/session-start.php');
	header("Cache-Control: no-cache, must-revalidate"); // HTTP/1.1
	header("Expires: Mon, 26 Jul 2007 05:00:00 GMT"); // Date in the past
	if ($_COOKIE['uid']){
		$_SESSION['uid'] = $_COOKIE['uid'];
	}
	include('includes/cys-functions.php');
?><!doctype html>  

<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"> <!--<![endif]-->
<head>	
	<meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<?php
    	include('cys-functions.php');
    ?>
  <title></title>
  <meta name="description" content="">
  <meta name="author" content="">

  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <link rel="stylesheet" href="<?php bloginfo( 'stylesheet_directory' ); ?>/_css/article.css?v=2">
  <!--<link rel="stylesheet" href="http://code.jquery.com/mobile/1.0a4.1/jquery.mobile-1.0a4.1.min.css">-->
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

<?php
	$pi = get_post_info();
?>

<body class="article-page learn-more-page reverse-mortgage-learn-more post-type-<?= $pi->type ?>">

	<!-- ================================= --> 
	
	<!-- ! Global Header				   --> 
	
	<!-- ================================= -->

	<header id="global-hdr" class="global-hdr">
		
		<div class="global-hdr-col-group">

			<!-- Column 1: Logo -->
			<div class="hdr-logo-col col-1">
				<h1 class="hdr-logo-container"><a href="/">
					<img class="hdr-logo" src="<?php bloginfo('stylesheet_directory'); ?>/_images/sqa-logo-large.png" alt="Squared Away" />
				</a></h1>
			</div> <!-- col-1 logo -->
	
	
			<!-- Column 2: Navigation -->
			<nav class="global-nav global-nav-col col-2">
				<ul class="global-nav-list">
					<li id="global-nav-login" class="global-nav-item-btn"><a href="/wp-login.php">
						Login</a></li>
					<!--<li id="global-nav-mysqa" class="global-nav-item"><a href="#">
						My Squared Away</a></li>-->
					<li id="global-nav-calculators" class="global-nav-item"><a href="/calculators/">
						Calculators</a></li>
					<li id="global-nav-life-stage" class="global-nav-item"><a href="/life-stages/">
						Life Stage</a></li>
					<li id="global-nav-topics" class="global-nav-item"><a href="/topics/">
						Topics</a></li>
				</ul> <!-- /.global-nav-list -->
			</nav> <!-- /.global-nav -->
		
		</div> <!-- /.global-hdr-col-group -->
	
	</header> <!-- /.global-hdr -->

<div id="site-container">