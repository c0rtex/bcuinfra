app.controller('dobController', ['$scope', 'category', 'AnswersByCategories', function($scope, category, AnswersByCategories) {

    $scope.calcDob = function() {
        if (($scope.$root.answers[category.currentCategory()].dob_month != undefined)&&($scope.$root.answers[category.currentCategory()].dob_year != undefined)) {

            AnswersByCategories.setCategory('dob',category.currentCategory(),'integer');

            $scope.$root.answers[category.currentCategory()].dob = (new Date().getFullYear()) - $scope.$root.answers[category.currentCategory()].dob_year;
            if ((new Date().getMonth() + 1) < $scope.$root.answers[$scope.category].dob_month.id) {
                $scope.$root.answers[category.currentCategory()].dob = $scope.$root.answers[category.currentCategory()].dob - 1;
            }
        }
    }

    var yearWatch = '$root.answers.'+category.currentCategory()+'.dob_year';

    $scope.$watch(yearWatch, function() {
        $scope.calcDob();
    });

    var monthWatch = '$root.answers.'+category.currentCategory()+'.dob_month';

    $scope.$watch(monthWatch, function() {
        $scope.calcDob();
    });
}]);
