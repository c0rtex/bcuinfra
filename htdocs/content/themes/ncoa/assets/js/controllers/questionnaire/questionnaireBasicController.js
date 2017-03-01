app.controller('questionnaireBasicController', ['$scope','$state', 'questionnaire', function($scope, $state, questionnaire){

	$scope.tooltip = {
		"race": "Why are we asking? This question is optional, and does not affect your results. Your answer will help us understand how best to reach people who can benefit from this service."
	};

	$scope.genders = [{id:"male",   name:"Male"},
		{id:"female", name:"Female"}];

	$scope.citizens = [{id:"citizen",         name:"Citizen"},
		{id:"legal_resident",  name:"Legal Resident"},
		{id:"qualified_alien", name:"Other Qualified Alien"},
		{id:"other_citizen",   name:"Other"}];

	$scope.receives = [{id:"medicare_receive",    name:"Medicare (currently enrolled or expect to be within the next 3 months)"},
		{id:"receive_partd",       name:"Medicare Prescription Drug Plan (Part D)"},
		{id:"receive_lis",         name:"Extra Help/LIS through Medicare Prescription Drug Coverage"},
		{id:"med_receive",         name:"Medicaid"},
		{id:"receive_msp",         name:"Medicare Savings Programs (QMB, SLMB, or QI)"},
		{id:"snap_receive",        name:"Supplemental Nutrition Assistance Program (SNAP)"},
		{id:"ssi_receive",         name:"Supplemental Security Income (SSI)"},
		{id:"rec_tricare",         name:"TRICARE"},
		{id:"receive_va",          name:"Veteran's Health Care Benefits"},
		{id:"liheap_receive",      name:"Low Income Home Energy Assistance Program (LIHEAP)"},
		{id:"receive_pub_housing", name:"Public Housing"},
		{id:"receive_section_8",   name:"Housing Choice Vouchers (Section 8)"},
		{id:"scsep_receive",       name:"Senior Community Service Employment Program (SCSEP)"}];

	$scope.races = [{id:"white",                           name:"White"},
		{id:"african_american",                name:"Black or African-American"},
		{id:"american_indian_native_alaskans", name:"American Indian or Alaska Native"},
		{id:"asian",                           name:"Asian or Asian-American"},
		{id:"pacific_islander",                name:"Native Hawaiian or Other Pacific Islander"},
		{id:"hispanic",                        name:"Hispanic, Latino, or Spanish Origin"},
		{id:"other_race",                      name:"Other"}];

}]);
