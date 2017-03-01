app.factory('screening', ['localStorageService', '$window', 'ScreeningRoutes', function(localStorageService, $window, ScreeningRoutes) {
    var screening = {};

    var _data = localStorageService.get('screening');

    if (_data != undefined) {
        if (_data.name != $window.name) {
            _data == undefined;
            localStorageService.remove('screening');
        }
    }

    if (_data == undefined) {
        _data = {};
        _data.questions = {};
        _data.answers = {};
        _data.results = {};
        _data.results.screening = {};
    } else if (_data.answers == undefined) {
        _data.answers = {};
    }

    if (Object.keys(_data.answers).length != Object.keys(ScreeningRoutes).length) {
        _data.answers = {};
        for (i in ScreeningRoutes) {
            _data.answers[i] = {};
        }
    }

    screening.data = _data;

    screening.save = function() {
        localStorageService.set('screening', screening.data);
    };

    screening.clear = function() {
        localStorageService.remove('screening');
    };

    return screening;
}]);
