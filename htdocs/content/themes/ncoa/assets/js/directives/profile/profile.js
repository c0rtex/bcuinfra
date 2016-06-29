app.directive('profile', ['prescreen', '$state', function (prescreen, $state) {
	return {
	  restrict: 'A',	  
	  templateUrl: '/content/themes/ncoa/resources/views/directives/profile/profile.html',
	  link: function (scope, element, attr) {
	  	scope.screenData = prescreen;
	  	scope.showOptions = ($state.current.name.split('.')[1] == "results" || $state.current.name.split(".")[1] == "initial-results");
	  }
	}
}]);