<?php
class RSU_UpdateWatch {
	public static function update_watch() {
		if ( ( empty( $_REQUEST['action'] ) || ( in_array( $_REQUEST['action'], array( 'edit', 'trash', 'delete' ) ) ) && empty( $_REQUEST['action2'] ) ) )
			return;

		$pp_update_info = rsu_get_version_info( true ); // force refresh
		
		$action = ( isset($_REQUEST['action']) ) ? sanitize_key($_REQUEST['action']) : '';
		
		if ( ( -1 == $action ) || ! $action )
			$action = ( isset($_REQUEST['action2']) ) ? sanitize_key($_REQUEST['action2']) : '';

		if ( 'role-scoper-migration-advisor' == $action ) {		
			add_action( 'update-custom_role-scoper-migration-advisor', array( 'RSU_UpdateWatch', 'plugin_update' ) );

		} elseif ( in_array( $action, array( 'update-selected', 'do-plugin-upgrade' ) ) && ( ! empty($_REQUEST['checked']) || ! empty($_REQUEST['plugins']) ) ) {
			$slug_by_basename = array();
			$slug_by_basename[ RSU_BASENAME ] = 'role-scoper-migration-advisor';

			$arr_checked = ( isset($_REQUEST['checked']) ) ? (array) $_REQUEST['checked'] : (array) $_REQUEST['plugins'];

			$msg = sprintf( __('Bulk Update is not currently supported for Role Scoper Migration Advisor. Please use the individual plugin update link in the %1$splugins list%2$s instead.', 'rsu' ), '<a href="plugins.php?plugin_status=upgrade">', '</a>' );
			
			$any_pp_updates = false;
			foreach( $arr_checked as $basename ) {
				if ( isset( $slug_by_basename[$basename] ) ) {
					$any_pp_updates = true;
					add_action( 'all_admin_notices', create_function('', 'echo \'<div id="message" class="error fade" style="color: black"><p>' . $msg . '</p></div>\';') );
					break;
				}
			}
			
			// for now, just remove RSU from bulk update
			$any_other_updates = false;
			foreach( array( 'checked', 'plugins' ) as $varname ) {
				if ( isset($_REQUEST[$varname]) ) {
					if ( is_array( $_REQUEST[$varname] ) ) {
						$_REQUEST[$varname] = @array_diff( $_REQUEST[$varname], array_keys($slug_by_basename) );
						$_POST[$varname] = @array_diff( $_POST[$varname], array_keys($slug_by_basename) );
						if ( count($_REQUEST[$varname]) ) {
							$any_other_updates = true;
						}
					} else {
						$arr_selected = explode( ',', $_REQUEST[$varname] );
						$arr_selected = @array_diff( $arr_selected, array_keys($slug_by_basename) );
						if ( count($arr_selected ) ) {
							$any_other_updates = true;
						}
						$_REQUEST[$varname] = implode( ',', $arr_selected );
						$_POST[$varname] = implode( ',', $arr_selected );
					}
				}
			}

			if ( $any_pp_updates && ! $any_other_updates ) {
				wp_die( $msg );
			}
		}
	}
	
	function plugin_update( $plugin = '' ) {
		require_once( dirname(__FILE__).'/plugin-update_rsu.php' );
		RSU_Updater::update( $plugin );
	}
} // end class

?>