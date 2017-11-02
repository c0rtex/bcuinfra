<?php

class WhiteLabelController extends BaseController
{
  protected $categories;
  protected $states;

  function __construct() {
    $this->categories = array(
      "bcuqc_category_rx" => "Medication",
      "bcuqc_category_medicaid" => "Health Care",
      "bcuqc_category_income" => "Income Assistance",
      "bcuqc_category_nutrition" => "Food &amp; Nutrition",
      "bcuqc_category_utility" => "Housing & Utilities",
      "bcuqc_category_property_taxrelief" => "Tax Relief",
      "bcuqc_category_veteran" => "Veterans",
      "bcuqc_category_employment" => "Employment",
      "bcuqc_category_transportation" => "Transportation",
      "bcuqc_category_education" => "Education",
      "bcuqc_category_discounts" => "Discount",
      "bcuqc_category_other_assistance" => "Other Assistance"
    );

    // QA is overwriting the list of states in the code, and therefore this temporary
    // list of states has to be used instead. It only contains the 50 states + DC.
    // This issue needs to be solved in QA.
    $this->states = json_decode('{"AL": "Alabama","AK": "Alaska","AZ": "Arizona","AR": "Arkansas","CA": "California","CO": "Colorado","CT": "Connecticut","DC": "District of Columbia", "DE": "Delaware","FL": "Florida","GA": "Georgia","HI": "Hawaii","ID": "Idaho","IL": "Illinois","IN": "Indiana","IA": "Iowa","KS": "Kansas","KY": "Kentucky","LA": "Louisiana","ME": "Maine","MD": "Maryland","MA": "Massachusetts","MI": "Michigan","MN": "Minnesota","MS": "Mississippi","MO": "Missouri","MT": "Montana","NE": "Nebraska","NV": "Nevada","NH": "New Hampshire","NJ": "New Jersey","NM": "New Mexico","NY": "New York","NC": "North Carolina","ND": "North Dakota","OH": "Ohio","OK": "Oklahoma","OR": "Oregon","PA": "Pennsylvania","RI": "Rhode Island","SC": "South Carolina","SD": "South Dakota","TN": "Tennessee","TX": "Texas","UT": "Utah","VT": "Vermont","VA": "Virginia","WA": "Washington","WV": "West Virginia","WI": "Wisconsin","WY": "Wyoming"}');
  }

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
      'questionnaire' => false,
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
    $posts = $this->_load_rss_feed();

    return View::make('templates.white-label-home', [
      'loggedin' => $loggedin,
      'medicarerx' => $medicarerx,
      'nutrition' => $nutrition,
      'questionnaire' => false,
      'home' => $home,
      'partnerlogin' => $partnerlogin,
      'grantees' => $grantees,
      'resources' => $resources,
      'home6' => $home6,
      'posts' => $posts,
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
    $posts = $this->_load_rss_feed();
    
    return View::make('templates.white-label-home', [
      'loggedin' => $loggedin,
      'medicarerx' => $medicarerx,
      'nutrition' => $nutrition,
      'questionnaire' => false,
      'home' => $home,
      'partnerlogin' => $partnerlogin,
      'grantees' => $grantees,
      'resources' => $resources,
      'home6' => $home6,
      'posts' => $posts,
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
      'questionnaire' => false,
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
      'questionnaire' => false,
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
      'questionnaire' => false,
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
      'questionnaire' => false,
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
      'questionnaire' => false,
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
    $categories = $this->categories;

    $drugsList = \Httpful\Request::get($constants['WEB_SERVICE_URL'].'/rest/backend/questionnaire/drugList/')->send();

    return View::make('templates.white-label-resources', [
      'loggedin' => $loggedin,
      'medicarerx' => $medicarerx,
      'nutrition' => $nutrition,
      'home' => $home,
      'questionnaire' => false,
      'partnerlogin' => $partnerlogin,
      'grantees' => $grantees,
      'resources' => $resources,
      'home6' => $home6,
      'states' => $this->states,
      'categories' => $categories,
      'appFormsUri' => $constants['APPLICATION_FORMS_URL'],
      'webServiceUrl' => $constants['WEB_SERVICE_URL'],
      'drugsList' => $drugsList,
    ])->render(); 
  }

  /**
   * Retrieve and cache latest posts from NCOA's blog feed.
   */
  private function _load_rss_feed() {
    $posts = array();
    $filename = 'ncoafeed-' . date('mdY') . '.txt';
    $tmp_folder = sys_get_temp_dir();
    $file = $tmp_folder . '/' . $filename;
    
    if (file_exists($file)) {
      $data = file_get_contents($file);
      $json = json_decode($data);
    
      if (json_last_error() === JSON_ERROR_NONE) $posts = $json;
    }
    else {
      $posts_limit = 3; // Limit of posts to cache
      $ncoa_feed = 'https://www.ncoa.org/blog/feed/';
      $rss = @simplexml_load_file($ncoa_feed);
    
      $handle = fopen($file, 'w'); // Create empty file
      if (!empty($rss->channel->item)) {
        $i = 0;
        foreach ($rss->channel->item as $item) {
          if ($i++ == $posts_limit) break;

          // Extract featured image from description
          $findings = array();
          $description = (string) $item->description;
          preg_match('/src="([^"]*)"/i', $description, $findings);
          $image = !empty($findings[1]) ? $findings[1] : '';
      
          $items[] = array(
            'title' => (string) $item->title,
            'link' => (string) $item->link,
            'pubDate' => strtotime($item->pubDate),
            'image' => $image,
          );
        }

        if (!empty($items)) {
          $data = json_encode($items);
          fwrite($handle, $data); // Write data to file

          $posts = json_decode($data);
        }
      }
      fclose($handle);
    }
    
    return $posts;
  }
}
