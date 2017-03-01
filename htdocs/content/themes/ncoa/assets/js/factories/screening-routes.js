app.factory('ScreeningRoutes',[function() {

    var ScreeningParts = {};

    var _routes = {};
    _routes.basics = {"prev":"questionnaire.initial-results", "next":"health", pgno:1};
    _routes.health = {"prev":"basics", "next":"household", pgno:2};
    _routes.household = {"prev":"health", "next":"finances", pgno:3};
    _routes.finances = {"prev":"household", "next":"questionnaire.loader", pgno:4};

    return _routes;
}]);
