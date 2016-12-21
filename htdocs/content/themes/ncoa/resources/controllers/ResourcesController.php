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
      'AL' => 'Alabama',
      'AK' => 'Alaska',
      'AZ' => 'Arizona',
      'AR' => 'Arkansas',
      'CA' => 'California',
      'CO' => 'Colorado',
      'CT' => 'Connecticut',
      'DE' => 'Delaware',
      'DC' => 'District of Columbia',
      'FL' => 'Florida',
      'GA' => 'Georgia',
      'GU' => 'Guam',
      'HI' => 'Hawaii',
      'ID' => 'Idaho',
      'IL' => 'Illinois',
      'IN' => 'Indiana',
      'IA' => 'Iowa',
      'KS' => 'Kansas',
      'KY' => 'Kentucky',
      'LA' => 'Louisiana',
      'ME' => 'Maine',
      'MD' => 'Maryland',
      'MA' => 'Massachusetts',
      'MI' => 'Michigan',
      'MN' => 'Minnesota',
      'MS' => 'Mississippi',
      'MO' => 'Missouri',
      'MT' => 'Montana',
      'NE' => 'Nebraska',
      'NV' => 'Nevada',
      'NH' => 'New Hampshire',
      'NJ' => 'New Jersey',
      'NM' => 'New Mexico',
      'NY' => 'New York',
      'NC' => 'North Carolina',
      'ND' => 'North Dakota',
      'OH' => 'Ohio',
      'OK' => 'Oklahoma',
      'OR' => 'Oregon',
      'PA' => 'Pennsylvania',
      //'PR' => 'Puerto Rico',
      'RI' => 'Rhode Island',
      'SC' => 'South Carolina',
      'SD' => 'South Dakota',
      'TN' => 'Tennessee',
      'TX' => 'Texas',
      'UT' => 'Utah',
      'VT' => 'Vermont',
      //'VI' => 'Virgin Islands',
      'VA' => 'Virginia',
      'WA' => 'Washington',
      'WV' => 'West Virginia',
      'WI' => 'Wisconsin',
      'WY' => 'Wyoming',
    );

    $this->states_fact_sheets = array(
      '/fact-sheets/factsheet_nutrition_al_snap_program/' => 'Alabama',
      '/fact-sheets/factsheet_nutrition_ak_snap_program/' => 'Alaska',
      '/fact-sheets/factsheet_nutrition_az_snap_program/' => 'Arizona',
      '/fact-sheets/factsheet_nutrition_ar_snap_program/' => 'Arkansas',
      '/fact-sheets/factsheet_nutrition_ca_snap_program/' => 'California',
      '/fact-sheets/factsheet_nutrition_co_snap_program/' => 'Colorado',
      '/fact-sheets/factsheet_nutrition_ct_snap_program/' => 'Connecticut',
      '/fact-sheets/factsheet_nutrition_de_snap_program/' => 'Delaware',
      '/fact-sheets/factsheet_nutrition_dc_snap_program/' => 'District of Columbia',
      '/fact-sheets/factsheet_nutrition_fl_snap_program/' => 'Florida',
      '/fact-sheets/factsheet_nutrition_ga_snap_program/' => 'Georgia',
      '/fact-sheets/factsheet_nutrition_gu_snap_program/' => 'Guam',
      '/fact-sheets/factsheet_nutrition_hi_snap_program/' => 'Hawaii',
      '/fact-sheets/factsheet_nutrition_id_snap_program/' => 'Idaho',
      '/fact-sheets/factsheet_nutrition_il_snap_program/' => 'Illinois',
      '/fact-sheets/factsheet_nutrition_in_snap_program/' => 'Indiana',
      '/fact-sheets/factsheet_nutrition_ia_snap_program/' => 'Iowa',
      '/fact-sheets/factsheet_nutrition_ks_snap_program/' => 'Kansas',
      '/fact-sheets/factsheet_nutrition_ky_snap_program/' => 'Kentucky',
      '/fact-sheets/factsheet_nutrition_la_snap_program/' => 'Louisiana',
      '/fact-sheets/factsheet_nutrition_me_snap_program/' => 'Maine',
      '/fact-sheets/factsheet_nutrition_md_snap_program/' => 'Maryland',
      '/fact-sheets/factsheet_nutrition_ma_snap_program/' => 'Massachusetts',
      '/fact-sheets/factsheet_nutrition_mi_snap_program/' => 'Michigan',
      '/fact-sheets/factsheet_nutrition_mn_snap_program/' => 'Minnesota',
      '/fact-sheets/factsheet_nutrition_ms_snap_program/' => 'Mississippi',
      '/fact-sheets/factsheet_nutrition_mo_snap_program/' => 'Missouri',
      '/fact-sheets/factsheet_nutrition_mt_snap_program/' => 'Montana',
      '/fact-sheets/factsheet_nutrition_ne_snap_program/' => 'Nebraska',
      '/fact-sheets/factsheet_nutrition_nv_snap_program/' => 'Nevada',
      '/fact-sheets/factsheet_nutrition_nh_snap_program/' => 'New Hampshire',
      '/fact-sheets/factsheet_nutrition_nj_snap_program/' => 'New Jersey',
      '/fact-sheets/factsheet_nutrition_nm_snap_program/' => 'New Mexico',
      '/fact-sheets/factsheet_nutrition_ny_snap_program/' => 'New York',
      '/fact-sheets/factsheet_nutrition_nc_snap_program/' => 'North Carolina',
      '/fact-sheets/factsheet_nutrition_nd_snap_program/' => 'North Dakota',
      '/fact-sheets/factsheet_nutrition_oh_snap_program/' => 'Ohio',
      '/fact-sheets/factsheet_nutrition_ok_snap_program/' => 'Oklahoma',
      '/fact-sheets/factsheet_nutrition_or_snap_program/' => 'Oregon',
      '/fact-sheets/factsheet_nutrition_pa_snap_program/' => 'Pennsylvania',
      '/fact-sheets/factsheet_nutrition_pr_snap_program/' => 'Puerto Rico',
      '/fact-sheets/factsheet_nutrition_ri_snap_program/' => 'Rhode Island',
      '/fact-sheets/factsheet_nutrition_sc_snap_program/' => 'South Carolina',
      '/fact-sheets/factsheet_nutrition_sd_snap_program/' => 'South Dakota',
      '/fact-sheets/factsheet_nutrition_tn_snap_program/' => 'Tennessee',
      '/fact-sheets/factsheet_nutrition_tx_snap_program/' => 'Texas',
      '/fact-sheets/factsheet_nutrition_ut_snap_program/' => 'Utah',
      '/fact-sheets/factsheet_nutrition_vt_snap_program/' => 'Vermont',
      '/fact-sheets/factsheet_nutrition_vi_snap_program/' => 'Virgin Islands',
      '/fact-sheets/factsheet_nutrition_va_snap_program/' => 'Virginia',
      '/fact-sheets/factsheet_nutrition_wa_snap_program/' => 'Washington',
      '/fact-sheets/factsheet_nutrition_wv_snap_program/' => 'West Virginia',
      '/fact-sheets/factsheet_nutrition_wi_snap_program/' => 'Wisconsin',
      '/fact-sheets/factsheet_nutrition_wy_snap_program/' => 'Wyoming',
    );

    $this->categories = array(
      "110" => "bcuqc_category_rx",
      "107" => "bcuqc_category_medicaid",
      "109" => "bcuqc_category_income",
      "179" =>  "bcuqc_category_nutrition",
      "108" => "bcuqc_category_utility",
      "111" => "bcuqc_category_property_taxrelief",
      "113" => "bcuqc_category_veteran",
      "105" => "bcuqc_category_employment",
      "112" => "bcuqc_category_transportation",
      "104" => "bcuqc_category_education",
      "103" => "bcuqc_category_discounts",
      "102" => "bcuqc_category_other_assistance"
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
