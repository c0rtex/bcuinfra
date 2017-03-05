app.controller('preScreenInitalController', ['$scope', '$state', 'prescreenQuestions', 'prescreen', function($scope, $state, prescreenQuestions, prescreen){

	if ($scope.$root.answers == undefined) {
		$scope.$root.answers = {};
	}

	$scope.$root.answers.prescreen = prescreen.data.answers;

	prescreenQuestions.get().success(function(data, status, headers, config) {
		prescreen.data.questions = data;
		if($state.current.name == "prescreen") $state.transitionTo('prescreen.questions',{category:"prescreen"});
	});
}]);
