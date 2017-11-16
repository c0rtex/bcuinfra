<?php

/*
* Settings for White Label stuff
*/

// Shortcuts Menu
$menu_name = 'Shortcuts Menu';
$menu_exists = wp_get_nav_menu_object($menu_name);

// If it doesn't exist, let's create it.
if(!$menu_exists) {
	$menu_id = wp_create_nav_menu($menu_name);

	// Set up default menu items
	wp_update_nav_menu_item($menu_id, 0, array(
		'menu-item-title' =>  __('Benefits Enrollment Center (BEC) Toolkit'),
		'menu-item-url' => 'https://www.ncoa.org/resources/benefits-enrollment-center-toolkit/',
		'menu-item-status' => 'publish'));

	wp_update_nav_menu_item($menu_id, 0, array(
		'menu-item-title' =>  __('Map of BEC Grantees'),
		'menu-item-url' => 'https://www.ncoa.org/map/ncoa-map/',
		'menu-item-status' => 'publish'));

	wp_update_nav_menu_item($menu_id, 0, array(
		'menu-item-title' =>  __('BEC Promising Practices Report'),
		'menu-item-url' => 'https://www.ncoa.org/resources/bec-promising-practices-report/',
		'menu-item-status' => 'publish'));

	wp_update_nav_menu_item($menu_id, 0, array(
		'menu-item-title' =>  __('Outreach Toolkit'),
		'menu-item-url' => 'https://www.ncoa.org/centerforbenefits/outreach-toolkit/',
		'menu-item-status' => 'publish'));
}

$menu_term_id = !empty($menu_exists->term_id) ? $menu_exists->term_id : $menu_id;

$page = Page::make('global-settings', 'Global Settings')->set([
	'icon' => 'dashicons-cloud',
	'tabs' => false
]);

$sections[] = Section::make('whitelable-setting', 'White Label Settings');
$settings["whitelable-setting"] = [
	Field::media('main-logo', ['title' => 'Main Logo']),
	Field::text('main-logo-width', ['title' => 'Main Logo Width']),
	Field::text('main-logo-height', ['title' => 'Main Logo Height']),
	Field::radio('whitelabel', ['yes','no'], ['title' => 'White Label']),
	Field::radio('showHeaderCTA', ['yes','no'], ['title' => 'Show Header CTA']),
	Field::media('whitelabel-logo', ['title' => 'White Label Logo']),
	Field::text('white-label-logo-width', ['title' => 'White Label Logo Width']),
	Field::text('white-label-logo-height', ['title' => 'White Label Logo Height']),
	Field::radio('show-white-label-shortcuts', [1 => 'Yes', 0 => 'No'], [
		'title' => 'Show Shortcuts',
		'info' => 'Enables shortcuts (list of links) on white label homepage. To edit the Shortcuts Menu <a href="/cms/wp-admin/nav-menus.php?action=edit&menu=' . $menu_term_id . '">click here</a>.',
	]),
	Field::radio('show-white-label-orange-banner', [1 => 'Yes', 0 => 'No'], [
		'title' => 'Show White Label Orange Banner',
		'info' => 'Enables orange banner on white label homepage.',
	]),
	Field::editor('white-label-orange-banner', [
		'title' => 'White Label Orange Banner',
		'info' => 'Use with <strong>caution</strong>. The text entered here will be used on the homepage.',
		'default' => '<p><strong>REMINDER:</strong> The Medicare Annual Open Enrollment period is October 15th through December 7th. However, the Marketplace Open Enrollment period is November 1st through December 15th.</p>',
	]),
];

$page->addSections($sections);
$page->addSettings($settings);