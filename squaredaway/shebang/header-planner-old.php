<?php
	header("Cache-Control: no-cache, must-revalidate"); // HTTP/1.1
	header("Expires: Mon, 26 Jul 2007 05:00:00 GMT"); // Date in the past
	if ($_COOKIE['uid']){
		$_SESSION['uid'] = $_COOKIE['uid'];
	}
?><!doctype html><!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta charset="<?php bloginfo( 'charset' ); ?>" />
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
	
	$pi = get_post_info();
	if ($pi->post_parent == 0){
		$planner_slug = $pi->post_name;
	} else {
		$parent = get_post_info($pi->post_parent);
		$planner_slug = $parent->post_name;
	}
	$file = $_SERVER['DOCUMENT_ROOT'].'/wp-content/themes/shebang/_css/planner-'.$planner_slug.'.css';
	if (file_exists($file)){
		echo '<link rel="stylesheet" href="'.get_bloginfo( 'stylesheet_directory' ).'/_css/planner-'.$planner_slug.'.css?v=2">';
	} else {
		echo '<link rel="stylesheet" href="'.get_bloginfo( 'stylesheet_directory' ).'/_css/planner.css?v=2">';
	}	
	?>

	<script src="/wp-content/themes/shebang/js/jquery.min.js" type="text/javascript"></script>
<?php
	wp_head();
	echo '<script type="text/javascript" src="'.get_template_directory_uri().'/shebang.js"></script>';
	echo '<script type="text/javascript" src="'.get_template_directory_uri().'/js/tito-base.js"></script>';
	//echo '<script type="text/javascript" src="'.get_template_directory_uri().'/js/planner-target.js"></script>';
?>

  <!-- TypeKit code -->
  <script type="text/javascript" src="http://use.typekit.com/kun2gxu.js"></script>
  <script type="text/javascript">try{Typekit.load();}catch(e){}</script>

</head>
<?php
	$pi = get_post_info(get_the_ID());
	$classes = 'frame-page '.$pi->post_name;
	$classes .= ' post-type-'.$pi->post_type;
	$parent_slug = shebang_get_parent_slug($pi->ID);
?>
<body class="<?= $classes; ?>" data-slide-name="<?= $pi->post_name; ?>" data-post-parent-slug="<?= $parent_slug ?>">

  <div id="container" data-role="page">


	<!-- ================================= --> 
	<!-- ! Treatment Header Mini		   --> 
	<!-- ================================= -->

	<header id="treatment-mini" class="treatment-header-mini"> 

		<!-- Column 1: Logo -->
		
		<div class="col-1">
			<a class="header-logo-small" href="/">
				<img src="<?= get_bloginfo('template_url')?>/_images/sqa-logo-small.png" />
			</a>
		</div> <!-- col-1 logo -->


		<!-- Column 2: Prev-Next -->
		<nav class="col-2 prev-next-mini">
			<div class="col-1">
				<?php
					$np = get_next_slide();
					if ($np){
					echo '<a class="next tip-trigger" href="'.$np->permalink.'">';
						echo '<span class="next-arrow"></span>';
						echo '<span class="next-text tooltip-dark">Next</span></a>';
					}
				?>
			</div> <!-- /.col-1 -->

			<div class="col-2">
				<?php
					$pp = get_previous_slide();
					if ($pp){
					echo '<a class="prev tip-trigger" href="'.$pp->permalink.'">';
						echo '<span class="prev-arrow"></span>';
						echo '<span class="next-text tooltip-dark">Prev</span></a>';
					}
				?>
			</div> <!-- /.col-2 -->		
		
		</nav> <!-- /.col-2 prev-next-mini -->

		<!-- Treatment Title -->
		<div class="treatment-title-col">
			<h1 class="treatment-submenu-trigger"><a class="treatment-title" href="index.php"> 
				<?php echo get_planner_title(); ?><span class="down-arrow-white"></span></a>
				<ul class="treatment-submenu step-2-drop">
					<div class="y-scroll">
						<?php
							$children = get_planner_slides();
							foreach($children as $child){
								$c++;
								$link = get_permalink($child->ID);
								echo '<li class="treatment-submenu-item"><a href="'.$link.'"><span class="submenu-number">'.$c.'</span>'.$child->post_title.'</a></li>';
							}
						?>							 
						<li class="treatment-submenu-item back-to-dash"><a href="#"> 
							<span class="submenu-number">&laquo;</span> Back to dashboard</a></li>
					</div> <!-- y-scroll -->	
				</ul></h1> 

		</div> <!-- treatment-title -->

	
	</header> <!-- treatment-header-mini -->
	
	
	<!-- ================================= --> 
	<!-- ! Start #main div container	   --> 
	<!-- ================================= -->

    <div id="main">
    	<header id="frame-menu">
			
			<div class="col-1">
				<div id="action-menu" class="action-menu">
	
					<!-- Dropdown Trigger: Activates Menu --> 
					<a class="action-dropdown dropdown-button dropdown-trigger clearfix"> 
						<h3 class="action-menu-action-h1">Action Plan <span class="action-item">&nbsp;</span></h3>
						<span class="circle-down-arrow-white"></span>
					</a> 
					
					<!-- Action Plan: Dropdown -->
					<ul class="action-list">
						<div class="y-scroll">
							<?php include('_includes/cys/action-menu-todos.php'); ?>	
						</div> <!-- y-scroll -->
					</ul> <!-- action-list -->
						
				</div> <!-- action-menu -->
			</div> <!-- /.col-1 -->
			

			<!-- Action Plan: Goal Menu -->

			<div class="col-2">
				<div id="savings-menu" class="savings-menu">

					<div class="savings-menu-text">
						<div class="col-1">
							<h3 class="action-menu-goal-h1" data-field="cys_monthly_goal">Goal</h3>
						</div> <!-- /.col-1 -->
						<div class="money-saved col-2">
							<span class="money-number">
								<span class="dollar">$</span><span class="value saved ls-value" data-field="cys_savings">0</span>
								
								<span class="ls-boolean-display" data-field="cys_monthly_goal">
									<span class="slash"> / </span>
									<span class="dollar">$</span>
									<span class="value goal ls-value" data-field="cys_monthly_goal">0</span>
								</span>
								
							</span> <!-- money-number -->
						</div> <!-- /.col-2 money-saved -->
					</div> <!-- savings-menu-text -->
					
					<div class="money-bar">
						<div class="money-bar-leader"></div>
					</div> <!-- money-bar -->
				
				</div> <!-- savings-menu -->
			</div> <!-- /.col-2 -->
				
    	</header> <!-- frame-menu -->


		<!-- ================================= --> 
		<!-- ! Optimized Modal	   			   --> 
		<!-- ================================= -->
	
		<?php include('_includes/optimized-modal.php'); ?>	


    	<section id="session-data">
    		
    		<input type="hidden" id="uid" value="<?php echo $_COOKIE['uid'];?>" />
    	</section>
    	
    	<section class="frame-container section">
    	
    	<?php
    		echo shebang_get_json_payload('shebang_defaults');
    	?>