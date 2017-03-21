app.directive('grid', ['$state', 'AnswersByCategories',function ($state, AnswersByCategories) {
	return {
		restrict: 'E',
		scope: {
			title: "@",
			description: "@",
			code: "@",
			type: "@",
			request: "@",
			answer_field: "=answerField"
		},
		templateUrl: '/content/themes/ncoa/resources/views/directives/grid/grid-tpl.html?'+(new Date()),
		link: function (scope, element, attr) {

			scope.category = $state.params.category;

			var cat = AnswersByCategories.getCategory('marital_stat');

			scope.isMarital = false;

			if (cat != undefined) {
				if (scope.$root.answers[cat.category] != undefined) {
					if (scope.$root.answers[cat.category].marital_stat != undefined) {
						if (scope.$root.answers[cat.category].marital_stat.code == 'married' || scope.$root.answers[cat.category].marital_stat.code == 'widowed') {
							scope.isMarital = true;
						}
					}
				}
			}

			switch (parseInt(scope.type)) {
				case 1:
					scope.self_code="s_income_";
					scope.spouse_code="sp_income_";
					scope.joint_code="s_sp_income_";
					scope.household_code="hh_income_";
					break;
				case 2:
					scope.self_code="s_asset_";
					scope.spouse_code="sp_asset_";
					scope.joint_code="s_sp_asset_";
					scope.household_code="hh_asset_";
					break;
				default:
					scope.self_code="";
					scope.spouse_code="";
					scope.joint_code="";
					scope.household_code="";
					break;
			}


			scope.setForJoint = function(code) {

				var s = scope.$root.answers[scope.category][scope.self_code + code] == undefined ? 0 : scope.$root.answers[scope.category][scope.self_code + code];
				var sp = scope.$root.answers[scope.category][scope.spouse_code + code] == undefined ? 0 : scope.$root.answers[scope.category][scope.spouse_code + code];
				var s_sp = scope.$root.answers[scope.category][scope.joint_code+code] == undefined ? 0 : scope.$root.answers[scope.category][scope.joint_code+code];

				if (s_sp < s + sp) {
					scope.$root.answers[scope.category][scope.joint_code + code] = s+sp;
				}
			};


			scope.calcTotal = function(code) {
				var suffix = ((code == "hh_income_")||(code == "hh_asset_")) ? "_simple" : "";
				if (scope.$root.answers[scope.category] == undefined) scope.$root.answers[scope.category] = {};
				scope.$root.answers[scope.category][code+"total_complete"+suffix] = 0;
				scope.$root.answers[scope.category][code+"total_unearned"+suffix] = 0;
				for (var i in scope.$root["grid_"+code+"_"+scope.type]) {
					if (scope.$root.answers[scope.category][code+i+suffix] != undefined) {
						scope.$root.answers[scope.category][code + "total_complete"+suffix] =
							scope.$root.answers[scope.category][code + "total_complete"+suffix] +
							scope.$root.answers[scope.category][code + i + suffix];

						if (scope.$root["grid_" + code + "_" + scope.type][i] == 0) {
							scope.$root.answers[scope.category][code + "total_unearned"+suffix] =
								scope.$root.answers[scope.category][code + "total_unearned"+suffix] +
								scope.$root.answers[scope.category][code + i + suffix];

						}
					}

				}
				scope.$root.answers[scope.category][code+"total_earned"+suffix] = scope.$root.answers[scope.category][code+"total_complete"+suffix] - scope.$root.answers[scope.category][code+"total_unearned"+suffix];


				var total_self = scope.$root.answers[scope.category][scope.self_code+"total_complete"] == undefined ? 0 : scope.$root.answers[scope.category][scope.self_code+"total_complete"] + 0;
				var total_spouse = scope.$root.answers[scope.category][scope.spouse_code+"total_complete"] == undefined ? 0 : scope.$root.answers[scope.category][scope.spouse_code+"total_complete"] + 0;
				var total_joint = scope.$root.answers[scope.category][scope.joint_code+"total_complete"] == undefined ? 0 : scope.$root.answers[scope.category][scope.joint_code+"total_complete"] + 0;
				var total_hh = scope.$root.answers[scope.category][scope.household_code+"total_complete_simple"] == undefined ? 0 : scope.$root.answers[scope.category][scope.household_code+"total_complete_simple"] + 0;

				scope.$root.answers[scope.category][scope.household_code+"total_complete"] = total_self + total_spouse + total_joint + total_hh;

				total_self = scope.$root.answers[scope.category][scope.self_code+"total_unearned"] == undefined ? 0 : scope.$root.answers[scope.category][scope.self_code+"total_unearned"] + 0;
				total_spouse = scope.$root.answers[scope.category][scope.spouse_code+"total_unearned"] == undefined ? 0 : scope.$root.answers[scope.category][scope.spouse_code+"total_unearned"] + 0;
				total_joint = scope.$root.answers[scope.category][scope.joint_code+"total_unearned"] == undefined ? 0 : scope.$root.answers[scope.category][scope.joint_code+"total_unearned"] + 0;
				total_hh = scope.$root.answers[scope.category][scope.household_code+"total_unearned_simple"] == undefined ? 0 : scope.$root.answers[scope.category][scope.household_code+"total_unearned_simple"] + 0;

				scope.$root.answers[scope.category][scope.household_code+"total_unearned"] = total_self + total_spouse + total_joint + total_hh;

				scope.$root.answers[scope.category][scope.household_code+"total_earned"] = scope.$root.answers[scope.category][scope.household_code+"total_complete"] - scope.$root.answers[scope.category][scope.household_code+"total_unearned"];
			}

			scope.$watch("$root.answers."+scope.category+"."+scope.self_code+scope.answer_field.code,function() {
				if (scope.$root["grid_"+scope.self_code+"_"+scope.type] == undefined) scope.$root["grid_"+scope.self_code+"_"+scope.type] = {};
				scope.$root["grid_"+scope.self_code+"_"+scope.type][scope.answer_field.code] = scope.answer_field.earned;
				scope.calcTotal(scope.self_code);
			});

			scope.$watch("$root.answers."+scope.category+"."+scope.spouse_code+scope.answer_field.code,function() {
				if (scope.$root["grid_"+scope.spouse_code+"_"+scope.type] == undefined) scope.$root["grid_"+scope.spouse_code+"_"+scope.type] = {};
				scope.$root["grid_"+scope.spouse_code+"_"+scope.type][scope.answer_field.code] = scope.answer_field.earned;
				scope.calcTotal(scope.spouse_code);
			});

			scope.$watch("$root.answers."+scope.category+"."+scope.joint_code+scope.answer_field.code,function() {
				if (scope.$root["grid_"+scope.joint_code+"_"+scope.type] == undefined) scope.$root["grid_"+scope.joint_code+"_"+scope.type] = {};
				scope.$root["grid_"+scope.joint_code+"_"+scope.type][scope.answer_field.code] = scope.answer_field.earned;
				scope.calcTotal(scope.joint_code);
			});

			scope.$watch("$root.answers."+scope.category+"."+scope.household_code+scope.answer_field.code+"_simple",function() {
				if (scope.$root["grid_"+scope.household_code+"_"+scope.type] == undefined) scope.$root["grid_"+scope.household_code+"_"+scope.type] = {};
				scope.$root["grid_"+scope.household_code+"_"+scope.type][scope.answer_field.code] = scope.answer_field.earned;
				scope.calcTotal(scope.household_code);
			});


			scope.$root.answers[scope.category][scope.self_code+scope.code] = 0;

			scope.$root.answers[scope.category][scope.spouse_code+scope.code] = 0;

			scope.$root.answers[scope.category][scope.joint_code+scope.code] = 0;

			scope.$root.answers[scope.category][scope.household_code+scope.code+'_simple'] = 0;

		}
	}
}]);