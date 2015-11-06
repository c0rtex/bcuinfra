<?php
if ( ! defined( 'ABSPATH' ) ) exit; // Exit if accessed directly

if ( is_admin() )
	require_once( dirname(__FILE__).'/admin/admin-load_rsu.php' );

add_action( 'init', '_rsu_version_check' );

function _rsu_version_check() {
	$ver = get_option('rsu_version');
	
	if ( empty($ver['version']) || version_compare( RSU_VERSION, $ver['version'], '!=') ) {
		update_option( 'rsu_version', array( 'version' => RSU_VERSION, 'db_version' => 0 ) );
	}
}

function rsu_get_version_info( $force_refresh = false, $return_raw = false, $update_transient = false ) {
	require_once( dirname(__FILE__).'/admin/plugin_rsu.php' );
	return RSU_Plugin_Status::get_version_info( $force_refresh, $return_raw, $update_transient );
}
?>