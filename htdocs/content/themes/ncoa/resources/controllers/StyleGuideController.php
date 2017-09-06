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
		return View::make('pages.styleguide',[
			'loggedin' => true,
			'medicarerx' => true,
			'nutrition' => true,
			'home' => true,
			'partnerlogin' => true,
			'grantees' => true,
			'resources' => true,
			'home6' => true,
		]);
	}

}