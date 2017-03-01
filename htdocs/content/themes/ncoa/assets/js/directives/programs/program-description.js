app.directive('divProgramDesc',function() {
    return {
        restrict: 'E',
        //templateUrl:'/content/themes/ncoa/resources/views/pages/benefits-checkup/programs/programs.category.html?'+(new Date()),
        link: function(scope, element) {
            element.append("<p>"+scope.program_desc+"</p>");
        },
        scope: {
            program_desc:"=programDesc"
        }
    }
});
