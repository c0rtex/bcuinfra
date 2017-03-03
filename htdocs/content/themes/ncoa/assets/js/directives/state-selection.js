app.directive('stateSelection',function(){

    return {
        restrict: 'A',
        link: function(scope,element,attrs){
            scope.stateChange = function(){
                if(scope.mapState == "TX")
                    $('#map_base svg path#map_43').css({'fill':'#1F3D7D'});
                else
                    $('#map_base svg path#map_43').css({'fill':'#1888de'});

                if(scope.mapState == "AL")
                    $('#map_base svg path#map_1').css({'fill':'#1F3D7D'});
                else
                    $('#map_base svg path#map_1').css({'fill':'#1888de'});
            }
        }
    }
});
