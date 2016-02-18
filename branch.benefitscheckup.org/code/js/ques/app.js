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
        when('/questionset/:questionSet/:questionSubset', {
          templateUrl: 'templates/question-set.html',
          controller: 'QuestionnaireController'
        }).
        when('/questionset/:questionSet', {
          redirectTo: '/questionset/:questionSet/1'
        }).
        otherwise({
          redirectTo: '/questionset/questionSet1/1'
        });
  }]);



questionnaireApp
    .directive('divQuestion', function() {
      return {
        templateUrl:"templates/question.html",
        link: function (scope) {
          scope.$root.globalQuestionCounter++;
          scope.questionCounter=scope.$root.globalQuestionCounter-1;
        },
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

questionnaireApp
    .directive('textToCompile',function($compile) {
        return{
            link: function(scope, element, attributes){
                var linkFn = $compile(attributes['textToCompile']);
                var content = linkFn(scope);
                element.append(content);
            }
        }
    });
