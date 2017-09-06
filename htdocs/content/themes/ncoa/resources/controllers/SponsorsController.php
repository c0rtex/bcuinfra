<?php 

class SponsorsController extends BaseController
{
	/**
	 * Returns the home page.
	 *
	 * @return Response
	 */
	public function index()
	{
		return View::make('templates.sponsors',[
			'loggedin' => true,
			'medicarerx' => true,
			'nutrition' => true,
			'home' => true,
			'partnerlogin' => true,
			'grantees' => true,
			'resources' => true,
			'home6' => true,
			'sponsors' => SponsorsModel::queryNonFeaturedSponosrs(),
			'featured' => SponsorsModel::queryFeaturedSponsors()
		]);
	}

}