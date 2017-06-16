<?php

class EchoTestController extends BaseController
{
  /**
   * Returns the home page.
   *
   * @return Response
   */
  public function index()
  {
  	/*$heroImage = wp_get_attachment_image_src(Meta::get(get_the_ID(), $key = 'hero-image', $single = true), 'full')[0];

    $bodySection = Meta::get(get_the_ID(), $key = 'body-item', $single = true);
    $worksSection = Meta::get(get_the_ID(), $key = 'work-item', $single = true);


    return View::make('pages.echotest',[
    	'heroImage' => $heroImage,
      'bodySection' => $bodySection,
      'worksSection' => $worksSection
	]);*/

      return View::make('templates.echo', [])->render();
  }

}
