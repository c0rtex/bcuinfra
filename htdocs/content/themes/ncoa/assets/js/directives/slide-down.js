app.directive('slideDown',[function(){
	return {
		link: function(scope, elm){
			
			$(elm).click(function(){
				$(elm).find('.programs-container').slideToggle();
				$(elm).toggleClass('active');
			});
		}
	}
}]);