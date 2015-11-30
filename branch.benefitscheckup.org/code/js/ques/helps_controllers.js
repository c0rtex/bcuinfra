'use strict';

angular.module('helps', []).controller("HelpsController",["$scope", "$rootScope", function($scope, $rootScope) {
    $scope.showHelp=false;
    $scope.showHide = function() {
        $scope.showHelp= !$scope.showHelp;
        return false;
    };
}])
    .directive('divHelps',function() {
        return {
            templateUrl: "templates/help.html",
            controller: "HelpsController",
            scope: {help:"="}
        }
    });
