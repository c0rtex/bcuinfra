app.controller('questionnairePrescreenResultsController', ['$scope', '$state', 'BenefitItems', 'prescreen', function($scope, $state, BenefitItems, prescreen){
	var el = document.querySelector('.odometer');

	od = new Odometer({
		el: el,
		value: 0
	});

	var returned_programs = [];
	$scope.found_programs = [];
	$scope.available_fact_sheets = {};

	prescreen.data.results.found_programs.forEach(function(element) {
		if (prescreen.data.answers[element.category]) {
			returned_programs.push(element.category);
			$scope.found_programs.push(element);
		}

		$scope.available_fact_sheets[element.category] = [];
		element.programs.forEach(function(program) {
			$scope.available_fact_sheets[element.category].push(program.code);
		});
	});

	// BCURD-300: List of categories & programs.
	console.log(encodeURIComponent(JSON.stringify($scope.available_fact_sheets)));

	// Find empty programs
	var programs_diff = $(prescreen.data.screenData.benefits_categories_codes).not(returned_programs).get();
	programs_diff.forEach(function(element) {
		$scope.found_programs.push({
			'category': element,
			'count': 0,
			'programs': []
		});
	});

	$scope.foundCount = 0;

	for (var i=0; i<prescreen.data.results.found_programs.length; i++) {
		$scope.foundCount = $scope.foundCount + prescreen.data.results.found_programs[i].count;
	}

	od.update($scope.foundCount);

	document.querySelector('.page-wrapper h1').scrollIntoView();

}]);
