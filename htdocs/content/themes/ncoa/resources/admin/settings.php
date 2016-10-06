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
	Field::media('main-logo'),
	Field::text('main-logo-width'),
	Field::text('main-logo-height'),
	Field::radio('whitelabel', ['yes','no']),
	Field::radio('showHeaderCTA', ['yes','no']),
	Field::media('whitelabel-logo')
];

$page->addSections($sections);
$page->addSettings($settings);