app.service('locationFinder', ['$http', function($http){
	var urlBase = '//maps.googleapis.com/maps/api/geocode/json';

	this.getLocation = function(zipcode){
		return $http.get(urlBase + '?address=' + zipcode + '&sensor=true');
	}
}]);
