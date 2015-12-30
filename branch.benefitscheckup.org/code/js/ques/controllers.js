'use strict';

/* Controllers */

var parseLocation = function(location) {
  var params = location.split("#")[0].split("?")[1];
  var pairs = params.split("&");
  var obj = {};
  var pair;
  var i;

  for ( i in pairs ) {
    if ( pairs[i] === "" ) continue;

    pair = pairs[i].split("=");
    obj[ decodeURIComponent( pair[0] ) ] = decodeURIComponent( pair[1] );
  }

  return obj;
};

var controllers = angular.module('controllers', []);

controllers.controller('QuestionnaireController', ['$scope','$location','$injector','$routeParams',
  function($scope, $location, $injector,$routeParams) {
    if ($scope.$root.div_af == undefined) $scope.$root.div_af = {};
    if ($scope.$root.af == undefined) $scope.$root.af = {};
    var params = parseLocation($location.$$absUrl);
    $scope.questions = $injector.get($routeParams.questionSet).query(params);
  }]);








