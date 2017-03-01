app.directive('ncoaForm',[function(){

	return {
		restrict: 'A',
		link: function(scope, elm){
			scope.category = window.category;
			scope.state = window.state;
			scope.error = false;
			scope.processForm = function(form, event){
				if((scope.category == "")&&(scope.state == "")){
					scope.error = true;
					event.preventDefault();
				}
			}
		}
	}
}]);