var app = angular.module('styleGuide', []);

app.controller('styleGuideController',[function(){
	$('.fa').popover();
}]);


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

app.directive('breadcrumb', ['$document', '$state', function ($document, $state) {
	return {
	  restrict: 'A',
	  templateUrl: '/content/themes/ncoa/resources/views/directives/breadcrumb/breadcrumb.html',
	  link: function (scope, element, attr) {
  			scope.pages = ["Basics", "Health", "Household", "Finances", "Results"];
  			scope.currentState = $state.current.name.split(".")[1];
  			scope.hideBreadCrumbs = ($state.current.name.split(".")[1] == "results" || $state.current.name.split(".")[1] == "initial-results");

  			scope.$on('$stateChangeSuccess', function() {
  				scope.hideBreadCrumbs = ($state.current.name.split(".")[1] == "results" || $state.current.name.split(".")[1] == "initial-results");
  			});
	  }
	}
}]);
app.directive('ncoaCarousel', [function(){
	return {		
		link: function(scope, elm){

			
			//Set counter for Image slider
			$('.currItem').html("1");
			$('.currTotal').html($('.ncoa-carousel-container .item').length);
			

			$(elm).slick({
				autoplay: true,
				autoplaySpeed: 5000,
			  	dots: false,
			  	infinite: true,
			  	speed: 1000,
			  	slidesToShow: 3,
			  	slidesToScroll: 3,
			  	nextArrow: '<span class="fa fa-chevron-right" aria-hidden="true"></span>',
			  	prevArrow: '<span class="fa fa-chevron-left" aria-hidden="true"></span>',
			  	responsive: [
			    {
			      breakpoint: 1024,
			      settings: {
			        slidesToShow: 3,
			        slidesToScroll: 3,
			        infinite: false,
			        dots: false,
			        appendArrows: $(elm)
			      }
			    },
			    {
			      breakpoint: 1000,
			      settings: {
			        slidesToShow: 2,
			        slidesToScroll: 2,
			        appendArrows: $('.controls')
			      }
			    },
			    {
			      breakpoint: 480,
			      settings: {
			        slidesToShow: 1,
			        slidesToScroll: 1,
			        appendArrows: $('.controls')
			      }
			    }
			    // You can unslick at a given breakpoint now by adding:
			    // settings: "unslick"
			    // instead of a settings object
			  ]
			});

			$(elm).on('afterChange', function(event, slick, currentSlide, nextSlide){
		  		$('.currItem').html(currentSlide + 1);
			});
		}
	}
}]);
app.directive('grid', [function () {
	return {
	  restrict: 'E',
	  scope: {
	  	title: "@",
	  	description: "@"
	  },
	  templateUrl: '/content/themes/ncoa/resources/views/directives/grid/grid-tpl.html',
	  link: function (scope, element, attr) {
	  	
	  }
	}
}]);
app.directive('ncoaLoader', function(){
    return {
        restrict: 'E',
        templateUrl: '/content/themes/ncoa/resources/views/directives/loader/loader.html',
        link: function(scope,element,attrs){
            
        }
    }    
});
app.directive('medicationSelector',[function(){
	return {
		restrict: 'E',
		scope: {},
		templateUrl: '/content/themes/ncoa/resources/views/directives/med-selector/medication-selector.html',
		link: function(scope, elm){

			$('#multiselect').multiSelect({
			 	selectableHeader: "<p class='bold'>Available Medications <i class='fa fa-question-circle' aria-hidden='true'></i></p><input type='text' class='form-control' autocomplete='off' placeholder='Search...'>",
			 	selectionHeader: "<span class='h4'>My Medication List</span><p>Below are the medications you have selected</p>",
				selectableFooter: "<button class='btn btn-secondary add' disabled>Add to My List</button>",
  				selectionFooter: "<button class='btn btn-secondary remove' disabled>Remove from My List</button>",
  				afterInit: function(ms){
				    var that = this,
				        $selectableSearch = that.$selectableUl.prev(),
				        selectableSearchString = '#'+that.$container.attr('id')+' .ms-elem-selectable:not(.ms-selected)';

				    that.qs1 = $selectableSearch.quicksearch(selectableSearchString)
				    .on('keydown', function(e){
				      if (e.which === 40){
				        that.$selectableUl.focus();
				        return false;
				      }
				    });
			  	},
		  		afterSelect: function(){
			    	this.qs1.cache();
			    	$('.ms-selectable .ms-list .selected').removeClass('selected');
	            	$('.ms-selectable .add').attr('disabled', true);
			  	},
			  	afterDeselect: function(values){
			    	this.qs1.cache();
			    	$('.ms-selectable .ms-list .selected').removeClass('selected');
	            	$('.ms-selection .remove').attr('disabled', true);
			  	}
			});

			$('.ms-selectable').on('click', 'button.add', function(){
				var selected = $('.ms-selectable .ms-list .selected span').map(function(){
					return $(this).html();
				}).get();
				
				$('#multiselect').multiSelect('select', selected);
			});

			$('.ms-selection').on('click', 'button.remove', function(){
				var selected = $('.ms-selection .ms-list .selected span').map(function(){
					return $(this).html();
				}).get();

				$('#multiselect').multiSelect('deselect', selected);
			});
		}
	}
}]);
app.directive('ncoaFooter',['$http', function($http){
	return {
		restrict: 'E',
		scope: {
			url: '@'
		},
		link: function(scope, elm){
			$http.get(scope.url).then(function(response){
				console.log(response.data);
			});

			$.ajax({
			  url: scope.url,
			  context: document.body
			}).success(function(data) {
			  console.log(data);
			});
		}
	}
}]);
app.directive('ncoaForm',[function(){

	return {
		restrict: 'A',   
		link: function(scope, elm){

			scope.processForm = function(form, event){
				console.log(form);

				event.preventDefault();
			}
		}
	}
}]);
app.directive('pageSwitch',['$state', 'Income','$filter', function($state, Income, $filter){
	return {
		link: function(scope, elm){
			
			scope.preState = $state.current.data.prev;
			scope.nextState = $state.current.data.next;
			
			scope.switchPage = function(stateName){
				$state.go(stateName);
			}


			/*
			** When page is changed successfully then populate all options and links with from and to states to go to.
			*/
			scope.$on('$stateChangeSuccess', function() {
				scope.preState = ('data' in $state.current ) ? $state.current.data.prev : '';
				scope.nextState = ('data' in $state.current ) ? $state.current.data.next : '';
				scope.currentState = $state.current.name.split(".")[1];
				scope.isResults = ($state.current.name.split(".")[1] == "results");
				scope.showOptions = ($state.current.name.split('.')[1] == "results" || $state.current.name.split(".")[1] == "initial-results");

				if(document.querySelector('.page-wrapper h1'))
					document.querySelector('.page-wrapper h1').scrollIntoView();
				// else
				// 	document.querySelector('.page').scrollIntoView();
			});


			/*
			** Will watch the changing of state and look for the fincances questions to make sure that if they choose items for the sales grid then it will show that panel if not move to the next panel. This will 
			** also catch if they go back from the results page they won't get the loader again.
			*/
			scope.$on('$stateChangeStart', function(event, toState, toParams, fromState, fromParams, options) {


				var incomes = $filter('filter')(scope.questionnaire.incomes, {selected: true});
				var assets = $filter('filter')(scope.questionnaire.assets, {selected: true});				

				if(fromState.name == "questionnaire.finances-income" && toState.name == "questionnaire.finances-income-grid" && incomes.length == 0){
					event.preventDefault(); 
					$state.transitionTo('questionnaire.finances-assets');
				}else if(fromState.name == "questionnaire.finances-assets" && toState.name == "questionnaire.finances-income-grid" && incomes.length == 0){
					event.preventDefault(); 
					$state.transitionTo('questionnaire.finances-income');
				}else if(fromState.name == "questionnaire.finances-assets" && toState.name == "questionnaire.finances-assets-grid" && assets.length == 0){
					event.preventDefault(); 
					$state.transitionTo('questionnaire.loader');
				}else if(fromState.name == "questionnaire.results" && toState.name == "questionnaire.finances-assets-grid" && assets.length == 0){
					event.preventDefault(); 
					$state.transitionTo('questionnaire.finances-assets');
				}else if(fromState.name == "questionnaire.results" && toState.name == "questionnaire.loader" && assets.length != 0){
					event.preventDefault(); 
					$state.transitionTo('questionnaire.finances-assets-grid');
				}else if(fromState.name == "questionnaire.results" && toState.name == "questionnaire.loader" && assets.length == 0){
					event.preventDefault(); 
					$state.transitionTo('questionnaire.finances-assets');
				}
			});


		}
	}
}]);
app.directive('profile', ['prescreen', '$state', function (prescreen, $state) {
	return {
	  restrict: 'A',	  
	  templateUrl: '/content/themes/ncoa/resources/views/directives/profile/profile.html',
	  link: function (scope, element, attr) {
	  	scope.screenData = prescreen;
	  	scope.showOptions = ($state.current.name.split('.')[1] == "results" || $state.current.name.split(".")[1] == "initial-results");
	  }
	}
}]);
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
app.directive('textSizeChanger', ['$document', 'localStorageService', function ($document, localStorageService) {
	return {
	  restrict: 'E',
	  templateUrl: '/content/themes/ncoa/resources/views/directives/text-size-changer/text-size-changer.html',
	  scope: {
	    min: '@',
	    mid: '@',
	    max: '@',
	    unit: '@'
	  },
	  link: function (scope, element, attr) {

	  	var tSize = localStorageService.get('TextSize');
	  	scope.sel = 'min';
	  	
	  	if(tSize){
	  		sizeChanger(tSize);
	  	}
	  	
	  	scope.changeSize = sizeChanger;

	  	function sizeChanger(size){
	  		
	  		$document[0].body.style.fontSize = size + scope.unit;
	  		$(element).addClass(size);
	  		switch(size){
	  			case '18':
	  				scope.sel = 'min';
	  				break;
	  			case '20':
	  				scope.sel = 'mid';
	  				break;
	  			default:
	  				scope.sel = 'max';	
	  		};

	  		localStorageService.set('TextSize', size);
	  	}
	  }
	}
}]);
app.directive('yearDrop',function(){
   	function getYears(offset, range){
        var currentYear = new Date().getFullYear();
        var years = [];
        for (var i = 0; i < range; i++){
            years.push(currentYear - i);
        }
        return years;
    }
    return {
        restrict: 'E',
        template: '<select class="form-control inline" name="dob-year" ng-model="prescreen.year" ng-options="y for y in years"></select>',
        link: function(scope,element,attrs){
            scope.years = getYears(+attrs.offset, +attrs.range);            
            scope.prescreen.year = scope.years[66];
        }
    }    
});

app.directive('stateSelection',function(){
    
    return {
        restrict: 'A',       
        link: function(scope,element,attrs){
            
            scope.stateChange = function(){

                if(scope.mapState == "TX")
                    $('#map_base svg path#map_43').css({'fill':'#1F3D7D'});
                else
                    $('#map_base svg path#map_43').css({'fill':'#1888de'});

                if(scope.mapState == "AL")
                    $('#map_base svg path#map_1').css({'fill':'#1F3D7D'});
                else
                    $('#map_base svg path#map_1').css({'fill':'#1888de'});

            }
        }
    }    
});
app.directive('zipcode',['locationFinder', '$filter', 'localStorageService',  function(locationFinder, $filter, localStorageService){

	return {
		link: function(scope, elm){

			scope.regPattern = "\\d{5}";
			scope.isZipValid = true;
			scope.isEdit = false;
			

			//Location finder to populate formatted address
			locationFinder.getLocation(localStorageService.get('zipcode')).success(function(data, status, headers, config) {
				validateZip(data);
		    });

			$(elm).focusout(function(){
				locationFinder.getLocation($(this).val()).success(function(data, status, headers, config) {
					validateZip(data);
			    });
			});

			scope.resetZip = function(){
				scope.isEdit = true;				
				$('#zipcode').focus();
			}

			function validateZip(data){
				if(data.status == "OK"){
					if(data.results[0].address_components[0].short_name != "Undefined" && data.results[0].formatted_address.lastIndexOf("US") != -1){				
						scope.prescreen.zipcode = data.results[0].address_components[0].long_name;
					
						//Filter on string to remove USA from return as google returns full formatted address
				  		scope.prescreen.zipcode_formatted = $filter('limitTo')(data.results[0].formatted_address, data.results[0].formatted_address.lastIndexOf(','), 0);
				  		localStorageService.set('zipcode', data.results[0].address_components[0].long_name);
				  		scope.isZipValid = true;
				  		scope.isEdit = false;
					}else{
						scope.isZipValid = false;
					}
				}else{
					scope.isZipValid = false;	
				}
			}
		}
	}
}]);
