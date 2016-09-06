app.controller('questionnaireLoaderController', ['$scope', '$state', function($scope, $state){	
	$('.btns-container').hide();
	$('.card-nested').addClass('loader');

	setTimeout(function(){		
		$state.transitionTo('questionnaire.results');
	}, 8000);		
	

	$scope.$on('$stateChangeStart', function(event, toState, toParams, fromState, fromParams, options) {
		$('.btns-container').show();
		$('.card-nested').removeClass('loader');
	});
	
}]);