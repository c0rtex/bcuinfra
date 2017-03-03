app.directive('setDefaultAnswer',[function(){
    return {
        link: function(scope, element, attr) {
            if (scope.$root.answers[scope.category] == undefined) scope.$root.answers[scope.category] = {};
            scope.$root.answers[scope.category][scope.code] = scope.value;
        },
        scope: {
            category:"@",
            code:"@",
            value:"@"
        }
    }
}]);
