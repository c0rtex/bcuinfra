app.directive('profile', ['prescreen', '$state', 'Drugs', 'CronicConditions', function (prescreen, $state, Drugs, CronicConditions) {
	return {
		restrict: 'A',
		templateUrl: '/content/themes/ncoa/resources/views/directives/profile/profile.html?'+(new Date()),
		link: function (scope, element, attr) {
			scope.screenData = prescreen.data.screenData;
			//scope.questionnaire.prevScreening = prescreen.results.screening;
			// @TODO: Options were disabled as per requested in ticket BCURD-105
			scope.showOptions = false;
			//scope.showOptions = ($state.current.name.split('.')[1] == "results" || $state.current.name.split(".")[1] == "initial-results");

			scope.cronicConditions = function() {
				try {
					return CronicConditions.getByCode(scope.questionnaire.request.health.chronic_condition == undefined ? "" : scope.questionnaire.request.health.chronic_condition);
				} catch (e) {
					return "";
				}
			}

			scope.drugs = function () {
				var retVal = "";
				try {
					for (var i=0; i<scope.questionnaire.request.health.drugs.length; i++) {
						retVal = retVal + Drugs.nameByCode(scope.questionnaire.request.health.drugs[i])+", ";
					}

				} catch (e) {
					retVal = ""
				}
				return retVal.substr(0,retVal.length-2);
			}

			scope.categories = function() {
				var retVal="";
				for (var i=0;i<scope.screenData.benefits_categories.length;i++) {
					retVal = retVal + scope.screenData.benefits_categories[i]+", ";
				}
				return retVal.substr(0,retVal.length-2)
			}

		}
	}
}]);
