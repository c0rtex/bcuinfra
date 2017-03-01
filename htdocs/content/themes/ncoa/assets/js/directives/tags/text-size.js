app.directive('textSizeChanger', ['$document', 'localStorageService', function ($document, localStorageService) {
    return {
        restrict: 'E',
        templateUrl: '/content/themes/ncoa/resources/views/directives/text-size-changer/text-size-changer.html?'+(new Date()),
        scope: {
            min: '@',
            mid: '@',
            max: '@',
            unit: '@'
        },
        link: function (scope, element, attr) {

            var tSize = localStorageService.get('TextSize');
            scope.sel = 'min';

            if(tSize){
                sizeChanger(tSize);
            }

            scope.changeSize = sizeChanger;

            function sizeChanger(size){

                $document[0].body.style.fontSize = size + scope.unit;
                $(element).addClass(size);
                switch(size){
                    case '18':
                        scope.sel = 'min';
                        break;
                    case '20':
                        scope.sel = 'mid';
                        break;
                    default:
                        scope.sel = 'max';
                };

                localStorageService.set('TextSize', size);
            }
        }
    }
}]);
