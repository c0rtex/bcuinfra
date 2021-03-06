<?php

class GenericController extends BaseController
{
  /**
   * Returns the home page.
   *
   * @return Response
   */
  public function index()
  {
    return View::make('templates.generic',[
        'loggedin' => true,
        'medicarerx' => true,
        'nutrition' => false,
        'questionnaire' => false,
        'home' => false,
        'partnerlogin' => false,
        'grantees' => false,
        'resources' => false,
        'home6' => false
    ]);
  }

}