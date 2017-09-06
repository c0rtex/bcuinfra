<?php

class AboutUsController extends BaseController
{
  /**
   * Returns the home page.
   *
   * @return Response
   */
  public function index()
  {
  	$heroImage = wp_get_attachment_image_src(Meta::get(get_the_ID(), $key = 'hero-image', $single = true), 'full')[0];

    $bodySection = Meta::get(get_the_ID(), $key = 'body-item', $single = true);
    $worksSection = Meta::get(get_the_ID(), $key = 'work-item', $single = true);
    

    return View::make('pages.aboutus',[
        'loggedin' => true,
        'medicarerx' => true,
        'nutrition' => true,
        'home' => true,
        'partnerlogin' => true,
        'grantees' => true,
        'resources' => true,
        'home6' => true,
        'heroImage' => $heroImage,
      'bodySection' => $bodySection,
      'worksSection' => $worksSection
	]);
  }

}
