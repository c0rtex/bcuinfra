<?php

/*
* Settings for White Label stuff
*/

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