<?php 

class BenefitsCheckUpController extends BaseController
{
	/**
	 * Returns the home page.
	 *
	 * @return Response
	 */
	public function index()
	{
		$constants = Config::get('constants');

		return View::make('templates.benefitscheckup',['webServiceUrl' => $constants['WEB_SERVICE_URL']]);
	}

}