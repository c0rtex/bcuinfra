<?php
class RSU_Plugin_Status {
	public static function get_remote_request_params(){
		global $wpdb;
		
		$data = array(
			/*'call' => 'pp',*/
			'core' => 0,
			'wp' => get_bloginfo('version'),
			'is_ms' => is_multisite(),
			'php' => phpversion(),
			'mysql' => $wpdb->db_version(),
		);
		
		$data['bp'] = ( defined( 'BP_VERSION' ) ) ? BP_VERSION : 0;
		$data['bbp'] = ( function_exists( 'bbp_get_version' ) ) ? bbp_get_version() : 0;
		$data['rvy'] = ( defined( 'RVY_VERSION' ) ) ? RVY_VERSION : 0;
		$data['cme'] = ( defined( 'CAPSMAN_ENH_VERSION' ) ) ? CAPSMAN_ENH_VERSION : 0;

		$data['role-scoper-migration-advisor'] = RSU_VERSION;
		
		return $data;
    }

	// function callhome() derived from Gravity Forms and Shopp
	public static function callhome( $request_topic, $request_vars = array(), $post_vars = false ) {
		$request_vars = array_merge( self::get_remote_request_params(), (array) $request_vars, array( 'PPServerRequest' => $request_topic ) );

		$query = http_build_query( $request_vars, '', '&' );
		
		$args = array(
			'headers' => array(
				'Content-Type' => 'application/x-www-form-urlencoded; charset=' . get_option('blog_charset'),
				'User-Agent' => 'WordPress/' . get_bloginfo("version"),
				'Referer' => get_bloginfo("url")
			),
		);
		
		if ( 'config-info' == $request_topic )
			$args['timeout'] = 30;
		else
			$args['timeout'] = in_array( $request_topic, array( 'update-check', 'changelog' ) ) ? 8 : 20;
		
		if ( false !== $post_vars )
			$args['body'] = $post_vars;
		
		$server_response = wp_remote_post( 'http://presspermit.com/' . "index.php?$query", $args );
		
		$result = false;
		
		if ( is_wp_error($server_response) ) {
			// @todo
		} else {
			if ( isset($server_response['body']) ) {
				$start_tag = '<!--PPServer-->';
				$pos = strpos( $server_response['body'], $start_tag );
				if ( false !== $pos ) {
					$end_pos = strpos( $server_response['body'], '<!--End PPServer-->' );
					if ( $end_pos ) {
						$result = substr( $server_response['body'], $pos + strlen($start_tag), $end_pos - ( $pos + strlen($start_tag) ) );
						$result = maybe_unserialize($result);
					}
				}
			}
		}

		if ( 'config-upload' == $request_topic )
			return ( ! empty($server_response) && ! is_wp_error($server_response) );
		else
			return $result;
	}

	// function get_verision_info() derived from Gravity Forms and Shopp
	public static function get_version_info( $force_refresh = false, $return_all = false, $update_transient = false ){
		delete_site_transient('rsu_update_info');
		
		$updates = get_site_transient('rsu_update_info'); // pull current stored values from DB
		
		if ( ! is_object($updates) )
			$updates = (object) array( 'response' => array() );
		
		static $done;  // sanity check - never call more than once in a single http request
		if ( ! empty($updates->response) && isset($done) && ! ( $force_refresh || ! $return_all ) ) { return $updates; }
		$done = true;

        if ( empty($_REQUEST['deactivate']) && empty($_REQUEST['deactivate-multi']) && ( $force_refresh || empty($updates) || ! isset($updates->response[RSU_BASENAME]) ) ) {
			$raw_response = self::callhome( 'version-check' );

			$all_updates = ( isset( $raw_response->all ) ) ? $raw_response->all : array();

			//set_site_transient( 'ppc_all_updates', $all_updates );

			if ( isset( $raw_response->extensions['role-scoper-migration-advisor'] ) ) {
				$updates->response[RSU_BASENAME] = (object) $raw_response->extensions['role-scoper-migration-advisor'];
			
				if ( $raw_response && ( -1 !== $raw_response ) ) {
					if ( ! defined( 'UPDATED_RSU_PLUGIN' ) )
						set_site_transient('rsu_update_info', $updates, 7200); //caching for 2 hours
				}
			}
        }
		
		$plugin_updates = (object) get_site_transient('update_plugins');

		if ( $plugin_updates )
			unset($plugin_updates->response[RSU_BASENAME]); // If no updates, remove PP from the plugin update count
		
		if ( $updates && ! empty($updates->response) && ! empty($updates->response[RSU_BASENAME]) && ! empty( $updates->response[RSU_BASENAME]->package ) )
			$plugin_updates->response[RSU_BASENAME] = (object) array( 'slug' => 'role-scoper-migration-advisor', 'new_version' => null );

		if ( $update_transient && ! defined('UPDATED_RSU_PLUGIN') )
			set_site_transient( 'update_plugins', $plugin_updates );
		
		return ( $return_all ) ? $all_updates : $updates;
	}
	
	/**
	 * Reports on the availability of new updates and the update key
	 *
	 * @author Jonathan Davis
	 * @author Kevin Behrens
	 *
	 * @return void
	 **/
	public static function status ( $plugin_file, $plugin_data, $status ) {
		$updates = self::get_version_info();

		if ( RSU_BASENAME == $plugin_file ) {
			$slug = 'role-scoper-migration-advisor';
			$current_version = RSU_VERSION;
		} else {
			return;
		}

		$version_info = isset( $updates->response[$plugin_file] ) ? $updates->response[$plugin_file] : false;
		
		if ( ! empty( $version_info ) && isset($version_info->new_version) ) { // update available
			if ( version_compare( $version_info->new_version, $current_version, '>' ) ) { 
				$network = ( is_network_admin() ) ? 'network/' : '';
				$details_url = admin_url("{$network}plugin-install.php?tab=plugin-information&plugin=$slug&TB_iframe=true&width=600&height=800");
				$update_url = wp_nonce_url( "update.php?action=$slug&plugin=" . $plugin_file, 'upgrade-plugin_' . $slug );

				$message = sprintf(__rsuw('There is a new version of %1$s available. <a href="%2$s" class="thickbox" title="%3$s">View version %4$s details</a> or <a href="%5$s">upgrade automatically</a>.'),$plugin_data['Name'],$details_url,esc_attr($plugin_data['Name']),$version_info->new_version,$update_url);

				echo '<tr class="plugin-update-tr"><td colspan="3" class="plugin-update"><div class="update-message">'.$message.'</div></td></tr>';

				return;
			}
		}
	}
	
	/**
	 * Loads the change log for an available update
	 *
	 * @author Jonathan Davis
	 * @author Kevin Behrens
	 *
	 * @return void
	 **/
	public static function changelog () {
		if ( ( $_REQUEST["plugin"] != "role-scoper-migration-advisor" ) ) return;
		
		$response = self::callhome( 'changelog-ppc', array( 'plugin' => $_REQUEST["plugin"] ) );

		echo '<html><head>';
		echo '<link rel="stylesheet" href="'.admin_url().'/css/install.css" type="text/css" />';
		echo '</head>';
		echo '<body id="error-page" class="rsu-update" style="margin-top:20px;margin-bottom:20px;width:540px;">';
		echo $response;
		echo "</body>";
		echo '</html>';
		exit();
	}
}
?>