'use strict';

/* Controllers */

var parseLocation = function(location) {
  var obj = {};
  var params = location.split("#")[0].split("?");
  if (params.length<2) return obj;
  var pairs = params[1].split("&");
  var pair;
  var i;

  for ( i in pairs ) {
    if ( pairs[i] === "" ) continue;

    pair = pairs[i].split("=");
    obj[ decodeURIComponent( pair[0] ) ] = decodeURIComponent( pair[1] );
  }

  return obj;
};

var reloadQuestionSubset = function ($scope, $routeParams) {
  if (($scope.$root.questionSubsetNum != $routeParams.questionSubset)&&($scope.$root.questionSet.QUESTIONS != undefined)) {
    var from = $scope.$root.questionSet.QUESTIONS.length>($routeParams.questionSubset-1)*$scope.$root.questionCount
        ? ($routeParams.questionSubset-1)*$scope.$root.questionCount
        : (Math.ceil(($scope.$root.questionSet.QUESTIONS.length)/$scope.$root.questionCount)-1)*$scope.$root.questionCount;

    $scope.questions = $scope.$root.questionSet.QUESTIONS.slice(from,from+$scope.$root.questionCount);
    $scope.$root.questionSubsetNum = $routeParams.questionSubset;

    if ((from != 0)||($scope.$root.questionSet.PREVSERVICE != "")) {
      if ($scope.$root.questionSubsetNum == 1) {
        $scope.$root.prevQuestionSetURL = "/questionset/"+$scope.$root.questionSet.PREVSERVICE+"/1000";
      } else {
        $scope.$root.prevQuestionSetURL = "/questionset/"+$routeParams.questionSet+"/"+(from/$scope.$root.questionCount);
      }
    } else {
      $scope.$root.prevQuestionSetURL = undefined;
    }

    if ((from+$scope.$root.questionCount>=$scope.$root.questionSet.QUESTIONS.length)&&($scope.$root.questionSet.NEXTSERVICE == "")) {
      $scope.$root.nextQuestionSetURL = undefined;
    } else {
      if (from+$scope.$root.questionCount>=$scope.$root.questionSet.QUESTIONS.length) {
        $scope.$root.nextQuestionSetURL = "/questionset/" + $scope.$root.questionSet.NEXTSERVICE + "/1";
      } else {
        $scope.$root.nextQuestionSetURL = "/questionset/" + $routeParams.questionSet + "/" + ($routeParams.questionSubset * 1 + 1);
      }
    }

  }
};

var controllers = angular.module('controllers', []);

controllers.controller('QuestionnaireController', ['$scope','$location','$injector','$routeParams',
  function($scope, $location, $injector,$routeParams) {

    if (($scope.$root.globalQuestionCounter == undefined)||($scope.$root.prevQuestionSetURL == undefined)) {
      $scope.$root.globalQuestionCounter=1;
      $scope.$root.prevQuestionsCount=0;
    } else {

    }

    $scope.$root.questionCount=6;

    $scope.$location = $location;

    if ($scope.$root.div_af == undefined) $scope.$root.div_af = {};
    if ($scope.$root.af == undefined) $scope.$root.af = {};

    if ($scope.$root.questionSetName == undefined) $scope.$root.questionSetName="";
    if ($scope.$root.questionSubsetNum == undefined) $scope.$root.questionSubsetNum=0;

    if ($scope.$root.questionSetName != $routeParams.questionSet) {
      var params = parseLocation($location.$$absUrl);
      $scope.$root.questionSet = $injector
                                  .get($routeParams.questionSet)
                                    .query(params,
                                           function() {
                                               reloadQuestionSubset($scope,$routeParams);
                                           },
                                           null);
      $scope.$root.questionSetName = $routeParams.questionSet;
      $scope.$root.questionSubsetNum=0;
    }

    $scope.prevQS = function () {
      $scope.$root.globalQuestionCounter = $scope.$root.globalQuestionCounter - $scope.questions.length-$scope.$root.prevQuestionsCount;
      $location.url($scope.$root.prevQuestionSetURL);
    };

    $scope.nextQS = function () {
      //$scope.$root.globalQuestionCounter = $scope.$root.globalQuestionCounter + $scope.questions.length;
      $scope.$root.prevQuestionsCount = $scope.questions.length;
      $location.url($scope.$root.nextQuestionSetURL);
    };

    reloadQuestionSubset($scope,$routeParams);
  }]);










