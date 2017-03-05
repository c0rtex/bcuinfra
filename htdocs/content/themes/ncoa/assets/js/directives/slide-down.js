app.directive('slideDown',[function(){
	return {
		link: function(scope, elm){

			$(elm).children('.program-header').click(function(){
				$(elm).find('.programs-container').slideToggle();
				$(elm).toggleClass('active');
			});
		}
	}
}]);