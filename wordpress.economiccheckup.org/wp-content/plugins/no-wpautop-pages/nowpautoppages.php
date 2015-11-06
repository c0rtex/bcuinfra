<?php
/*
Plugin Name: No wpautop Pages
Plugin URI: http://wordpress28vqs.com/
Description: This removes the wpautop function for pages, but leaves it intact for posts.
Author: Matt Beck
Version: 1.0
Author URI: http://couldbestudios.com
*/



/* REMOVE WPAUTOP FOR PAGES ONLY */

function nowpautop($content){
	if(is_page())
		{
		remove_filter('the_content','wpautop');
		}
	return $content;
	}
	
add_action('loop_start','nowpautop');
?>
