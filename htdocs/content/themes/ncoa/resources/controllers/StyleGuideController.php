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
			'medicarerx' => false,
			'nutrition' => false,
			'home' => false,
			'partnerlogin' => false,
			'grantees' => false,
			'resources' => false,
			'home6' => false,
		]);
	}

}