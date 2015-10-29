<!doctype html>  

<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"> <!--<![endif]-->
<head>	
	<meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <title><?php
			/*
			 * Print the <title> tag based on what is being viewed.
			 * We filter the output of wp_title() a bit -- see
			 * boilerplate_filter_wp_title() in functions.php.
			 */
			wp_title( '|', true, 'right' );
		?></title>
  <meta name="description" content="">
  <meta name="author" content="">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

	<?php
		
/* 		echo '<link rel="stylesheet" href="'.get_bloginfo( 'stylesheet_directory' ).'/_css/print.css?v=2" type="text/css" media="print" />'; */
	
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

  <!-- TypeKit code -->
  <script type="text/javascript" src="http://use.typekit.com/kun2gxu.js"></script>
  <script type="text/javascript">try{Typekit.load();}catch(e){}</script>
  <script src="/wp-content/themes/shebang/js/jquery.min.js" type="text/javascript"></script>
  <script src="<?php bloginfo( 'stylesheet_directory' ); ?>/js/modernizr.js"></script>
<?php
// GN addition to actually insert Google Analytics code!
global $gaf;
if(isset($gaf)) $gaf->spool_analytics();
?>
</head>
<?php
	echo '<body class="'.trim($body_classes).'"';
	if ($parent_slug){
		echo ' data-post-parent-slug="'.$parent_slug.'" ';
	}
	if ($pi->post_name){
		echo ' data-slide-name="'.$pi->post_name.'" ';
	}
	echo '>';
?>

	<!-- ================================= --> 
	
	<!-- ! Global Header				   --> 
	
	<!-- ================================= -->
	<?php
		if ($pi){
			if ($pi->post_type == 'planner' || $pi->post_type == 'planners'){
				echo '<div id="container" data-role="page">';
			}
		}
	?>

	<header id="global-hdr" class="global-hdr">
		
		<div class="global-hdr-col-group">

			<!-- Column 1: Logo -->
			<div class="hdr-logo-col col-1">
				<h1 class="hdr-logo-container"><a href="/">
					<img class="hdr-logo" src="<?php bloginfo('stylesheet_directory'); ?>/_images/sqa-logo-large.png" alt="Squared Away" />
					<span class="beta-label"><span class="beta-label-text">Beta</span></span>
				</a></h1>
			</div> <!-- col-1 logo -->
	
	
			<!-- Column 2: Navigation -->
			<nav class="global-nav global-nav-col col-2">
				<ul class="global-nav-list">
               <li id="global-nav-search" class="global-nav-item"> 
                  <form id="searchform" method="get" action="/index.php">
                      <input id="search" name="s" type="text" class="ui-autocomplete-input search-header instant-search-small" autocomplete="off"  />
                     <!--<span class="search-header-magnifying"></span>-->
                     <input type="submit" class="search-header-magnifying" value="submit" />
                  </form>
               </li>
					<li id="global-nav-login" class="global-nav-item-btn"><a href="/wp-login.php">
						Login</a></li>
					<li id="global-nav-about" class="global-nav-item">
						<a href="/about/">
							About</a></li>
					<!--<li id="global-nav-life-stage" class="global-nav-item dropdown-trigger-hover">
						<a href="/getting-squared-away/">
							Make a Plan</a>
						
					</li>-->
					
					<li id="global-nav-tools" class="global-nav-item dropdown-trigger-hover">
						<a href="/tools/">
							Tools</a>
						<div class="dropdown-menu nav-dropdown-menu">
							<ul class="menu">
								<li class="menu-item"><a href="/calculators">Calculators</a></li>
								<li class="menu-item"><a href="/learn-more">Learn More</a></li>
								<li class="menu-item"><a href="/how-to">How To</a></li>
							</ul> <!-- /.menu -->
						</div>
					</li>
					<li id="global-nav-topics" class="global-nav-item dropdown-trigger-hover">
						<a href="/topics/">
							Topics</a>
						<div class="dropdown-menu nav-dropdown-menu">
							<?php get_template_part('menu', 'topics'); ?>
						</div>
					</li>
				</ul> <!-- /.global-nav-list -->
			</nav> <!-- /.global-nav -->
		
		</div> <!-- /.global-hdr-col-group -->
	
	</header> <!-- /.global-hdr -->


	<!-- ================================= --> 
	<!-- ! Optimized Modal	   			   --> 
	<!-- ================================= -->

	<?php include('_includes/optimized-modal.php'); ?>	


<div id="site-container">
<div class="nag-container"><p class="nag-text">Let us help you <a href="/getting-squared-away/" class="nag-link">Build a Personalized Financial Plan</a></p>
<a href="#"><img src="/wp-content/themes/shebang/_images/close.png" class="nag-close" /></a>
</div>