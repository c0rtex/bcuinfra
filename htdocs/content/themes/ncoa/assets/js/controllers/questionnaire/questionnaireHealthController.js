app.controller('questionnaireHealthController', ['$scope', 'questionnaire', /*'Drugs',*/ 'CronicConditions', function($scope, questionnaire, /*Drugs,*/ CronicConditions){

	//$scope.drugs = Drugs.getDrugs();

	$scope.chronicConditions = CronicConditions.getCronicConditions();



}]);