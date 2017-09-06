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
        'nutrition' => true,
        'home' => true,
        'partnerlogin' => true,
        'grantees' => true,
        'resources' => true,
        'home6' => true
    ]);
  }

}