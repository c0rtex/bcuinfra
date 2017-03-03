app.directive('completeQuestionnaire',['$state','$window','prescreen',function($state,$window,prescreen) {
    return {
        restrict: "E",
        template: '<a ng-click="completeFQ()" class="btn btn-primary">{{caption}}</a>',
        replace:true,
        link: function(scope,elm) {
            var prescreenAnswered = Object.keys(prescreen.data.answers).length != 0;
            if (prescreenAnswered) {
                scope.caption = "Continue to Full Questionnaire";
            } else {
                scope.caption = "Start Questionnaire";
            }

            scope.completeFQ = function (url) {
                if (prescreenAnswered) {
                    $state.go('screening-start');
                } else {
                    $window.location.href = '/find-my-benefits';
                }
            };
        }
    };
}]);