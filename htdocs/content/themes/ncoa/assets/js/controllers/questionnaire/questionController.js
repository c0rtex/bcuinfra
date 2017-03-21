app.controller('questionController',['$scope', 'category', 'BenefitItems', 'AnswersByCategories', 'Months', function($scope, category, BenefitItems, AnswersByCategories, Months){

    $scope.category = category.currentCategory();

    $scope.months = Months;

    $scope.programs = BenefitItems.getBenefitItems();

    if (BenefitItems.programsInStructure($scope.$root.answers[category.currentCategory()]) == $scope.programs.length) {
        $scope.selectLinkText = "Deselect All";
    } else {
        $scope.selectLinkText = "Select All";
    }

    $scope.showSpouseVeteranStatus = function(){
        if ($scope.$root.answers[category.currentCategory()].marital_stat == undefined) {
            return false;
        } else {
            return (($scope.$root.answers[category.currentCategory()].marital_stat.code == 'married' || $scope.$root.answers[category.currentCategory()].marital_stat.code == 'married_living_sep' || $scope.$root.answers[category.currentCategory()].marital_stat.code == 'widowed') && $scope.$root.answers[category.currentCategory()].veteran == 'n');
        }
    }

    $scope.showBenefits = function(){
        return ($scope.$root.answers[category.currentCategory()].veteran != undefined)&&($scope.$root.answers[category.currentCategory()].marital_stat != undefined);
    }

    $scope.addProgram = function(program){

        var benefitindex = $scope.$root.answers[category.currentCategory()][program.code];
        if(benefitindex == undefined){
            $scope.$root.answers[category.currentCategory()][program.code] = 'y';
        }else{
            delete $scope.$root.$root.answers[category.currentCategory()][program.code];
        }

        $scope.$root.areProgramsAdded = BenefitItems.programsInStructure($scope.$root.answers[category.currentCategory()]) == 0 ? undefined : '1';

        if (BenefitItems.programsInStructure($scope.$root.answers[category.currentCategory()]) == $scope.programs.length) {
            $scope.selectLinkText = "Deselect All";
        } else {
            $scope.selectLinkText = "Select All";
        }
    }

    $scope.programAdded = function(programCode) {
        return $scope.$root.$root.answers[category.currentCategory()][programCode] != undefined;
    }

    $scope.selectAll = function(){
        if(BenefitItems.programsInStructure($scope.$root.answers[category.currentCategory()]) == $scope.programs.length){
            for (var i=0;i<$scope.programs.length;i++) {
                delete $scope.$root.$root.answers[category.currentCategory()][$scope.programs[i].code];
            }
            $('.benefits-selector-repeater').removeClass('checked');
            $scope.selectLinkText = "Select All";
        }else {
            for (var i=0;i<$scope.programs.length;i++) {
                $scope.$root.answers[category.currentCategory()][$scope.programs[i].code] = 'y';
            }
            $('.benefits-selector-repeater').addClass('checked');
            $scope.selectLinkText = "Deselect All";
        }
        $scope.$root.areProgramsAdded = BenefitItems.programsInStructure($scope.$root.answers[category.currentCategory()]) == 0 ? undefined : '1';
    }
}]);
