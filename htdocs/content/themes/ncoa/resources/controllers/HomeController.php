<?php

class HomeController extends BaseController
{
	/**
	 * Returns the home page.
	 *
	 * @return Response
	 */
	public function index()
	{
		$testimonials = Meta::get(get_the_ID(), $key = 'testimonial-item', $single = true);
		$betterwaysection = Meta::get(get_the_ID(), $key = 'benefit-item', $single = true);
		$benefits = Meta::get(get_the_ID(), $key = 'benefits', $single = true);
		
		return View::make('templates.homepage',[
			'sponsors' 				=> SponsorsModel::all(),
			'testimonials' 			=> $testimonials,
			'betterwaysection' 		=> $betterwaysection,
			'benefits'				=> $benefits
		]);
	}

	public function whiteLabelIndex()
	{
		$testimonials = Meta::get(get_the_ID(), $key = 'testimonial-item', $single = true);
		
		if(empty($testimonials[1]["testimonial-image"]))
			$testimonials = [];

		$callouts = Meta::get(get_the_ID(), $key = 'callout-item', $single = true);

		return View::make('templates.white-label-homepage',[
			'testimonials' 			=> $testimonials,
			'callouts'				=> $callouts
		]);
	}

}
