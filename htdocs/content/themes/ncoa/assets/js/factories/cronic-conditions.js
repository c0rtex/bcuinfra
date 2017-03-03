app.factory('CronicConditions', [function(){

    var cronicConditions = {};

    var _cronicConditions = [{id:"chroniccondition_no",     name:"No Chronic Conditions"},
        {id:"chroniccondition_1",      name:"One Chronic Condition"},
        {id:"chroniccondition_2_more", name:"Two or More Chronic Conditions"}];

    cronicConditions.getCronicConditions = function() {
        return _cronicConditions;
    };

    cronicConditions.getByCode = function(code) {
        for (var i=0;i<_cronicConditions.length;i++) {
            if (_cronicConditions[i].id == code) return _cronicConditions[i].name;
        }
        return "";
    };

    return cronicConditions;
}]);
