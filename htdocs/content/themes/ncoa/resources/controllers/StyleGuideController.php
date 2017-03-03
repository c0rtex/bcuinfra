<?php 

class StyleGuideController extends BaseController
{
	public function __construct()
    {
        Asset::add('styles', 'css/main.css', false, false, 'all');
    }

	/**
	 * Returns the home page.
	 *
	 * @return Response
	 */
	public function index()
	{
		return View::make('pages.styleguide');
	}

}