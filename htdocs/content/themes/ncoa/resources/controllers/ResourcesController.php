<?php 

class ResourcesController extends BaseController
{
	protected $states;
	protected $categories;

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
			"Medications",
			"Healthcare",
			"Income Assistance",
			"Food and Nutrition",
			"Housing and Utilites",
			"Tax Relief",
			"Veteran",
			"Employment",
			"Transportation",
			"Education",
			"Discounts",
			"Other Assistance"
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
		$total = 19;
		$page = ($query->query["page"]) ? $query->query["page"] : 1;

		return View::make('templates.resources-results', [
			'states' => $this->states,
			'categories' => $this->categories,
			'total' => $total,
			'page' => $page
		]);
	}

	public function details($post, $query)
	{	
		$fact_sheet_slug = $query->query["p"];
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