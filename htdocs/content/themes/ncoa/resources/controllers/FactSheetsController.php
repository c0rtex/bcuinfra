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
		
		return View::make('templates.fact-sheets', [
			'page_slug' => $fact_sheet_slug,
			'is_alt' => false
		]);
	}

}