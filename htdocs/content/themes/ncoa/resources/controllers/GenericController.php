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
    return View::make('templates.generic'); 
  }

}