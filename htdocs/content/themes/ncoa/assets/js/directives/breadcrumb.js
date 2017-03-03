app.directive('breadcrumb', ['$document', '$state', function ($document, $state) {
	return {
		restrict: 'A',
		templateUrl: '/content/themes/ncoa/resources/views/directives/breadcrumb/breadcrumb.html?'+(new Date()),
		link: function (scope, element, attr) {
			scope.pages = ["Basics", "Health", "Household", "Finances", "Results"];
			scope.currentState = $state.params.category;
			scope.hideBreadCrumbs = ($state.current.name.split(".")[1] == "results" || $state.current.name.split(".")[1] == "initial-results");

			scope.$on('$stateChangeSuccess', function() {
				scope.hideBreadCrumbs = ($state.current.name.split(".")[1] == "results" || $state.current.name.split(".")[1] == "initial-results");
			});
		}
	}
}]);