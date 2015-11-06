<?php
if ( ! defined( 'ABSPATH' ) ) exit; // Exit if accessed directly

global $wpdb;

if ( ! defined('SCOPER_VERSION' ) || empty($wpdb->groups_rs) )
	rsu_rs_db_config();

function rsu_rs_db_config() {
	global $wpdb;
	$wpdb->user2role2object_rs = $wpdb->prefix . 'user2role2object_rs'; 
	$wpdb->role_scope_rs = $wpdb->prefix . 'role_scope_rs';

	$prefix = $wpdb->prefix; // ( ! empty($wpdb->base_prefix) && $sitewide_groups ) ? $wpdb->base_prefix : $wpdb->prefix;

	$wpdb->groups_basename =	'groups_rs';
	$wpdb->groups_rs = 			$prefix . $wpdb->groups_basename; 

	$wpdb->user2group_rs = 	$prefix . 'user2group_rs';

	$wpdb->groups_id_col = 		 'ID';
	$wpdb->groups_name_col = 	 'group_name';
	$wpdb->groups_descript_col = 'group_description';
	$wpdb->groups_homepage_col = 'group_homepage';
	$wpdb->groups_meta_id_col =  'group_meta_id';

	$wpdb->user2group_gid_col = 		'group_id';
	$wpdb->user2group_uid_col = 		'user_id';
	$wpdb->user2group_assigner_id_col = 'assigner_id';
	$wpdb->user2group_status_col 	  = 'status';
}
?>