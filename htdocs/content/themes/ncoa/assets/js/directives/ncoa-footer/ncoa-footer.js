app.directive('ncoaFooter',['$http', function($http){
	return {
		restrict: 'E',
		scope: {
			url: '@'
		},
		link: function(scope, elm){
			$http.get(scope.url).then(function(response){
				console.log(response.data);
			});

			$.ajax({
				url: scope.url,
				context: document.body
			}).success(function(data) {
				console.log(data);
			});
		}
	}
}]);