app.controller('questionnaireBasicController', ['$scope','$state', 'questionnaire', function($scope, $state, questionnaire){

	$('.fa-question-circle').popover();

	$scope.tooltip = {
		"race": "Why are we asking? This question is optional, and does not affect your results. Your answer will help us understand how best to reach people who can benefit from this service."
	};
	
}]);