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
			'medicarerx' => false,
			'nutrition' => false,
			'home' => false,
			'partnerlogin' => false,
			'grantees' => false,
			'resources' => false,
			'home6' => false,
			'sponsors' => SponsorsModel::queryNonFeaturedSponosrs(),
			'featured' => SponsorsModel::queryFeaturedSponsors()
		]);
	}

}