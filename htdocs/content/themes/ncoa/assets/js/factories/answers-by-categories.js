app.factory('AnswersByCategories', [function() {
    var retVal = {};

    var _retVal = {}

    retVal.getCategory = function(answerCode) {
        return _retVal[answerCode];
    }

    retVal.setCategory = function(answerCode, category, type) {
        _retVal[answerCode] = {'category':category,'type':type};
    }

    return retVal;

}]);
