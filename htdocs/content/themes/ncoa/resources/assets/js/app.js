var app = angular.module('ncoa', ['ngAnimate', 'ngRoute', 'LocalStorageModule', 'ui.router', 'angular-loading-bar']);

app.config(['$stateProvider', '$urlRouterProvider', function($stateProvider, $urlRouterProvider){

  $urlRouterProvider.otherwise("/");

  $stateProvider
    .state('prescreen', {
      url: "/",
      templateUrl: '/content/themes/ncoa/resources/views/pages/benefits-checkup/prescreen/prescreen.html?'+(new Date()),
      controller: 'preScreenInitalController'
    })
    .state('prescreen.questions', {
      url: "prescreen/questions",
      templateUrl: '/content/themes/ncoa/resources/views/pages/benefits-checkup/prescreen/prescreen.questions.html?'+(new Date()),
      controller: 'preScreenController'
    })
    .state('prescreen.results', {
      url: "prescreen/results",
      templateUrl: '/content/themes/ncoa/resources/views/pages/benefits-checkup/prescreen/prescreen.results.html?'+(new Date()),
      controller: 'preScreenResultsController'
    })
    .state('questionnaire.initial-results', {
      url: "/results/initial",
      templateUrl: '/content/themes/ncoa/resources/views/pages/benefits-checkup/questionnaire/questionnaire.initial-results.html?'+(new Date()),
      controller: 'questionnairePrescreenResultsController',
      data: {
        next: "questionnaire.basics",
        prev: "prescreen.results"
	  }
    })
    .state('questionnaire', {
      url: "/questionnaire",
      templateUrl: '/content/themes/ncoa/resources/views/pages/benefits-checkup/questionnaire/questionnaire.html?'+(new Date()),
      controller: 'questionnaireController',
      data:{
        next: "questionnaire.health",
        prev: "prescreen.results"
      }
    })
    .state('questionnaire.basics', {
      url: "/basics",
      templateUrl: '/content/themes/ncoa/resources/views/pages/benefits-checkup/questionnaire/questionnaire.basics.html?'+(new Date()),
      controller: 'questionnaireBasicController',
      data:{
        next: "questionnaire.health",
        prev: "prescreen.results"
      }
    })
    .state('questionnaire.health', {
      url: "/health",
      templateUrl: '/content/themes/ncoa/resources/views/pages/benefits-checkup/questionnaire/questionnaire.health.html?'+(new Date()),
      controller: 'questionnaireHealthController',
      data:{
        next: "questionnaire.household",
        prev: "questionnaire.basics"
      }
    })
    .state('questionnaire.household', {
      url: "/household",
      templateUrl: '/content/themes/ncoa/resources/views/pages/benefits-checkup/questionnaire/questionnaire.household.html?'+(new Date()),
      controller: 'questionnaireHouseholdController',
      data:{
        next: "questionnaire.finances",
        prev: "questionnaire.health"
      }
    })
    .state('questionnaire.finances', {
      url: "/finances",
      templateUrl: '/content/themes/ncoa/resources/views/pages/benefits-checkup/questionnaire/questionnaire.finances.html?'+(new Date()),
      controller: 'questionnaireFinancesController',
      data:{
        next: "questionnaire.finances-income",
        prev: "questionnaire.household"
      }
    })
    .state('questionnaire.finances-income', {
      url: "/finances/income",
      templateUrl: '/content/themes/ncoa/resources/views/pages/benefits-checkup/questionnaire/questionnaire.finances.income.html?'+(new Date()),
      controller: 'questionnaireFinancesController',
      data:{
        next: "questionnaire.finances-income-grid",
        prev: "questionnaire.finances"
      }
    })
    .state('questionnaire.finances-income-grid', {
      url: "/finances/income-grid",
      templateUrl: '/content/themes/ncoa/resources/views/pages/benefits-checkup/questionnaire/questionnaire.finances.income-grid.html?'+(new Date()),
      controller: 'questionnaireFinancesController',
      data:{
        next: "questionnaire.finances-assets",
        prev: "questionnaire.finances-income"
      }
    })
    .state('questionnaire.finances-assets', {
      url: "/finances/assets",
      templateUrl: '/content/themes/ncoa/resources/views/pages/benefits-checkup/questionnaire/questionnaire.finances.assets.html?'+(new Date()),
      controller: 'questionnaireFinancesController',
      data:{
        next: "questionnaire.finances-assets-grid",
        prev: "questionnaire.finances-income-grid"
      }
    })
    .state('questionnaire.finances-assets-grid', {
      url: "/finances/assets-grid",
      templateUrl: '/content/themes/ncoa/resources/views/pages/benefits-checkup/questionnaire/questionnaire.finances.assets-grid.html?'+(new Date()),
      controller: 'questionnaireFinancesController',
      data:{
        next: "questionnaire.loader",
        prev: "questionnaire.finances-assets"
      }
    })
    .state('questionnaire.results', {
      url: "/results",
      templateUrl: '/content/themes/ncoa/resources/views/pages/benefits-checkup/questionnaire/questionnaire.results.html?'+(new Date()),
      controller: 'questionnaireResultsController',
      data:{
        next: "",
        prev: "questionnaire.finances-assets-grid"
      }
    })
    .state('questionnaire.loader', {
      url: "/loader",
      templateUrl: '/content/themes/ncoa/resources/views/pages/loader.html?'+(new Date()),
      controller: 'questionnaireLoaderController',
      data:{
        next: "",
        prev: ""
      }
    })
    .state('fact-sheets', {
	  url: "/fact-sheets/:programCode/:stateId/:short/:zipcode",
      templateUrl: function($stateParams) {
		  if ($stateParams.short == "y") {
			  return '/fact-sheets/factsheet_' + $stateParams.programCode + "/?state=" + $stateParams.stateId + "&short_layout=y&short=y&zipcode=" + $stateParams.zipcode;
		  } else {
			  return '/fact-sheets/factsheet_' + $stateParams.programCode + "/?state=" + $stateParams.stateId + "&short_layout=y&zipcode=" + $stateParams.zipcode;
		  }
	  }
	})
	.state('screening-start', {
	  url: '/screening-start',
	  controller: 'screeningController'
	})
	.state('screening', {
		url: "/screening/:category/:state",
		templateUrl: '/content/themes/ncoa/resources/views/pages/benefits-checkup/screening/screening.html?'+(new Date()),
		controller: 'screeningController',
		data:{
		  next: "",
		  prev: ""
		}
	});
}]).run(['$rootScope', function($rootScope) {
	$rootScope.$on('$stateChangeSuccess',
		function(event, toState, toParams, fromState, fromParams){
			var test = document.querySelector('body');
			if (test != undefined) {
				$('html,body').animate({
					scrollTop: $(test).offset().top  + 'px'
				}, 0);
			}
		})
}]);

app.directive('completeQuestionnaire',['$state','$window','prescreen',function($state,$window,prescreen) {
	return {
		restrict: "E",
		template: '<a ng-click="completeFQ()" class="btn btn-primary">{{caption}}</a>',
		replace:true,
		link: function(scope,elm) {
			var prescreenAnswered = Object.keys(prescreen.data.answers).length != 0;
			if (prescreenAnswered) {
				scope.caption = "Complete Full Questionnaire";
			} else {
				scope.caption = "Start Questionnaire";
			}

			scope.completeFQ = function (url) {
				if (prescreenAnswered) {
					$state.go('screening-start');
				} else {
					$window.location.href = '/find-my-benefits';
				}
			};
		}
	};
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

app.factory('CronicConditions', [function(){

	var cronicConditions = {};

	var _cronicConditions = [{id:"chroniccondition_no",     name:"No Chronic Conditions"},
		{id:"chroniccondition_1",      name:"One Chronic Condition"},
		{id:"chroniccondition_2_more", name:"Two or More Chronic Conditions"}];

	cronicConditions.getCronicConditions = function() {
		return _cronicConditions;
	};

	cronicConditions.getByCode = function(code) {
		for (var i=0;i<_cronicConditions.length;i++) {
			if (_cronicConditions[i].id == code) return _cronicConditions[i].name;
		}
		return "";
	};

	return cronicConditions;
}]);

app.factory('Income', [function(){

	var income = {};

	var _incomes = [
		{
			title: 'Social Security Retirement and Survivor Benefits',
			code: 'ss_retire',
			unearned: true,
			description: 'Income you get from Social Security.'
		},
		{
			title: 'Social Security Disability',
			code: 'ss_disable',
			unearned: true,
			description: 'Social Security Disability Insurance (SSDI) is a cash benefit you and certain members of your family may get if you worked long enough and paid Social Security taxes.'
		},
		{
			title: 'Supplemental Security Income',
			code: 'ssi',
			unearned: true,
			description: 'Supplemental Security Income (SSI) is a cash benefit you may get if you have limited income and resources, and are 65 years of age or older, disabled or blind.'
		},
		{
			title: 'Pension and Retirement Benefits',
			code: 'pri_retire',
			unearned: true,
			description: 'A Pension or Retirement Benefit is a fixed amount of money based on the number of years you worked and how much you earned at jobs you have had.'
		},
		{
			title: 'Work Income',
			code: 'earned',
			unearned: false,
			description: 'Income you get from a job.'
		},
		{
			title: 'Dividends and Interest',
			code: 'dividends',
			unearned: true,
			description: 'Dividends are amounts of money, stock, or other property paid to you by a corporation. Interest income includes money you get from savings you have in banks, credit unions, and other organizations.'
		},
		{
			title: 'Veteran Benefits',
			code: 'vet_ben',
			unearned: true,
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'
		},
		{
			title: 'Cash Assistance',
			code: 'cash_assist',
			unearned: true,
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'
		},
		{
			title: 'TANF',
			code: 'tanf',
			unearned: true,
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'
		},
		{
			title: 'Unemployment Insurance',
			code: 'unemployment',
			unearned: true,
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'
		},
		{
			title: 'Railroad Retirement Benefits',
			code: 'rr_ben',
			unearned: true,
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'
		},
		{
			title: 'Workers Compensation',
			code: 'unemploy',
			unearned: true,
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'
		},
		{
			title: 'Other Non Work Income',
			code: 'other_nw',
			unearned: true,
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'
		}
	];

	income.getIncomes = function(){
		return _incomes;
	}

	income.isUnearned = function(code) {
		for(var i in _incomes) {
			if (_incomes[i].code == code) return _incomes[i].unearned;
		}
		return true;
	}

	return income;
}]);

app.factory('category', ['$state',function($state){
	if ($state.params.category == undefined) {
		return "prescreen";
	} else {
		return $state.params.category;
	}
}]);

app.factory('Asset', [function(){

	var asset = {};

	var _assets = [
		{
			title: 'Cash and Cash Equivalent',
			code: 'cash',
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'
		},
		{
			title: 'Primary Car',
			code: 'auto1',
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'
		},
		{
			title: 'Value of Home',
			code: 'home',
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'
		},
		{
			title: 'Second Car',
			code: 'auto2',
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'
		},
		{
			title: 'Life Insurance: Face Value',
			code: 'life_face',
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'
		},
		{
			title: 'Life Insurance: Cash Value',
			code: 'life_cash',
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'
		},
		{
			title: 'Retirement Accounts',
			code: 'retirement',
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'
		},
		{
			title: 'Investment Accounts',
			code: 'stocks',
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'
		},
		{
			title: 'Burial Accounts: Irrevocable',
			code: 'irrevocable',
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'
		},
		{
			title: 'Burial Accounts: Revocable',
			code: 'revocable',
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'
		},
		{
			title: 'Other Assets',
			code: 'other_a',
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'
		}
	];

	asset.getAssets = function(){
		return _assets;
	}

	return asset;
}]);


app.directive('benefitsSlider',['$window','localStorageService',function($window,localStorageService){
	return {
		restrict: 'A',
		link: function(scope, elm){

			var $navs = $('.benefits-slider-circle-nav>div');
			var $cards = $('.benefits-slider-carousel>.row');
			var length = $navs.length;
			var activeClass = 'benefits-slider-active';
			var currentIndex = 0;

			scope.findBenefits = function(category) {
				localStorageService.set('interested_category',category);
				$window.location.href= 'find-my-benefits';
			};

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
	  templateUrl: '/content/themes/ncoa/resources/views/directives/breadcrumb/breadcrumb.html?'+(new Date()),
	  link: function (scope, element, attr) {
  			scope.pages = ["Basics", "Health", "Household", "Finances", "Results"];
  			scope.currentState = $state.params.category;
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
app.directive('grid', ['$state',function ($state) {
	return {
	  restrict: 'E',
	  scope: {
	  	title: "@",
	  	description: "@",
		code: "@",
		type: "@",
		request: "@"
	  },
	  templateUrl: '/content/themes/ncoa/resources/views/directives/grid/grid-tpl.html?'+(new Date()),
	  link: function (scope, element, attr) {

		  scope.category = $state.params.category;

		  switch (parseInt(scope.type)) {
			  case 1:
				  scope.self_code="s_income_";
				  scope.spouse_code="sp_income_";
				  scope.joint_code="s_sp_income_";
				  scope.household_code="hh_income_";
				  break;
			  case 2:
				  scope.self_code="s_asset_";
				  scope.spouse_code="sp_asset_";
				  scope.joint_code="s_sp_asset_";
				  scope.household_code="hh_asset_";
				  break;
			  default:
				  scope.self_code="";
				  scope.spouse_code="";
				  scope.joint_code="";
				  scope.household_code="";
				  break;
		  }
	  }
	}
}]);
app.directive('ncoaLoader', function(){
    return {
        restrict: 'E',
        templateUrl: '/content/themes/ncoa/resources/views/directives/loader/loader.html?'+(new Date()),
        link: function(scope,element,attrs){
            
        }
    }    
});
app.directive('medicationSelector',['Drugs', function(Drugs){
	return {
		restrict: 'E',
		scope: {answer_field:"=answerField"},
		templateUrl: '/content/themes/ncoa/resources/views/directives/med-selector/medication-selector.html?'+(new Date()),
		link: function(scope, elm){

			Drugs.setDrugs(scope.answer_field.options);

			var drugs = Drugs.getDrugs();

			for(var i=0; i<drugs.length; i++) {
				var option = $("<option/>",{value:drugs[i].code, text:drugs[i].display});
				option.appendTo($("#multiselect"));
			}

			$("#multiselect").multiSelect({
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
					return Drugs.codeByName($(this).html());
				}).get();
				
				$('#multiselect').multiSelect('select', selected);
			});

			$('.ms-selection').on('click', 'button.remove', function(){
				var selected = $('.ms-selection .ms-list .selected span').map(function(){
					return Drugs.codeByName($(this).html());
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

app.directive('pageSwitch',['$state', 'prescreen', 'screening', 'saveScreening', 'ScreeningRoutes', function($state, prescreen, screening, saveScreening, ScreeningRoutes){
	return {
		link: function (scope, elm) {

			if ($state.params.category == undefined) {
				scope.prev = "prescreen.results";
				scope.next = "screening-start";
			} else {
				if ($state.current.name=="questionnaire.results") {
					scope.prev="finances";
					scope.next="basics";

				} else {
					scope.prev = ScreeningRoutes[$state.params.category].prev;
					scope.next = ScreeningRoutes[$state.params.category].next;
				}
			}

			scope.switchPage = function (stateName) {
				if ((stateName == "prescreen.results")||(stateName == "screening-start")) {
					$state.transitionTo(stateName);
				} else {

					var request = {};

					if (screening.data.results.screening.id != undefined) {
						request.screening = screening.data.results.screening;
					}

					request.pgno = ScreeningRoutes[$state.params.category].pgno;

					if (prescreen.data.results.screening.id != undefined) {
						request.prescreen = prescreen.data.results.screening;
					}


					if (stateName == "questionnaire.loader") {
						request.lastSet = "true";
					}

					request.answers = scope.$root.screening.answers[$state.params.category];

					saveScreening.post(request).success(function (data, status, headers, config) {
						if (stateName == "questionnaire.loader") {
							screening.data.answers = scope.$root.screening.answers;
							screening.data.results.screening = data.screening;
							screening.data.results.found_programs = data.found_programs;
							screening.data.results.key_programs = [];
							for (var i = 0; i < screening.data.results.found_programs.length; i++) {
								for (var j = 0; j < screening.data.results.found_programs[i].programs.length; j++) {
									if (screening.data.results.found_programs[i].programs[j].key_program) {
										var program = screening.data.results.found_programs[i].programs[j];
										program.category = screening.data.results.found_programs[i].category;
										screening.data.results.key_programs.push(program);
									}
								}
							}
							screening.save();
							$state.transitionTo('questionnaire.results');
						} else {
							screening.data.results.screening = data;
							screening.data.answers = scope.$root.screening.answers;
							screening.save();
							var stateId = ($state.params.state == undefined) ? scope.$root.prescreen.stateId : $state.params.state;
							$state.transitionTo("screening", {"category": stateName, "state": stateId});
						}
					});
				}

			}
		}
	}
}]);


app.directive('profile', ['prescreen', '$state', 'Drugs', 'CronicConditions', function (prescreen, $state, Drugs, CronicConditions) {
	return {
	  restrict: 'A',	  
	  templateUrl: '/content/themes/ncoa/resources/views/directives/profile/profile.html?'+(new Date()),
	  link: function (scope, element, attr) {
	  	scope.screenData = prescreen.data.screenData;
		//scope.questionnaire.prevScreening = prescreen.results.screening;
	  	scope.showOptions = ($state.current.name.split('.')[1] == "results" || $state.current.name.split(".")[1] == "initial-results");

		scope.cronicConditions = function() {
			try {
				return CronicConditions.getByCode(scope.questionnaire.request.health.chronic_condition == undefined ? "" : scope.questionnaire.request.health.chronic_condition);
			} catch (e) {
				return "";
			}
		}

		scope.drugs = function () {
			var retVal = "";
			try {
				for (var i=0; i<scope.questionnaire.request.health.drugs.length; i++) {
					retVal = retVal + Drugs.nameByCode(scope.questionnaire.request.health.drugs[i])+", ";
				}

			} catch (e) {
				retVal = ""
			}
			return retVal.substr(0,retVal.length-2);
		}

		scope.categories = function() {
			var retVal="";
			for (var i=0;i<scope.screenData.benefits_categories.length;i++) {
				retVal = retVal + scope.screenData.benefits_categories[i]+", ";
			}
			return retVal.substr(0,retVal.length-2)
		}

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

app.factory('questionTemplates',[function() {

	var directivePath = "/content/themes/ncoa/resources/views/directives/question/"; 

	var questionTemplates = {"zip":directivePath+"zip.html",
							 "client":directivePath+"client.html",
							 "veteran":directivePath+"veteran.html",
							 "dob":directivePath+"dob.html",
							 "marital_stat":directivePath+"marital_stat.html",
							 "bcuqc_income":directivePath+"bcuqc_income.html",
							 "bcuqc_interest_category":directivePath+"bcuqc_interest_category.html",
							 "sp_veteran":directivePath+"sp_veteran.html",
							 "incomegrid":directivePath+"incomegrid.html",
							 "assetgrid":directivePath+"assetgrid.html"};

	return questionTemplates;
}]);

app.directive('question',['questionTemplates', 'category', 'localStorageService', 'BenefitItems', function(questionTemplates, category, localStorageService, BenefitItems) {
	return {
		restrict: 'E',
		template:"<span ng-include='question_template_link'></span>",
		link: function(scope,element) {
			scope.category=category;
			if (questionTemplates[scope.question.code] == undefined) {
				scope.question_template_link = '/content/themes/ncoa/resources/views/directives/question/question.html?' + (new Date());
			} else {
				if ((localStorageService.get("interested_category") != undefined)&&(scope.question.code == "bcuqc_interest_category")) {
					if (localStorageService.get("interested_category") == "and_more") {
						scope.addProgram(BenefitItems.getByCode("bcuqc_category_transportation"));
						scope.addProgram(BenefitItems.getByCode("bcuqc_category_education"));
						scope.addProgram(BenefitItems.getByCode("bcuqc_category_discounts"));
						scope.addProgram(BenefitItems.getByCode("bcuqc_category_other_assistance"));
					} else {
						scope.addProgram(BenefitItems.getByCode(localStorageService.get("interested_category")));
					}
					localStorageService.remove("interested_category");
				}
				scope.question_template_link = questionTemplates[scope.question.code] + '?' + (new Date());
			}
		},
		scope: {
			question:"="
		},
		controller: "questionController"
	}
}]);

app.directive('answerfield',['$state', function($state){
	return {
		template:"<span ng-include='answer_field_link'></span>",
		link: function(scope, element, attributes, ngModel,ngShow) {
			scope.answer_field_link="/content/themes/ncoa/resources/views/directives/answer-field/"+scope.answer_field.type+".html?"+(new Date());
			scope.category = $state.params.category;
		},
		scope: {
			answer_field:"=answerField",
			question:"=question"
		}
	}
}]);

app.directive('ngLabel',['$compile',function($compile) {
	return {
		restrict: 'E',
		link: function (scope, element, attr) {
			element.html(scope.text);
		},
		scope: {
			text:"@"
		}
	}
}]);

app.directive('script',['localStorageService', function(localStorageService) {
	return {
		restrict: 'E',
		scope: false,
		link: function(scope, elem, attr) {
			if (attr.type === 'text/javascript-lazy') {
				var code = elem.text();
				var f = new Function(code);
				f();
			}
		}
	};
}]);

app.directive('textSizeChanger', ['$document', 'localStorageService', function ($document, localStorageService) {
	return {
	  restrict: 'E',
	  templateUrl: '/content/themes/ncoa/resources/views/directives/text-size-changer/text-size-changer.html?'+(new Date()),
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
app.directive('yearDrop',['category',function(category){
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
        template: '<select class="form-control inline" name="dob-year" ng-model="$root.answers[category][code]" ng-options="y for y in years"></select>',
        link: function(scope,element,attrs){
            scope.years = getYears(+attrs.offset, +attrs.range);
			scope.category = category;
			if (scope.$root.answers[category][scope.code] == undefined) {
				scope.$root.answers[category][scope.code] = scope.years[66];
			}
        },
		scope: {
			code:"@"
		}
    }    
}]);

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

app.directive('zipcode',['locationFinder', 'category', '$filter', 'localStorageService',  function(locationFinder, category, $filter, localStorageService){

	return {
		link: function(scope, elm){

			scope.category = category;

			scope.regPattern = "\\d{5}";
			scope.$root.isZipValid = true;
			scope.$root.isZipCodeValidating = false;

			scope.updateZip = function(){
				scope.$root.isZipCodeValidating = true;
				locationFinder.getLocation(scope.$root.answers[category].zip).success(function(data, status, headers, config) {
					validateZip(data);
					scope.$root.isZipCodeValidating = false;
				});
			};


			if (localStorageService.get('v_zipcode') != undefined) {
				scope.zipCodeLabel = "Update Zip Code";
				scope.$root.answers[scope.category].zip = localStorageService.get('v_zipcode');
				localStorageService.remove('v_zipcode');
				scope.updateZip();
			} else {
				scope.zipCodeLabel = "Find Zip Code";
			}



			scope.resetZip = function(){
				scope.$root.isZipEdit = true;
				$('#zipcode').focus();
			}

			function validateZip(data){
				if (scope.$root.answers[category].zip.length != 5) {
					scope.$root.isZipValid = false;
					scope.$parent.zipCodeCheckResult = "Error!"
					scope.$parent.zipCodeDescription = "Please enter a valid zipcode in the United States";
					scope.$parent.zipCodeUpdated=true;
					return;
				}
				if(data.status == "OK"){
					if(data.results[0].address_components[0].short_name != "Undefined" && data.results[0].formatted_address.lastIndexOf("US") != -1){				
						scope.$root.answers[category].zipcode = data.results[0].address_components[0].long_name;
						for (var i=1;i<data.results[0].address_components.length;i++) {
							if (data.results[0].address_components[i].types.indexOf("administrative_area_level_1") > -1) {
								scope.$root.answers[category].stateId = data.results[0].address_components[i].short_name;
								scope.zipCodeLabel = "Update Zip Code";
								continue;
							}
						}

				  		scope.$root.answers[category].zipcode_formatted = $filter('limitTo')(data.results[0].formatted_address, data.results[0].formatted_address.lastIndexOf(','), 0);
				  		scope.$root.isZipValid = true;
						scope.$parent.zipCodeCheckResult = "Success!"
						scope.$parent.zipCodeDescription = scope.$root.answers[category].zipcode_formatted;
					}else{
						scope.$root.isZipValid = false;
						scope.$parent.zipCodeCheckResult = "Error!"
						scope.$parent.zipCodeDescription = "Please enter a valid zipcode in the United States";
					}
				}else{
					scope.$root.isZipValid = false;
					scope.$parent.zipCodeCheckResult = "Error!"
					scope.$parent.zipCodeDescription = "Please enter a valid zipcode in the United States";
				}
				scope.$parent.zipCodeUpdated=true;
			}
		}
	}
}]);

app.factory('BenefitItems', [function(){

	var BenefitItems = {};

	var _BenefitItems = [
		{
			name: 'Medications',
			code: 'bcuqc_category_rx',
			image: '/content/themes/ncoa/resources/assets/images/categories/category_medicine.svg'
		},
		{
			name: 'Healthcare',
			code: 'bcuqc_category_medicaid',
			image: '/content/themes/ncoa/resources/assets/images/categories/category_health.svg'
		},
		{
			name: 'Income Assistance',
			code: 'bcuqc_category_income',
			image: '/content/themes/ncoa/resources/assets/images/categories/category_income.svg'
		},
		{
			name: 'Food and Nutrition',
			code: 'bcuqc_category_nutrition',
			image: '/content/themes/ncoa/resources/assets/images/categories/category_food.svg'
		},
		{
			name: 'Housing and Utilities',
			code: 'bcuqc_category_utility',
			image: '/content/themes/ncoa/resources/assets/images/categories/category_housing.svg'
		},
		{
			name: 'Tax Relief',
			code: 'bcuqc_category_property_taxrelief',
			image: '/content/themes/ncoa/resources/assets/images/categories/category_taxRelief.svg'
		},
		{
			name: 'Veteran',
			code: 'bcuqc_category_veteran',
			image: '/content/themes/ncoa/resources/assets/images/categories/category_veteran.svg'
		},
		{
			name: 'Employment',
			code: 'bcuqc_category_employment',
			image: '/content/themes/ncoa/resources/assets/images/categories/category_employment.svg'
		},
		{
			name: 'Transportation',
			code: 'bcuqc_category_transportation',
			image: '/content/themes/ncoa/resources/assets/images/categories/category_transportation.svg'
		},
		{
			name: 'Education',
			code: 'bcuqc_category_education',
			image: '/content/themes/ncoa/resources/assets/images/categories/category_education.svg'
		},
		{
			name: 'Discounts',
			code: 'bcuqc_category_discounts',
			image: '/content/themes/ncoa/resources/assets/images/categories/category_discounts.svg'
		},
		{
			name: 'Other Assistance',
			code: 'bcuqc_category_other_assistance',
			image: '/content/themes/ncoa/resources/assets/images/categories/category_assistance.svg'
		}
	];

	BenefitItems.getBenefitItems = function() {
		return _BenefitItems;
	};

	BenefitItems.getByCode = function(code) {
		for(var i=0;i<_BenefitItems.length;i++) {
			if (_BenefitItems[i].code == code) return _BenefitItems[i];
		}
		return undefined;
	}

	BenefitItems.programsInStructure = function(struct) {
		var retVal = 0;
		for (var i in struct) {
			if (BenefitItems.getByCode(i) != undefined) retVal++;
		}
		return retVal;
	}

	return BenefitItems;
}]);

app.factory('ScreeningRoutes',[function() {

	var ScreeningParts = {};

	var _routes = {};
	_routes.basics = {"prev":"prescreen.results", "next":"health", pgno:1};
	_routes.health = {"prev":"basics", "next":"household", pgno:2};
	_routes.household = {"prev":"health", "next":"finances", pgno:3};
	_routes.finances = {"prev":"household", "next":"questionnaire.loader", pgno:4};

	_routes.default="basics";

	return _routes;
}]);

app.factory('Drugs',[function() {

	var Drugs = {};

	var _drugs = [];

	Drugs.setDrugs = function(drugs) {
		_drugs = drugs;
	}

	Drugs.getDrugs = function() {
		return _drugs;
	}

	Drugs.nameByCode = function(code) {
		for(var i=0;i<_drugs.length;i++) {
			if (_drugs[i].code==code) return _drugs[i].display;
		}
		return undefined;
	};

	Drugs.codeByName = function(name) {
		for(var i=0;i<_drugs.length;i++) {
			if (_drugs[i].display==name) return _drugs[i].code;
		}
		return undefined;
	}

	return Drugs;
}]);


app.service('locationFinder', ['$http', function($http){
	var urlBase = '//maps.googleapis.com/maps/api/geocode/json';

	this.getLocation = function(zipcode){
		return $http.get(urlBase + '?address=' + zipcode + '&sensor=true');
	}
}]);

app.service('savePrescreen',['$http', function($http){
	this.post = function (data) {
		return $http.post(window.webServiceUrl+'/rest/backend/screening/savePrescreen',data,{
			headers:
			{
				'Content-Type': 'text/plain; charset=UTF-8'
			}
		});
	}
}]);

app.service('saveScreening',['$http', function($http){
	this.post = function (data) {
		return $http.post(window.webServiceUrl+'/rest/backend/screening/saveScreening',data,{
			headers:
			{
				'Content-Type': 'text/plain; charset=UTF-8'
			}
		});
	}
}]);

app.service('prescreenQuestions',['$http', function ($http) {
	this.get = function() {
		return $http.get(window.webServiceUrl+'/rest/backend/questionnaire/prescreen');
	}
}]);

app.service('screeningQuestions',['$http', function ($http) {
	this.get = function(category,state) {
		return $http.get(window.webServiceUrl+'/rest/backend/questionnaire/'+category+'/'+state);
	}
}]);

app.factory('prescreen', ['localStorageService', function(localStorageService){
	var prescreenform = {};

	var _data = localStorageService.get('prescreen');

	if (_data == undefined) {
		prescreenform.data = {};
	} else {
		prescreenform.data = _data;
	}

	if (prescreenform.data.answers == undefined) {
		prescreenform.data.answers = {};
	}

	prescreenform.save = function() {
		localStorageService.set('prescreen', prescreenform.data);
	};

	prescreenform.clear = function() {
		localStorageService.remove('prescreen');
	};

	return prescreenform;
}]);

app.factory('screening', ['localStorageService', function(localStorageService) {
	var screening = {};

	var _data = localStorageService.get('screening');

	if (_data == undefined) {
		_data = {};
		_data.questions = {};
		_data.answers = {};
		_data.results = {};
		_data.results.screening = {};
	} else if (_data.answers == undefined) {
		_data.answers = {};
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

app.factory('questionnaire', ['Income', 'Asset', function(Income, Asset){
	var questionnaire = {}

	questionnaire.incomes = Income.getIncomes();
	questionnaire.assets = Asset.getAssets();

	return questionnaire;
}]);

app.controller('questionController',['$scope', 'category', 'BenefitItems', function($scope, category, BenefitItems){

	$scope.category = category;

	$scope.months = [{id:1,name:"January"},{id:2,name:"February"},{id:3,name:"March"},{id:4,name:"April"},
		{id:5,name:"May"},{id:6,name:"June"},{id:7,name:"July"},{id:8,name:"August"},
		{id:9,name:"September"},{id:10,name:"October"},{id:11,name:"November"},{id:12,name:"December"}];

	$scope.programs = BenefitItems.getBenefitItems();
	$scope.selectLinkText = "Select All";

	$scope.showSpouseVeteranStatus = function(){
		if ($scope.$root.answers[category].marital_stat == undefined) {
			return false;
		} else {
			return (($scope.$root.answers[category].marital_stat.code == 'married' || $scope.$root.answers[category].marital_stat.code == 'married_living_sep' || $scope.$root.answers[category].marital_stat.code == 'widowed') && $scope.$root.answers[category].veteran == 'n');
		}
	}

	$scope.showBenefits = function(){
		if ($scope.$root.answers[category].marital_stat == undefined) {
			return false;
		} else {
			if ((($scope.$root.answers[category].marital_stat.code == 'married' || $scope.$root.answers[category].marital_stat.code == 'married_living_sep' || $scope.$root.answers[category].marital_stat.code == 'widowed') && $scope.$root.answers[category].veteran == 'y')) {
				return true;
			} else if ((($scope.$root.answers[category].marital_stat.code == 'married' || $scope.$root.answers[category].marital_stat.code == 'married_living_sep' || $scope.$root.answers[category].marital_stat.code == 'widowed') && $scope.$root.answers[category].veteran == 'n') && $scope.$root.answers[category].sp_veteran) {
				return true;
			} else if (($scope.$root.answers[category].marital_stat.code == 'divorced' || $scope.$root.answers[category].marital_stat.code == 'single') && $scope.$root.answers[category].veteran) {
				return true;
			} else {
				return false;
			}
		}
	}

	$scope.addProgram = function(program){

		var benefitindex = $scope.$root.answers[category][program.code];
		if(benefitindex == undefined){
			$scope.$root.answers[category][program.code] = 'y';
		}else{
			delete $scope.$root.$root.answers[category][program.code];
		}

		if (BenefitItems.programsInStructure($scope.$root.answers[category]) == $scope.programs.length) {
			$scope.selectLinkText = "Deselect All";
		} else {
			$scope.selectLinkText = "Select All";
		}
	}

	$scope.programAdded = function(programCode) {
		return $scope.$root.$root.answers[category][programCode] != undefined;
	}

	$scope.selectAll = function(){
		if(BenefitItems.programsInStructure($scope.$root.answers[category]) == $scope.programs.length){
			for (var i=0;i<$scope.programs.length;i++) {
				delete $scope.$root.$root.answers[category][$scope.programs[i].code];
			}
			$('.benefits-selector-repeater').removeClass('checked');
			$scope.selectLinkText = "Select All";
		}else {
			for (var i=0;i<$scope.programs.length;i++) {
				$scope.$root.answers[category][$scope.programs[i].code] = 'y';
			}
			$('.benefits-selector-repeater').addClass('checked');
			$scope.selectLinkText = "Deselect All";
		}
	}

}]);

app.controller('preScreenController', ['$scope', 'localStorageService', 'prescreen', 'locationFinder', 'savePrescreen', '$timeout', '$state', 'BenefitItems', function($scope, localStorageService, prescreen, locationFinder, savePrescreen, $timeout, $state, BenefitItems){

	$scope.category = "prescreen";

	if(prescreen.data.questions == undefined) $state.transitionTo('prescreen');

	$scope.sibmitDisabled = true;

	if ($scope.$root.prescreen == undefined) {
		$scope.$root.prescreen = {};
		$scope.$root.prescreen.programList = {};
	}

	$('.glyphicon-question-sign').popover();
	$scope.questions = prescreen.data.questions;
	$scope.canContinue = true;
	$scope.showquestions = false;
	$scope.$root.prescreen.showCTA = true;

	$scope.submitPrescreen = function() {

		$scope.sibmitDisabled = true;

		prescreen.data.screenData = {};

		prescreen.data.screenData.formatted_address = $scope.$root.answers[$scope.category].zipcode_formatted;

		prescreen.data.screenData.searchingFor = $scope.$root.answers[$scope.category].client.display;

		prescreen.data.screenData.date_of_birth = {
			"month": $scope.$root.answers[$scope.category].dob_month.name,
			"year": $scope.$root.answers[$scope.category].dob_year
		};

		prescreen.data.screenData.marital_status = $scope.$root.answers[$scope.category].marital_stat.display;

		prescreen.data.screenData.veteran = (($scope.$root.answers[$scope.category].veteran == "y") || ($scope.$root.answers[$scope.category].sp_veteran == "y")) ? "Yes" : "No";

		prescreen.data.screenData.benefits_categories = [];

		for (var programCatCode in $scope.$root.answers[$scope.category]) {
			if (BenefitItems.getByCode(programCatCode) != undefined)
			prescreen.data.screenData.benefits_categories.push(BenefitItems.getByCode(programCatCode).name);
		}


		var request = $scope.$root.answers[$scope.category];

		request.state_id = $scope.$root.answers[$scope.category].stateId;
		request.st = $scope.$root.answers[$scope.category].stateId;

		savePrescreen.post(request).success(function(data, status, headers, config) {
			$scope.sibmitDisabled = false;
			prescreen.data.answers = $scope.$root.answers[$scope.category];
			prescreen.data.results = data;

			prescreen.save();

			$state.go('prescreen.results');
		});
	}

	$scope.$watch('$root.answers.'+$scope.category+'.client', function(){
		if (($scope.$root.answers[$scope.category].client != undefined) && (!$('.dob').is(":visible"))) {
			setTimeout(function () {
				var test = document.querySelector('.dob');
				if (test != undefined) {
					$('html,body').animate({
						scrollTop: $(test).offset().top - 100 + 'px'
					}, 500);
				}
			}, 500);
		}
	});

	$scope.$watch('$root.answers.'+$scope.category+'.dob_year', function(){
		if($scope.$root.answers[$scope.category].dob_month != undefined && !$('.income').is(":visible")){
			setTimeout(function() {
				var test = document.querySelector('.income');
				if (test != undefined) {
					$('html,body').animate({
						scrollTop: $(test).offset().top - 100 + 'px'
					}, 500);
				}
			}, 500);
		}
	});

	$scope.$watch('$root.answers.'+$scope.category+'.dob_month', function(){
		if($scope.$root.answers[$scope.category].dob_year != undefined && !$('.income').is(":visible")){
			setTimeout(function(){
				var test = document.querySelector('.income');
				if (test != undefined) {
					$('html,body').animate({
						scrollTop: $(test).offset().top - 100 + 'px'
					}, 500);
				}
			}, 500);
		}
	});

	$scope.$watch('$root.answers.'+$scope.category+'.bcuqc_income', function(){
		if(($scope.$root.answers[$scope.category].bcuqc_income != undefined) && !$('.marital-status').is(":visible")){
			setTimeout(function(){
				var test = document.querySelector('.marital-status');
				if (test != undefined) {
					$('html,body').animate({
						scrollTop: $(test).offset().top - 100 + 'px'
					}, 500);
				}
			}, 500);
		}
	});

	$scope.$watch('$root.answers.'+$scope.category+'.marital_stat', function(){
		if(($scope.$root.answers[$scope.category].marital_stat != undefined) && !$('.veteran-status').is(":visible")){
			setTimeout(function(){
				var test = document.querySelector('.veteran-status');
				if (test != undefined) {
					$('html,body').animate({
						scrollTop: $(test).offset().top - 100 + 'px'
					}, 500);
				}
			}, 500);
		}
	});

	$scope.$watch('$root.answers.'+$scope.category+'.veteran', function(){
		var marital_stat = $scope.$root.answers[$scope.category].marital_stat;
		var veteran = $scope.$root.answers[$scope.category].veteran;
		if (marital_stat != undefined) {
			if ((marital_stat.code == "married" ||
				marital_stat.code == "married_living_sep" ||
				marital_stat.code == "widowed") &&
				veteran == "n" &&
				!$('.partner-veteran-status').is(":visible")) {
				
				setTimeout(function () {
					var test = document.querySelector('.partner-veteran-status');
					if (test != undefined) {
						$('html,body').animate({
							scrollTop: $(test).offset().top - 100 + 'px'
						}, 500);
					}
				}, 500);
			} else if ((marital_stat.code == "married" ||
				marital_stat.code == "married_living_sep" ||
				marital_stat.code == "widowed") &&
				veteran == "y" &&
				!$('.benefits').is(":visible")) {
				
				$scope.sibmitDisabled = false;
				setTimeout(function () {
					var test = document.querySelector('.veteran-status .cta');
					if (test != undefined) {
						$('html,body').animate({
							scrollTop: $(test).offset().top - 10 + 'px'
						}, 500);
					}
				}, 500);
			} else if ((marital_stat.code == "married" ||
				marital_stat.code == "married_living_sep" ||
				marital_stat.code == "widowed") &&
				veteran == "n" &&
				!$('.benefits').is(":visible")) {
				
				$scope.sibmitDisabled = false;
				setTimeout(function () {
					var test = document.querySelector('.benefits');
					if (test != undefined) {
						$('html,body').animate({
							scrollTop: $(test).offset().top - 100 + 'px'
						}, 500);
					}
				}, 500);
			} else if ((
				marital_stat.code == "divorced" ||
				marital_stat.code == "single") &&
				veteran == "y" &&
				!$('.benefits').is(":visible")) {
				
				$scope.sibmitDisabled = false;
				setTimeout(function () {
					var test = document.querySelector('.veteran-status .cta');
					if (test != undefined) {
						$('html,body').animate({
							scrollTop: $(test).offset().top - 10 + 'px'
						}, 500);
					}
				}, 500);
			} else if ((
				marital_stat.code == "divorced" ||
				marital_stat.code == "single") &&
				veteran == "n" &&
				!$('.benefits').is(":visible")) {
				
				$scope.sibmitDisabled = false;
				setTimeout(function () {
					var test = document.querySelector('.benefits');
					if (test != undefined) {
						$('html,body').animate({
							scrollTop: $(test).offset().top - 100 + 'px'
						}, 500);
					}
				}, 500);
			}
		}
	});

	$scope.$watch('$root.answers.'+$scope.category+'sp_veteran', function(){
		if(($scope.$root.answers[$scope.category].sp_veteran != undefined) && !$('.benefits').is(":visible")){
			$scope.sibmitDisabled = false;
			setTimeout(function(){
				var test = document.querySelector('.benefits');
				$('html,body').animate({
					scrollTop: $(test).offset().top-100 + 'px'
				}, 500);
			}, 500);
		}
	});

	$scope.disableSubmit = function(){
			return $scope.sibmitDisabled || BenefitItems.programsInStructure($scope.$root.answers[$scope.category]) == 0;
	};

}]);

app.controller('preScreenInitalController', ['$scope', '$state', 'prescreenQuestions', 'prescreen', function($scope, $state, prescreenQuestions, prescreen){

	if ($scope.$root.answers == undefined) {
		$scope.$root.answers = {};
	}

	$scope.$root.answers.prescreen = prescreen.data.answers;

	prescreenQuestions.get().success(function(data, status, headers, config) {
		prescreen.data.questions = data;
		if($state.current.name == "prescreen") $state.transitionTo('prescreen.questions',{category:"prescreen"});
	});
}]);

app.controller('preScreenResultsController', ['$scope', 'prescreen','$location','$state', function($scope, prescreen, $location, $state){

	$('.fa-question-circle').popover();


	
	document.querySelector('.page-wrapper').scrollIntoView();
	
	$scope.tooltipAccuracy = "You will receive more accurate results if you provide more details.";
	$scope.tooltipExpenses = "Expenses are the amount of money you spend on things like rent, utilities, and other costs of living."

	$scope.nextPage = function(url){
		$state.go(url);
	}

	var el = document.querySelector('.odometer');

	od = new Odometer({
	  el: el,
	  value: 0,
	});

	var foundCount = 0;

	for (var i=0; i<prescreen.data.results.found_programs.length; i++) {
		foundCount = foundCount + prescreen.data.results.found_programs[i].count;
	}

	od.update(foundCount);
}]);

app.controller('questionnaireBasicController', ['$scope','$state', 'questionnaire', function($scope, $state, questionnaire){

	$('.fa-question-circle').popover();

	$scope.tooltip = {
		"race": "Why are we asking? This question is optional, and does not affect your results. Your answer will help us understand how best to reach people who can benefit from this service."
	};

	$scope.genders = [{id:"male",   name:"Male"},
		              {id:"female", name:"Female"}];

	$scope.citizens = [{id:"citizen",         name:"Citizen"},
					   {id:"legal_resident",  name:"Legal Resident"},
					   {id:"qualified_alien", name:"Other Qualified Alien"},
					   {id:"other_citizen",   name:"Other"}];

	$scope.receives = [{id:"medicare_receive",    name:"Medicare (currently enrolled or expect to be within the next 3 months)"},
					   {id:"receive_partd",       name:"Medicare Prescription Drug Plan (Part D)"},
					   {id:"receive_lis",         name:"Extra Help/LIS through Medicare Prescription Drug Coverage"},
					   {id:"med_receive",         name:"Medicaid"},
					   {id:"receive_msp",         name:"Medicare Savings Programs (QMB, SLMB, or QI)"},
					   {id:"snap_receive",        name:"Supplemental Nutrition Assistance Program (SNAP)"},
					   {id:"ssi_receive",         name:"Supplemental Security Income (SSI)"},
					   {id:"rec_tricare",         name:"TRICARE"},
					   {id:"receive_va",          name:"Veteran's Health Care Benefits"},
					   {id:"liheap_receive",      name:"Low Income Home Energy Assistance Program (LIHEAP)"},
					   {id:"receive_pub_housing", name:"Public Housing"},
					   {id:"receive_section_8",   name:"Housing Choice Vouchers (Section 8)"},
					   {id:"scsep_receive",       name:"Senior Community Service Employment Program (SCSEP)"}];

	$scope.races = [{id:"white",                           name:"White"},
					{id:"african_american",                name:"Black or African-American"},
					{id:"american_indian_native_alaskans", name:"American Indian or Alaska Native"},
					{id:"asian",                           name:"Asian or Asian-American"},
					{id:"pacific_islander",                name:"Native Hawaiian or Other Pacific Islander"},
					{id:"hispanic",                        name:"Hispanic, Latino, or Spanish Origin"},
					{id:"other_race",                      name:"Other"}];

	
}]);

app.controller('questionnaireController', ['$scope','$state', 'questionnaire', function($scope, $state, questionnaire){
	
	$scope.questionnaire = questionnaire;

	if ($scope.questionnaire.request == undefined) {
		$scope.questionnaire.request = {};
	}

	if($state.current.name == "questionnaire")
		$state.transitionTo('questionnaire.basics');
	
}]);

app.controller('screeningController', ['$scope', '$state', 'prescreen', 'screening', 'screeningQuestions', function($scope, $state, prescreen, screening, screeningQuestions){
	if ($scope.$root.screening == undefined) {
		$scope.$root.screening = screening.data;
		if ($state.params.category != undefined) {
			if ($scope.$root.screening.answers[$state.params.category] == undefined) {

			}
		}
	}

	if (($state.params.category != undefined) && ($state.params.state != undefined)) {

		$scope.category = $state.params.category;

		if ($scope.$root.screening.answers[$state.params.category] == undefined) {
			$scope.$root.screening.answers[$state.params.category] = {};
		}

		screeningQuestions.get($state.params.category,$state.params.state).success(function(data){
			screening.data.questions[$state.params.category] = data;
			$scope.$root.screening.questions[$state.params.category] = data;
		});
	} else {
		$state.transitionTo('screening',{category:"basics",state:prescreen.data.answers.stateId});
	}
}]);

app.controller('questionnaireFinancesController', ['$scope','Income', function($scope, Income){
	

	$scope.income_total = function(type) {
		var retValTotal = 0;
		var retValUnearned = 0;
		for (var i in $scope.questionnaire.request['finances-income-grid']) {
			if ((i.indexOf(type)==0) && (i.indexOf('total_complete')==-1) && (i.indexOf('total_unearned')==-1)) {
				retValTotal = retValTotal + $scope.questionnaire.request['finances-income-grid'][i];
				if (Income.isUnearned(i.replace(type,""))) {
					retValUnearned = retValUnearned + $scope.questionnaire.request['finances-income-grid'][i];
				}
			}
		}
		if ($scope.questionnaire.request['income-totals'] == undefined) $scope.questionnaire.request['income-totals'] = {};
		$scope.questionnaire.request['income-totals'][type+"total_complete"] = retValTotal;
		$scope.questionnaire.request['income-totals'][type+"total_unearned"] = retValUnearned;
		return retValTotal;
	}


	$scope.assets_total = function(type) {
		var retVal = 0;
		for (var i in $scope.questionnaire.request['finances-assets-grid']) {
			if ((i.indexOf(type)==0) && (i.indexOf('total_complete')==-1)) {
				retVal = retVal + $scope.questionnaire.request['finances-assets-grid'][i];
			}
		}
		if ($scope.questionnaire.request['assets-totals'] == undefined) $scope.questionnaire.request['assets-totals'] = {};
		$scope.questionnaire.request['assets-totals'][type+"total_complete"] = retVal;
		return retVal;
	}

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
app.controller('questionnaireHealthController', ['$scope', 'questionnaire', /*'Drugs',*/ 'CronicConditions', function($scope, questionnaire, /*Drugs,*/ CronicConditions){
	
	//$scope.drugs = Drugs.getDrugs();

	$scope.chronicConditions = CronicConditions.getCronicConditions();



}]);
app.controller('questionnaireHouseholdController', ['$scope', 'questionnaire', function($scope, questionnaire){

	$scope.housings = [{id:"own_home",           name:"Own Home"},
					   {id:"rent_dwelling",      name:"Rental"},
					   {id:"own_mobile_home",    name:"Own Mobile Home"},
					   {id:"boarding_home",      name:"Boarding Home"},
					   {id:"live_with_others",   name:"Live with Others"},
					   {id:"nursing_facility",   name:"Nursing Facility"},
					   {id:"assisted_living",    name:"Assisted Living"},
					   {id:"subsidized_housing", name:"Low-Income Housing"},
					   {id:"homeless_shelter",   name:"Homeless or Live in a Shelter"}];
	
}]);
app.controller('questionnaireLoaderController', ['$scope', '$state', function($scope, $state){	
	$('.btns-container').hide();
	$('.card-nested').addClass('loader');

	$scope.$on('$stateChangeStart', function(event, toState, toParams, fromState, fromParams, options) {
		$('.btns-container').show();
		$('.card-nested').removeClass('loader');
	});
	
}]);
app.controller('questionnairePrescreenResultsController', ['$scope', '$state', 'prescreen', function($scope, $state, prescreen){
	var el = document.querySelector('.odometer');

	od = new Odometer({
	  el: el,
	  value: 0
	});

	$scope.found_programs = prescreen.data.results.found_programs;

	var foundCount = 0;

	for (var i=0; i<prescreen.data.results.found_programs.length; i++) {
		foundCount = foundCount + prescreen.data.results.found_programs[i].count;
	}

	od.update(foundCount);

	
	document.querySelector('.page-wrapper h1').scrollIntoView();

}]);

app.directive('divProgramsCategory',['BenefitItems', 'prescreen', function(BenefitItems,prescreen) {
	return {
		restrict: 'E',
		templateUrl:'/content/themes/ncoa/resources/views/directives/program/programs.category.html?'+(new Date()),
		link: function(scope, element) {
			scope.benefitItem = BenefitItems.getByCode(scope.found_program.category);
			scope.stateId = prescreen.data.answers.stateId;
			scope.zipcode = prescreen.data.answers.zip;
		},
		scope: {
			found_program:"=foundProgram",
			short:"@"
		}
	}
}]);

app.directive("divKeyProgram",['prescreen',function(prescreen) {
	return {
		restrict: 'E',
		templateUrl:'/content/themes/ncoa/resources/views/directives/program/programs.key-program.html?'+(new Date()),
		scope: {
			program:"=program"
		},
		link: function(scope,element) {
			scope.stateId = prescreen.data.answers.stateId;
			scope.zipcode = prescreen.data.answers.zip;
			scope.subString = function(string) {
				if (string.length>70) {
					return string.substring(0,70)+"...";
				} else {
					return string;
				}
			}
		}
	}
}]);

app.directive('divProgramDesc',function() {
	return {
		restrict: 'E',
		//templateUrl:'/content/themes/ncoa/resources/views/pages/benefits-checkup/programs/programs.category.html?'+(new Date()),
		link: function(scope, element) {
			element.append("<p>"+scope.program_desc+"</p>");
		},
		scope: {
			program_desc:"=programDesc"
		}
	}
});

app.controller('questionnaireResultsController', ['$scope', '$state', 'screening', function($scope, $state, screening){
	var el = document.querySelector('.odometer');

	od = new Odometer({
		el: el,
		value: 0
	});

	var odValue = 0;

	for (var i=0; i<screening.data.results.found_programs.length;i++) {
		odValue = odValue + screening.data.results.found_programs[i].count;
	}

	od.update(odValue);

	$scope.key_programs = screening.data.results.key_programs;
	$scope.found_programs = screening.data.results.found_programs;

	document.querySelector('.page-wrapper h1').scrollIntoView();

}]);


app.controller('zipCodeController', ['$scope', '$http', '$window', 'localStorageService', 'locationFinder', '$state', function($scope, $http, $window, localStorageService, locationFinder, $state){	


	$scope.findZip = function(zip){

		if (zip.length != 5) {
			$scope.isZipInvalid=true;
			return;
		} else {
			$scope.isZipInvalid=false;
		}

		locationFinder.getLocation(zip).success(function(data, status, headers, config) {

			if(data.results[0].address_components[0].short_name != "Undefined" && data.results[0].formatted_address.lastIndexOf("US") != -1){
				localStorageService.set('v_zipcode', data.results[0].address_components[0].long_name);
				$window.location.href = '/find-my-benefits';
			} else {
				$scope.isZipInvalid=true;
			}
   	 	});
	}

}]);


app.filter('unsafe', function($sce) { return $sce.trustAsHtml; });



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
		'url':'/fact-sheets/factsheet_nutrition_al_snap_program/', //Goto URL
		'target':'same_window', //open link in new window:new_window, open in current window:same_window, or none for nothing.
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D', //state's color when mouse hover
		'downColor':'#FFEE88',//state's color when mouse clicking
		'enable':true,//true/false to enable/disable this state
	},
	'map_2':{
		'hover': 'ALASKA',
		'url':'/fact-sheets/factsheet_nutrition_ak_snap_program/',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true
	},
	'map_3':{
		'hover': 'ARIZONA',
		'url':'/fact-sheets/factsheet_nutrition_az_snap_program/',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_4':{
		'hover': 'ARKANSAS',
		'url':'/fact-sheets/factsheet_nutrition_ar_snap_program/',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_5':{
		'hover': 'CALIFORNIA',
		'url':'/fact-sheets/factsheet_nutrition_ca_snap_program/',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_6':{
		'hover': 'COLORADO',
		'url':'/fact-sheets/factsheet_nutrition_co_snap_program/',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_7':{
		'hover': 'CONNECTICUT',
		'url':'/fact-sheets/factsheet_nutrition_ct_snap_program/',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_8':{
		'hover': 'DELAWARE',
		'url':'/fact-sheets/factsheet_nutrition_de_snap_program/',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_9':{
		'hover': 'FLORIDA',
		'url':'/fact-sheets/factsheet_nutrition_fl_snap_program/',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_10':{
		'hover': 'GEORGIA',
		'url':'/fact-sheets/factsheet_nutrition_ga_snap_program/',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_11':{
		'hover': 'HAWAII',
		'url':'/fact-sheets/factsheet_nutrition_hi_snap_program/',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_12':{
		'hover': 'IDAHO',
		'url':'/fact-sheets/factsheet_nutrition_id_snap_program/',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_13':{
		'hover': 'ILLINOIS',
		'url':'/fact-sheets/factsheet_nutrition_il_snap_program/',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_14':{
		'hover': 'INDIANA',
		'url':'/fact-sheets/factsheet_nutrition_in_snap_program/',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_15':{
		'hover': 'IOWA',
		'url':'/fact-sheets/factsheet_nutrition_ia_snap_program/',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_16':{
		'hover': 'KANSAS',
		'url':'/fact-sheets/factsheet_nutrition_ks_snap_program/',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_17':{
		'hover': 'KENTUCKY',
		'url':'/fact-sheets/factsheet_nutrition_ky_snap_program/',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_18':{
		'hover': 'LOUISIANA',
		'url':'/fact-sheets/factsheet_nutrition_la_snap_program/',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_19':{
		'hover': 'MAINE',
		'url':'/fact-sheets/factsheet_nutrition_me_snap_program/',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_20':{
		'hover': 'MARYLAND',
		'url':'/fact-sheets/factsheet_nutrition_md_snap_program/',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_21':{
		'hover': 'MASSACHUSETTS',
		'url':'/fact-sheets/factsheet_nutrition_ma_snap_program/',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_22':{
		'hover': 'MICHIGAN',
		'url':'/fact-sheets/factsheet_nutrition_mi_snap_program/',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_23':{
		'hover': 'MINNESOTA',
		'url':'/fact-sheets/factsheet_nutrition_mn_snap_program/',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_24':{
		'hover': 'MISSISSIPPI',
		'url':'/fact-sheets/factsheet_nutrition_ms_snap_program/',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_25':{
		'hover': 'MISSOURI',
		'url':'/fact-sheets/factsheet_nutrition_mo_snap_program/',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_26':{
		'hover': 'MONTANA',
		'url':'/fact-sheets/factsheet_nutrition_mt_snap_program/',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_27':{
		'hover': 'NEBRASKA',
		'url':'/fact-sheets/factsheet_nutrition_ne_snap_program/',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_28':{
		'hover': 'NEVADA',
		'url':'/fact-sheets/factsheet_nutrition_nv_snap_program/',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_29':{
		'hover': 'NEW HAMPSHIRE',
		'url':'/fact-sheets/factsheet_nutrition_nh_snap_program/',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_30':{
		'hover': 'NEW JERSEY',
		'url':'/fact-sheets/factsheet_nutrition_nj_snap_program/',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_31':{
		'hover': 'NEW MEXICO',
		'url':'/fact-sheets/factsheet_nutrition_nm_snap_program/',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_32':{
		'hover': 'NEW YORK',
		'url':'/fact-sheets/factsheet_nutrition_ny_snap_program/',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_33':{
		'hover': 'NORTH CAROLINA',
		'url':'/fact-sheets/factsheet_nutrition_nc_snap_program/',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_34':{
		'hover': 'NORTH DAKOTA',
		'url':'/fact-sheets/factsheet_nutrition_nd_snap_program/',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_35':{
		'hover': 'OHIO',
		'url':'/fact-sheets/factsheet_nutrition_oh_snap_program/',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_36':{
		'hover': 'OKLAHOMA',
		'url':'/fact-sheets/factsheet_nutrition_ok_snap_program/',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_37':{
		'hover': 'OREGON',
		'url':'/fact-sheets/factsheet_nutrition_or_snap_program/',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_38':{
		'hover': 'PENNSYLVANIA',
		'url':'/fact-sheets/factsheet_nutrition_pa_snap_program/',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_39':{
		'hover': 'RHODE ISLAND',
		'url':'/fact-sheets/factsheet_nutrition_ri_snap_program/',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_40':{
		'hover': 'SOUTH CAROLINA',
		'url':'/fact-sheets/factsheet_nutrition_sc_snap_program/',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#FFEE88',
		'enable':true,
	},
	'map_41':{
		'hover': 'SOUTH DAKOTA',
		'url':'/fact-sheets/factsheet_nutrition_sd_snap_program/',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#FFEE88',
		'enable':true,
	},
	'map_42':{
		'hover': 'TENNESSEE',
		'url':'/fact-sheets/factsheet_nutrition_tn_snap_program/',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_43':{
		'hover': 'In Texas, over <strong>333,000 people</strong> are using SNAP to stretch their grocery budget. Are you?',
		'url':'/fact-sheets/factsheet_nutrition_tx_snap_program/',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_44':{
		'hover': 'UTAH',
		'url':'/fact-sheets/factsheet_nutrition_ut_snap_program/',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_45':{
		'hover': 'VERMONT',
		'url':'/fact-sheets/factsheet_nutrition_vt_snap_program/',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_46':{
		'hover': 'VIRGINIA',
		'url':'/fact-sheets/factsheet_nutrition_va_snap_program/',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true, 
	},
	'map_47':{
		'hover': 'WASHINGTON',
		'url':'/fact-sheets/factsheet_nutrition_wa_snap_program/',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_48':{
		'hover': 'WEST VIRGINIA',
		'url':'/fact-sheets/factsheet_nutrition_wv_snap_program/',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_49':{
		'hover': 'WISCONSIN',
		'url':'/fact-sheets/factsheet_nutrition_wi_snap_program/',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_50':{
		'hover': 'WYOMING',
		'url':'/fact-sheets/factsheet_nutrition_wy_snap_program/',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_51':{
		'hover': 'Puerto Rico',
		'url':'/fact-sheets/factsheet_nutrition_pr_snap_program/',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_52':{
		'hover': 'Guam',
		'url':'/fact-sheets/factsheet_nutrition_gu_snap_program/',
		'target':'same_window',
		'upColor':'#1888de', //state's color when page loads
		'overColor':'#1F3D7D',
		'downColor':'#993366',
		'enable':true,
	},
	'map_53':{
		'hover': 'Virgin Islands',
		'url':'/fact-sheets/factsheet_nutrition_vi_snap_program/',
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
      for (var i = 0, ls = value.length; i < ls; i++) {
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

//Lynna Cekova: popovers 
    $('[data-toggle="popover"]')
     .popover()
     .click(function(e) {
      e.stopPropagation();
      console.log("test this");
        e.preventDefault()
	var el = this;
      $(el).popover('show');
      $(".popover > h3").append('<span id="closeButton" class="close icon icon-remove">X</span>')
                        .find('.close').on('click', function(e) {
                            e.preventDefault();
                            e.stopPropagation();
                            $(el).popover('hide');
                        }
       );

      $(".popover > h3").show();
      $("#closeButton").show();

     });   

 

//Lynna Cekova: click to call

//console.log ($(".single-fact-sheets").html());
//if( /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) ) {
 
var countrycodes = "1"
var delimiters = "-|\\.|—|–|&nbsp;"
var phonedef = "\\+?(?:(?:(?:" + countrycodes + ")(?:\\s|" + delimiters + ")?)?\\(?[2-9]\\d{2}\\)?(?:\\s|" + delimiters + ")?[2-9]\\d{2}(?:" + delimiters + ")?[0-9a-z]{4})"
var spechars = new RegExp("([- \(\)\.:]|\\s|" + delimiters + ")","gi") //Special characters to be removed from the link
var phonereg = new RegExp("((^|[^0-9])(href=[\"']tel:)?((?:" + phonedef + ")[\"'][^>]*?>)?(" + phonedef + ")($|[^0-9]))","gi")
 
function ReplacePhoneNumbers(oldhtml) {
//Created by Jon Meck at LunaMetrics.com - Version 1.0
var newhtml = oldhtml.replace("/href=['']callto:/gi",'href="tel:');
newhtml = newhtml.replace(phonereg, function ($0, $1, $2, $3, $4, $5, $6) {
    if ($3) return $1;
    else if ($4) return $2+$4+$5+$6;
    else return $2+"<a href='tel:"+$5.replace(spechars,"")+"' onclick=\"_gaq.push(['_trackEvent','Phone Call Tracking','Click/Touch']);\" >"+$5+"</a>"+$6; });
return newhtml;
}


 
//http://www.lunametrics.com/blog/2014/01/16/phone-numbers-clickable-trackable-mobile-devices-javascript-google-tag-manager/

//$(".test").html(ReplacePhoneNumbers($(".test").html()));
$("#factsheetContent").html(ReplacePhoneNumbers($("#factsheetContent").html()));
 
//}








}(window.jQuery);


