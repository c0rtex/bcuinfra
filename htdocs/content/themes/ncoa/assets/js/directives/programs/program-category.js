app.directive('divProgramsCategory',['BenefitItems', 'prescreen', '$sce', function(BenefitItems,prescreen, $sce) {
    return {
        restrict: 'E',
        templateUrl:'/content/themes/ncoa/resources/views/directives/program/programs.category.html?'+(new Date()),
        link: function(scope, element) {
            scope.benefitItem = BenefitItems.getByCode(scope.found_program.category);
            scope.stateId = prescreen.data.answers.stateId;
            scope.defaultLangs = window.defaultLangs;
            scope.zipcode = prescreen.data.answers.zip;
        },
        scope: {
            found_program:"=foundProgram",
            short:"@"
        }
    }
}]);
