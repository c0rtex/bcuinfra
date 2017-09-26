<?php

class WhiteLabelController extends BaseController
{

  /**
   * Returns the home page.
   *
   * @return Response
   */
  public function index() { 
    $loggedin = false;
    $medicarerx = false;
    $nutrition = false;
    $home = true;
    $partnerlogin = false;
    $grantees = json_encode(GranteesModel::all());
    $resources = false;
    $home6 = false;
    return View::make('templates.white-label-landing', [
      'loggedin' => $loggedin,
      'medicarerx' => $medicarerx,
      'nutrition' => $nutrition,
      'home' => $home,
      'partnerlogin' => $partnerlogin,
      'grantees' => $grantees,
      'resources' => $resources,
      'home6' => $home6,
    ])->render(); 
  }

  protected function registerGlobalAssets() {
    //setcookie('partner_id',58,time()+7200,'/');
    //$_COOKIE['partner_id'] = 58;
  }

  public function home() { 
    $loggedin = true;
    $medicarerx = false;
    $nutrition = false;
    $home = true;
    $partnerlogin = false;
    $grantees = false;
    $resources = false;
    $home6 = false;
    return View::make('templates.white-label-home', [
      'loggedin' => $loggedin,
      'medicarerx' => $medicarerx,
      'nutrition' => $nutrition,
      'home' => $home,
      'partnerlogin' => $partnerlogin,
      'grantees' => $grantees,
      'resources' => $resources,
      'home6' => $home6,
    ])->render(); 
  }

  public function home6() { 
    $loggedin = true;
    $medicarerx = false;
    $nutrition = false;
    $home = true;
    $partnerlogin = false;
    $grantees = false;
    $resources = false;
    $home6 = true;
    return View::make('templates.white-label-home', [
      'loggedin' => $loggedin,
      'medicarerx' => $medicarerx,
      'nutrition' => $nutrition,
      'home' => $home,
      'partnerlogin' => $partnerlogin,
      'grantees' => $grantees,
      'resources' => $resources,
      'home6' => $home6,
    ])->render(); 
  }

  public function medicare_rx_extra_help_landing() { 
    $loggedin = true;
    $medicarerx = true;
    $nutrition = false;
    $home = false;
    $partnerlogin = false;
    $grantees = false;
    $resources = false;
    $home6 = false;
    return View::make('templates.white-label-medicare-rx-extra-help-landing', [
      'loggedin' => $loggedin,
      'medicarerx' => $medicarerx,
      'nutrition' => $nutrition,
      'home' => $home,
      'partnerlogin' => $partnerlogin,
      'grantees' => $grantees,
      'resources' => $resources,
      'home6' => $home6,
    ])->render(); 
  }

  public function medicare_rx_extra_help() { 
    $loggedin = true;
    $medicarerx = true;
    $nutrition = false;
    $home = false;
    $partnerlogin = false;
    $grantees = false;
    $resources = false;
    $home6 = false;
    return View::make('templates.white-label-medicare-rx-extra-help', [
      'loggedin' => $loggedin,
      'medicarerx' => $medicarerx,
      'nutrition' => $nutrition,
      'home' => $home,
      'partnerlogin' => $partnerlogin,
      'grantees' => $grantees,
      'resources' => $resources,
      'home6' => $home6,
    ])->render(); 
  }

  public function snap() { 
    $loggedin = true;
    $medicarerx = false;
    $nutrition = true;
    $home = false;
    $partnerlogin = false;
    $grantees = false;
    $resources = false;
    $home6 = false;
    return View::make('templates.white-label-snap', [
      'loggedin' => $loggedin,
      'medicarerx' => $medicarerx,
      'nutrition' => $nutrition,
      'home' => $home,
      'partnerlogin' => $partnerlogin,
      'grantees' => $grantees,
      'resources' => $resources,
      'home6' => $home6,
    ])->render(); 
  }

  public function partner_login() { 
    $loggedin = true;
    $medicarerx = false;
    $nutrition = false;
    $home = false;
    $partnerlogin = true;
    $grantees = false;
    $resources = false;
    $home6 = false;
    return View::make('templates.white-label-partner-login', [
      'loggedin' => $loggedin,
      'medicarerx' => $medicarerx,
      'nutrition' => $nutrition,
      'home' => $home,
      'partnerlogin' => $partnerlogin,
      'grantees' => $grantees,
      'resources' => $resources,
      'home6' => $home6,
    ])->render(); 
  }

  public function grantees() { 
    $loggedin = true;
    $medicarerx = false;
    $nutrition = false;
    $home = false;
    $partnerlogin = false;
    $resources = false;
    $home6 = false;
    $grantees = GranteesModel::all();

    return View::make('templates.white-label-grantees', [
      'loggedin' => $loggedin,
      'medicarerx' => $medicarerx,
      'nutrition' => $nutrition,
      'home' => $home,
      'partnerlogin' => $partnerlogin,
      'resources' => $resources,
      'home6' => $home6,
      'grantees' => $grantees,
    ])->render(); 
  }

  public function resources() { 
    $loggedin = true;
    $medicarerx = false;
    $nutrition = false;
    $home = false;
    $partnerlogin = false;
    $grantees = false;
    $resources = true;
    $home6 = false;

    $constants = Config::get('constants');
    $states = json_decode(Config::get('constants')["US_STATES"], true);
    $categories = json_decode(Config::get('constants')["BCU_CATEGORIES"], true);

    return View::make('templates.white-label-resources', [
      'loggedin' => $loggedin,
      'medicarerx' => $medicarerx,
      'nutrition' => $nutrition,
      'home' => $home,
      'partnerlogin' => $partnerlogin,
      'grantees' => $grantees,
      'resources' => $resources,
      'home6' => $home6,
      'states' => $states,
      'categories' => $categories,
      'webServiceUrl' => $constants['WEB_SERVICE_URL'],
    ])->render(); 
  }
}
