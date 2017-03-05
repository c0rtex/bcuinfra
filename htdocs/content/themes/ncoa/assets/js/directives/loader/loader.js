app.directive('ncoaLoader', function(){
    return {
        restrict: 'E',
        templateUrl: '/content/themes/ncoa/resources/views/directives/loader/loader.html?'+(new Date()),
        link: function(scope,element,attrs){

        }
    }
});