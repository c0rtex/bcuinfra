app.service('screeningQuestions',['$http', function ($http) {
    this.get = function(category,prescreen,state) {
        return $http.get(window.webServiceUrl+'/rest/backend/questionnaire/'+category+'/'+prescreen+'/'+state);
    }
}]);
