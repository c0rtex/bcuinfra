app.directive('benefitsSlider',[function(){
	return {
		restrict: 'A',
		link: function(scope, elm){

			var $navs = $('.benefits-slider-circle-nav>div');
			var $cards = $('.benefits-slider-carousel>.row');
			var length = $navs.length;
			var activeClass = 'benefits-slider-active';
			var currentIndex = 0;

			function getIndex(currentId) {
				var index;

				$navs.each(function (i) {
					if ($(this).attr('id') == currentId) {
						index = i;
					}
				});

				return index;
			}

			function prepNav() {
				var index;
				var currentId = $('.benefits-slider-icon.benefits-slider-active').parent().parent().attr('id');

				$('.benefits-slider-active').removeClass(activeClass);

				return currentId;
			}

			function arrowReposition(newNav) {
				$('style[data-benefits-slider]').remove();

				$('head').append('<style data-benefits-slider>.benefits-slider-carousel:before,.benefits-slider-carousel:after{ left: ' +
					(($(newNav).offset().left - $('.benefits-slider-carousel').offset().left) + $(newNav).width() / 2) + 'px}</style>');
			}

			function transitionNav(newIndex) {
				var newNav = $navs.get(newIndex);
				var newCard = $cards.get(newIndex);
				currentIndex = newIndex;

				$(newNav).find('.benefits-slider-icon').first().addClass(activeClass);
				$(newCard).addClass(activeClass);

				arrowReposition(newNav);

				$('.benefits-slider-index').text((newIndex + 1) + ' of ' + length);
			}

			$('.benefits-slider-circle-nav>div').each(function (i) {
				$(this).prop('id', 'benefits-slider-circle-' + i);
			});

			$(window).resize(function() {
			  var nav = $navs.get(currentIndex);

			  arrowReposition(nav);
			});

			$('.benefits-slider-index').text('1 of ' + length);

			$('.benefits-slider-arrow.fa-chevron-left').click(function () {
				var index;
				var currentId;
				var newIndex;

				currentId = prepNav();
				index = getIndex(currentId);

				newIndex = index - 1;
				if (newIndex < 0) {
					newIndex = length - 1;
				}

				transitionNav(newIndex);
			});

			$('.benefits-slider-arrow.fa-chevron-right').click(function () {
				var index;
				var currentId;
				var newIndex;

				currentId = prepNav();
				index = getIndex(currentId);

				newIndex = index + 1;
				if (newIndex > length - 1) {
					newIndex = 0;
				}

				transitionNav(newIndex);
			});

			$('.benefits-slider-circle-nav>div').click(function () {
				var newId = $(this).attr('id');
				var newIndex = getIndex(newId);

				prepNav();

				transitionNav(newIndex);
			});
		}
	}
}]);
