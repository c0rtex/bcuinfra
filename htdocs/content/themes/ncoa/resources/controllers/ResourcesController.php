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
			'AS'=>'AMERICAN SAMOA',
			'AZ'=>'ARIZONA',
			'AR'=>'ARKANSAS',
			'CA'=>'CALIFORNIA',
			'CO'=>'COLORADO',
			'CT'=>'CONNECTICUT',
			'DE'=>'DELAWARE',
			'DC'=>'DISTRICT OF COLUMBIA',
			'FM'=>'FEDERATED STATES OF MICRONESIA',
			'FL'=>'FLORIDA',
			'GA'=>'GEORGIA',
			'GU'=>'GUAM GU',
			'HI'=>'HAWAII',
			'ID'=>'IDAHO',
			'IL'=>'ILLINOIS',
			'IN'=>'INDIANA',
			'IA'=>'IOWA',
			'KS'=>'KANSAS',
			'KY'=>'KENTUCKY',
			'LA'=>'LOUISIANA',
			'ME'=>'MAINE',
			'MH'=>'MARSHALL ISLANDS',
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
			'MP'=>'NORTHERN MARIANA ISLANDS',
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
			'WY'=>'WYOMING',
			'AE'=>'ARMED FORCES AFRICA \ CANADA \ EUROPE \ MIDDLE EAST',
			'AA'=>'ARMED FORCES AMERICA (EXCEPT CANADA)',
			'AP'=>'ARMED FORCES PACIFIC'
		);
		
		$this->categories = array(
			"PAP" => "Patient Assistance Programs",
			"MSP" => "Medicare Savings Program",
			"QMB" => "Qualified Medicare Beneficiary",
			"QI" => "Qualifying Individual",
			"SLMB" => "Specified Low-Income Medicare",
			"MED" => "Medicaid",
			"STRX" => "State Rx"
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

			$response = \Httpful\Request::get($constants['WEB_SERVICE_URL'].'/rest/backend/findPrograms/findResources?cat='.$_REQUEST['category'].'&st='.$_REQUEST['state'])->send();
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
		$fact_sheet_slug = "";//$query->query["p"];
		return View::make('templates.fact-sheets',[
			'page_slug' => $fact_sheet_slug,
			'is_alt' => true
		]);
	}

	public function snap(){
		return View::make('templates.program-snap',[
			'states' => $this->states
		]);
	}

}