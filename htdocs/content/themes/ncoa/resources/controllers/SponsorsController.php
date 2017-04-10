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
			'sponsors' => SponsorsModel::queryNonFeaturedSponosrs(),
			'featured' => SponsorsModel::queryFeaturedSponsors()
		]);
	}

}