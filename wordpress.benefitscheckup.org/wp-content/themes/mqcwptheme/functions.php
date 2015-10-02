<?php
//Some simple code for our widget-enabled sidebar
if ( function_exists('register_sidebar') )
    register_sidebar();

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
	echo '<style  type="text/css"> h1 a {  background-image:url('.get_bloginfo('template_directory').'/images/logos/bcu.png)  !important; } </style>';
}
add_action('login_head',  'my_custom_login_logo');

// Admin footer modification

function remove_footer_admin ()
{
	echo '<span id="footer-thankyou">Benefitscheckup.org</span>';
}
add_filter('admin_footer_text', 'remove_footer_admin');
?>