app.factory('category', ['$state',function($state){
    var _category = {};
    _category.currentCategory = function() {
        if ($state.params.category == undefined) {
            return "prescreen";
        } else {
            return $state.params.category;
        }
    }
    return _category;
}]);
