app.directive('zipcode',['locationFinder', 'category', '$filter', 'localStorageService',  function(locationFinder, category, $filter, localStorageService){

	return {
		link: function(scope, elm){

			scope.category = category.currentCategory();

			scope.regPattern = "\\d{5}";
			scope.$root.isZipValid = false;
			scope.zipValid = '';
			scope.$root.isZipCodeValidating = false;

			scope.updateZip = function(){
				scope.$root.isZipCodeValidating = true;
				locationFinder.getLocation(scope.$root.answers[scope.category].zip).success(function(data, status, headers, config) {
					validateZip(data);
					scope.$root.isZipCodeValidating = false;
				});
			};


			if (localStorageService.get('v_zipcode') != undefined) {
				scope.zipCodeLabel = "Update Zip Code";
				scope.$root.answers[category.currentCategory()].zip = localStorageService.get('v_zipcode');
				localStorageService.remove('v_zipcode');
				scope.updateZip();
			} else {
				scope.zipCodeLabel = "Find Zip Code";
			}



			scope.resetZip = function(){
				scope.$root.isZipEdit = true;
				$('#zipcode').focus();
			}

			function validateZip(data){
				if (scope.$root.answers[category.currentCategory()].zip.length != 5) {
					scope.$root.isZipValid = false;
					scope.zipValid = '';
					scope.$parent.zipCodeCheckResult = "Error!"
					scope.$parent.zipCodeDescription = "Please enter a valid zip code in the United States.";
					scope.$parent.zipCodeUpdated=true;
					return;
				}
				if(data.status == "OK"){

					var isZipInvalid=true;
					var zipCode = "";

					for (var i=0;i<data.results[0].address_components.length;i++) {
						for(var j=0;j<data.results[0].address_components[i].types.length;j++) {
							if (((data.results[0].address_components[i].types[j] == "country")||
								(data.results[0].address_components[i].types[j] == "political"))&&
								(data.results[0].address_components[i].short_name == "US")) {
								isZipInvalid=false;
							}

							if (data.results[0].address_components[i].types[j] == "postal_code") {
								scope.$root.answers[category.currentCategory()].zipcode = data.results[0].address_components[i].long_name;
							}

							if (data.results[0].address_components[i].types[j] == "administrative_area_level_1") {
								scope.$root.answers[category.currentCategory()].stateId = data.results[0].address_components[i].short_name;
								scope.zipCodeLabel = "Update Zip Code";
							}

							if (data.results[0].address_components[i].types[j] == "administrative_area_level_2") {
								scope.$root.answers[category.currentCategory()].county = data.results[0].address_components[i].short_name.toUpperCase().replace(' COUNTY','');
							}
						}
					}

					if(!isZipInvalid){
						scope.$root.answers[category.currentCategory()].zipcode_formatted = $filter('limitTo')(data.results[0].formatted_address, data.results[0].formatted_address.lastIndexOf(','), 0);
						scope.$root.isZipValid = true;
						scope.zipValid = '1';
						scope.$parent.zipCodeCheckResult = "Success!"
						scope.$parent.zipCodeDescription = scope.$root.answers[category.currentCategory()].zipcode_formatted;
					}else{
						scope.$root.isZipValid = false;
						scope.zipValid = '';
						scope.$parent.zipCodeCheckResult = "Error!"
						scope.$parent.zipCodeDescription = "Please enter a valid zip code in the United States.";
					}
				}else{
					scope.$root.isZipValid = false;
					scope.zipValid = '';
					scope.$parent.zipCodeCheckResult = "Error!"
					scope.$parent.zipCodeDescription = "Please enter a valid zip code in the United States.";
				}
				scope.$parent.zipCodeUpdated=true;
			}

			if (scope.$root.answers != undefined) {
				if (scope.$root.answers[category.currentCategory()] != undefined) {
					if (scope.$root.answers[category.currentCategory()].zipcode != undefined) {
						scope.updateZip();
					}
				}
			}
		}
	}
}]);
