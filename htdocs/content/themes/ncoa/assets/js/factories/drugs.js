app.factory('Drugs',[function() {

    var Drugs = {};

    var _drugs = [];

    Drugs.setDrugs = function(drugs) {
        _drugs = drugs;
    }

    Drugs.getDrugs = function() {
        return _drugs;
    }

    Drugs.nameByCode = function(code) {
        for(var i=0;i<_drugs.length;i++) {
            if (_drugs[i].code==code) return _drugs[i].display;
        }
        return undefined;
    };

    Drugs.codeByName = function(name) {
        for(var i=0;i<_drugs.length;i++) {
            if (_drugs[i].display==name) return _drugs[i].code;
        }
        return undefined;
    }

    return Drugs;
}]);
