'use strict';

/* App Module */

var questionnaireApp = angular.module('questionnaireApp', [
  'controllers',
  'services',
  'helps',
  'validations',
  'ngSanitize',
  'ngRoute',
  'ui.utils.masks'
]);


questionnaireApp.config(['$routeProvider',
  function($routeProvider) {
    $routeProvider.
        when('/questionset/:questionSet/:questionSubset', {
          templateUrl: 'templates/question-set.html?'+(new Date()),
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
        templateUrl:"templates/question.html?"+(new Date()),
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
          scope.answer_field_link="templates/answer-field-"+scope.answer_field.type+".html?"+(new Date());
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

questionnaireApp
    .directive('divVar',function(){
        return {
            template:"",
            link: function (scope,element,attributes) {
                if (scope.$root.params == undefined) scope.$root.params ={};
                scope.$root.params[attributes['name']]=attributes['value'];
            },
            scope:{
                question:'='
            }
        }
    });