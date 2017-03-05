app.controller('preScreenResultsController', ['$scope', 'prescreen','$location','$state', function($scope, prescreen, $location, $state){

	document.querySelector('.page-wrapper').scrollIntoView();

	$scope.tooltipAccuracy = "You will receive more accurate results if you provide more details.";
	$scope.tooltipExpenses = "Expenses are the amount of money you spend on things like rent, utilities, and other costs of living."

	$scope.goScreening = function(){
		$state.transitionTo('screening',{category:"basics",state:prescreen.data.answers.stateId});
	}

	var el = document.querySelector('.odometer');

	od = new Odometer({
		el: el,
		value: 0,
	});

	$scope.foundCount = 0;

	for (var i=0; i<prescreen.data.results.found_programs.length; i++) {
		$scope.foundCount = $scope.foundCount + prescreen.data.results.found_programs[i].count;
	}

	od.update($scope.foundCount);
}]);
