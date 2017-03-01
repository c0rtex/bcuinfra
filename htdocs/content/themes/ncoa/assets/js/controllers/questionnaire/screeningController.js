app.controller('screeningController', ['$rootScope', '$scope', '$state', 'prescreen', 'screening', 'screeningQuestions', function($rootScope, $scope, $state, prescreen, screening, screeningQuestions){

    $rootScope.showLoader = false;

    if ($scope.$root.answers == undefined) {
        $scope.$root.answers = screening.data.answers;
    }

    if ($scope.$root.questions == undefined) {
        $scope.$root.questions = screening.data.questions;
    }

    if (($state.params.category != undefined) && ($state.params.state != undefined)) {

        $scope.category = $state.params.category;

        if ($scope.$root.answers[$state.params.category] == undefined) {
            $scope.$root.answers[$state.params.category] = screening.data.answers[$state.params.category];
        }

        screeningQuestions.get($state.params.category,prescreen.data.results.screening.id,$state.params.state).success(function(data){
            screening.data.questions[$state.params.category] = data;
            $scope.$root.questions[$state.params.category] = data;
        });
    } else {
        $state.transitionTo('screening',{category:"basics",state:prescreen.data.answers.stateId});
    }
}]);
