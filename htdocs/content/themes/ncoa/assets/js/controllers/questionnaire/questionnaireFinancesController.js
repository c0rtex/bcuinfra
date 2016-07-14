app.controller('questionnaireFinancesController', ['$scope','Income', 'Asset', '$state', function($scope, Income, Asset, $state){
	

	$scope.setIncomeSelected = function(index){
		if($scope.questionnaire.incomes[index].selected == undefined)
			$scope.questionnaire.incomes[index].selected = true;
		else if($scope.questionnaire.incomes[index].selected == true)
			$scope.questionnaire.incomes[index].selected = false;
		else
			$scope.questionnaire.incomes[index].selected = true;
	}

	$scope.setAssetsSelected = function(index){
		if($scope.questionnaire.assets[index].selected == undefined)
			$scope.questionnaire.assets[index].selected = true;
		else if($scope.questionnaire.assets[index].selected == true)
			$scope.questionnaire.assets[index].selected = false;
		else
			$scope.questionnaire.assets[index].selected = true;
	}
	

}]);