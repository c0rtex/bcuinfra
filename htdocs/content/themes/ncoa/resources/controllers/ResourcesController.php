<?php

class ResourcesController extends BaseController
{
  protected $states;
  protected $categories;
  protected $programs;

  public function __construct()
  {
    // Do something
    $this->states = array(
      'AL'=>'ALABAMA',
      'AK'=>'ALASKA',
      'AZ'=>'ARIZONA',
      'AR'=>'ARKANSAS',
      'CA'=>'CALIFORNIA',
      'CO'=>'COLORADO',
      'CT'=>'CONNECTICUT',
      'DE'=>'DELAWARE',
      'DC'=>'DISTRICT OF COLUMBIA',
      'FL'=>'FLORIDA',
      'GA'=>'GEORGIA',
      'HI'=>'HAWAII',
      'ID'=>'IDAHO',
      'IL'=>'ILLINOIS',
      'IN'=>'INDIANA',
      'IA'=>'IOWA',
      'KS'=>'KANSAS',
      'KY'=>'KENTUCKY',
      'LA'=>'LOUISIANA',
      'ME'=>'MAINE',
      'MD'=>'MARYLAND',
      'MA'=>'MASSACHUSETTS',
      'MI'=>'MICHIGAN',
      'MN'=>'MINNESOTA',
      'MS'=>'MISSISSIPPI',
      'MO'=>'MISSOURI',
      'MT'=>'MONTANA',
      'NE'=>'NEBRASKA',
      'NV'=>'NEVADA',
      'NH'=>'NEW HAMPSHIRE',
      'NJ'=>'NEW JERSEY',
      'NM'=>'NEW MEXICO',
      'NY'=>'NEW YORK',
      'NC'=>'NORTH CAROLINA',
      'ND'=>'NORTH DAKOTA',
      'OH'=>'OHIO',
      'OK'=>'OKLAHOMA',
      'OR'=>'OREGON',
      'PW'=>'PALAU',
      'PA'=>'PENNSYLVANIA',
      'PR'=>'PUERTO RICO',
      'RI'=>'RHODE ISLAND',
      'SC'=>'SOUTH CAROLINA',
      'SD'=>'SOUTH DAKOTA',
      'TN'=>'TENNESSEE',
      'TX'=>'TEXAS',
      'UT'=>'UTAH',
      'VT'=>'VERMONT',
      'VI'=>'VIRGIN ISLANDS',
      'VA'=>'VIRGINIA',
      'WA'=>'WASHINGTON',
      'WV'=>'WEST VIRGINIA',
      'WI'=>'WISCONSIN',
      'WY'=>'WYOMING'
    );

    $this->categories = array(
      "110" => "medication",
      "107" => "healthcare",
      "109" => "income",
      "179" =>  "foodnutrition",
      "108" => "housingutility",
      "111" => "taxrelief",
      "113" => "veteran",
      "105" => "employment",
      "112" => "transportation",
      "104" => "education",
      "103" => "discount",
      "102" => "otherassistance"
    );
  }
  /**
   * Returns the home page.
   *
   * @return Response
   */
  public function index()
  {
    $keyprograms = Meta::get(Loop::id(), $key = 'KeyProgram', $single = true);
    $keycategories = Meta::get(Loop::id(), $key = 'KeyCategories', $single = true);

    return View::make('templates.resources', [
      'states' => $this->states,
      'categories' => $this->categories,
      'programs' => $keyprograms,
      'keycategories' => $keycategories
    ]);
  }

  public function results($post, $query)
  {
    $page = ($query->query["page"]) ? $query->query["page"] : 1;

    if ($page==1) {

      $constants = Config::get('constants');

      $category = $this->categories[$_REQUEST['category']];

      $response = \Httpful\Request::get($constants['WEB_SERVICE_URL'].'/rest/backend/findPrograms/findResources?cat='.$category.'&st='.$_REQUEST['state'])->send();
    }

    return View::make('templates.resources-results', [
      'state' => $_REQUEST['state'],
      'category' => $_REQUEST['category'],
      'states' => $this->states,
      'categories' => $this->categories,
      'programs' => $response->body
    ]);
  }

  public function details($post, $query)
  {
    if (!empty($_POST['fact_sheet_url'])) {
      header('Location: ' . $_POST['fact_sheet_url']);
    }
  }

  public function snap(){

    $constants = Config::get('constants');

    return View::make('templates.program-snap',[
      'states' => $this->states,
      'webServiceUrl' => $constants['WEB_SERVICE_URL']
    ]);
  }

}