var app = angular.module('ncoa', ['ngAnimate', 'ngRoute', 'LocalStorageModule', 'ui.router']);

app.config(['$stateProvider', '$urlRouterProvider', function($stateProvider, $urlRouterProvider){

  $urlRouterProvider.otherwise("/");

  $stateProvider
    .state('prescreen', {
      url: "/",
      templateUrl: '/content/themes/ncoa/resources/views/pages/benefits-checkup/prescreen/prescreen.html',
      controller: 'preScreenInitalController'
    })
    .state('prescreen.questions', {
      url: "prescreen/questions",
      templateUrl: '/content/themes/ncoa/resources/views/pages/benefits-checkup/prescreen/prescreen.questions.html',
      controller: 'preScreenController'
    })
    .state('prescreen.results', {
      url: "prescreen/results",
      templateUrl: '/content/themes/ncoa/resources/views/pages/benefits-checkup/prescreen/prescreen.results.html',
      controller: 'preScreenResultsController'
    })
    .state('questionnaire.initial-results', {
      url: "/results/initial",
      templateUrl: '/content/themes/ncoa/resources/views/pages/benefits-checkup/questionnaire/questionnaire.initial-results.html',
      controller: 'questionnaireResultsController',
      data: {
        next: "questionnaire.basics",
        prev: "prescreen.results"
      }
    })
    .state('questionnaire', {
      url: "/questionnaire",
      templateUrl: '/content/themes/ncoa/resources/views/pages/benefits-checkup/questionnaire/questionnaire.html',
      controller: 'questionnaireController',
      data:{
        next: "questionnaire.health",
        prev: "prescreen.results"
      }
    })
    .state('questionnaire.basics', {
      url: "/basics",
      templateUrl: '/content/themes/ncoa/resources/views/pages/benefits-checkup/questionnaire/questionnaire.basics.html',
      controller: 'questionnaireBasicController',
      data:{
        next: "questionnaire.health",
        prev: "prescreen.results"
      }
    })
    .state('questionnaire.health', {
      url: "/health",
      templateUrl: '/content/themes/ncoa/resources/views/pages/benefits-checkup/questionnaire/questionnaire.health.html',
      controller: 'questionnaireHealthController',
      data:{
        next: "questionnaire.household",
        prev: "questionnaire.basics"
      }
    })
    .state('questionnaire.household', {
      url: "/household",
      templateUrl: '/content/themes/ncoa/resources/views/pages/benefits-checkup/questionnaire/questionnaire.household.html',
      controller: 'questionnaireHouseholdController',
      data:{
        next: "questionnaire.finances",
        prev: "questionnaire.health"
      }
    })
    .state('questionnaire.finances', {
      url: "/finances",
      templateUrl: '/content/themes/ncoa/resources/views/pages/benefits-checkup/questionnaire/questionnaire.finances.html',
      controller: 'questionnaireFinancesController',
      data:{
        next: "questionnaire.finances-income",
        prev: "questionnaire.household"
      }
    })
    .state('questionnaire.finances-income', {
      url: "/finances/income",
      templateUrl: '/content/themes/ncoa/resources/views/pages/benefits-checkup/questionnaire/questionnaire.finances.income.html',
      controller: 'questionnaireFinancesController',
      data:{
        next: "questionnaire.finances-income-grid",
        prev: "questionnaire.finances"
      }
    })
    .state('questionnaire.finances-income-grid', {
      url: "/finances/income-grid",
      templateUrl: '/content/themes/ncoa/resources/views/pages/benefits-checkup/questionnaire/questionnaire.finances.income-grid.html',
      controller: 'questionnaireFinancesController',
      data:{
        next: "questionnaire.finances-assets",
        prev: "questionnaire.finances-income"
      }
    })
    .state('questionnaire.finances-assets', {
      url: "/finances/assets",
      templateUrl: '/content/themes/ncoa/resources/views/pages/benefits-checkup/questionnaire/questionnaire.finances.assets.html',
      controller: 'questionnaireFinancesController',
      data:{
        next: "questionnaire.finances-assets-grid",
        prev: "questionnaire.finances-income-grid"
      }
    })
    .state('questionnaire.finances-assets-grid', {
      url: "/finances/assets-grid",
      templateUrl: '/content/themes/ncoa/resources/views/pages/benefits-checkup/questionnaire/questionnaire.finances.assets-grid.html',
      controller: 'questionnaireFinancesController',
      data:{
        next: "questionnaire.loader",
        prev: "questionnaire.finances-assets"
      }
    })
    .state('questionnaire.results', {
      url: "/results",
      templateUrl: '/content/themes/ncoa/resources/views/pages/benefits-checkup/questionnaire/questionnaire.results.html',
      controller: 'questionnaireResultsController',
      data:{
        next: "",
        prev: "questionnaire.finances-assets-grid"
      }
    })
    .state('questionnaire.loader', {
      url: "/loader",
      templateUrl: '/content/themes/ncoa/resources/views/pages/loader.html',
      controller: 'questionnaireLoaderController',
      data:{
        next: "",
        prev: ""
      }
    })
    .state('fact-sheets', {
      url: '/fact-sheets',
      templateUrl: '/content/themes/ncoa/resources/views/pages/benefits-checkup/fact-sheets/fact-sheets.html',
      controller: 'factSheetsController',
      data: {
        next: '',
        prev: ''
      }
    });

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
app.directive('ncoaPrograms',[function(){

	return {
		restrict: 'A',
		link: function(scope,elm){
			scope.programs = window.programs;
			scope.currentProgramsList =scope.programs.slice(0,9);
			scope.pageCount=Math.ceil(scope.programs.length/10);
			scope.currentPage= scope.pageCount==0 ? 0 : 1;
			scope.showPage = function(pageNum) {
				if (pageNum<1) {
					scope.currentPage= scope.pageCount==0 ? 0 : 1;
				} else if (pageNum>Math.ceil(scope.programs.length/10)) {
					scope.currentPage = Math.ceil(scope.programs.length/10);
				} else {
					scope.currentPage = pageNum;
				}
				scope.currentProgramsList =scope.programs.slice((scope.currentPage-1)*10, scope.currentPage*10-1);
				return false;
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

app.factory('Asset', [function(){

	var asset = {};

	var _assets = [
		{
			title: 'Cash and Cash Equivalent',
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'
		},
		{
			title: 'Primary Car',
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'	
		},
		{
			title: 'Value of Home',
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'	
		},
		{
			title: 'Second Car',
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'
		},
		{
			title: 'Life Insurance: Face Value',
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'	
		},
		{
			title: 'Life Insurance: Cash Value',
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'	
		},
		{
			title: 'Retirement Accounts',
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'	
		},
		{
			title: 'Investment Accounts',
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'	
		},
		{
			title: 'Burial Accounts: Irrevocable',
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'	
		},
		{
			title: 'Burial Accounts: Revocable',
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'	
		},
		{
			title: 'Other Assets',
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'	
		}
	];

	asset.getAssets = function(){
		return _assets;
	}

	return asset;
}]);
app.factory('BenefitItems', [function(){
	var BenefitItems = [
		{
			name: 'Medications',
			image: '/content/themes/ncoa/resources/assets/images/categories/category_medicine.svg'
		},
		{
			name: 'Healthcare',
			image: '/content/themes/ncoa/resources/assets/images/categories/category_health.svg'
		},
		{
			name: 'Income Assistance',
			image: '/content/themes/ncoa/resources/assets/images/categories/category_income.svg'
		},
		{
			name: 'Food and Nutrition',
			image: '/content/themes/ncoa/resources/assets/images/categories/category_food.svg'
		},
		{
			name: 'Housing and Utilities',
			image: '/content/themes/ncoa/resources/assets/images/categories/category_housing.svg'
		},
		{
			name: 'Tax Relief',
			image: '/content/themes/ncoa/resources/assets/images/categories/category_taxRelief.svg'
		},
		{
			name: 'Veteran',
			image: '/content/themes/ncoa/resources/assets/images/categories/category_veteran.svg'
		},
		{
			name: 'Employment',
			image: '/content/themes/ncoa/resources/assets/images/categories/category_employment.svg'
		},
		{
			name: 'Transportation',
			image: '/content/themes/ncoa/resources/assets/images/categories/category_transportation.svg'
		},
		{
			name: 'Education',
			image: '/content/themes/ncoa/resources/assets/images/categories/category_education.svg'
		},
		{
			name: 'Discounts',
			image: '/content/themes/ncoa/resources/assets/images/categories/category_discounts.svg'
		},
		{
			name: 'Other Assistance',
			image: '/content/themes/ncoa/resources/assets/images/categories/category_assistance.svg'
		}
	];

	return BenefitItems;
}]);
app.factory('Income', [function(){

	var income = {};

	var _incomes = [
		{
			title: 'Social Security Retirement and Survivor Benefits',
			description: 'Income you get from Social Security.'
		},
		{
			title: 'Social Security Disability',
			description: 'Social Security Disability Insurance (SSDI) is a cash benefit you and certain members of your family may get if you worked long enough and paid Social Security taxes.'	
		},
		{
			title: 'Supplemental Security Income',
			description: 'Supplemental Security Income (SSI) is a cash benefit you may get if you have limited income and resources, and are 65 years of age or older, disabled or blind.'	
		},
		{
			title: 'Pension and Retirement Benefits',
			description: 'A Pension or Retirement Benefit is a fixed amount of money based on the number of years you worked and how much you earned at jobs you have had.'	
		},
		{
			title: 'Work Income',
			description: 'Income you get from a job.'	
		},
		{
			title: 'Dividends and Interest',
			description: 'Dividends are amounts of money, stock, or other property paid to you by a corporation. Interest income includes money you get from savings you have in banks, credit unions, and other organizations.'
		},
		{
			title: 'Veteran Benefits',
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'	
		},
		{
			title: 'Cash Assistance',
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'	
		},
		{
			title: 'TANF',
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'	
		},
		{
			title: 'Unemployment Insurance',
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'	
		},
		{
			title: 'Railroad Retirement Benefits',
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'	
		},
		{
			title: 'Workers Compensation',
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'	
		},
		{
			title: 'Senior Community Service Employment Program (SCSEP)',
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'	
		},
		{
			title: 'Other Non Work Income',
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'	
		}
	];

	income.getIncomes = function(){
		return _incomes;
	}


	return income;
}]);
app.service('locationFinder', ['$http', function($http){
	var urlBase = 'http://maps.googleapis.com/maps/api/geocode/json';

	this.getLocation = function(zipcode){
		return $http.get(urlBase + '?address=' + zipcode + '&sensor=true');
	}
}]);
app.factory('prescreen', [function(){
	var prescreenform = {}

	return prescreenform;
}]);
app.factory('questionnaire', ['Income', 'Asset', function(Income, Asset){
	var questionnaire = {}

	questionnaire.incomes = Income.getIncomes();
	questionnaire.assets = Asset.getAssets();

	return questionnaire;
}]);
app.controller('factSheetsController', ['$scope', '$state', function($scope, $state){

}]);

app.controller('preScreenController', ['$scope', 'localStorageService', 'prescreen', 'locationFinder', '$timeout', '$state', 'BenefitItems', function($scope, localStorageService, prescreen, locationFinder, $timeout, $state, BenefitItems){


	$('.fa-question-circle').popover();
	$scope.canContinue = true;
	$scope.showquestions = false;
	$scope.showCTA = true;
	$scope.programList = [];
	$scope.months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
	$scope.tooltip = "<strong>Gross monthly income</strong> is your income before any deductions are taken. Please include yourself and your spouse (if applicable) in your calculations.";
	$scope.programs = BenefitItems;
	$scope.selectLinkText = "Select All";
	

	$scope.onStatusChange = function(){
		$scope.showCTA = ($scope.prescreen.searchfor == '' || $scope.prescreen.searchfor == 'self');
	}

	$scope.addProgram = function(programName, $index){

		var benefitindex = $scope.programList.indexOf(programName);
		if(benefitindex == -1){
			$scope.programList.push(programName);
		}else{
			$scope.programList.splice(benefitindex, 1);
		}
	}

	$scope.submitPrescreen = function(){

		prescreen.zipcode = {
			"code" : $scope.prescreen.zipcode,
			"formatted_address": $scope.prescreen.zipcode_formatted
		};
		prescreen.date_of_birth = {
			"month" : $scope.prescreen.month,
			"year" : $scope.prescreen.year
		};

		prescreen.searchingFor = $scope.prescreen.searchfor;
		prescreen.income = $scope.prescreen.income;
		prescreen.marital_status = $scope.prescreen.marital_status;
		prescreen.veteran = $scope.prescreen.veteran;
		prescreen.spouse_veteran_status = ($scope.prescreen.spouse_veteran_status) ? $scope.prescreen.spouse_veteran_status : "";
		prescreen.benefits_categories = $scope.programList;
		$state.go('prescreen.results');
	}

	$scope.selectAll = function(){

		if($scope.programList.length == 12){
			$scope.programList = [];
			$('.benefits-selector-repeater').removeClass('checked');
			$scope.selectLinkText = "Select All";
		}else if($scope.programList.length >= 0){
			$scope.programList = ['Medications', 'Healthcare', 'Income Assistance', 'Food and Nutrition', 'Housing and Utilities', 'Tax Relief', 'Veteran', 'Employment', 'Transportation', 'Education', 'Discounts', 'Other Assistance']
			$('.benefits-selector-repeater').addClass('checked');
			$scope.selectLinkText = "Deselect All";
		}
	}

	$scope.$watch('prescreen.searchfor', function(){
		if(!$('.dob').is(":visible")){
			setTimeout(function(){
				var test = document.querySelector('.dob');
				$('html,body').animate({
					scrollTop: $(test).offset().top + 'px'
				}, 500);
			}, 500);
		}
	});

	$scope.$watch('prescreen.year', function(){
		if($scope.prescreen.month != undefined && !$('.income').is(":visible")){
			setTimeout(function(){
				var test = document.querySelector('.income');
				$('html,body').animate({
					scrollTop: $(test).offset().top + 'px'
				}, 500);
			}, 500);
		}
	});

	$scope.$watch('prescreen.month', function(){
		if($scope.prescreen.year != undefined && !$('.income').is(":visible")){
			setTimeout(function(){
				var test = document.querySelector('.income');
				$('html,body').animate({
					scrollTop: $(test).offset().top + 'px'
				}, 500);
			}, 500);
		}
	});

	$scope.$watch('prescreen.income', function(){
		if(!$('.marital-status').is(":visible")){
			setTimeout(function(){
				var test = document.querySelector('.marital-status');
				$('html,body').animate({
					scrollTop: $(test).offset().top + 'px'
				}, 500);
			}, 500);
		}
	});

	$scope.$watch('prescreen.marital_status', function(){
		if(!$('.veteran-status').is(":visible")){
			setTimeout(function(){
				var test = document.querySelector('.veteran-status');
				$('html,body').animate({
					scrollTop: $(test).offset().top + 'px'
				}, 500);
			}, 500);
		}
	});

	$scope.$watch('prescreen.veteran', function(){
		if(($scope.prescreen.marital_status == "married" ||
			$scope.prescreen.marital_status == "married_living_separately" ||
			$scope.prescreen.martial_status == "widowed") && $scope.prescreen.veteran == "no" && !$('.partner-veteran-status').is(":visible")){
			setTimeout(function(){
				var test = document.querySelector('.partner-veteran-status');
				$('html,body').animate({
					scrollTop: $(test).offset().top + 'px'
				}, 500);
			}, 500);
		}else if(($scope.prescreen.marital_status == "married" ||
			$scope.prescreen.marital_status == "married_living_separately" ||
			$scope.prescreen.martial_status == "widowed") && $scope.prescreen.veteran == "yes" && !$('.benefits').is(":visible")){
				setTimeout(function(){
					var test = document.querySelector('.benefits');
					$('html,body').animate({
						scrollTop: $(test).offset().top + 'px'
					}, 500);
				}, 500);
		}else if(($scope.prescreen.marital_status == "divorced" || $scope.prescreen.marital_status == "single") && !$('.benefits').is(":visible")){
			setTimeout(function(){
				var test = document.querySelector('.benefits');
				$('html,body').animate({
					scrollTop: $(test).offset().top + 'px'
				}, 500);
			}, 500);
		}
	});

	$scope.$watch('prescreen.spouse_veteran_status', function(){
		if(!$('.benefits').is(":visible")){
			setTimeout(function(){
				var test = document.querySelector('.benefits');
				$('html,body').animate({
					scrollTop: $(test).offset().top + 'px'
				}, 500);
			}, 500);
		}
	});

	$scope.disableSubmit = function(){
		return ($scope.programList.length == 0);
	};

	$scope.showSpouseVeteranStatus = function(){

		return (($scope.prescreen.marital_status == 'married' || $scope.prescreen.marital_status == 'married_living_separately' || $scope.prescreen.marital_status == 'widowed') && $scope.prescreen.veteran == 'no');
	}

	$scope.showBenefits = function(){
		if((($scope.prescreen.marital_status == 'married' || $scope.prescreen.marital_status == 'married_living_separately' || $scope.prescreen.marital_status == 'widowed') && $scope.prescreen.veteran == 'yes')){
			return true;
		}else if((($scope.prescreen.marital_status == 'married' || $scope.prescreen.marital_status == 'married_living_separately' || $scope.prescreen.marital_status == 'widowed') && $scope.prescreen.veteran == 'no') && $scope.prescreen.spouse_veteran_status){
			return true;
		}else if(($scope.prescreen.marital_status == 'divorced' || $scope.prescreen.marital_status == 'single') && $scope.prescreen.veteran){
			return true;
		}else{
			return false;
		}
	}

}]);

app.controller('preScreenInitalController', ['$scope', '$state', function($scope, $state){

	if($state.current.name == "prescreen")
		$state.transitionTo('prescreen.questions');
}]);
app.controller('preScreenResultsController', ['$scope', 'prescreen','$location','$state', function($scope, prescreen, $location, $state){	
	$('.fa-question-circle').popover();
	
	document.querySelector('.page-wrapper').scrollIntoView();
	
	$scope.tooltipAccuracy = "You will receive more accurate results if you provide more details.";
	$scope.tooltipExpenses = "Expenses are the amount of money you spend on things like rent, utilities, and other costs of living."

	$scope.nextPage = function(url){
		$state.go('questionnaire');
	}

	var el = document.querySelector('.odometer');

	od = new Odometer({
	  el: el,
	  value: 0,
	});

	od.update(48);
}]);



app.controller('questionnaireBasicController', ['$scope','$state', 'questionnaire', function($scope, $state, questionnaire){

	$('.fa-question-circle').popover();

	$scope.tooltip = {
		"race": "Why are we asking? This question is optional, and does not affect your results. Your answer will help us understand how best to reach people who can benefit from this service."
	};
	
}]);
app.controller('questionnaireController', ['$scope','$state', 'questionnaire', function($scope, $state, questionnaire){
	
	$scope.questionnaire = questionnaire;

	if($state.current.name == "questionnaire")
		$state.transitionTo('questionnaire.basics');
	
}]);
app.controller('questionnaireFinancesController', ['$scope','Income', 'Asset', '$state', function($scope, Income, Asset, $state){
	

	$scope.setIncomeSelected = function(index){
		if($scope.questionnaire.incomes[index].selected == undefined)
			$scope.questionnaire.incomes[index].selected = true;
		else if($scope.questionnaire.incomes[index].selected == true)
			$scope.questionnaire.incomes[index].selected = false;
		else
			$scope.questionnaire.incomes[index].selected = true;
	}

	$scope.setAssetsSelected = function(index){
		if($scope.questionnaire.assets[index].selected == undefined)
			$scope.questionnaire.assets[index].selected = true;
		else if($scope.questionnaire.assets[index].selected == true)
			$scope.questionnaire.assets[index].selected = false;
		else
			$scope.questionnaire.assets[index].selected = true;
	}
	

}]);
app.controller('questionnaireHealthController', ['$scope', 'questionnaire', function($scope, questionnaire){
	
	$scope.drugs = [
		'abacavir sulfate',
		'abacavir sulfate/lamivudine',
		'abacavir sulfate/lamivudine/zidovudine',
		'abacavir, dolutegravir, and lamivudine',
		'abatacept',
		'abciximab',
		'Abilify (aripiprazole)',
		'abiraterone acetate',
		'Abraxane for Injectable Suspension (paclitaxel)',
		'acamprosate calcium',
		'acarbose',
		'Accolate (zafirlukast)',
		'Accupril (quinapril HCl)',
		'Accuretic (quinapril HCl/hydrochlorothiazide)',
		'acetohydroxamic acid',
		'Aciphex (rabeprazole sodium) Tablets',
		'acitretin',
		'aclidinium bromide inhalation powder',
		'aclometasone dipropionate cream',
		'Aclovate Cream (aclometasone dipropionate)',
		'Acterma (tocilizumab)',
		'Acthar Gel (corticotropin)',
		'Actimmune (interferon-gamma-1b)',
		'Activella (estradiol/norethindrone acetate tablets)',
		'Actos (pioglitazone HCl)',
		'Acular LS Opththalmic Solution 0.40 (ketorolac tromethamine)',
		'Acular Opththalmic Solution 0.45 (ketorolac tromethamine)',
		'Acuvail (ketorolac)',
		'acyclovir',
		'Aczone (dapsone)',
		'Adacel (tetanus, diphtheria, acellular pertussis vaccine)',
		'Adalat CC (nifedipine)',
		'adalimumab',
		'adapalene and benzoyl peroxide',
		'Adcetris (brentuximab vedotin)',
		'Adcirca (tadalafil)',
		'adefoir dipivoxil',
		'Adempas (riociguat)',
		'ado-trastuzumab emtansine',
		'Advair Diskus (fluticasone propionate/salmeterol)',
		'aspirin',
		'eye drops'
	];

}]);
app.controller('questionnaireHouseholdController', ['$scope', 'questionnaire', function($scope, questionnaire){
	
}]);
app.controller('questionnaireLoaderController', ['$scope', '$state', function($scope, $state){	
	$('.btns-container').hide();
	$('.card-nested').addClass('loader');

	setTimeout(function(){		
		$state.transitionTo('questionnaire.results');
	}, 8000);		
	

	$scope.$on('$stateChangeStart', function(event, toState, toParams, fromState, fromParams, options) {
		$('.btns-container').show();
		$('.card-nested').removeClass('loader');
	});
	
}]);
app.controller('questionnaireResultsController', ['$scope', '$state', function($scope, $state){
	var el = document.querySelector('.odometer');

	od = new Odometer({
	  el: el,
	  value: 0
	});

	od.update(18); 

	
	
	document.querySelector('.page-wrapper h1').scrollIntoView();

}]);
app.controller('zipCodeController', ['$scope', '$http', '$window', 'localStorageService', 'locationFinder', '$state', function($scope, $http, $window, localStorageService, locationFinder, $state){	

	$scope.findZip = function(zip){
		locationFinder.getLocation(zip).success(function(data, status, headers, config) {
			localStorageService.set('zipcode', zip);
			$window.location.href = '/find-my-benefits';
			
   	 	});
	}

}]);



var map_config = {
	'default':{
		'borderColor':'#ffffff', //inter-state borders
		'lakesColor':'#ffffff', // lakes color
		'namesColor':'#ffffff', //color of short names
		'mapShadow':'#1F3D7D', //shadow color below the map
		'shadowOpacity':'50', //shadow opacity, value, 0-100
		'hoverShadow':'#1F3D7D', //tooltip shadow color
	},
	'map_1':{
		'hover': 'ALABAMA', //state hover content
		'url':'/resources/details', //Goto URL
		'target':'same_window', //open link in new window:new_window, open in current window:same_window, or none for nothing.
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D', //state's color when mouse hover
		'downColor':'#FFEE88',//state's color when mouse clicking
		'enable':true,//true/false to enable/disable this state
	},
	'map_2':{
		'hover': 'ALASKA',
		'url':'/resources/details',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true
	},
	'map_3':{
		'hover': 'ARIZONA',
		'url':'/resources/details',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_4':{
		'hover': 'ARKANSAS',
		'url':'/resources/details',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_5':{
		'hover': 'CALIFORNIA',
		'url':'/resources/details',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_6':{
		'hover': 'COLORADO',
		'url':'/resources/details',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_7':{
		'hover': 'CONNECTICUT',
		'url':'/resources/details',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_8':{
		'hover': 'DELAWARE',
		'url':'/resources/details',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_9':{
		'hover': 'FLORIDA',
		'url':'/resources/details',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_10':{
		'hover': 'GEORGIA',
		'url':'/resources/details',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_11':{
		'hover': 'HAWAII',
		'url':'/resources/details',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_12':{
		'hover': 'IDAHO',
		'url':'/resources/details',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_13':{
		'hover': 'ILLINOIS',
		'url':'/resources/details',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_14':{
		'hover': 'INDIANA',
		'url':'/resources/details',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_15':{
		'hover': 'IOWA',
		'url':'/resources/details',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_16':{
		'hover': 'KANSAS',
		'url':'/resources/details',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_17':{
		'hover': 'KENTUCKY',
		'url':'/resources/details',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_18':{
		'hover': 'LOUISIANA',
		'url':'/resources/details',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_19':{
		'hover': 'MAINE',
		'url':'/resources/details',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_20':{
		'hover': 'MARYLAND',
		'url':'/resources/details',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_21':{
		'hover': 'MASSACHUSETTS',
		'url':'/resources/details',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_22':{
		'hover': 'MICHIGAN',
		'url':'/resources/details',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_23':{
		'hover': 'MINNESOTA',
		'url':'/resources/details',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_24':{
		'hover': 'MISSISSIPPI',
		'url':'/resources/details',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_25':{
		'hover': 'MISSOURI',
		'url':'/resources/details',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_26':{
		'hover': 'MONTANA',
		'url':'/resources/details',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_27':{
		'hover': 'NEBRASKA',
		'url':'/resources/details',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_28':{
		'hover': 'NEVADA',
		'url':'/resources/details',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_29':{
		'hover': 'NEW HAMPSHIRE',
		'url':'/resources/details',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_30':{
		'hover': 'NEW JERSEY',
		'url':'/resources/details',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_31':{
		'hover': 'NEW MEXICO',
		'url':'/resources/details',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_32':{
		'hover': 'NEW YORK',
		'url':'/resources/details',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_33':{
		'hover': 'NORTH CAROLINA',
		'url':'/resources/details',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_34':{
		'hover': 'NORTH DAKOTA',
		'url':'/resources/details',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_35':{
		'hover': 'OHIO',
		'url':'/resources/details',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_36':{
		'hover': 'OKLAHOMA',
		'url':'/resources/details',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_37':{
		'hover': 'OREGON',
		'url':'/resources/details',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_38':{
		'hover': 'PENNSYLVANIA',
		'url':'/resources/details',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_39':{
		'hover': 'RHODE ISLAND',
		'url':'/resources/details',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_40':{
		'hover': 'SOUTH CAROLINA',
		'url':'/resources/details',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#FFEE88',
		'enable':true,
	},
	'map_41':{
		'hover': 'SOUTH DAKOTA',
		'url':'/resources/details',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#FFEE88',
		'enable':true,
	},
	'map_42':{
		'hover': 'TENNESSEE',
		'url':'/resources/details',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_43':{
		'hover': 'In Texas, over <strong>333,000 people</strong> are using SNAP to stretch their grocery budget. Are you?',
		'url':'/resources/details',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_44':{
		'hover': 'UTAH',
		'url':'/resources/details',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_45':{
		'hover': 'VERMONT',
		'url':'/resources/details',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_46':{
		'hover': 'VIRGINIA',
		'url':'/resources/details',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true, 
	},
	'map_47':{
		'hover': 'WASHINGTON',
		'url':'/resources/details',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_48':{
		'hover': 'WEST VIRGINIA',
		'url':'/resources/details',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_49':{
		'hover': 'WISCONSIN',
		'url':'/resources/details',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_50':{
		'hover': 'WYOMING',
		'url':'/resources/details',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_51':{
		'hover': 'Puerto Rico',
		'url':'/resources/details',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_52':{
		'hover': 'Guam',
		'url':'/resources/details',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_53':{
		'hover': 'Virgin Islands',
		'url':'/resources/details',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	}
};

var pin_config = {
	'default':{
		'pinShadow':'#000', //shadow color below the points
		'pinShadowOpacity':'50', //shadow opacity, value, 0-100
	},
	'points':[
		// {
		// 	'shape':'circle',
		// 	'hover':'In Texas, over <strong>333,000 people</strong> are using SNAP to stretch their grocery budget. Are you?',
		// 	'pos_X':362,
		// 	'pos_Y':376,
		// 	'diameter':12,
		// 	'outline':'#FFF',
		// 	'thickness':1,
		// 	'upColor':'#FF0000',
		// 	'overColor':'#FFEE88',
		// 	'downColor':'#00ffff',
		// 	'url':'http://www.html5interactivemaps.com',
		// 	'target':'same_window',
		// 	'enable':true,
		// }
	]
}

// Quick feature detection
function isTouchEnabled() {
	return (('ontouchstart' in window)
		|| (navigator.MaxTouchPoints > 0)
		|| (navigator.msMaxTouchPoints > 0));
}

$(function(){
	addEvent('map_1');
	addEvent('map_2');
	addEvent('map_3');
	addEvent('map_4');
	addEvent('map_5');
	addEvent('map_6');
	addEvent('map_7');
	addEvent('map_8');
	addEvent('map_9');
	addEvent('map_10');
	addEvent('map_11');
	addEvent('map_12');
	addEvent('map_13');
	addEvent('map_14');
	addEvent('map_15');
	addEvent('map_16');
	addEvent('map_17');
	addEvent('map_18');
	addEvent('map_19');
	addEvent('map_20');
	addEvent('map_21');
	addEvent('map_22');
	addEvent('map_23');
	addEvent('map_24');
	addEvent('map_25');
	addEvent('map_26');
	addEvent('map_27');
	addEvent('map_28');
	addEvent('map_29');
	addEvent('map_30');
	addEvent('map_31');
	addEvent('map_32');
	addEvent('map_33');
	addEvent('map_34');
	addEvent('map_35');
	addEvent('map_36');
	addEvent('map_37');
	addEvent('map_38');
	addEvent('map_39');
	addEvent('map_40');
	addEvent('map_41');
	addEvent('map_42');
	addEvent('map_43');
	addEvent('map_44');
	addEvent('map_45');
	addEvent('map_46');
	addEvent('map_47');
	addEvent('map_48');
	addEvent('map_49');
	addEvent('map_50');
	addEvent('map_51');
	addEvent('map_52');
	addEvent('map_53');
})
$(function(){
	if($('#lakes').find('path').eq(0).attr('fill') != 'undefined'){
		$('#lakes').find('path').attr({'fill':map_config['default']['lakesColor']}).css({'stroke':map_config['default']['borderColor']});
	}

	$('#map-tip').css({
		'box-shadow':'1px 2px 4px '+map_config['default']['hoverShadow'],
		'-moz-box-shadow':'2px 3px 6px '+map_config['default']['hoverShadow'],
		'-webkit-box-shadow':'2px 3px 6px '+map_config['default']['hoverShadow'],
	});

	if($('#shadow').find('path').eq(0).attr('fill') != 'undefined'){
		var shadowOpacity = map_config['default']['shadowOpacity'];
		var shadowOpacity = parseInt(shadowOpacity);
		if (shadowOpacity >=100){shadowOpacity = 1;}else if(shadowOpacity <=0){shadowOpacity =0;}else{shadowOpacity = shadowOpacity/100;}
		
		$('#shadow').find('path').attr({'fill':map_config['default']['mapShadow']}).css({'fill-opacity':shadowOpacity})
	}
});

function addEvent(id,relationId){
	var _obj = $('#'+id);
	var _Textobj = $('#'+id+','+'#'+map_config[id]['namesId']);

	$('#'+['text-abb']).attr({'fill':map_config['default']['namesColor']});

	_obj.attr({'fill':map_config[id]['upColor'],'stroke':map_config['default']['borderColor']});
	_Textobj.attr({'cursor':'default'});
	if(map_config[id]['enable'] == true){
		if (isTouchEnabled()) {
			//clicking effect
			_Textobj.on('touchstart', function(e){
				var touch = e.originalEvent.touches[0];
				var x=touch.pageX+10, y=touch.pageY+15;
				var tipw=$('#map-tip').outerWidth(), tiph=$('#map-tip').outerHeight(), 
				x=(x+tipw>$(document).scrollLeft()+$(window).width())? x-tipw-(20*2) : x
				y=(y+tiph>$(document).scrollTop()+$(window).height())? $(document).scrollTop()+$(window).height()-tiph-10 : y
				$('#'+id).css({'fill':map_config[id]['downColor']});
				$('#map-tip').show().html(map_config[id]['hover']);
				$('#map-tip').css({left:x, top:y})
			})
			_Textobj.on('touchend', function(){
				$('#'+id).css({'fill':map_config[id]['upColor']});
				if(map_config[id]['target'] == 'new_window'){
					window.open(map_config[id]['url']);	
				}else if(map_config[id]['target'] == 'same_window'){
					window.parent.location.href=map_config[id]['url'];
				}
			})
		}
		_Textobj.attr({'cursor':'pointer'});
		_Textobj.hover(function(){
			//moving in/out effect
			$('#map-tip').show().html(map_config[id]['hover']);
			_obj.css({'fill':map_config[id]['overColor']})
		},function(){
			$('#map-tip').hide();
			$('#'+id).css({'fill':map_config[id]['upColor']});
		})
		//clicking effect
		_Textobj.mousedown(function(){
			$('#'+id).css({'fill':map_config[id]['downColor']});
		})
		_Textobj.mouseup(function(){
			$('#'+id).css({'fill':map_config[id]['overColor']});
			if(map_config[id]['target'] == 'new_window'){
				window.open(map_config[id]['url']);	
			}else if(map_config[id]['target'] == 'same_window'){
				window.parent.location.href=map_config[id]['url'];
			}
		})
		_Textobj.mousemove(function(e){
			var x=e.pageX+10, y=e.pageY+15;
			var tipw=$('#map-tip').outerWidth(), tiph=$('#map-tip').outerHeight(), 
			x=(x+tipw>$(document).scrollLeft()+$(window).width())? x-tipw-(20*2) : x
			y=(y+tiph>$(document).scrollTop()+$(window).height())? $(document).scrollTop()+$(window).height()-tiph-10 : y
			$('#map-tip').css({left:x, top:y})
		})
	}	
}

//The pins code
$(function(){
	if($('#pin-shadow').find('path').eq(0).attr('fill') != 'undefined'){
		var pinShadowOpacity = pin_config['default']['pinShadowOpacity'];
		var pinShadowOpacity = parseInt(pinShadowOpacity);
		if (pinShadowOpacity >=100){pinShadowOpacity = 1;}else if(pinShadowOpacity <=0){pinShadowOpacity =0;}else{pinShadowOpacity = pinShadowOpacity/100;}

		$('#pin-shadow').find('path').attr({'fill':pin_config['default']['pinShadow']}).css({'fill-opacity':pinShadowOpacity})
};


	var points_len = pin_config['points'].length;
	if( points_len > 0){
		var xmlns = "http://www.w3.org/2000/svg";
		var tsvg_obj = document.getElementById("map_points");
		var svg_circle,svg_rect;
		for(var i=0;i<points_len;i++){
			if (pin_config['points'][i]['shape']=="circle"){
				svg_circle = document.createElementNS(xmlns, "circle");
				svg_circle.setAttributeNS(null, "cx", pin_config['points'][i]['pos_X']+1);
				svg_circle.setAttributeNS(null, "cy", pin_config['points'][i]['pos_Y']+1);
				svg_circle.setAttributeNS(null, "r", pin_config['points'][i]['diameter']/2);
				svg_circle.setAttributeNS(null, "fill", pin_config['default']['pinShadow']);
				svg_circle.setAttributeNS(null, "style",'fill-opacity:'+pinShadowOpacity);
				svg_circle.setAttributeNS(null, "id",'map_points_shadow_'+i);
				tsvg_obj.appendChild(svg_circle);
				svg_circle = document.createElementNS(xmlns, "circle");
				svg_circle.setAttributeNS(null, "cx", pin_config['points'][i]['pos_X']);
				svg_circle.setAttributeNS(null, "cy", pin_config['points'][i]['pos_Y']);
				svg_circle.setAttributeNS(null, "r", pin_config['points'][i]['diameter']/2);
				svg_circle.setAttributeNS(null, "fill", pin_config['points'][i]['upColor']);
				svg_circle.setAttributeNS(null, "stroke",pin_config['points'][i]['outline']);
				svg_circle.setAttributeNS(null, "stroke-width",pin_config['points'][i]['thickness']);
				svg_circle.setAttributeNS(null, "id",'map_points_'+i);
				tsvg_obj.appendChild(svg_circle);
				dynamicAddEvent(i);
			}
			else if(pin_config['points'][i]['shape']=="rectangle"){
				svg_rect = document.createElementNS(xmlns, "rect");
				svg_rect.setAttributeNS(null, "x", pin_config['points'][i]['pos_X']- pin_config['points'][i]['width']/2+1);
				svg_rect.setAttributeNS(null, "y", pin_config['points'][i]['pos_Y']- pin_config['points'][i]['height']/2+1);
				svg_rect.setAttributeNS(null, "width", pin_config['points'][i]['width']);
				svg_rect.setAttributeNS(null, "height", pin_config['points'][i]['height']);
				svg_rect.setAttributeNS(null, "fill", pin_config['default']['pinShadow']);
				svg_rect.setAttributeNS(null, "style",'fill-opacity:'+pinShadowOpacity);
				svg_rect.setAttributeNS(null, "id",'map_points_shadow_'+i);
				tsvg_obj.appendChild(svg_rect);
				svg_rect = document.createElementNS(xmlns, "rect");
				svg_rect.setAttributeNS(null, "x", pin_config['points'][i]['pos_X']- pin_config['points'][i]['width']/2);
				svg_rect.setAttributeNS(null, "y", pin_config['points'][i]['pos_Y']- pin_config['points'][i]['height']/2);
				svg_rect.setAttributeNS(null, "width", pin_config['points'][i]['width']);
				svg_rect.setAttributeNS(null, "height", pin_config['points'][i]['height']);
				svg_rect.setAttributeNS(null, "fill", pin_config['points'][i]['upColor']);
				svg_rect.setAttributeNS(null, "stroke",pin_config['points'][i]['outline']);
				svg_rect.setAttributeNS(null, "stroke-width",pin_config['points'][i]['thickness']);
				svg_rect.setAttributeNS(null, "id",'map_points_'+i);
				tsvg_obj.appendChild(svg_rect);
				dynamicAddEvent(i);
			}
		}
	}
});

function dynamicAddEvent(id){
	var obj = $('#map_points_'+id);

	if(pin_config['points'][id]['enable'] == true){
		if (isTouchEnabled()) {
			obj.on('touchstart', function(e){
				var touch = e.originalEvent.touches[0];
				var x=touch.pageX+10, y=touch.pageY+15;
				var tipw=$('#map-tip').outerWidth(), tiph=$('#map-tip').outerHeight(),
				x=(x+tipw>$(document).scrollLeft()+$(window).width())? x-tipw-(20*2) : x
				y=(y+tiph>$(document).scrollTop()+$(window).height())? $(document).scrollTop()+$(window).height()-tiph-10 : y
				$('#'+id).css({'fill':pin_config['points'][id]['downColor']});
				$('#map-tip').show().html(pin_config['points'][id]['hover']);
				$('#map-tip').css({left:x, top:y})
			})
			obj.on('touchend', function(){
				$('#'+id).css({'fill':pin_config['points'][id]['upColor']});
				if(pin_config['points'][id]['target'] == 'new_window'){
					window.open(pin_config['points'][id]['url']);
				}else if(pin_config['points'][id]['target'] == 'same_window'){
					window.parent.location.href=pin_config['points'][id]['url'];
				}
			})
		}
		obj.attr({'cursor':'pointer'});
		obj.hover(function(){
			$('#map-tip').show().html(pin_config['points'][id]['hover']);
			obj.css({'fill':pin_config['points'][id]['overColor']})
		},function(){
			$('#map-tip').hide();
			obj.css({'fill':pin_config['points'][id]['upColor']});
		})
		//clicking effect
		obj.mousedown(function(){
			obj.css({'fill':pin_config['points'][id]['downColor']});
		})
		obj.mouseup(function(){
			obj.css({'fill':pin_config['points'][id]['overColor']});
			if(pin_config['points'][id]['target'] == 'new_window'){
				window.open(pin_config['points'][id]['url']);	
			}else if(pin_config['points'][id]['target'] == 'same_window'){
				window.parent.location.href=pin_config['points'][id]['url'];
			}
		})
		obj.mousemove(function(e){
				var x=e.pageX+10, y=e.pageY+15;
				var tipw=$('#map-tip').outerWidth(), tiph=$('#map-tip').outerHeight(), 
				x=(x+tipw>$(document).scrollLeft()+$(window).width())? x-tipw-(20*2) : x
				y=(y+tiph>$(document).scrollTop()+$(window).height())? $(document).scrollTop()+$(window).height()-tiph-10 : y
				$('#map-tip').css({left:x, top:y})
		})
	}	
}

(function($, window, document, undefined) {
	$.fn.quicksearch = function (target, opt) {
		
		var timeout, cache, rowcache, jq_results, val = '', e = this, options = $.extend({ 
			delay: 100,
			selector: null,
			stripeRows: null,
			loader: null,
			noResults: '',
			matchedResultsCount: 0,
			bind: 'keyup',
			onBefore: function () { 
				return;
			},
			onAfter: function () { 
				return;
			},
			show: function () {
				this.style.display = "";
			},
			hide: function () {
				this.style.display = "none";
			},
			prepareQuery: function (val) {
				return val.toLowerCase().split(' ');
			},
			testQuery: function (query, txt, _row) {
				for (var i = 0; i < query.length; i += 1) {
					if (txt.indexOf(query[i]) === -1) {
						return false;
					}
				}
				return true;
			}
		}, opt);
		
		this.go = function () {
			
			var i = 0,
				numMatchedRows = 0,
				noresults = true, 
				query = options.prepareQuery(val),
				val_empty = (val.replace(' ', '').length === 0);
			
			for (var i = 0, len = rowcache.length; i < len; i++) {
				if (val_empty || options.testQuery(query, cache[i], rowcache[i])) {
					options.show.apply(rowcache[i]);
					noresults = false;
					numMatchedRows++;
				} else {
					options.hide.apply(rowcache[i]);
				}
			}
			
			if (noresults) {
				this.results(false);
			} else {
				this.results(true);
				this.stripe();
			}
			
			this.matchedResultsCount = numMatchedRows;
			this.loader(false);
			options.onAfter();
			
			return this;
		};
		
		/*
		 * External API so that users can perform search programatically. 
		 * */
		this.search = function (submittedVal) {
			val = submittedVal;
			e.trigger();
		};
		
		/*
		 * External API to get the number of matched results as seen in 
		 * https://github.com/ruiz107/quicksearch/commit/f78dc440b42d95ce9caed1d087174dd4359982d6
		 * */
		this.currentMatchedResults = function() {
			return this.matchedResultsCount;
		};
		
		this.stripe = function () {
			
			if (typeof options.stripeRows === "object" && options.stripeRows !== null)
			{
				var joined = options.stripeRows.join(' ');
				var stripeRows_length = options.stripeRows.length;
				
				jq_results.not(':hidden').each(function (i) {
					$(this).removeClass(joined).addClass(options.stripeRows[i % stripeRows_length]);
				});
			}
			
			return this;
		};
		
		this.strip_html = function (input) {
			var output = input.replace(new RegExp('<[^<]+\>', 'g'), "");
			output = $.trim(output.toLowerCase());
			return output;
		};
		
		this.results = function (bool) {
			if (typeof options.noResults === "string" && options.noResults !== "") {
				if (bool) {
					$(options.noResults).hide();
				} else {
					$(options.noResults).show();
				}
			}
			return this;
		};
		
		this.loader = function (bool) {
			if (typeof options.loader === "string" && options.loader !== "") {
				 (bool) ? $(options.loader).show() : $(options.loader).hide();
			}
			return this;
		};
		
		this.cache = function () {
			
			jq_results = $(target);
			
			if (typeof options.noResults === "string" && options.noResults !== "") {
				jq_results = jq_results.not(options.noResults);
			}
			
			var t = (typeof options.selector === "string") ? jq_results.find(options.selector) : $(target).not(options.noResults);
			cache = t.map(function () {
				return e.strip_html(this.innerHTML);
			});
			
			rowcache = jq_results.map(function () {
				return this;
			});

			/*
			 * Modified fix for sync-ing "val". 
			 * Original fix https://github.com/michaellwest/quicksearch/commit/4ace4008d079298a01f97f885ba8fa956a9703d1
			 * */
			val = val || this.val() || "";
			
			return this.go();
		};
		
		this.trigger = function () {
			this.loader(true);
			options.onBefore();
			
			window.clearTimeout(timeout);
			timeout = window.setTimeout(function () {
				e.go();
			}, options.delay);
			
			return this;
		};
		
		this.cache();
		this.results(true);
		this.stripe();
		this.loader(false);
		
		return this.each(function () {
			
			/*
			 * Changed from .bind to .on.
			 * */
			$(this).on(options.bind, function () {
				
				val = $(this).val();
				e.trigger();
			});
		});
		
	};

}(jQuery, this, document));
/*
* MultiSelect v0.9.12
* Copyright (c) 2012 Louis Cuny
*
* This program is free software. It comes without any warranty, to
* the extent permitted by applicable law. You can redistribute it
* and/or modify it under the terms of the Do What The Fuck You Want
* To Public License, Version 2, as published by Sam Hocevar. See
* http://sam.zoy.org/wtfpl/COPYING for more details.
*/

!function ($) {

  "use strict";


 /* MULTISELECT CLASS DEFINITION
  * ====================== */

  var MultiSelect = function (element, options) {
    this.options = options;
    this.$element = $(element);
    this.$container = $('<div/>', { 'class': "ms-container" });
    this.$selectableContainer = $('<div/>', { 'class': 'ms-selectable' });
    this.$selectionContainer = $('<div/>', { 'class': 'ms-selection' });
    this.$selectableUl = $('<ul/>', { 'class': "ms-list", 'tabindex' : '-1' });
    this.$selectionUl = $('<ul/>', { 'class': "ms-list", 'tabindex' : '-1' });
    this.scrollTo = 0;
    this.elemsSelector = 'li:visible:not(.ms-optgroup-label,.ms-optgroup-container,.'+options.disabledClass+')';
  };

  MultiSelect.prototype = {
    constructor: MultiSelect,

    init: function(){
      var that = this,
          ms = this.$element;

      if (ms.next('.ms-container').length === 0){
        ms.css({ position: 'absolute', left: '-9999px' });
        ms.attr('id', ms.attr('id') ? ms.attr('id') : Math.ceil(Math.random()*1000)+'multiselect');
        this.$container.attr('id', 'ms-'+ms.attr('id'));
        this.$container.addClass(that.options.cssClass);
        ms.find('option').each(function(){
          that.generateLisFromOption(this);
        });

        this.$selectionUl.find('.ms-optgroup-label').hide();

        if (that.options.selectableHeader){
          that.$selectableContainer.append(that.options.selectableHeader);
        }
        that.$selectableContainer.append(that.$selectableUl);
        if (that.options.selectableFooter){
          that.$selectableContainer.append(that.options.selectableFooter);
        }

        if (that.options.selectionHeader){
          that.$selectionContainer.append(that.options.selectionHeader);
        }
        that.$selectionContainer.append(that.$selectionUl);
        if (that.options.selectionFooter){
          that.$selectionContainer.append(that.options.selectionFooter);
        }

        that.$container.append(that.$selectableContainer);
        that.$container.append(that.$selectionContainer);
        ms.after(that.$container);

        that.activeMouse(that.$selectableUl);
        that.activeKeyboard(that.$selectableUl);

        var action = that.options.dblClick ? 'dblclick' : 'click';

        that.$selectableUl.on(action, '.ms-elem-selectable', function(){
          //that.select($(this).data('ms-value'));
          $(this).toggleClass('selected');
         
         //Check weather there is any data selected so button can be enabled/disabled
          if($('.ms-selectable .selected').length == 0)
            $('.ms-selectable .add').attr('disabled', true);
          else
            $('.ms-selectable .add').removeAttr('disabled');
        });
        
        that.$selectionUl.on(action, '.ms-elem-selection', function(){
          //that.deselect($(this).data('ms-value'));
          $(this).toggleClass('selected');

          //Check weather there is any data selected so button can be enabled/disabled
          if($('.ms-selection .selected').length == 0)
            $('.ms-selection .remove').attr('disabled', true);
          else
            $('.ms-selection .remove').removeAttr('disabled');
        });

        that.activeMouse(that.$selectionUl);
        that.activeKeyboard(that.$selectionUl);

        ms.on('focus', function(){
          that.$selectableUl.focus();
        });
      }

      var selectedValues = ms.find('option:selected').map(function(){ return $(this).val(); }).get();
      that.select(selectedValues, 'init');

      if (typeof that.options.afterInit === 'function') {
        that.options.afterInit.call(this, this.$container);
      }
    },

    'generateLisFromOption' : function(option, index, $container){
      var that = this,
          ms = that.$element,
          attributes = "",
          $option = $(option);

      for (var cpt = 0; cpt < option.attributes.length; cpt++){
        var attr = option.attributes[cpt];

        if(attr.name !== 'value' && attr.name !== 'disabled'){
          attributes += attr.name+'="'+attr.value+'" ';
        }
      }
      var selectableLi = $('<li '+attributes+'><span>'+that.escapeHTML($option.text())+'</span></li>'),
          selectedLi = selectableLi.clone(),
          value = $option.val(),
          elementId = that.sanitize(value);

      selectableLi
        .data('ms-value', value)
        .addClass('ms-elem-selectable')
        .attr('id', elementId+'-selectable');

      selectedLi
        .data('ms-value', value)
        .addClass('ms-elem-selection')
        .attr('id', elementId+'-selection')
        .hide();

      if ($option.prop('disabled') || ms.prop('disabled')){
        selectedLi.addClass(that.options.disabledClass);
        selectableLi.addClass(that.options.disabledClass);
      }

      var $optgroup = $option.parent('optgroup');

      if ($optgroup.length > 0){
        var optgroupLabel = $optgroup.attr('label'),
            optgroupId = that.sanitize(optgroupLabel),
            $selectableOptgroup = that.$selectableUl.find('#optgroup-selectable-'+optgroupId),
            $selectionOptgroup = that.$selectionUl.find('#optgroup-selection-'+optgroupId);

        if ($selectableOptgroup.length === 0){
          var optgroupContainerTpl = '<li class="ms-optgroup-container"></li>',
              optgroupTpl = '<ul class="ms-optgroup"><li class="ms-optgroup-label"><span>'+optgroupLabel+'</span></li></ul>';

          $selectableOptgroup = $(optgroupContainerTpl);
          $selectionOptgroup = $(optgroupContainerTpl);
          $selectableOptgroup.attr('id', 'optgroup-selectable-'+optgroupId);
          $selectionOptgroup.attr('id', 'optgroup-selection-'+optgroupId);
          $selectableOptgroup.append($(optgroupTpl));
          $selectionOptgroup.append($(optgroupTpl));
          if (that.options.selectableOptgroup){
            $selectableOptgroup.find('.ms-optgroup-label').on('click', function(){
              var values = $optgroup.children(':not(:selected, :disabled)').map(function(){ return $(this).val();}).get();
              that.select(values);
            });
            $selectionOptgroup.find('.ms-optgroup-label').on('click', function(){
              var values = $optgroup.children(':selected:not(:disabled)').map(function(){ return $(this).val();}).get();
              that.deselect(values);
            });
          }
          that.$selectableUl.append($selectableOptgroup);
          that.$selectionUl.append($selectionOptgroup);
        }
        index = index === undefined ? $selectableOptgroup.find('ul').children().length : index + 1;
        selectableLi.insertAt(index, $selectableOptgroup.children());
        selectedLi.insertAt(index, $selectionOptgroup.children());
      } else {
        index = index === undefined ? that.$selectableUl.children().length : index;

        selectableLi.insertAt(index, that.$selectableUl);
        selectedLi.insertAt(index, that.$selectionUl);
      }
    },

    'addOption' : function(options){
      var that = this;

      if (options.value !== undefined && options.value !== null){
        options = [options];
      } 
      $.each(options, function(index, option){
        if (option.value !== undefined && option.value !== null &&
            that.$element.find("option[value='"+option.value+"']").length === 0){
          var $option = $('<option value="'+option.value+'">'+option.text+'</option>'),
              index = parseInt((typeof option.index === 'undefined' ? that.$element.children().length : option.index)),
              $container = option.nested === undefined ? that.$element : $("optgroup[label='"+option.nested+"']");

          $option.insertAt(index, $container);
          that.generateLisFromOption($option.get(0), index, option.nested);
        }
      });
    },

    'escapeHTML' : function(text){
      return $("<div>").text(text).html();
    },

    'activeKeyboard' : function($list){
      var that = this;

      $list.on('focus', function(){
        $(this).addClass('ms-focus');
      })
      .on('blur', function(){
        $(this).removeClass('ms-focus');
      })
      .on('keydown', function(e){
        switch (e.which) {
          case 40:
          case 38:
            e.preventDefault();
            e.stopPropagation();
            that.moveHighlight($(this), (e.which === 38) ? -1 : 1);
            return;
          case 37:
          case 39:
            e.preventDefault();
            e.stopPropagation();
            that.switchList($list);
            return;
          case 9:
            if(that.$element.is('[tabindex]')){
              e.preventDefault();
              var tabindex = parseInt(that.$element.attr('tabindex'), 10);
              tabindex = (e.shiftKey) ? tabindex-1 : tabindex+1;
              $('[tabindex="'+(tabindex)+'"]').focus();
              return;
            }else{
              if(e.shiftKey){
                that.$element.trigger('focus');
              }
            }
        }
        if($.inArray(e.which, that.options.keySelect) > -1){
          e.preventDefault();
          e.stopPropagation();
          that.selectHighlighted($list);
          return;
        }
      });
    },

    'moveHighlight': function($list, direction){
      var $elems = $list.find(this.elemsSelector),
          $currElem = $elems.filter('.ms-hover'),
          $nextElem = null,
          elemHeight = $elems.first().outerHeight(),
          containerHeight = $list.height(),
          containerSelector = '#'+this.$container.prop('id');

      $elems.removeClass('ms-hover');
      if (direction === 1){ // DOWN

        $nextElem = $currElem.nextAll(this.elemsSelector).first();
        if ($nextElem.length === 0){
          var $optgroupUl = $currElem.parent();

          if ($optgroupUl.hasClass('ms-optgroup')){
            var $optgroupLi = $optgroupUl.parent(),
                $nextOptgroupLi = $optgroupLi.next(':visible');

            if ($nextOptgroupLi.length > 0){
              $nextElem = $nextOptgroupLi.find(this.elemsSelector).first();
            } else {
              $nextElem = $elems.first();
            }
          } else {
            $nextElem = $elems.first();
          }
        }
      } else if (direction === -1){ // UP

        $nextElem = $currElem.prevAll(this.elemsSelector).first();
        if ($nextElem.length === 0){
          var $optgroupUl = $currElem.parent();

          if ($optgroupUl.hasClass('ms-optgroup')){
            var $optgroupLi = $optgroupUl.parent(),
                $prevOptgroupLi = $optgroupLi.prev(':visible');

            if ($prevOptgroupLi.length > 0){
              $nextElem = $prevOptgroupLi.find(this.elemsSelector).last();
            } else {
              $nextElem = $elems.last();
            }
          } else {
            $nextElem = $elems.last();
          }
        }
      }
      if ($nextElem.length > 0){
        $nextElem.addClass('ms-hover');
        var scrollTo = $list.scrollTop() + $nextElem.position().top - 
                       containerHeight / 2 + elemHeight / 2;

        $list.scrollTop(scrollTo);
      }
    },

    'selectHighlighted' : function($list){
      var $elems = $list.find(this.elemsSelector),
          $highlightedElem = $elems.filter('.ms-hover').first();

      if ($highlightedElem.length > 0){
        if ($list.parent().hasClass('ms-selectable')){
          this.select($highlightedElem.data('ms-value'));
        } else {
          this.deselect($highlightedElem.data('ms-value'));
        }
        $elems.removeClass('ms-hover');
      }
    },

    'switchList' : function($list){
      $list.blur();
      this.$container.find(this.elemsSelector).removeClass('ms-hover');
      if ($list.parent().hasClass('ms-selectable')){
        this.$selectionUl.focus();
      } else {
        this.$selectableUl.focus();
      }
    },

    'activeMouse' : function($list){
      var that = this;

      this.$container.on('mouseenter', that.elemsSelector, function(){
        $(this).parents('.ms-container').find(that.elemsSelector).removeClass('ms-hover');
        $(this).addClass('ms-hover');
      });

      this.$container.on('mouseleave', that.elemsSelector, function () {
        $(this).parents('.ms-container').find(that.elemsSelector).removeClass('ms-hover');
      });
    },

    'refresh' : function() {
      this.destroy();
      this.$element.multiSelect(this.options);
    },

    'destroy' : function(){
      $("#ms-"+this.$element.attr("id")).remove();
      this.$element.off('focus');
      this.$element.css('position', '').css('left', '');
      this.$element.removeData('multiselect');
    },

    'select' : function(value, method){
      if (typeof value === 'string'){ value = [value]; }

      var that = this,
          ms = this.$element,
          msIds = $.map(value, function(val){ return(that.sanitize(val)); }),
          selectables = this.$selectableUl.find('#' + msIds.join('-selectable, #')+'-selectable').filter(':not(.'+that.options.disabledClass+')'),
          selections = this.$selectionUl.find('#' + msIds.join('-selection, #') + '-selection').filter(':not(.'+that.options.disabledClass+')'),
          options = ms.find('option:not(:disabled)').filter(function(){ return($.inArray(this.value, value) > -1); });

      if (method === 'init'){
        selectables = this.$selectableUl.find('#' + msIds.join('-selectable, #')+'-selectable'),
        selections = this.$selectionUl.find('#' + msIds.join('-selection, #') + '-selection');
      }

      if (selectables.length > 0){
        selectables.addClass('ms-selected').hide();
        selections.addClass('ms-selected').show();

        options.prop('selected', true);

        that.$container.find(that.elemsSelector).removeClass('ms-hover');

        var selectableOptgroups = that.$selectableUl.children('.ms-optgroup-container');
        if (selectableOptgroups.length > 0){
          selectableOptgroups.each(function(){
            var selectablesLi = $(this).find('.ms-elem-selectable');
            if (selectablesLi.length === selectablesLi.filter('.ms-selected').length){
              $(this).find('.ms-optgroup-label').hide();
            }
          });

          var selectionOptgroups = that.$selectionUl.children('.ms-optgroup-container');
          selectionOptgroups.each(function(){
            var selectionsLi = $(this).find('.ms-elem-selection');
            if (selectionsLi.filter('.ms-selected').length > 0){
              $(this).find('.ms-optgroup-label').show();
            }
          });
        } else {
          if (that.options.keepOrder && method !== 'init'){
            var selectionLiLast = that.$selectionUl.find('.ms-selected');
            if((selectionLiLast.length > 1) && (selectionLiLast.last().get(0) != selections.get(0))) {
              selections.insertAfter(selectionLiLast.last());
            }
          }
        }
        if (method !== 'init'){
          ms.trigger('change');
          if (typeof that.options.afterSelect === 'function') {
            that.options.afterSelect.call(this, value);
          }
        }
      }
    },

    'deselect' : function(value){
      if (typeof value === 'string'){ value = [value]; }

      var that = this,
          ms = this.$element,
          msIds = $.map(value, function(val){ return(that.sanitize(val)); }),
          selectables = this.$selectableUl.find('#' + msIds.join('-selectable, #')+'-selectable'),
          selections = this.$selectionUl.find('#' + msIds.join('-selection, #')+'-selection').filter('.ms-selected').filter(':not(.'+that.options.disabledClass+')'),
          options = ms.find('option').filter(function(){ return($.inArray(this.value, value) > -1); });

      if (selections.length > 0){
        selectables.removeClass('ms-selected').show();
        selections.removeClass('ms-selected').hide();
        options.prop('selected', false);

        that.$container.find(that.elemsSelector).removeClass('ms-hover');

        var selectableOptgroups = that.$selectableUl.children('.ms-optgroup-container');
        if (selectableOptgroups.length > 0){
          selectableOptgroups.each(function(){
            var selectablesLi = $(this).find('.ms-elem-selectable');
            if (selectablesLi.filter(':not(.ms-selected)').length > 0){
              $(this).find('.ms-optgroup-label').show();
            }
          });

          var selectionOptgroups = that.$selectionUl.children('.ms-optgroup-container');
          selectionOptgroups.each(function(){
            var selectionsLi = $(this).find('.ms-elem-selection');
            if (selectionsLi.filter('.ms-selected').length === 0){
              $(this).find('.ms-optgroup-label').hide();
            }
          });
        }
        ms.trigger('change');
        if (typeof that.options.afterDeselect === 'function') {
          that.options.afterDeselect.call(this, value);
        }
      }
    },

    'select_all' : function(){
      var ms = this.$element,
          values = ms.val();

      ms.find('option:not(":disabled")').prop('selected', true);
      this.$selectableUl.find('.ms-elem-selectable').filter(':not(.'+this.options.disabledClass+')').addClass('ms-selected').hide();
      this.$selectionUl.find('.ms-optgroup-label').show();
      this.$selectableUl.find('.ms-optgroup-label').hide();
      this.$selectionUl.find('.ms-elem-selection').filter(':not(.'+this.options.disabledClass+')').addClass('ms-selected').show();
      this.$selectionUl.focus();
      ms.trigger('change');
      if (typeof this.options.afterSelect === 'function') {
        var selectedValues = $.grep(ms.val(), function(item){
          return $.inArray(item, values) < 0;
        });
        this.options.afterSelect.call(this, selectedValues);
      }
    },

    'deselect_all' : function(){
      var ms = this.$element,
          values = ms.val();

      ms.find('option').prop('selected', false);
      this.$selectableUl.find('.ms-elem-selectable').removeClass('ms-selected').show();
      this.$selectionUl.find('.ms-optgroup-label').hide();
      this.$selectableUl.find('.ms-optgroup-label').show();
      this.$selectionUl.find('.ms-elem-selection').removeClass('ms-selected').hide();
      this.$selectableUl.focus();
      ms.trigger('change');
      if (typeof this.options.afterDeselect === 'function') {
        this.options.afterDeselect.call(this, values);
      }
    },

    sanitize: function(value){
      var hash = 0, i, character;
      if (value.length == 0) return hash;
      var ls = 0;
      for (i = 0, ls = value.length; i < ls; i++) {
        character  = value.charCodeAt(i);
        hash  = ((hash<<5)-hash)+character;
        hash |= 0; // Convert to 32bit integer
      }
      return hash;
    }
  };

  /* MULTISELECT PLUGIN DEFINITION
   * ======================= */

  $.fn.multiSelect = function () {
    var option = arguments[0],
        args = arguments;

    return this.each(function () {
      var $this = $(this),
          data = $this.data('multiselect'),
          options = $.extend({}, $.fn.multiSelect.defaults, $this.data(), typeof option === 'object' && option);

      if (!data){ $this.data('multiselect', (data = new MultiSelect(this, options))); }

      if (typeof option === 'string'){
        data[option](args[1]);
      } else {
        data.init();
      }
    });
  };

  $.fn.multiSelect.defaults = {
    keySelect: [32],
    selectableOptgroup: false,
    disabledClass : 'disabled',
    dblClick : false,
    keepOrder: false,
    cssClass: ''
  };

  $.fn.multiSelect.Constructor = MultiSelect;

  $.fn.insertAt = function(index, $parent) {
    return this.each(function() {
      if (index === 0) {
        $parent.prepend(this);
      } else {
        $parent.children().eq(index - 1).after(this);
      }
    });
};

}(window.jQuery);
