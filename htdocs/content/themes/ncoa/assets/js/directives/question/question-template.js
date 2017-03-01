app.directive('question',['questionTemplates', 'AnswersByCategories', 'category', 'localStorageService', 'BenefitItems', function(questionTemplates, AnswersByCategories,category, localStorageService, BenefitItems) {
    return {
        restrict: 'E',
        template:"<span ng-show='checkRule()' ng-include='question_template_link'></span>",
        link: function(scope,element,ngShow) {

            for (var i=0; i<scope.question.answer_fields.length;i++) {
                if ((scope.question.answer_fields[i].default != undefined) && (scope.$root.answers[category.currentCategory()][scope.question.answer_fields[i].code] == undefined)) {
                    scope.$root.answers[category.currentCategory()][scope.question.answer_fields[i].code] = scope.question.answer_fields[i].default;
                }
                AnswersByCategories.setCategory(scope.question.answer_fields[i].code,category.currentCategory(),scope.question.answer_fields[i].type);
            }

            if (scope.question.rule == undefined) {
                scope.checkRule = function() {return true};
            } else if (scope.question.rule == '') {
                scope.checkRule = function() {return true};
            } else {
                if (scope.question.rulecode.indexOf('question_dep_') != 0) {
                    scope.checkRule = function() {return true};
                } else {
                    scope.checkRule = function () {
                        if (scope.question.rule == undefined) return true;
                        if (scope.question.rule == '') return true;

                        var ruleArray = scope.question.rule.split('#');
                        var evalString = '';
                        for (var i = 0; i < ruleArray.length; i++) {
                            var isVar = i % 2 == 1;
                            if (isVar) {
                                var val = '';
                                try {
                                    var ans = ruleArray[i].trim();
                                    var cat = AnswersByCategories.getCategory(ans);
                                    switch (cat.type) {
                                        case 'select':
                                            val = '\'' + scope.$root.answers[cat.category][ans].code + '\'';
                                            break;
                                        case 'yn':
                                            val = '\'' + scope.$root.answers[cat.category][ans] + '\'';
                                            break;
                                        default:
                                            val = scope.$root.answers[cat.category][ans];
                                            break;
                                    }
                                } catch (err) {
                                    val = 'undefined';
                                }
                                evalString = evalString + val;
                            } else {
                                evalString = evalString + ruleArray[i];
                            }
                        }
                        var retVal = false;
                        try {
                            retVal = eval(evalString);
                        } catch (err) {
                            retVal = false;
                        }
                        if (retVal) {
                            return retVal;
                        } else {
                            return retVal;
                        }
                    }
                }
            }

            scope.category=category.currentCategory();
            if (questionTemplates[scope.question.code] == undefined) {
                scope.question_template_link = '/content/themes/ncoa/resources/views/directives/question/question.html?' + (new Date());
            } else {
                if ((localStorageService.get("interested_category") != undefined)&&(scope.question.code == "bcuqc_interest_category")) {
                    if (localStorageService.get("interested_category") == "and_more") {
                        scope.addProgram(BenefitItems.getByCode("bcuqc_category_transportation"));
                        scope.addProgram(BenefitItems.getByCode("bcuqc_category_education"));
                        scope.addProgram(BenefitItems.getByCode("bcuqc_category_discounts"));
                        scope.addProgram(BenefitItems.getByCode("bcuqc_category_other_assistance"));
                    } else {
                        scope.addProgram(BenefitItems.getByCode(localStorageService.get("interested_category")));
                    }
                    localStorageService.remove("interested_category");
                }
                scope.question_template_link = questionTemplates[scope.question.code] + '?' + (new Date());
            }
        },
        scope: {
            question:"="
        },
        controller: "questionController"
    }
}]);
