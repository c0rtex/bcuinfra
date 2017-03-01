app.directive("divKeyProgram",['prescreen',function(prescreen) {
    return {
        restrict: 'E',
        templateUrl:'/content/themes/ncoa/resources/views/directives/program/programs.key-program.html?'+(new Date()),
        scope: {
            program:"=program"
        },
        link: function(scope,element) {
            scope.stateId = prescreen.data.answers.stateId;
            scope.zipcode = prescreen.data.answers.zip;
            scope.subString = function(string) {
                if (string.length>70) {
                    return string.substring(0,70)+"...";
                } else {
                    return string;
                }
            }
        }
    }
}]);
