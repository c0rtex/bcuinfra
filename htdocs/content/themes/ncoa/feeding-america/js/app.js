var app = angular.module('feeding-america',[]);

app.service('locationFinder', ['$http', function($http){
    var urlBase = '//maps.googleapis.com/maps/api/geocode/json';

    this.getLocation = function(zipcode){
        return $http.get(urlBase + '?address=' + zipcode + '&sensor=true');
    }
}]);

app.controller('zipCodeController', ['$scope', '$window', 'locationFinder', function($scope, $window, locationFinder){

    $scope.isZipInvalid = false;

    $scope.findZip = function(zip){

        if (!zip || (zip.length != 5) || (!/\d{5}/.exec(zip))) {
            $scope.isZipInvalid=true;
            return;
        } else {
            $scope.isZipInvalid=false;
        }

        locationFinder.getLocation(zip).then(function(data) {
            var retZipCode = "";

            if(data.status == 200) {
                $scope.stateId=undefined;
                var results = data.data.results[0];
                for (var i=0;i<results.address_components.length;i++) {
                    for(var j=0;j<results.address_components[i].types.length;j++) {
                        if (((results.address_components[i].types[j] == "country")||
                            (results.address_components[i].types[j] == "political"))&&
                            (results.address_components[i].short_name == "US")) {
                            $scope.isZipInvalid=false;
                        }

                        if (results.address_components[i].types[j] == "administrative_area_level_1") {
                            $scope.stateId = results.address_components[i].short_name;
                        }
                    }
                }

                if($scope.stateId){
                    $window.location.href = 'https://www.benefitscheckup.org/fact-sheets/factsheet_nutrition_'+$scope.stateId+'_snap_program/?state='+$scope.stateId+'&x=12&y=20&zipcode='+zip;
                } else {
                    $scope.isZipInvalid=true;
                }
            }else{
                $scope.isZipInvalid=true;
            }
        });
    }

}]);

