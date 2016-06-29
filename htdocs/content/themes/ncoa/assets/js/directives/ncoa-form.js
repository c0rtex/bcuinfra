app.directive('ncoaForm',[function(){

	return {
		restrict: 'A',   
		link: function(scope, elm){
			scope.error = false;
			scope.processForm = function(form, event){
				if(!form.$valid){
					scope.error = true;
					event.preventDefault();
				}
			}
		}
	}
}]);