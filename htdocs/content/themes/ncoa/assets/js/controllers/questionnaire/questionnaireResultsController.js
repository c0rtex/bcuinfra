app.controller('questionnaireResultsController', ['$scope', '$state', function($scope, $state){
	var el = document.querySelector('.odometer');

	od = new Odometer({
	  el: el,
	  value: 0
	});

	od.update(18); 

	
	
	document.querySelector('.page-wrapper h1').scrollIntoView();

}]);