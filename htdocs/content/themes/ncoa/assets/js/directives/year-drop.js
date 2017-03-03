app.directive('yearDrop',['category',function(category){
    function getYears(offset, range){
        var currentYear = new Date().getFullYear();
        var years = [];
        for (var i = 0; i < range; i++){
            years.push(currentYear - i);
        }
        return years;
    }
    return {
        restrict: 'E',
        template: '<select class="form-control inline" name="dob-year" ng-model="$root.answers[category][code]" ng-options="y for y in years"></select>',
        link: function(scope,element,attrs){
            scope.years = getYears(+attrs.offset, +attrs.range);
            scope.category = category.currentCategory();
            if (scope.$root.answers[category.currentCategory()][scope.code] == undefined) {
                scope.$root.answers[category.currentCategory()][scope.code] = scope.years[66];
            }
        },
        scope: {
            code:"@"
        }
    }
}]);
