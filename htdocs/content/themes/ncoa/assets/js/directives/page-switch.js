app.directive('pageSwitch',['$rootScope', '$state', 'prescreen', 'screening', 'saveScreening', 'ScreeningRoutes', function($rootScope, $state, prescreen, screening, saveScreening, ScreeningRoutes){
	return {
		link: function (scope, elm) {
			if ($state.current.name == 'questionnaire.results') {
				scope.isResults = true;
			}

			if ($state.params.category == undefined) {
				scope.prev = "prescreen";
				scope.next = "screening-start";
			} else {
				if ($state.current.name=="questionnaire.results") {
					scope.prev="finances";
					scope.next="basics";

				} else {
					scope.prev = ScreeningRoutes[$state.params.category].prev;
					scope.next = ScreeningRoutes[$state.params.category].next;
				}
			}

			scope.switchPage = function (stateName) {
				if ((stateName == "prescreen")||(stateName == "screening-start")||(stateName == "questionnaire.initial-results")) {
					$state.transitionTo(stateName);
				} else {

					var request = {};

					if (screening.data.results.screening.id != undefined) {
						request.screening = screening.data.results.screening;
					}

					request.pgno = ScreeningRoutes[$state.params.category].pgno;

					if (prescreen.data.results.screening.id != undefined) {
						request.prescreen = prescreen.data.results.screening;
					}


					if (stateName == "questionnaire.loader") {
						request.lastSet = "true";
						$rootScope.showLoader = true;
						document.querySelector('.container').scrollIntoView();
					}

					request.answers = scope.$root.answers[$state.params.category] == undefined ? {} : scope.$root.answers[$state.params.category];

					saveScreening.post(request).success(function (data, status, headers, config) {
						if (stateName == "questionnaire.loader") {
							screening.data.answers = scope.$root.answers;
							screening.data.results.screening = data.screening;
							screening.data.results.found_programs = data.found_programs;
							screening.data.results.key_programs = [];
							for (var i = 0; i < screening.data.results.found_programs.length; i++) {
								for (var j = 0; j < screening.data.results.found_programs[i].programs.length; j++) {
									if (screening.data.results.found_programs[i].programs[j].key_program) {
										var program = screening.data.results.found_programs[i].programs[j];
										program.category = screening.data.results.found_programs[i].category;
										screening.data.results.key_programs.push(program);
									}
								}
							}
							screening.save();
							$state.transitionTo('questionnaire.results');
						} else {
							screening.data.results.screening = data;
							screening.data.answers = scope.$root.answers;
							screening.save();
							var stateId = ($state.params.state == undefined) ? scope.$root.prescreen.stateId : $state.params.state;
							$state.transitionTo("screening", {"category": stateName, "state": stateId});
						}
					});
				}

			}
		}
	}
}]);
