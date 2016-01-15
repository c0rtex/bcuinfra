'use strict';

/* App Module */

var questionnaireApp = angular.module('questionnaireApp', [
  'controllers',
  'services',
  'helps',
  'validations',
  'ngSanitize',
  'ngRoute',
  'ui.mask'
]);


questionnaireApp.config(['$routeProvider',
  function($routeProvider) {
    $routeProvider.
        when('/questionset/:questionSet', {
          templateUrl: 'templates/question-set.html',
          controller: 'QuestionnaireController'
        }).
        otherwise({
          redirectTo: '/questionset/questionSet1'
        });
  }]);



questionnaireApp
    .directive('divQuestion', function() {
      return {
        templateUrl:"templates/question.html",
        scope:{
          question:'='
        }
      }
    });

questionnaireApp
    .directive('divAnswerField',function() {
      return {
        template:"<span ng-include='answer_field_link'></span>",
        link: function(scope, element, attributes, ngModel,ngShow) {
          scope.answer_field_link="templates/answer-field-"+scope.answer_field.type+".html";
        },
        controller: "ValidationController",
        scope: {
          answer_field:"=answerField"

        }
      }
    });
