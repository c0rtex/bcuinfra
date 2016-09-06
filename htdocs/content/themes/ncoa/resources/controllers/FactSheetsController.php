<?php 

class FactSheetsController extends BaseController
{
	/**
	 * Returns the home page.
	 *
	 * @return Response
	 */
	public function index($post, $query)
	{
		$fact_sheet_slug = $query->query["name"];

		$program_code = Meta::get($query->queried_object_id, 'program_code');

		$program_state =  Meta::get($query->queried_object_id, 'program_state_id');

		$constants = Config::get('constants');

		$entryPoints = \Httpful\Request::get($constants['WEB_SERVICE_URL'].'/rest/backend/entryPoints/forProgram/'.$program_code)->send();

		$entryPoints = json_decode($entryPoints->body);

		return View::make('templates.fact-sheets', [
			'page_slug' => $fact_sheet_slug,
			'entry_points' => $entryPoints,
			'is_alt' => false
		]);
	}

}