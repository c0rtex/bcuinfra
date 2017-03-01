app.directive('answerfield',['$state', function($state){
    return {
        template:"<span ng-include='answer_field_link'></span>",
        link: function(scope, element, attributes, ngModel,ngShow) {
            scope.answer_field_link="/content/themes/ncoa/resources/views/directives/answer-field/"+scope.answer_field.type+".html?"+(new Date());
            scope.category = $state.params.category;
        },
        scope: {
            answer_field:"=answerField",
            question:"=question"
        }
    }
}]);
