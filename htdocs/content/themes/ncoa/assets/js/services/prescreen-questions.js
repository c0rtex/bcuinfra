app.service('prescreenQuestions',['$http', function ($http) {
    this.get = function() {
        return $http.get(window.webServiceUrl+'/rest/backend/questionnaire/prescreen');
    }
}]);
