app.directive('zipcode',['locationFinder', '$filter', 'localStorageService',  function(locationFinder, $filter, localStorageService){

	return {
		link: function(scope, elm){

			scope.regPattern = "\\d{5}";
			scope.isZipValid = true;
			scope.isEdit = false;
			

			//Location finder to populate formatted address
			locationFinder.getLocation(localStorageService.get('zipcode')).success(function(data, status, headers, config) {
				validateZip(data);
		    });

			$(elm).focusout(function(){
				locationFinder.getLocation($(this).val()).success(function(data, status, headers, config) {
					validateZip(data);
			    });
			});

			scope.resetZip = function(){
				scope.isEdit = true;				
				$('#zipcode').focus();
			}

			function validateZip(data){
				if(data.status == "OK"){
					if(data.results[0].address_components[0].short_name != "Undefined" && data.results[0].formatted_address.lastIndexOf("US") != -1){				
						scope.prescreen.zipcode = data.results[0].address_components[0].long_name;
					
						//Filter on string to remove USA from return as google returns full formatted address
				  		scope.prescreen.zipcode_formatted = $filter('limitTo')(data.results[0].formatted_address, data.results[0].formatted_address.lastIndexOf(','), 0);
				  		localStorageService.set('zipcode', data.results[0].address_components[0].long_name);
				  		scope.isZipValid = true;
				  		scope.isEdit = false;
					}else{
						scope.isZipValid = false;
					}
				}else{
					scope.isZipValid = false;	
				}
			}
		}
	}
}]);
