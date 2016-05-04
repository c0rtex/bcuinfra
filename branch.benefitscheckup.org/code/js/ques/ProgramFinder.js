'use strict';

angular.module('programFinder', []).controller("ProgramFinderController",["$scope", "ProgramFinder", function($scope, ProgramFinder) {
    var params = {};
    params.CFID = $scope.$root.questionSet.CFID;
    params.CFTOKEN = $scope.$root.questionSet.CFTOKEN;

    $scope.programs = ProgramFinder.query(params,null,null);
}])
    .directive('divProgram',function() {
        return {
            templateUrl: "templates/program.html",
            controller: "ProgramFinderController",
            scope: {program:"="}
        }
    });