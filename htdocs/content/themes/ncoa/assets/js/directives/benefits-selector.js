app.directive('selector',[function(){
	return {
		link: function(scope, elm){
			
			$(elm).click(function(){
				if(!$(elm).hasClass('checked'))
					$(elm).addClass('checked');
				else
					$(elm).removeClass('checked');
			})
		}
	}
}]);