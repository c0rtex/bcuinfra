<?php
/**
 * Plugin Name: Role Scoper Migration Advisor
 * Plugin URI:  http://agapetry.net/
 * Description: Analyzes your Role Scoper installation for Press Permit import compatibility
 * Author:      Agapetry Creations LLC
 * Author URI:  http://agapetry.com/
 * Version:     1.0
 * Text Domain: rsu
 * Domain Path: /languages/
 * Min WP Version: 3.4
 */

/*
Copyright © 2013 Agapetry Creations LLC.

This file is part of Role Scoper Migration Advisor.

Role Scoper Migration Advisor is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 2 of the License, or
(at your option) any later version.

Role Scoper Migration Advisor is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

See <http://www.gnu.org/licenses/>.
*/

if ( ! defined( 'ABSPATH' ) ) exit; // Exit if accessed directly

if ( defined( 'RSU_FILE' ) ) {
	//$func = "do_action('pp_duplicate_extension', 'pp-import','" . PPI_FOLDER . "');";
	//add_action( 'init', create_function( '', $func ) );
	return;
} else {
	define( 'RSU_VERSION', '1.0' );
	define( 'RSU_FILE', __FILE__ );
	define( 'RSU_BASENAME', plugin_basename(__FILE__) );

	require_once( dirname(__FILE__).'/rsu_load.php' );
}
?>