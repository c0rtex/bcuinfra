'use strict';

/* Controllers */

var parseLocation = function(location, vParams) {
  var retVal = vParams == undefined ? {} : angular.copy(vParams);
  var params = location.split("#")[0].split("?");
  if (params.length<2) return retVal;
  var pairs = params[1].split("&");
  var pair;
  var i;

  for ( i in pairs ) {
    if ( pairs[i] === "" ) continue;

    pair = pairs[i].split("=");
    var paramName = decodeURIComponent(pair[0]);
    var paramValue = decodeURIComponent(pair[1]);
    if (retVal[paramName] == undefined) retVal[paramName] = paramValue;
  }

  return retVal;
};

var showHideHelpDef = function(show, divName) {
  if (show) {
    $("div#" + divName).show();
  } else {
    $("div#" + divName).hide();
  }
  return false;
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

var months=[{id:1,name:"January"},{id:2,name:"February"},{id:3,name:"March"},{id:4,name:"April"},
            {id:5,name:"May"},{id:6,name:"June"},{id:7,name:"July"},{id:8,name:"August"},
            {id:9,name:"September"},{id:10,name:"October"},{id:11,name:"November"},{id:12,name:"December"}];


var controllers = angular.module('controllers', []);

controllers.controller('QuestionnaireController', ['$scope','$location','$injector','$routeParams','questionSet','Screening',
  function($scope, $location, $injector,$routeParams,questionSet,Screening) {

    if ($scope.$root.globalQuestionCounter == undefined) {
      $scope.$root.pgno=1;
      $scope.$root.globalQuestionCounter=1;
      $scope.$root.prevQuestionsCount=0;
    } else {

    }
    $scope.$root.months = months;

    $scope.$root.years= [{id:1899, name:"before 1900"}];

    for (var i=1900;i<=(new Date()).getFullYear();i++) {
      $scope.$root.years[$scope.$root.years.length]={id:i,name:i};
    }

    $scope.$root.questionCount=6;

    $scope.$location = $location;

    if ($scope.$root.div_af == undefined) $scope.$root.div_af = {};
    if ($scope.$root.af == undefined) $scope.$root.af = {};

    if ($scope.$root.questionSetName == undefined) $scope.$root.questionSetName="";
    if ($scope.$root.questionSubsetNum == undefined) $scope.$root.questionSubsetNum=0;

    if ($scope.$root.questionSetName != $routeParams.questionSet) {
      var params = parseLocation($location.$$absUrl,$scope.$root.params);
      params.questionSet = $routeParams.questionSet;
      if ($scope.$root.questionSet!=undefined) {
        if (($scope.$root.questionSet.CFID != undefined) && ($scope.$root.questionSet.CFTOKEN != undefined)) {
          params.CFID = $scope.$root.questionSet.CFID;
          params.CFTOKEN = $scope.$root.questionSet.CFTOKEN;
        }
      }
      $scope.$root.questionSet = questionSet.query(params,
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
      $scope.$root.pgno--;
    };

    $scope.nextQS = function () {
      params = parseLocation($location.$$absUrl,$scope.$root.params);
      params.pgno=$scope.$root.pgno;
      params.response = {};
      for (var i=0;i<$scope.questions.length;i++) {
        for (var j=0;j<$scope.questions[i].answer_fields.length;j++) {
          params.response[$scope.questions[i].answer_fields[j].code]=$scope.$root.af[$scope.questions[i].answer_fields[j].code];
        }
      }

      params.CFID = $scope.$root.questionSet.CFID;
      params.CFTOKEN = $scope.$root.questionSet.CFTOKEN;

      Screening.query(params,function() {
        $scope.$root.prevQuestionsCount = $scope.questions.length;
        $location.url($scope.$root.nextQuestionSetURL);
        $scope.$root.pgno++;
        return false;
      },null);
    };

    reloadQuestionSubset($scope,$routeParams);
  }]);












