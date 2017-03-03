app.factory('questionnaire', ['Income', 'Asset', function(Income, Asset){
	var questionnaire = {}

	questionnaire.incomes = Income.getIncomes();
	questionnaire.assets = Asset.getAssets();

	return questionnaire;
}]);