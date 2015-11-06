<?php
if ( ! defined( 'ABSPATH' ) ) exit; // Exit if accessed directly

$rs_pp_loader = new RS_PP_Loader();

class RS_PP_Loader {
	function __construct() {
		global $pagenow;
		
		add_action( 'admin_menu', array( &$this, 'rsu_admin_menu' ) );
		add_action( 'admin_head', array( &$this, 'rsu_admin_head' ) );
		
		if ( in_array( $pagenow, array( 'plugins.php', 'plugin-install.php' ) ) ) {
			global $rsu_plugin_admin;
			require_once( dirname(__FILE__).'/admin-plugins_rsu.php' );
			$rsu_plugin_admin = new RSU_Plugin_Admin();
		}

		if ( in_array( $pagenow, array( 'update.php', 'plugin-install.php', 'update-core.php', 'plugins.php' ) ) ) {
			require_once( dirname(__FILE__).'/plugin-update-watch_rsu.php' );
			RSU_UpdateWatch::update_watch();
		}
	}

	function rsu_admin_head() {
		$screen = get_current_screen();
        $page_slug = $screen->id;
		
		if ( false !== strpos( $page_slug, 'rs-migration-advisor' ) ) {
			wp_enqueue_style( 'rs-admin-advisor', plugins_url( '', RSU_FILE ) . '/admin/css/rs-admin-advisor.css', array(), RSU_VERSION );
		}
	}
	
	function rsu_admin_menu() {
		if ( ! is_super_admin() && ! current_user_can('activate_plugins') )
			return;
		
		//add_utility_page( __( 'RS Migration Advisor', 'rsu' ), __( 'RS Migration Advisor', 'rsu' ), 'read', plugins_url( 'admin.php?page=rs-migration-advisor.php' ) );
		
		$slug = add_menu_page( __( 'RS Migration Advisor', 'rsu' ), __( 'RS Migration', 'rsu' ), 'read', 'rs-migration-advisor', array( &$this, 'do_rs_advisor' ) );
		add_action( "load-$slug", array(&$this, 'nada'));
		
		$slug = add_submenu_page( 'rs-migration-advisor', __( 'RS Migration Advisor', 'rsu' ), __( 'RS Migration', 'rsu' ), 'read', 'rs-migration-advisor', array( &$this, 'do_rs_advisor' ) );
		add_action( "load-$slug", array(&$this, 'nada'));
	}

	function nada() {
	}
	
	function do_rs_advisor() {
		$screen = get_current_screen();
        $page_slug = $screen->id;
		
		if ( false !== strpos( $page_slug, 'rs-migration-advisor' ) ) {
			global $rsu_rs_import;
			require_once( dirname(__FILE__).'/rs-pp-analysis_rsu.php' );
			$rsu_rs_import = new RS_PP_Analysis();
			$rsu_rs_import->analyze();
		}
	}
}

// wrapper for __(), prevents WP strings from being forced into plugin .po
function __rsuw( $string, $unused = '' ) {
	return __( $string );		
}
?>