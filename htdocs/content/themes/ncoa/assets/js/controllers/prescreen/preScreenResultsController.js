app.controller('preScreenResultsController', ['$scope', 'prescreen','$location','$state', function($scope, prescreen, $location, $state){	
	$('.fa-question-circle').popover();
	
	document.querySelector('.page-wrapper').scrollIntoView();
	
	$scope.tooltipAccuracy = "You will receive more accurate results if you provide more details.";
	$scope.tooltipExpenses = "Expenses are the amount of money you spend on things like rent, utilities, and other costs of living."

	$scope.nextPage = function(url){
		$state.go('questionnaire');
	}

	var el = document.querySelector('.odometer');

	od = new Odometer({
	  el: el,
	  value: 0,
	});

	od.update(48);
}]);


