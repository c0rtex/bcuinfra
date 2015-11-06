<?php
class RSU_Plugin_Admin {
	function __construct() {
		add_action( 'after_plugin_row_' . RSU_BASENAME, array(&$this, 'plugin_status'), 10, 3 );
		
		add_action( 'load-plugins.php', array( &$this, 'suppress_wp_update_msg' ) );

		add_action( 'install_plugins_pre_plugin-information', array( &$this, 'changelog' ) );
		add_action( 'plugins_api', array( &$this, 'disable_plugins_api' ), 10, 3 );
	}
	
	function disable_plugins_api( $val, $action, $args ) {
		if ( $args && ! empty($args->slug) ) {
			if ( RSU_BASENAME == $args->slug )
				return (object) array( 'body' => '' );
		}

		return $val;
	}
	
	// Suppress the standard WordPress plugin update message for the pp listing on the plugin page
	function suppress_wp_update_msg() {
		remove_action( 'after_plugin_row_' . RSU_BASENAME, 'wp_plugin_update_row' );
	}

	// note: this is only called for RSU plugin row
	function plugin_status( $plugin_file, $plugin_data, $status ) {
		require_once( dirname(__FILE__).'/plugin_rsu.php' );
		RSU_Plugin_Status::status( $plugin_file, $plugin_data, $status );
	}
	
	function changelog() {
		if ( $_REQUEST["plugin"] == 'role-scoper-migration-advisor' ) {
			require_once( dirname(__FILE__).'/plugin_rsu.php' );
			RSU_Plugin_Status::changelog();
		}
	}
} // end class
?>