<?php
if ( ! defined( 'ABSPATH' ) ) exit; // Exit if accessed directly

define ( 'RSU_URLPATH', plugins_url( '', RSU_FILE ) );

require_once( ABSPATH . 'wp-admin/includes/class-wp-upgrader.php' );

class RSU_Updater {

	/**
	 * Perform automatic updates for the core plugin and addons
	 *
	 * @author Jonathan Davis
	 * @author Kevin Behrens
	 *
	 * @return void
	 **/
	public static function update( $plugin = '' ) {
		global $parent_file, $submenu_file;

		rsu_get_version_info(true);
		
		if ( ! current_user_can('update_plugins') )
			wp_die( __('You do not have sufficient permissions to update plugins for this site.') );

		if ( ! $plugin )
			$plugin = isset($_REQUEST['plugin']) ? trim($_REQUEST['plugin']) : '';

		$plugin = urldecode($plugin);

		if ( RSU_BASENAME != $plugin )
			return;
		
		$title = sprintf( __('Upgrade %s','pp'), 'Role Scoper Migration Advisor' );
		
		$slug = 'role-scoper-migration-advisor';

		// temp workaround
		global $pp_update_done;
		if ( ! empty($pp_update_done) ) { $return; }
		$pp_update_done = true;
	
		// check_admin_referer('upgrade-plugin_' . $plugin);
		$parent_file = 'plugins.php';
		$submenu_file = 'plugins.php';
		?>
<style>
.rsu .updating { background-image:url('<?php echo admin_url('');?>/images/wspin_light.gif');background-repeat:no-repeat; }
.rsu button.updating { background-position:5px 1px;padding-left:25px; }
.rsu .icon32 { background:url('<?php echo RSU_URLPATH;?>/admin/images/pp-logo-32.png') no-repeat; width:18px;height:32px;float:left;margin-right:15px }
.rsu p { font-family: sans-serif;font-size: 12px;line-height: 1.4em; }
</style>
		<?php
		$nonce = 'upgrade-plugin_' . $plugin;
		$url = "update.php?action={$slug}&plugin=" . $plugin;

		$upgrader = new RSU_Core_Upgrader( new RSU_Upgrader_Skin( compact('title', 'nonce', 'url', 'plugin') ) );
		$upgrader->upgrade($plugin);

		define('UPDATED_RSU_PLUGIN', true);
		
		$plugin_updates = get_site_transient('update_plugins');

		if ( is_object($plugin_updates) && isset($plugin_updates->response) ) {
			unset( $plugin_updates->response[$plugin] );
			set_site_transient( 'update_plugins', $plugin_updates );
		}
	}
} // end class RSU_Updater


/**
 * RSU_Upgrader class
 *
 * Provides foundational functionality specific to Press Permit update
 * processing classes.
 *
 * Extensions derived from the WordPress WP_Upgrader & Plugin_Upgrader classes:
 * @see wp-admin/includes/class-wp-upgrader.php
 *
 * @copyright WordPress {@link http://codex.wordpress.org/Copyright_Holders}
 *
 * @author Jonathan Davis
 * @author Kevin Behrens
 **/
class RSU_Upgrader extends Plugin_Upgrader {

	function download_package($package) {
		if ( ! preg_match('!^(http|https|ftp)://!i', $package) && file_exists($package) ) //Local file or remote?
			return $package; //must be a local file..

		if ( empty($package) )
			return new WP_Error('no_package', $this->strings['no_package']);

		$this->skin->feedback( 'downloading_package', $package );

		$vars = array('VERSION','KEY','URL');
		$values = array( RSU_VERSION, '', urlencode( get_option('siteurl') ) );
		$package = str_replace( $vars, $values, $package );

		$download_file = $this->download_url($package);

		if ( is_wp_error($download_file) )
			return new WP_Error('download_failed', $this->strings['download_failed'], $download_file->get_error_message());

		return $download_file;
	}

	function download_url ( $url ) {
		//WARNING: The file is not automatically deleted, The script must unlink() the file.
		if ( ! $url )
			return new WP_Error('http_no_url', __rsuw('Invalid URL Provided'));

		$request = parse_url($url);
		parse_str($request['query'],$query);
		$tmpfname = wp_tempnam( $query['update'] . ".zip" );
		if ( ! $tmpfname )
			return new WP_Error('http_no_file', __rsuw('Could not create Temporary file'));

		$handle = @fopen($tmpfname, 'wb');
		if ( ! $handle )
			return new WP_Error('http_no_file', __rsuw('Could not create Temporary file'));

		$response = wp_remote_get($url, array('timeout' => 300));

		if ( is_wp_error($response) ) {
			fclose($handle);
			unlink($tmpfname);
			return $response;
		}

		if ( $response['response']['code'] != '200' ){
			fclose($handle);
			unlink($tmpfname);
			return new WP_Error('http_404', trim($response['response']['message']));
		}

		fwrite($handle, $response['body']);
		fclose($handle);

		return $tmpfname;
	}

	function unpack_package($package, $delete_package = true, $clear_working = true) {
		global $wp_filesystem;

		$this->skin->feedback('unpack_package');

		$upgrade_folder = $wp_filesystem->wp_content_dir() . 'upgrade/';

		//Clean up contents of upgrade directory beforehand.
		if ($clear_working) {
			$upgrade_files = $wp_filesystem->dirlist($upgrade_folder);
			if ( !empty($upgrade_files) ) {
				foreach ( $upgrade_files as $file )
					$wp_filesystem->delete($upgrade_folder . $file['name'], true);
			}
		}

		//We need a working directory
		$working_dir = $upgrade_folder . basename($package, '.zip');

		// Clean up working directory
		if ( $wp_filesystem->is_dir($working_dir) )
			$wp_filesystem->delete($working_dir, true);

		// Unzip package to working directory
		$result = unzip_file($package, $working_dir); // @todo optimizations, Copy when Move/Rename would suffice?

		// Once extracted, delete the package if required.
		if ( $delete_package )
			unlink($package);

		if ( is_wp_error($result) ) {
			$wp_filesystem->delete($working_dir, true);
			return $result;
		}
		$this->working_dir = $working_dir;

		return $working_dir;
	}
}

/**
 * RSU_Core_Upgrader class
 *
 * Adds auto-update support for the core plugin.
 *
 * Extensions derived from the WordPress WP_Upgrader & Plugin_Upgrader classes:
 * @see wp-admin/includes/class-wp-upgrader.php
 *
 * @copyright WordPress {@link http://codex.wordpress.org/Copyright_Holders}
 *
 * @author Jonathan Davis
 * @author Kevin Behrens
 **/
class RSU_Core_Upgrader extends RSU_Upgrader {

	function upgrade_strings($plugin) {
		$title = 'Role Scoper Migration Advisor';
	
		if ( $title ) {
			$this->strings['up_to_date'] = __rsuw( 'The plugin is at the latest version.' );
			$this->strings['no_package'] = sprintf( __rsuw('%s upgrade package not available.','pp'), $title );
			$this->strings['downloading_package'] = sprintf(__rsuw('Downloading update from <span class="code">%s</span>&#8230;'),untrailingslashit('http://presspermit.com/'));
			$this->strings['unpack_package'] = __rsuw('Unpacking the update&#8230;');
			$this->strings['deactivate_plugin'] = sprintf( __rsuw('Deactivating %s.','pp'), $title );
			$this->strings['remove_old'] = __rsuw('Removing the old version of the plugin&#8230;');
			$this->strings['remove_old_failed'] = __rsuw('Could not remove the old plugin.');
			$this->strings['process_failed'] = sprintf( __rsuw('%s upgrade Failed.','pp'), $title );
			$this->strings['process_success'] = sprintf( __rsuw('%s upgraded successfully.','pp'), $title );
		}
	}

	function upgrade($plugin) {
		$this->init();
		$this->upgrade_strings($plugin);

		$current = get_site_transient('rsu_update_info');
	
		if ( ! isset( $current->response[ $plugin ] ) ) {
			$this->skin->set_result(false);
			$this->skin->error('up_to_date');
			$this->skin->after();
			return false;
		}

		// Get the URL to the zip file
		$r = $current->response[ $plugin ];

		add_filter('upgrader_clear_destination', array(&$this, 'delete_old_plugin'), 10, 4);

		$this->run(array(
					'package' => $r->package,
					'destination' => WP_PLUGIN_DIR,
					'clear_destination' => true,
					'clear_working' => true,
					'hook_extra' => array(
					'plugin' => $plugin
					)
				));

		// Cleanup our hooks, incase something else does a upgrade on this connection.
		remove_filter('upgrader_clear_destination', array(&$this, 'delete_old_plugin'));

		if ( ! $this->result || is_wp_error($this->result) )
			return $this->result;

		// Force refresh of plugin update information
		set_site_transient('rsu_update_info', false);
	}
}

/**
 * RSU_Upgrader_Skin class
 *
 * Extensions derived from the WordPress Plugin_Upgrader_Skin class:
 * @see wp-admin/includes/class-wp-upgrader.php
 *
 * @author Jonathan Davis
 * @author Kevin Behrens
 **/
class RSU_Upgrader_Skin extends Plugin_Upgrader_Skin {
	/**
	 * Custom heading
	 *
	 * @author Jonathan Davis
	 * @author Kevin Behrens
	 *
	 * @return void Description...
	 **/

	function header() {
		if ( $this->done_header )
			return;
		$this->done_header = true;
		echo '<div class="wrap rsu">';
		echo screen_icon();
		echo '<h2>' . $this->options['title'] . '</h2>';
	}
} // END class RSU_Upgrader_Skin
?>