app.controller('zipCodeController', ['$scope', '$http', '$window', 'localStorageService', 'locationFinder', '$state', function($scope, $http, $window, localStorageService, locationFinder, $state){	

	$scope.findZip = function(zip){
		locationFinder.getLocation(zip).success(function(data, status, headers, config) {
			localStorageService.set('zipcode', zip);
			$window.location.href = '/find-my-benefits';
			
   	 	});
	}

}]);


