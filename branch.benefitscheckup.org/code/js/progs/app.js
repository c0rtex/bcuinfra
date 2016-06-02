'use strict';

/* App Module */

var programSearchApp = angular.module('programSearchApp', [
    'services',
    'ngSanitize',
    'ngRoute',
    'ngTable',
    'ui.utils.masks',
    'ui.mask'
]);


programSearchApp.controller("programFinderController",['$scope','programFinder','NgTableParams',
    function($scope,programFinder,NgTableParams) {
        $scope.programs = [];
        $scope.onClick = function() {
            $scope.programs = programFinder.query({"cat":$scope.cat,"st":$scope.st},function(data) {
                $scope.tableParams = new NgTableParams({},{dataset: $scope.programs});
            },function(data) {
                $scope.programs=data;
            });
        };

    }]);



