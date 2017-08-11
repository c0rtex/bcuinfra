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
Route::get('page', ['styleguide', 'uses' => 'StyleGuideController@index']);
Route::get('page', ['uses' => 'GenericController@index']);

Route::any('singular', ['fact-sheets', 'uses' => 'FactSheetsController@index']);

Route::get('template', ['home-template', 'uses' => 'HomeController@index']);
Route::get('template', ['benefitscheckup-template', 'uses' => 'BenefitsCheckUpController@index']);
Route::get('template', ['resources-template', 'uses' => 'ResourcesController@index']);
Route::any('template', ['resources-results-template', 'uses' => 'ResourcesController@results']);
Route::any('template', ['program-details-template', 'uses' => 'ResourcesController@details']);
Route::get('template', ['sponsors-template', 'uses' => 'SponsorsController@index']);
Route::get('template', ['AboutUsTemplate', 'uses' => 'AboutUsController@index']);
Route::get('template', ['program-snap-template', 'uses' => 'ResourcesController@snap']);
Route::get('template', ['white-label-homepage-template', 'uses' => 'HomeController@whiteLabelIndex']);
Route::get('template', ['fact-sheets-template', 'uses' => 'FactSheetsController@index']);
