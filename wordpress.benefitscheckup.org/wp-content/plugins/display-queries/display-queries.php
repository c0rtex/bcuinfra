<?php
/*
Plugin Name: Display Queries
Plugin URI: http://www.wordpress.org/extend/plugins/display-queries/
Description: Display page loading time and number of queries
Version: 1.0.1
Author: Markus M&#252;ller
Author URI: http://www.dreams.de/
Lizenz: GPL2
*/

function get_all_text() {
	$def_lang = "en_US";
	if (defined('WPLANG')) { $def_lang = constant('WPLANG'); }

	switch ($def_lang) {
	    case 'de_DE':
			$lang[queries] =	"Abfragen";
			$lang[seconds] =	"Sekunden";
	        break;
	    case 'fr_FR':
			$lang[queries] =	"requ&#234;tes";
			$lang[seconds] =	"seconde";
	        break;


	    default:
			$lang[queries] =	"queries";
			$lang[seconds] =	"seconds";
	}
	return $lang;
}

add_action('wp_footer', 'view');

function view() {
	global $user_level;
	if ( $user_level < 8 ) { return; }
	$lang = get_all_text();
?>	
<div style="background:#000;color:#fff;border:1px solid #f00;padding:5px;text-align:center;">
	<div style="float:right;text-align: right;">
		<a onclick="v_target(this)" rel="nofollow" href="http://validator.w3.org/check/referer"><img style="border:0;width:51px;height:18px" src="http://validator.w3.org/images/valid_icons/valid-xhtml10.gif" alt="XHTML" /></a>&nbsp;
		<a onclick="v_target(this)" rel="nofollow" href="http://jigsaw.w3.org/css-validator/check/referer"><img style="border:0;width:51px;height:18px" src="http://jigsaw.w3.org/css-validator/images/vcss" alt="CSS" /></a>
	</div>
	<span style="font-size:15px;font-weight:bold;font-family:verdana, sans-serif;"><?php printf("%u %s - %s %s.",get_num_queries(),$lang[queries],timer_stop(0,2),$lang[seconds]);?></span>	
	<br style="clear:both" />
</div>
<?php } ?>