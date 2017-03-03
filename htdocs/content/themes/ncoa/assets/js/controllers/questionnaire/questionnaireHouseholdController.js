app.controller('questionnaireHouseholdController', ['$scope', 'questionnaire', function($scope, questionnaire){

    $scope.housings = [{id:"own_home",           name:"Own Home"},
        {id:"rent_dwelling",      name:"Rental"},
        {id:"own_mobile_home",    name:"Own Mobile Home"},
        {id:"boarding_home",      name:"Boarding Home"},
        {id:"live_with_others",   name:"Live with Others"},
        {id:"nursing_facility",   name:"Nursing Facility"},
        {id:"assisted_living",    name:"Assisted Living"},
        {id:"subsidized_housing", name:"Low-Income Housing"},
        {id:"homeless_shelter",   name:"Homeless or Live in a Shelter"}];

}]);
