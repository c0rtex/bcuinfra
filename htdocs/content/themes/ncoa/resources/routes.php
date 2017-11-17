<?php

/**
 * Define your routes and which views to display
 * depending of the query.
 *
 * Based on WordPress conditional tags from the WordPress Codex
 * http://codex.wordpress.org/Conditional_Tags
 *
 */

//Route::get('home', 'HomeController@index');

if ($_SESSION['partner_id'] != '0') {
  Route::get('template', ['home-template', 'uses' =>'WhiteLabelController@home6']);
} else {
  Route::get('template', ['home-template', 'uses' =>'HomeController@index']);
}

Route::get('page', ['styleguide', 'uses' => 'StyleGuideController@index']);
Route::get('page', ['uses' => 'GenericController@index']);

Route::get('singular', ['fact-sheets', 'uses' => 'FactSheetsController@index']);
Route::post('singular', ['fact-sheets', 'uses' => 'FactSheetsController@index']);

//Route::get('template', ['home-template', 'uses' => 'HomeController@index']);
Route::get('template', ['benefitscheckup-template', 'uses' => 'BenefitsCheckUpController@index']);
Route::get('template', ['resources-template', 'uses' => 'ResourcesController@index']);
Route::get('template', ['echo-template', 'uses' => 'EchoTestController@index']);
Route::any('template', ['resources-results-template', 'uses' => 'ResourcesController@results']);
Route::any('template', ['program-details-template', 'uses' => 'ResourcesController@details']);
Route::get('template', ['sponsors-template', 'uses' => 'SponsorsController@index']);
Route::get('template', ['AboutUsTemplate', 'uses' => 'AboutUsController@index']);
Route::get('template', ['program-snap-template', 'uses' => 'ResourcesController@snap']);

Route::get('template', ['white-label-homepage-template', 'uses' => 'HomeController@whiteLabelIndex']);
Route::get('template', ['fact-sheets-template', 'uses' => 'FactSheetsController@index']);

Route::get('template', ['echotest-template', 'uses' => 'EchoTestController@index']);

Route::get('template', ['white-label-landing-template', 'uses' => 'WhiteLabelController@index']);

Route::get('template', ['white-label-home-template', 'uses' => 'WhiteLabelController@home']);
Route::get('template', ['white-label-home6-template', 'uses' => 'WhiteLabelController@home6']);

Route::get('template', ['white-label-medicare-rx-extra-help-landing-template', 'uses' => 'WhiteLabelController@medicare_rx_extra_help_landing']);
Route::get('template', ['white-label-medicare-rx-extra-help-template', 'uses' => 'WhiteLabelController@medicare_rx_extra_help']);
Route::get('template', ['white-label-snap-template', 'uses' => 'WhiteLabelController@snap']);
Route::get('template', ['white-label-partner-login-template', 'uses' => 'WhiteLabelController@partner_login']);
Route::get('template', ['white-label-grantees-template', 'uses' => 'WhiteLabelController@grantees']);
Route::get('template', ['white-label-resources-template', 'uses' => 'WhiteLabelController@resources']);


//Counties map
Route::get('template', ['resources-medicaid-locator-template', 'uses' => 'ResourcesController@medicaidLocator']);