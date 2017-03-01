app.controller('zipCodeController', ['$scope', '$http', '$window', 'localStorageService', 'locationFinder', '$state', function($scope, $http, $window, localStorageService, locationFinder, $state){


	$scope.findZip = function(zip){

		if (zip.length != 5) {
			$scope.isZipInvalid=true;
			return;
		} else {
			$scope.isZipInvalid=false;
		}

		locationFinder.getLocation(zip).success(function(data, status, headers, config) {

			var retZipCode = "";

			if(data.status == "OK"){
				$scope.isZipInvalid=true;
				for (var i=0;i<data.results[0].address_components.length;i++) {
					for(var j=0;j<data.results[0].address_components[i].types.length;j++) {
						if (((data.results[0].address_components[i].types[j] == "country")||
							(data.results[0].address_components[i].types[j] == "political"))&&
							(data.results[0].address_components[i].short_name == "US")) {
							$scope.isZipInvalid=false;
						}

						if (data.results[0].address_components[i].types[j] == "postal_code") {
							retZipCode = data.results[0].address_components[i].long_name;
						}
					}
				}

				if(!$scope.isZipInvalid){
					localStorageService.set('v_zipcode', data.results[0].address_components[0].long_name);
					$window.location.href = '/find-my-benefits';
				}
			}else{
				$scope.isZipInvalid=true;
			}
		});
	}

}]);
