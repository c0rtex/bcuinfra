'use strict';

angular.module('validations', []).controller("ValidationController",["$scope", "$rootScope", function($scope, $rootScope) {

}])
    .directive('showEventHandler',function() {
        return {
            link: function (scope, element, attributes) {
                if (scope.$parent.answer_field.event_handlers['ng-show']!=undefined) {
                    attributes.ngShow = scope.$parent.answer_field.event_handlers['ng-show'];
                } else {
                    attributes.ngShow = "true";
                }
            }
        }
    });
