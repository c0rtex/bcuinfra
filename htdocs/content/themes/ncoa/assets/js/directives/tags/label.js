app.directive('ngLabel',['$compile',function($compile) {
    return {
        restrict: 'E',
        link: function (scope, element, attr) {
            element.html(scope.text);
        },
        scope: {
            text:"@"
        }
    }
}]);
