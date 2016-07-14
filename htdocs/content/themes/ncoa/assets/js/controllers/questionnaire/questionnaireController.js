app.controller('questionnaireController', ['$scope','$state', 'questionnaire', function($scope, $state, questionnaire){
	
	$scope.questionnaire = questionnaire;

	if($state.current.name == "questionnaire")
		$state.transitionTo('questionnaire.basics');
	
}]);