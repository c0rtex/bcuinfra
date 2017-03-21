app.directive('profile', ['prescreen','screening', 'BenefitItems', '$state', 'Drugs', 'CronicConditions', function (prescreen,screening, BenefitItems, $state, Drugs, CronicConditions) {
	return {
		restrict: 'A',
		templateUrl: '/content/themes/ncoa/resources/views/directives/profile/profile.html?'+(new Date()),
		link: function (scope, element, attr) {
			scope.screenData = prescreen.data.screenData;
			//scope.questionnaire.prevScreening = prescreen.results.screening;
			// @TODO: Options were disabled as per requested in ticket BCURD-105
			scope.showOptions = false;
			//scope.showOptions = ($state.current.name.split('.')[1] == "results" || $state.current.name.split(".")[1] == "initial-results");

			scope.programs_calculated=false;

			if (screening.data.results.found_programs != undefined) {
				scope.programs_calculated=screening.data.results.found_programs.length>0;
			}

			scope.slugs={};

			scope.printReport = function() {
				if (Object.keys(scope.slugs).length>0) {
					var i = 0;
					var firstSlug = "";
					var slugs = "";
					for(var key in scope.slugs) {
						if(i==0) {
							firstSlug = key;
						} else {
							slugs = slugs +";" + key;
						}
						i++;
					}

					slugs = slugs.substring(1);

					window.open('/fact-sheets/factsheet_' + firstSlug + "/?state=" + prescreen.data.answers.stateId + "&zipcode=" + prescreen.data.answers.zipcode+'&slugs='+slugs+'&pdf=y');
				}
			};

			scope.found_programs=[];

			if (scope.programs_calculated) {
				scope.programs_calculated=true;
				scope.found_programs = screening.data.results.found_programs;

				for (var i=0;i<scope.found_programs.length;i++) {
					var program_category = BenefitItems.getByCode(scope.found_programs[i].category);
					scope.found_programs[i].name= program_category.name;
					scope.found_programs[i].sort = program_category.sort;
				}
			}

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