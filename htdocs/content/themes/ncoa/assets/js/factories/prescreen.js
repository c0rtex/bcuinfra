app.factory('prescreen', ['localStorageService','$window', function(localStorageService, $window){
	var prescreenform = {};

	var _data = localStorageService.get('prescreen');

	prescreenform.clear = function() {
		localStorageService.remove('prescreen');
	};

	if (_data == undefined) {
		prescreenform.data = {};
	} else {
		if (_data.name==$window.name) {
			prescreenform.data = _data;
		} else {
			localStorageService.remove('prescreen');
			prescreenform.data = {};
		}
	}

	if (prescreenform.data.answers == undefined) {
		prescreenform.data.answers = {};
	}

	prescreenform.save = function() {
		prescreenform.data.name=$window.name;
		localStorageService.set('prescreen', prescreenform.data);
	};

	return prescreenform;
}]);
