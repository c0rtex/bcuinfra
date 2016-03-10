'use strict';

angular.module('validations', []).controller("ValidationController",["$scope", "$rootScope", "$timeout", function($scope, $rootScope, $timeout) {

    $scope.validators = {};

    $scope.validators["function_specify_client"] = function () {
        $scope.$watch(function(scope) {
                            return scope.$root.af.client != undefined ? scope.$root.af.client.code : undefined ;
                          },

                          function () {
                            var elem = $('p#div_client_other');
                            if ((elem != undefined)&&($rootScope.af.client != undefined)) {
                                if ($rootScope.af.client.code=="other") {
                                    elem.removeClass("ng-hide");
                                } else {
                                    elem.addClass("ng-hide");
                                }
                            }
                          }
        );
        $scope.$watch(function(scope) {
                return $('p#div_client_other') != undefined
            },

            function () {
                $timeout (function() {
                    var elem = $('p#div_client_other');
                    if ((elem != undefined) && ($rootScope.af.client != undefined)) {
                        if ($rootScope.af.client.code == "other") {
                            elem.removeClass("ng-hide");
                        } else {
                            elem.addClass("ng-hide");
                        }
                    } else if((elem != undefined) && ($rootScope.af.client == undefined)) {
                        elem.addClass("ng-hide");
                    }
                },100);
            }
        );
    };



    if ($scope.answer_field.prev != undefined) {
        switch ($scope.answer_field.type) {
            case "select":
                $rootScope.af[$scope.answer_field.code]=$scope.answer_field.prev.option;
                break;
            case "gender":
                $rootScope.af[$scope.answer_field.code]=$scope.answer_field.prev.option.id;
                break;
            case "yn":
                $rootScope.af[$scope.answer_field.code]=$scope.answer_field.prev.option.id;
                break;
            case "yns":
                $rootScope.af[$scope.answer_field.code]=$scope.answer_field.prev.option.id;
                break;
            case "checkbox":
                $rootScope.af[$scope.answer_field.code]=$scope.answer_field.prev != undefined;
                break;
            case "month":
                $rootScope.af[$scope.answer_field.code]={id:$scope.answer_field.prev.response};
                break;
            case "year":
                $rootScope.af[$scope.answer_field.code]={id:$scope.answer_field.prev.response};
                break;
            default :
                $rootScope.af[$scope.answer_field.code]=$scope.answer_field.prev.response;
        }

    }

}])

    .directive('validatorAdd',function() {
        return {
            link: function (scope, element, attributes) {
                if (scope.validators[attributes.validatorAdd] != undefined) {
                    scope.validators[attributes.validatorAdd]();
                }
            }
        }
    })

    .directive('zipValidator',function($q,ZipValidator){
        return {
            require: 'ngModel',
            link: function(scope, elm, attrs, ctrl) {
                ctrl.$asyncValidators.zipValidator = function(modelValue, viewValue) {

                    scope.zipValid=false;

                    if (viewValue.length != 5) {
                        return $q.reject();
                    }

                    var def = $q.defer();
                    var data = ZipValidator.query({zip:viewValue,state_id:scope.$root.params["state_id"]},function(){
                        if (data.result=="YES") {
                            def.resolve()
                            scope.zipValid=true;
                        } else {
                            def.reject();
                            scope.zipValid=false;
                        }
                    },null);

                    return def.promise;
                };
            }
        }
    });


