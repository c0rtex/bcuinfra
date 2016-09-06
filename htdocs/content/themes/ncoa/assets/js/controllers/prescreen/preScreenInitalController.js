app.controller('preScreenInitalController', ['$scope', '$state', function($scope, $state){

	if($state.current.name == "prescreen")
		$state.transitionTo('prescreen.questions');
}]);