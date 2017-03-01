app.controller('questionnaireResultsController', ['$scope', '$state', 'screening', function($scope, $state, screening){
	var el = document.querySelector('.odometer');

	od = new Odometer({
		el: el,
		value: 0
	});

	var odValue = 0;

	$scope.foundCount = 0;

	for (var i=0; i<screening.data.results.found_programs.length;i++) {
		$scope.foundCount = $scope.foundCount + screening.data.results.found_programs[i].count;
	}

	od.update($scope.foundCount);

	$scope.key_programs = screening.data.results.key_programs;
	$scope.found_programs = screening.data.results.found_programs;

	document.querySelector('.page-wrapper h1').scrollIntoView();

}]);
