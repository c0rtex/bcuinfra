app.service('savePrescreen',['$http', function($http){
    this.post = function (data) {
        return $http.post(window.webServiceUrl+'/rest/backend/screening/savePrescreen',data,{
            headers:
            {
                'Content-Type': 'text/plain; charset=UTF-8'
            }
        });
    }
}]);
