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

    $this->states_fact_sheets = array(
      '/fact-sheets/factsheet_nutrition_al_snap_program/'=>'ALABAMA',
      '/fact-sheets/factsheet_nutrition_ak_snap_program/'=>'ALASKA',
      '/fact-sheets/factsheet_nutrition_az_snap_program/'=>'ARIZONA',
      '/fact-sheets/factsheet_nutrition_ar_snap_program/'=>'ARKANSAS',
      '/fact-sheets/factsheet_nutrition_ca_snap_program/'=>'CALIFORNIA',
      '/fact-sheets/factsheet_nutrition_co_snap_program/'=>'COLORADO',
      '/fact-sheets/factsheet_nutrition_ct_snap_program/'=>'CONNECTICUT',
      '/fact-sheets/factsheet_nutrition_de_snap_program/'=>'DELAWARE',
      '/fact-sheets/factsheet_nutrition_dc_snap_program/'=>'DISTRICT OF COLUMBIA',
      '/fact-sheets/factsheet_nutrition_fl_snap_program/'=>'FLORIDA',
      '/fact-sheets/factsheet_nutrition_ga_snap_program/'=>'GEORGIA',
      '/fact-sheets/factsheet_nutrition_hi_snap_program/'=>'HAWAII',
      '/fact-sheets/factsheet_nutrition_id_snap_program/'=>'IDAHO',
      '/fact-sheets/factsheet_nutrition_il_snap_program/'=>'ILLINOIS',
      '/fact-sheets/factsheet_nutrition_in_snap_program/'=>'INDIANA',
      '/fact-sheets/factsheet_nutrition_ia_snap_program/'=>'IOWA',
      '/fact-sheets/factsheet_nutrition_ks_snap_program/'=>'KANSAS',
      '/fact-sheets/factsheet_nutrition_ky_snap_program/'=>'KENTUCKY',
      '/fact-sheets/factsheet_nutrition_la_snap_program/'=>'LOUISIANA',
      '/fact-sheets/factsheet_nutrition_me_snap_program/'=>'MAINE',
      '/fact-sheets/factsheet_nutrition_md_snap_program/'=>'MARYLAND',
      '/fact-sheets/factsheet_nutrition_ma_snap_program/'=>'MASSACHUSETTS',
      '/fact-sheets/factsheet_nutrition_mi_snap_program/'=>'MICHIGAN',
      '/fact-sheets/factsheet_nutrition_mn_snap_program/'=>'MINNESOTA',
      '/fact-sheets/factsheet_nutrition_ms_snap_program/'=>'MISSISSIPPI',
      '/fact-sheets/factsheet_nutrition_mo_snap_program/'=>'MISSOURI',
      '/fact-sheets/factsheet_nutrition_mt_snap_program/'=>'MONTANA',
      '/fact-sheets/factsheet_nutrition_ne_snap_program/'=>'NEBRASKA',
      '/fact-sheets/factsheet_nutrition_nv_snap_program/'=>'NEVADA',
      '/fact-sheets/factsheet_nutrition_nh_snap_program/'=>'NEW HAMPSHIRE',
      '/fact-sheets/factsheet_nutrition_nj_snap_program/'=>'NEW JERSEY',
      '/fact-sheets/factsheet_nutrition_nm_snap_program/'=>'NEW MEXICO',
      '/fact-sheets/factsheet_nutrition_ny_snap_program/'=>'NEW YORK',
      '/fact-sheets/factsheet_nutrition_nc_snap_program/'=>'NORTH CAROLINA',
      '/fact-sheets/factsheet_nutrition_nd_snap_program/'=>'NORTH DAKOTA',
      '/fact-sheets/factsheet_nutrition_oh_snap_program/'=>'OHIO',
      '/fact-sheets/factsheet_nutrition_ok_snap_program/'=>'OKLAHOMA',
      '/fact-sheets/factsheet_nutrition_or_snap_program/'=>'OREGON',
      '/fact-sheets/factsheet_nutrition_pa_snap_program/'=>'PENNSYLVANIA',
      '/fact-sheets/factsheet_nutrition_pr_snap_program/'=>'PUERTO RICO',
      '/fact-sheets/factsheet_nutrition_ri_snap_program/'=>'RHODE ISLAND',
      '/fact-sheets/factsheet_nutrition_sc_snap_program/'=>'SOUTH CAROLINA',
      '/fact-sheets/factsheet_nutrition_sd_snap_program/'=>'SOUTH DAKOTA',
      '/fact-sheets/factsheet_nutrition_tn_snap_program/'=>'TENNESSEE',
      '/fact-sheets/factsheet_nutrition_tx_snap_program/'=>'TEXAS',
      '/fact-sheets/factsheet_nutrition_ut_snap_program/'=>'UTAH',
      '/fact-sheets/factsheet_nutrition_vt_snap_program/'=>'VERMONT',
      '/fact-sheets/factsheet_nutrition_vi_snap_program/'=>'VIRGIN ISLANDS',
      '/fact-sheets/factsheet_nutrition_va_snap_program/'=>'VIRGINIA',
      '/fact-sheets/factsheet_nutrition_wa_snap_program/'=>'WASHINGTON',
      '/fact-sheets/factsheet_nutrition_wv_snap_program/'=>'WEST VIRGINIA',
      '/fact-sheets/factsheet_nutrition_wi_snap_program/'=>'WISCONSIN',
      '/fact-sheets/factsheet_nutrition_wy_snap_program/'=>'WYOMING'
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
    if (!empty($_POST['state-selection'])) {
      header('Location: ' . $_POST['state-selection']);
    }
  }

  public function snap(){

    $constants = Config::get('constants');

    return View::make('templates.program-snap',[
      'states' => $this->states_fact_sheets,
      'webServiceUrl' => $constants['WEB_SERVICE_URL']
    ]);
  }

}