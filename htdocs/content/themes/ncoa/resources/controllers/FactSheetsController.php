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

		$constants = Config::get('constants');

		if (array_key_exists('state', $_REQUEST)) {
			$program_state = $_REQUEST['state'];
		} else {
			$program_state = Meta::get($query->queried_object_id, 'program_state_id');
		}

		$requiredMaterials = \Httpful\Request::get($constants['WEB_SERVICE_URL'].'/rest/backend/materials/required/forProgram/'.$program_code)->send();
		$requiredMaterials = json_decode($requiredMaterials->body);

		if (array_key_exists('short',$_REQUEST)) {

			if (array_key_exists("short_layout",$_REQUEST)) {
				$layout = "layouts.short";
			} else {
				$layout = "layouts.main";
			}

			return View::make('templates.short-fact-sheets', [
				'page_slug' => $fact_sheet_slug,
				'app_forms_uri' => $constants['APPLICATION_FORMS_URL'],
				'layout' => $layout,
				'required_materials' => $requiredMaterials,
				'is_alt' => false
			]);
		} else {

			$entryPoints = \Httpful\Request::get($constants['WEB_SERVICE_URL'] . '/rest/backend/entryPoints/forProgram/' . $program_code)->send();

			$entryPoints = json_decode($entryPoints->body);

			$appForms = \Httpful\Request::get($constants['WEB_SERVICE_URL'].'/rest/backend/forms/appForms/forProgram/'.$program_code.'/?stateId='.$program_state)->send();

			$appForms = json_decode($appForms->body);

			return View::make('templates.fact-sheets', [
				'page_slug' => $fact_sheet_slug,
				'entry_points' => $entryPoints,
				'app_forms' => $appForms,
				'app_forms_uri' => $constants['APPLICATION_FORMS_URL'],
				'required_materials' => $requiredMaterials,
				'is_alt' => false
			]);
		}
	}

}