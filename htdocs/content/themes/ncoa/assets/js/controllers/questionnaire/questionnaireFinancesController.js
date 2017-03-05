app.controller('questionnaireFinancesController', ['$scope','Income', function($scope, Income){


	$scope.income_total = function(type) {
		var retValTotal = 0;
		var retValUnearned = 0;
		for (var i in $scope.questionnaire.request['finances-income-grid']) {
			if ((i.indexOf(type)==0) && (i.indexOf('total_complete')==-1) && (i.indexOf('total_unearned')==-1)) {
				retValTotal = retValTotal + $scope.questionnaire.request['finances-income-grid'][i];
				if (Income.isUnearned(i.replace(type,""))) {
					retValUnearned = retValUnearned + $scope.questionnaire.request['finances-income-grid'][i];
				}
			}
		}
		if ($scope.questionnaire.request['income-totals'] == undefined) $scope.questionnaire.request['income-totals'] = {};
		$scope.questionnaire.request['income-totals'][type+"total_complete"] = retValTotal;
		$scope.questionnaire.request['income-totals'][type+"total_unearned"] = retValUnearned;
		return retValTotal;
	}


	$scope.assets_total = function(type) {
		var retVal = 0;
		for (var i in $scope.questionnaire.request['finances-assets-grid']) {
			if ((i.indexOf(type)==0) && (i.indexOf('total_complete')==-1)) {
				retVal = retVal + $scope.questionnaire.request['finances-assets-grid'][i];
			}
		}
		if ($scope.questionnaire.request['assets-totals'] == undefined) $scope.questionnaire.request['assets-totals'] = {};
		$scope.questionnaire.request['assets-totals'][type+"total_complete"] = retVal;
		return retVal;
	}

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
