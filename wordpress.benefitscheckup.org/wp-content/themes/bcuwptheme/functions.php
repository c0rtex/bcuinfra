<?php


add_action('init', 'session_manager');
function session_manager() {
       if (!session_id()) {
               session_start();
       }
}

add_action('wp_logout', 'session_logout');
function session_logout() {
        session_destroy();
}

add_filter('wp_login', 'check_login', 10, 3);
function check_login() {
     $_SESSION['authorized']='true'; return $user;
}


//update_option('siteurl','https://redesign.benefitscheckup.org');
//update_option('home','https://redesign.benefitscheckup.org');

register_sidebars(4, array('name'=>'sidebar%d'));

//Some simple code for our widget-enabled sidebar
//if ( function_exists('register_sidebar') )
 //   register_sidebar();

//Add support for WordPress 3.0's custom menus
add_action( 'init', 'register_my_menu' );

//Register area for custom menu
function register_my_menu() {
	register_nav_menu( 'primary-menu', __( 'Main Menu' ) );
}

//Code for custom background support
add_custom_background();

//Enable post and comments RSS feed links to head
add_theme_support( 'automatic-feed-links' );

// Enable post thumbnails
add_theme_support('post-thumbnails');
set_post_thumbnail_size(520, 250, true);

remove_filter('the_content', 'wpautop');

// CUSTOM ADMIN LOGIN LOGO LINK

function change_wp_login_url()
{
	echo bloginfo('url');  // OR ECHO YOUR OWN URL
}add_filter('login_headerurl', 'change_wp_login_url');

// CUSTOM ADMIN LOGIN LOGO & ALT TEXT

function change_wp_login_title()
{
	echo get_option('blogname'); // OR ECHO YOUR OWN ALT TEXT
}add_filter('login_headertitle', 'change_wp_login_title');

// CUSTOM ADMIN LOGIN HEADER LOGO

function my_custom_login_logo()
{
	echo '<style  type="text/css"> .login h1 a {  background-image:url('.get_bloginfo('template_directory').'/images/logos/bcu.png)  !important; background-size: 360px 77px; width: 360px; height: 77px; margin-left: -20px; } </style>';
}
add_action('login_head',  'my_custom_login_logo');

// Admin footer modification

function remove_footer_admin ()
{
	echo '<span id="footer-thankyou">Benefitscheckup.org</span>';
}
add_filter('admin_footer_text', 'remove_footer_admin');

/* RESPONSIVE STUFF */

// loading modernizr and jquery, and reply script
function rbcu_scripts_and_styles() {	
	if ( is_page_template( 'index-responsive.php' )  || is_page_template( 'index-mqc-rev.php' ) || is_page_template( 'index-ecu-rev.php' ) || is_page_template( 'index-ecu-full-rev.php' ) || is_page_template( 'index-ecu-alt-rev.php' ) || is_page_template( 'index-bcu-responsive-home.php' ) || is_page_template( 'index-bcu-responsive-full.php' ) || is_page_template( 'index-bcu-responsive-sidebar.php' ) ) {
		// bootstrap js
		wp_register_script( 'rbcu-bootstrap-js', get_stylesheet_directory_uri() . '/responsive/js/bootstrap.min.js', array('jquery'), false, false );
		wp_enqueue_script( 'rbcu-bootstrap-js' );
		
		// mqc and mqc_v3 js
		wp_register_script( 'mqc-js', get_stylesheet_directory_uri() . '/mqc.js', array('jquery'), false, false );
		wp_enqueue_script( 'mqc-js' );
		
		// register main stylesheet
		wp_register_style( 'rbcu-stylesheet', get_stylesheet_directory_uri() . '/responsive/css/bootstrap.min.css', array(), '', 'all' );
		wp_enqueue_style( 'rbcu-stylesheet' );

	}

	// pull in the correct stylesheet 
	if ( is_page_template( 'index-mqc-rev.php' )) {
		
		wp_register_style( 'rbcu-mqc-stylesheet', get_stylesheet_directory_uri() . '/mqc.css', array(), '', 'all' );
		wp_enqueue_style( 'rbcu-mqc-stylesheet' );

	}
	if (is_page_template( 'index-ecu-rev.php' ) || is_page_template( 'index-ecu-full-rev.php' ) || is_page_template( 'index-ecu-alt-rev.php' )) {
		
		wp_register_style( 'rbcu-mqc-stylesheet', get_stylesheet_directory_uri() . '/ecu.css', array(), '', 'all' );
		wp_enqueue_style( 'rbcu-mqc-stylesheet' );

	}
	if (is_page_template( 'index-bcu-responsive-home.php' ) || is_page_template( 'index-bcu-responsive-full.php' ) || is_page_template( 'index-bcu-responsive-sidebar.php' )) {
			
			wp_register_style( 'rbcu-mqc-stylesheet', get_stylesheet_directory_uri() . '/bcu.css', array(), '', 'all' );
			wp_enqueue_style( 'rbcu-mqc-stylesheet' );
	
		}
}

// Validations for the BCU QuickCheck form.
wp_enqueue_script( 'bcu-js', get_template_directory_uri() . '/bcu.js', array(), '1.0.0', true );

// enqueue base scripts and styles
add_action('wp_enqueue_scripts', 'rbcu_scripts_and_styles');

?>
