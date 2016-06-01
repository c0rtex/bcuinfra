'use strict';

/* App Module */

var programSearchApp = angular.module('programSearchApp', [
    'services',
    'ngSanitize',
    'ngRoute',
    'ui.utils.masks',
    'ui.mask'
]);


programSearchApp.controller("programFinderController",['$scope','programFinder',
    function($scope,programFinder) {
        $scope.programs = [];
        $scope.onClick = function() {
            $scope.programs = programFinder.query({"cat":$scope.cat,"st":$scope.st},function(data) {
                $scope.iterator=1;
            },function(data) {
                $scope.programs=data;
            });
        };

    }]);



