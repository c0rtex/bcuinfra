'use strict';

angular.module('programFinder', []).controller("ProgramFinderController",["$scope", "ProgramFinder", function($scope, ProgramFinder) {
    var params = {};
    params.CFID = $scope.$root.questionSet.CFID;
    params.CFTOKEN = $scope.$root.questionSet.CFTOKEN;

    $scope.programs = ProgramFinder.query(params,function() {
                                                        $scope.programs=$scope.programs.PROGRAMS;
                                                        },null);
}])
    .directive('divProgram',function() {
        return {
            templateUrl: "templates/program.html?"+(new Date()),
            link:function(scope, element, attributes, ngModel,ngShow) {
                scope.$root.programNum = scope.$root.programNum == undefined ? 1 : scope.$root.programNum+1;
                scope.programNum=scope.$root.programNum;
            },
            scope: {program:"="}
        }
    });