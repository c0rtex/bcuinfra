var app = angular.module('ncoa', ['ngAnimate', 'ngRoute', 'LocalStorageModule', 'ui.router']);

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
      url: '/fact-sheets',
      templateUrl: '/content/themes/ncoa/resources/views/pages/benefits-checkup/fact-sheets/fact-sheets.html?'+(new Date()),
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
	  templateUrl: '/content/themes/ncoa/resources/views/directives/breadcrumb/breadcrumb.html?'+(new Date()),
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
	  	description: "@",
		code: "@",
		type: "@",
		request: "@"
	  },
	  templateUrl: '/content/themes/ncoa/resources/views/directives/grid/grid-tpl.html?'+(new Date()),
	  link: function (scope, element, attr) {

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
		scope: {},
		templateUrl: '/content/themes/ncoa/resources/views/directives/med-selector/medication-selector.html?'+(new Date()),
		link: function(scope, elm){

			var drugs = Drugs.getDrugs();

			for(var i=0; i<drugs.length; i++) {
				var option = $("<option/>",{value:drugs[i].id, text:drugs[i].name});
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

app.directive('pageSwitch',['$state', 'Income','$filter', 'questionnaire', 'saveScreening', function($state, Income, $filter, questionnaire, saveScreening){
	return {
		link: function(scope, elm){
			
			scope.preState = $state.current.data.prev;
			scope.nextState = $state.current.data.next;
			
			scope.switchPage = function(stateName,iterator){
				scope.pgno = scope.pgno == undefined ? 1 : scope.pgno + iterator;
				if (scope.pgno<1) scope.pgno = 1;
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

				var statusChangeProc = function() {
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
				};

				var prefix = fromState.name.replace("questionnaire.","");

				if ((scope.questionnaire.request[prefix] != undefined)||(toState.name == "questionnaire.loader")) {

					var request = {};
					if (scope.questionnaire.screening != undefined) {
						request.screening = scope.questionnaire.screening;
					}

					request.pgno=scope.pgno;
					request.prescreen =scope.questionnaire.prevScreening;

					if (scope.questionnaire.request[prefix]!= undefined) {
						request.answers = scope.questionnaire.request[prefix];
					} else {
						request.answers = {};
					}

					if (toState.name == "questionnaire.loader") {
						request.lastSet="true";
					}

					if (prefix == "finances-income-grid") {
						for (var i in scope.questionnaire.request['income-totals']) {
							request.answers[i] = scope.questionnaire.request['income-totals'][i];
						}

					}

					if (prefix == "finances-assets-grid") {
						for (var i in scope.questionnaire.request['assets-totals']) {
							request.answers[i] = scope.questionnaire.request['assets-totals'][i];
						}
					}

					saveScreening.post(request).success(function(data, status, headers, config) {
						if (toState.name == "questionnaire.loader") {
							scope.questionnaire.screening = data.screening;
							scope.questionnaire.found_programs = data.found_programs;
							scope.questionnaire.key_programs = [];
							for (var i=0;i<scope.questionnaire.found_programs.length;i++) {
								for (var j=0;j<scope.questionnaire.found_programs[i].programs.length;j++) {
									if (scope.questionnaire.found_programs[i].programs[j].key_program) {
										var program = scope.questionnaire.found_programs[i].programs[j];
										program.category = scope.questionnaire.found_programs[i].category;
										scope.questionnaire.key_programs.push(program);
									}
								}
							}
							questionnaire = scope.questionnaire;
							$state.transitionTo('questionnaire.results');
						} else {
							scope.questionnaire.screening = data;
							questionnaire = scope.questionnaire;
						}
						statusChangeProc();
					});
				} else {
					statusChangeProc();
				}



			});


		}
	}
}]);
app.directive('profile', ['prescreen', '$state', 'Drugs', 'CronicConditions', function (prescreen, $state, Drugs, CronicConditions) {
	return {
	  restrict: 'A',	  
	  templateUrl: '/content/themes/ncoa/resources/views/directives/profile/profile.html?'+(new Date()),
	  link: function (scope, element, attr) {
	  	scope.screenData = prescreen.screenData;
		scope.questionnaire.prevScreening = prescreen.results.screening;
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
							 "sp_veteran":directivePath+"sp_veteran.html"};

	return questionTemplates;
}]);

app.directive('questionDiv',['questionTemplates',function(questionTemplates) {
	return {
		restrict: 'E',
		template:"<span ng-include='question_template_link'></span>",
		link: function(scope,element) {
			if (questionTemplates[scope.question.code] == undefined) {
				scope.question_template_link = 'question.html?' + (new Date());
			} else {
				scope.question_template_link = questionTemplates[scope.question.code] + '?' + (new Date());
			}
		},
		scope: {
			question:"="
		},
		controller: "questionController"
	}
}]);

app.directive('script', function() {
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
});

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
        template: '<select class="form-control inline" name="dob-year" ng-model="$root.prescreen.year" ng-options="y for y in years"></select>',
        link: function(scope,element,attrs){
            scope.years = getYears(+attrs.offset, +attrs.range);
            scope.$root.prescreen.year = scope.years[66];
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
			scope.$root.prescreen.isZipValid = true;
			scope.$root.prescreen.isValidating = false;

			scope.updateZip = function(){
				scope.$root.prescreen.isValidating = true;
				locationFinder.getLocation(scope.$root.prescreen.zip).success(function(data, status, headers, config) {
					validateZip(data);
					scope.$root.prescreen.isValidating = false;
				});
			};


			if (localStorageService.get('v_zipcode') != undefined) {
				scope.$root.prescreen.zip = localStorageService.get('v_zipcode');
				localStorageService.remove('v_zipcode');
				scope.updateZip();
			}
			
			scope.resetZip = function(){
				scope.$root.prescreen.isEdit = true;
				$('#zipcode').focus();
			}

			function validateZip(data){
				if (scope.$root.prescreen.zip.length != 5) {
					scope.$root.prescreen.isZipValid = false;
					scope.$parent.zipCodeCheckResult = "Error!"
					scope.$parent.zipCodeDescription = "Please enter a valid zipcode in the United States";
					scope.$parent.zipCodeUpdated=true;
					return;
				}
				if(data.status == "OK"){
					if(data.results[0].address_components[0].short_name != "Undefined" && data.results[0].formatted_address.lastIndexOf("US") != -1){				
						scope.$root.prescreen.zipcode = data.results[0].address_components[0].long_name;
						for (var i=1;i<data.results[0].address_components.length;i++) {
							if (data.results[0].address_components[i].types.indexOf("administrative_area_level_1") > -1) {
								scope.$root.prescreen.stateId = data.results[0].address_components[i].short_name;
								continue;
							}
						}

				  		scope.$root.prescreen.zipcode_formatted = $filter('limitTo')(data.results[0].formatted_address, data.results[0].formatted_address.lastIndexOf(','), 0);
				  		scope.$root.prescreen.isZipValid = true;
						scope.$parent.zipCodeCheckResult = "Success!"
						scope.$parent.zipCodeDescription = scope.$root.prescreen.zipcode_formatted;
					}else{
						scope.$root.prescreen.isZipValid = false;
						scope.$parent.zipCodeCheckResult = "Error!"
						scope.$parent.zipCodeDescription = "Please enter a valid zipcode in the United States";
					}
				}else{
					scope.$root.prescreen.isZipValid = false;
					scope.$parent.zipCodeCheckResult = "Error!"
					scope.$parent.zipCodeDescription = "Please enter a valid zipcode in the United States";
				}
				scope.$parent.zipCodeUpdated=true;
			}
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
			code: 'un_prg_1',
			image: '/content/themes/ncoa/resources/assets/images/categories/category_employment.svg'
		},
		{
			name: 'Transportation',
			code: 'un_prg_2',
			image: '/content/themes/ncoa/resources/assets/images/categories/category_transportation.svg'
		},
		{
			name: 'Education',
			code: 'un_prg_3',
			image: '/content/themes/ncoa/resources/assets/images/categories/category_education.svg'
		},
		{
			name: 'Discounts',
			code: 'un_prg_4',
			image: '/content/themes/ncoa/resources/assets/images/categories/category_discounts.svg'
		},
		{
			name: 'Other Assistance',
			code: 'un_prg_5',
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

	return BenefitItems;
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
app.factory('Drugs',[function() {

	var Drugs = {};

	var _drugs = [{id:'g1', name:'abacavir sulfate'},
		{id:'g744', name:'abacavir sulfate/lamivudine'},
		{id:'g2', name:'abacavir sulfate/lamivudine/zidovudine'},
		{id:'gen_abac1', name:'abacavir, dolutegravir, and lamivudine'},
		{id:'gen_abat1', name:'abatacept'},
		{id:'g711', name:'abciximab'},
		{id:'dn_ABIL1', name:'Abilify (aripiprazole)'},
		{id:'gen_abir1', name:'abiraterone acetate'},
		{id:'dn_abra1', name:'Abraxane for Injectable Suspension (paclitaxel)'},
		{id:'g839', name:'acamprosate calcium'},
		{id:'g3', name:'acarbose'},
		{id:'dn_ACCU1', name:'Accupril (quinapril HCl)'},
		{id:'dn_ACCU2', name:'Accuretic (quinapril HCl/hydrochlorothiazide)'},
		{id:'gen_acet2', name:'acetohydroxamic acid'},
		{id:'g7', name:'acitretin'},
		{id:'gen_acli1', name:'aclidinium bromide inhalation powder'},
		{id:'g8', name:'aclometasone dipropionate cream'},
		{id:'dn_ACLO1', name:'Aclovate Cream (aclometasone dipropionate)'},
		{id:'dn_acte1', name:'Acterma (tocilizumab)'},
		{id:'dn_ACTH1', name:'Acthar Gel (corticotropin)'},
		{id:'dn_acti3', name:'Actimmune (interferon-gamma-1b)'},
		{id:'dn_ACTI2', name:'Activella (estradiol/norethindrone acetate tablets)'},
		{id:'dn_acul2', name:'Acular LS Opththalmic Solution 0.40 (ketorolac tromethamine) '},
		{id:'dn_acul1', name:'Acular Opththalmic Solution 0.45 (ketorolac tromethamine) '},
		{id:'dn_acuv1', name:'Acuvail (ketorolac)'},
		{id:'g11', name:'acyclovir'},
		{id:'dn_aczo1', name:'Aczone (dapsone)'},
		{id:'dn_adac1', name:'Adacel (tetanus, diphtheria, acellular pertussis vaccine)'},
		{id:'dn_ADAL1', name:'Adalat CC  (nifedipine)'},
		{id:'g13', name:'adalimumab'},
		{id:'gen_adap3', name:'adapalene'},
		{id:'gen_adap2', name:'adapalene and benzoyl peroxide'},
		{id:'gen_adap1', name:'adapalene gel'},
		{id:'dn_adce1', name:'Adcetris (brentuximab vedotin)'},
		{id:'dn_adci1', name:'Adcirca (tadalafil)'},
		{id:'g14', name:'adefoir dipivoxil'},
		{id:'dn_adem1', name:'Adempas (riociguat) '},
		{id:'gen_adot1', name:'ado-trastuzumab emtansine'},
		{id:'dn_ADVA1', name:'Advair Diskus (fluticasone propionate/salmeterol)'},
		{id:'dn_adva2', name:'Advair HFA Inhalation Aerosol (fluticasone propionate/salmeterol)'},
		{id:'dn_adva3', name:'Advate (antihemophilic factor)'},
		{id:'dn_afin1', name:'Afinitor (everolimus)'},
		{id:'gen_afli1', name:'aflibercept'},
		{id:'g820', name:'agalsidase beta'},
		{id:'dn_AGGR1', name:'Aggrenox (aspirin/dipyridamole)'},
		{id:'gen_albi1', name:'albiglutide'},
		{id:'g16', name:'albuterol sulfate'},
		{id:'g17', name:'albuterol sulfate HFA inhaler'},
		{id:'g18', name:'albuterol sulfate inhalation aerosol'},
		{id:'dn_alca1', name:'Alcaine .5% (proparacaine hydrochloride) '},
		{id:'dn_ALDA2', name:'Aldactazide (spironolactone/hydrochlorothiazide)'},
		{id:'dn_ALDA3', name:'Aldactone (spironolactone)'},
		{id:'dn_ALDU1', name:'Aldurazyme (laronidase)'},
		{id:'g23', name:'alendronate sodium tablets'},
		{id:'gen_algl1', name:'alglucosidase alfa'},
		{id:'dn_ALIM1', name:'Alimta (pemetrexed)'},
		{id:'dn_alin2', name:'Alinia Suspension (nitazoxanide)'},
		{id:'dn_alin1', name:'Alinia Tablets (nitazoxanide)'},
		{id:'gen_alis1', name:'aliskiren'},
		{id:'gen_alis4', name:'aliskiren amlodipine'},
		{id:'gen_alis2', name:'aliskiren and hydrochlorothiazide'},
		{id:'gen_alis5', name:'aliskiren, amlodipine and hydrochlorothize'},
		{id:'gen_alit1', name:'alitretinoin'},
		{id:'gen_allo1', name:'allopurinol'},
		{id:'g25', name:'almotriptan malate'},
		{id:'gen_alog2', name:'alogliptin'},
		{id:'gen_alog3', name:'alogliptin and metformin HCl'},
		{id:'gen_alog1', name:'alogliptin and pioglitazone'},
		{id:'dn_alom1', name:'Alomide .1% (lodoxamide tromethamine)'},
		{id:'dn_ALOX1', name:'Aloxi (palonosetron HCL injection)'},
		{id:'gen_alph1', name:'alpha 1-proteinase inhibitor'},
		{id:'dn_alph5', name:'Alphagan Opththalmic Solution .15% (brimonidine tartrate) '},
		{id:'dn_ALPH2', name:'Alphagan P (brimonidine tartrate)'},
		{id:'dn_alph4', name:'Alphanate Injection (antihemophilic factor/von willebrand factor complex)'},
		{id:'dn_alph3', name:'AlphaNine SD (coagulation factor ix)'},
		{id:'gen_alpr1', name:'alprazolam'},
		{id:'g783', name:'alprostadil for injection'},
		{id:'dn_alre1', name:'Alrex Suspension (loteprednol etabonate ophthalmic suspension)'},
		{id:'dn_alta2', name:'Altabax Ointment (retapamulin)'},
		{id:'dn_ALTA1', name:'Altace (ramipril)'},
		{id:'g27', name:'altretamine'},
		{id:'dn_AMAR1', name:'Amaryl (glimepiride)'},
		{id:'dn_AMBI1', name:'Ambien (zolpidem)'},
		{id:'gen_ambr1', name:'ambrisentan'},
		{id:'g34', name:'amiodarone HCl'},
		{id:'gen_amio2', name:'amiodipine valsartan hydrochlorothiazide'},
		{id:'dn_amit1', name:'Amitiza (lubiprostone)'},
		{id:'gen_amit1', name:'amitriptyline'},
		{id:'dn_amit2', name:'Amitriptyline Tablet (amitriptyline)'},
		{id:'gen_amlo1', name:'amlodipine and olmesartan medoxomil'},
		{id:'gen_amlo2', name:'amlodipine and valsartan'},
		{id:'g35', name:'amlodipine besylate'},
		{id:'g727', name:'amlodipine besylate/atorvastatin calcium'},
		{id:'g36', name:'amlodipine besylate/benazepril HCI'},
		{id:'dn_ampy1', name:'Ampyra (dalfampridine)'},
		{id:'dn_amtu1', name:'Amturnide (aliskiren, amlodipine and hydrochlorothize)'},
		{id:'g45', name:'anakinra'},
		{id:'dn_anal1', name:'Analpram (hydrocortisone/pramoxine)'},
		{id:'dn_ANAP1', name:'Anaprox/Anaprox DS (naproxen)'},
		{id:'g46', name:'anastrozole'},
		{id:'dn_ANCO1', name:'Ancobon Caps (flucytosine)'},
		{id:'dn_ANDR1', name:'AndroGel 1% (testosterone gel) '},
		{id:'dn_ange1', name:'Angeliq (drospirenone/estradiol)'},
		{id:'dn_angi1', name:'Angiomax (bivalirudin)'},
		{id:'gen_anid1', name:'anidulafungin IV'},
		{id:'dn_anor1', name:'Anoro Ellipta (umeclidinium and vilanterol inhalation powder)'},
		{id:'gen_anti1', name:'anti-inhibitor coagulant'},
		{id:'gen_anti4', name:'Anti-thymocyte Globulin (Rabbit)'},
		{id:'gen_anti2', name:'antihemophilic factor'},
		{id:'gen_anti3', name:'antihemophilic factor/von willebrand factor complex'},
		{id:'dn_ANTI1', name:'Antivert (meclizine HCl)'},
		{id:'dn_apid1', name:'Apidra (insulin glulisine)'},
		{id:'gen_apix1', name:'apixaban'},
		{id:'gen_apli1', name:'apligraf'},
		{id:'dn_apli1', name:'Apligraf (apligraf)'},
		{id:'g47', name:'apraclonidine'},
		{id:'g814', name:'aprepitant'},
		{id:'dn_APTI1', name:'Aptivus (tipranavir)'},
		{id:'dn_apti2', name:'Aptivus Oral Solution (tipranavir)'},
		{id:'dn_aral2', name:'Aralast NP (alpha1-proteinase inhibitor, human)'},
		{id:'dn_ARAN1', name:'Aranesp (darbepoetin alpha)'},
		{id:'dn_ARAV1', name:'Arava (leflunomide)'},
		{id:'dn_arca2', name:'Arcalyst (rilonacept)'},
		{id:'dn_arca1', name:'Arcapta Neohaler (indacaterol inhalation powder)'},
		{id:'gen_argi1', name:'arginine hydrochloride'},
		{id:'dn_ARIC1', name:'Aricept (donepezil HCI) '},
		{id:'dn_ARIM1', name:'Arimidex (anastrozole) '},
		{id:'g48', name:'aripiprazole'},
		{id:'dn_ARIX1', name:'Arixtra (fondaparinux)'},
		{id:'gen_armo1', name:'armodafinil'},
		{id:'dn_ARMO1', name:'Armour Thyroid (thyroid desiccated)'},
		{id:'dn_AROM1', name:'Aromasin (exemestane)'},
		{id:'dn_arra1', name:'Arranon (nelarabine)'},
		{id:'g49', name:'arsenic trioxide injection'},
		{id:'dn_ARTH1', name:'Arthrotec (diclofenac sodium/misoprostol)'},
		{id:'dn_arze1', name:'Arzerra Injection (ofatumumab)'},
		{id:'gen_asen1', name:'asenapine'},
		{id:'dn_asma2', name:'Asmanex (mometasone furoate inhalation powder)'},
		{id:'gen_aspa1', name:'asparaginase Erwinia chrysanthemi'},
		{id:'g50', name:'aspirin/dipyridamole'},
		{id:'dn_ATAC1', name:'Atacand (candesartan cilexetil)'},
		{id:'dn_ATAC2', name:'Atacand HCT (candesartan cilexetil/hydrochlorothiazide)'},
		{id:'g698', name:'atazanavir sulfate'},
		{id:'g810', name:'atenolol'},
		{id:'g51', name:'atenolol/chlorthalidone'},
		{id:'dn_atga1', name:'Atgam (lymphocyte immune globulin/anti-thymocyte globulin)'},
		{id:'dn_ativ1', name:'Ativan (lorazepam)'},
		{id:'g710', name:'atomoxetine hydrochloride'},
		{id:'g52', name:'atorvastatin calcium'},
		{id:'g53', name:'atovaquone'},
		{id:'g54', name:'atovaquone/proguanil HCI'},
		{id:'dn_atri1', name:'Atripla (efavirenz/emtricitabine/tenofovir)'},
		{id:'dn_ATRO1', name:'Atrovent HFA Inhalation Aerosol (ipratopium bromide)'},
		{id:'dn_auvi1', name:'Auvi-Q (epinephrine injection, USP)'},
		{id:'dn_AVAL1', name:'Avalide (irbesartan-hydrochlorothiazide)'},
		{id:'dn_AVAN1', name:'Avandia (rosiglitazone maleate)'},
		{id:'dn_AVAP1', name:'Avapro (irbesartan)'},
		{id:'dn_AVAS1', name:'Avastin (bevacizumab)'},
		{id:'dn_AVEL1', name:'Avelox (moxifloxacin HCl)'},
		{id:'dn_avin2', name:'Avinza (morphine sulfate extended release capsules)'},
		{id:'dn_AVOD1', name:'Avodart (dutasteride)'},
		{id:'dn_AVON1', name:'Avonex (interferon beta-1a)'},
		{id:'dn_avon2', name:'Avonex IM Injection (interferon beta-1a IM injection)'},
		{id:'dn_AXER1', name:'Axert (almotriptan malate)'},
		{id:'gen_axit1', name:'axitinib'},
		{id:'dn_AYGE1', name:'Aygestin (norethindrone acetate)'},
		{id:'gen_azac1', name:'azacitidine'},
		{id:'gen_azel1', name:'azelaic acid'},
		{id:'dn_azil1', name:'Azilect (rasagiline)'},
		{id:'gen_azit2', name:'azithromycin'},
		{id:'g832', name:'azithromycin extended release'},
		{id:'dn_AZOP1', name:'Azopt (brinzolamide)'},
		{id:'dn_azor1', name:'Azor (amlodipine and olmesartan medoxomil)'},
		{id:'gen_aztr1', name:'aztreonam'},
		{id:'dn_AZUL1', name:'Azulfidine (sulfasalazine, enteric coated)'},
		{id:'g56', name:'bacillus Calmette-Guerin, live intravesical'},
		{id:'dn_baci1', name:'Bacitracin (bacitracin USP)'},
		{id:'gen_baci1', name:'bacitracin USP'},
		{id:'gen_bacl1', name:'baclofen'},
		{id:'dn_bact2', name:'Bactrim DS (sulfamethoxazole/trimethoprim DS)'},
		{id:'dn_bact3', name:'Bactroban Cream (mupirocin)'},
		{id:'dn_bact4', name:'Bactroban Nasal Ointment (mupirocin)'},
		{id:'dn_BACT1', name:'Bactroban Ointment (mupirocin)'},
		{id:'gen_bala1', name:'balanced eye salt with preservatives'},
		{id:'dn_banz1', name:'Banzel (rufinamide)'},
		{id:'dn_banz2', name:'Banzel Oral Suspension (rufinamide)'},
		{id:'dn_BARA1', name:'Baraclude (entecavir)'},
		{id:'g59', name:'beclomethasone dipropionate'},
		{id:'gen_becl1', name:'beclomethasone dipropionate/monohydrate'},
		{id:'dn_beco3', name:'Beconase AQ Nasal Spray (beclomethasone dipropionate/monohydrate )'},
		{id:'gen_bela1', name:'belatacept'},
		{id:'gen_beli1', name:'belimumab'},
		{id:'gen_bell1', name:'belladonna'},
		{id:'dn_bell1', name:'Belladonna Alkaloids (belladonna)'},
		{id:'g63', name:'benazapril HCl/hydrochlorothiazide'},
		{id:'gen_bend1', name:'bendamustine HCl'},
		{id:'dn_BENE1', name:'Benefix Coagulation Factor IX (recombinant)'},
		{id:'dn_BENI1', name:'Benicar (olmesartan medoxomil)'},
		{id:'dn_BENI2', name:'Benicar HCT (olmesartan medoxomil/hydrochlorothiazide)'},
		{id:'dn_benl1', name:'Benlysta (belimumab)'},
		{id:'dn_BENT1', name:'Bentyl (dicyclomine HCl) '},
		{id:'g65', name:'benzonatate'},
		{id:'gen_benz3', name:'benzphetamine hydrochloride'},
		{id:'gen_benz2', name:'benztropine'},
		{id:'dn_benz7', name:'Benztropine Tablet (benztropine) '},
		{id:'dn_beri1', name:'Berinert (C1 esterase) '},
		{id:'gen_besi1', name:'besifloxacin ophthalmic suspension'},
		{id:'dn_besi1', name:'Besivance (besifloxacin ophthalmic suspension) '},
		{id:'dn_BETA1', name:'Betagan (levobunolol HCl)'},
		{id:'g69', name:'betaine anhydrous for oral solution'},
		{id:'g70', name:'betamethasone dipropionate'},
		{id:'dn_BETA4', name:'Betapace (sotalol HCl)'},
		{id:'dn_BETA5', name:'Betapace AF (sotalol HCl)'},
		{id:'dn_BETA6', name:'Betaseron (interferon beta)'},
		{id:'g71', name:'betaxolol HCl'},
		{id:'dn_BETO1', name:'Betoptic S (betaxolol HCl)'},
		{id:'g760', name:'bevacizumab'},
		{id:'g741', name:'bexarotene'},
		{id:'g72', name:'bicalutamide'},
		{id:'dn_bidi1', name:'BiDil (isosorbide dinitrate/hydralazine hydrochloride)'},
		{id:'dn_BILT1', name:'Biltricide (praziquantel)'},
		{id:'g73', name:'bimatoprost'},
		{id:'gen_bion1', name:'bion tears'},
		{id:'dn_bion1', name:'Bion Tears (bion tears)'},
		{id:'g75', name:'bisprolol fumarate/hydrochlorothiazide'},
		{id:'gen_biva1', name:'bivalirudin'},
		{id:'dn_blep1', name:'Bleph-10 Ophthalmic Solution (sulfacetamid sodium)'},
		{id:'gen_boce1', name:'boceprevir'},
		{id:'dn_boos1', name:'Boostrix'},
		{id:'g831', name:'bortezomib'},
		{id:'g738', name:'bosentan'},
		{id:'dn_bosu1', name:'Bosulif Tablets (bosutinib)'},
		{id:'gen_bosu1', name:'bosutinib'},
		{id:'dn_BOTO1', name:'Botox (botulinum toxin)'},
		{id:'g78', name:'botulinum toxin'},
		{id:'gen_bren1', name:'brentuximab vedotin'},
		{id:'dn_breo1', name:'Breo Ellipta (fluticasone furoate and vilanterol inhalation powder)'},
		{id:'dn_bril1', name:'Brilinta (ticagrelor)'},
		{id:'dn_brim1', name:'Brimonidine (tartrate ophthalmic solution)'},
		{id:'g79', name:'brimonidine tartrate'},
		{id:'gen_brim1', name:'brimonidine tartrate/timolol maleate'},
		{id:'dn_brin1', name:'Brintellix (vortioxetine)'},
		{id:'g80', name:'brinzolamide'},
		{id:'g82', name:'budesonide'},
		{id:'gen_bude1', name:'budesonide inhalation powder'},
		{id:'g84', name:'budesonide respules'},
		{id:'gen_bude2', name:'budesonide/formoterol fumarate dihydrate'},
		{id:'g86', name:'bumetanide'},
		{id:'dn_BUME1', name:'Bumex (bumetanide)'},
		{id:'g87', name:'bupropion HCl'},
		{id:'g736', name:'bupropion HCl extended-release tablets'},
		{id:'dn_busp2', name:'Buspar Tablet (buspirone)'},
		{id:'gen_busp1', name:'buspirone'},
		{id:'dn_bydu1', name:'Bydureon Extended Release for Injectable Suspension (exenatide)'},
		{id:'dn_byet1', name:'Byetta Injection (exenatide)'},
		{id:'dn_byst1', name:'Bystolic Tablets (nebivolol tablets)'},
		{id:'gen_cest1', name:'C1 esterase'},
		{id:'gen_cest2', name:'c1 esterase inhibitor [human]'},
		{id:'gen_caba1', name:'cabazitaxel'},
		{id:'dn_CADU1', name:'Caduet (amlodipine besylate/atorvastatin calcium)'},
		{id:'dn_CALA2', name:'Calan (verapamil hydrochloride)'},
		{id:'dn_CALA1', name:'Calan SR (verapamil hydrochloride)'},
		{id:'gen_calc3', name:'calcipotriene'},
		{id:'gen_calc4', name:'calcipotriene 0.005% and betamethasone dipropionate 0.064%'},
		{id:'gen_calc1', name:'calcium acetate'},
		{id:'dn_camp3', name:'Campral Delayed Release (acamprosate calcium)'},
		{id:'dn_CAMP1', name:'Camptosar (irinotecan HCl)'},
		{id:'gen_cana2', name:'canagliflozin'},
		{id:'gen_cana1', name:'canakinumab'},
		{id:'g99', name:'candesartan cilexetil'},
		{id:'g100', name:'candesartan cilexetil/hydrochlorothiazide'},
		{id:'dn_caph1', name:'Caphosol Oral Solution (dibasic sodium phosphate)'},
		{id:'dn_capo1', name:'Capoten Tablet (captopril)'},
		{id:'gen_capr1', name:'capromab pendetide'},
		{id:'gen_capt1', name:'captopril'},
		{id:'g102', name:'carbachol'},
		{id:'g103', name:'carbamazepine'},
		{id:'dn_CARB1', name:'Carbatrol (carbamazepine)'},
		{id:'g105', name:'carbidopa'},
		{id:'g697', name:'carbidopa, levodopa, and entacapone tablets'},
		{id:'gen_carb2', name:'carbidopa/levo SR tablet'},
		{id:'gen_carb3', name:'carboprost tromethamine USP'},
		{id:'dn_card4', name:'Cardizem CD Tablets (diltiazem ER dilt-cd) '},
		{id:'dn_card5', name:'Cardura  XL (doxazosin mesylate) '},
		{id:'dn_CARD2', name:'Cardura (doxazosin mesylate)'},
		{id:'gen_carf1', name:'carfilzomib'},
		{id:'dn_cari1', name:'Carimune NF Injection (immune globulin)'},
		{id:'dn_CARN1', name:'Carnitor (levocarnitine)'},
		{id:'dn_CART1', name:'Carteolol HCl ophthalmic solution'},
		{id:'g706', name:'carteolol hydrochloride'},
		{id:'g109', name:'carvedilol'},
		{id:'gen_carv1', name:'carvedilol phosphate'},
		{id:'dn_CASO1', name:'Casodex (bicalutamide) '},
		{id:'dn_cata2', name:'Catapres Tablets (clonidine HCL)'},
		{id:'dn_CAVE1', name:'Caverject (alprostadil for injection)'},
		{id:'dn_cays1', name:'Cayston Inhalation Solution (aztreonam) '},
		{id:'dn_CELE1', name:'Celebrex (celecoxib)'},
		{id:'g122', name:'celecoxib'},
		{id:'dn_CELE3', name:'Celexa (citalopram hydrobromide)'},
		{id:'dn_CELL1', name:'CellCept (mycophenolate mofetil)'},
		{id:'dn_CELO1', name:'Celontin (methsuximide)'},
		{id:'dn_CERE2', name:'Cerezyme (imiglucerase injection)'},
		{id:'gen_ceri1', name:'ceritinib'},
		{id:'dn_cerv1', name:'Cervarix'},
		{id:'g755', name:'cetuximab'},
		{id:'gen_cevi1', name:'cevimeline HCl'},
		{id:'dn_chan1', name:'Chantix (varenicline)'},
		{id:'dn_chlo2', name:'Chlorpromazine HCL tablet (chlorpromazine hydrochloride)'},
		{id:'gen_chlo1', name:'chlorpromazine hydrochloride'},
		{id:'g688', name:'chlorthalidone'},
		{id:'dn_chlo1', name:'Chlorthalidone Tablet (chlorthalidone)'},
		{id:'g132', name:'chlorzoxazone'},
		{id:'dn_cial1', name:'Cialis (tadalafil)'},
		{id:'g134', name:'cidofovir'},
		{id:'g135', name:'cilostazol'},
		{id:'dn_cilo1', name:'Ciloxan Ointment (ciprofloxacin)'},
		{id:'gen_cina1', name:'cinacalcet'},
		{id:'dn_cinr1', name:'Cinryze (c1 esterase inhibitor [human])'},
		{id:'dn_cipr6', name:'Cipro HC Suspension (ciprofloxacin/hydrocortisone otic)'},
		{id:'dn_CIPR1', name:'Cipro Tablets (ciprofloxacin tablets)'},
		{id:'dn_cipr5', name:'Ciprodex (ciprofloxacin / dexamethasone)'},
		{id:'gen_cipr1', name:'ciprofloxacin'},
		{id:'gen_cipr2', name:'ciprofloxacin / dexamethasone'},
		{id:'g139', name:'ciprofloxacin tablets'},
		{id:'gen_cipr3', name:'ciprofloxacin/hydrocortisone otic'},
		{id:'g141', name:'citalopram hydrobromide'},
		{id:'g142', name:'cladribine'},
		{id:'dn_CLAR1', name:'Clarinex (desloratadine)'},
		{id:'dn_clar3', name:'Clarinex-D (desloratadine/pseudoephedrine sulfate) '},
		{id:'dn_CLEO2', name:'Cleocin HCL (clindamycin hydrochloride)'},
		{id:'dn_cleo5', name:'Cleocin Phosphate (clindamycin phosphate, USP)'},
		{id:'dn_CLIM1', name:'Climara (estradiol)'},
		{id:'dn_CLIM2', name:'Climara Pro (estradiol/levonorgestrel)'},
		{id:'dn_clin2', name:'Clindagel (clindamycin phosphate)'},
		{id:'g784', name:'clindamycin hcl'},
		{id:'g786', name:'clindamycin phosphate'},
		{id:'gen_clin2', name:'clindamycin phosphate 1%/benzoyl peroxide 5%'},
		{id:'gen_clin4', name:'clindamycin phosphate, USP'},
		{id:'gen_clin3', name:'clindamycin phosphate/tretinoin'},
		{id:'dn_clin4', name:'CLINIMIX'},
		{id:'dn_clin5', name:'CLINIMIX E'},
		{id:'g817', name:'clobetasol propionate'},
		{id:'dn_clob3', name:'Clobex Spray (clobetasol propionate)'},
		{id:'gen_clof1', name:'clofarabine'},
		{id:'dn_clol1', name:'Clolar Injection (clofarabine)'},
		{id:'g147', name:'clonazepam'},
		{id:'gen_clon1', name:'clonidine HCL'},
		{id:'g150', name:'clopidogrel bisulfate'},
		{id:'g151', name:'clotrimazole troche'},
		{id:'dn_CLOZ2', name:'clozapine'},
		{id:'dn_CLOZ1', name:'Clozaril (clozapine)'},
		{id:'gen_coag1', name:'coagulation factor IX'},
		{id:'gen_coag2', name:'coagulation factor ix'},
		{id:'gen_colc2', name:'colchicine'},
		{id:'dn_colc2', name:'Colcrys (colchicine)'},
		{id:'g156', name:'colesevelam HCI'},
		{id:'dn_COLE1', name:'Colestid (colestipol hydrochloride)'},
		{id:'g787', name:'colestipol hcl'},
		{id:'gen_coll1', name:'collagenase clostridium histolyticum'},
		{id:'dn_comb4', name:'Combigan (brimonidine tartrate/timolol maleate)'},
		{id:'dn_COMB2', name:'Combivent (ipratopium bromide/albuterol sulfate)'},
		{id:'dn_COMB3', name:'Combivir (lamivudine/zidovudine)'},
		{id:'dn_comp2', name:'Complera (emtricitabine/rilpivirine/tenofovir disoproxil fumarate)'},
		{id:'dn_CONC1', name:'Concerta (methylphenidate HCl)'},
		{id:'gen_conj2', name:'conjugated estrogens/bazedoxifene'},
		{id:'dn_COPA1', name:'Copaxone (glatiramer acetate for injection)'},
		{id:'dn_CORD1', name:'Cordarone (amiodarone HCl)'},
		{id:'dn_CORE1', name:'Coreg (carvedilol)'},
		{id:'dn_core2', name:'Coreg CR (carvedilol phosphate)'},
		{id:'dn_core3', name:'Coreg Cr Extended Release Capsules (carvedilol phosphate)'},
		{id:'dn_CORG1', name:'Corgard (nadolol)'},
		{id:'dn_cori1', name:'Corifact (factor xiii concentrate) '},
		{id:'dn_CORT1', name:'Cortef (hydrocortisone)'},
		{id:'g157', name:'corticotropin gel'},
		{id:'dn_cort3', name:'Cortisporin Otic Solution (Neomycin/Polymyxin B/Hydrocortisone)'},
		{id:'dn_cort4', name:'Cortisporin Otic Suspension (Neomycin/Polymyxin B/Hydrocortisone)'},
		{id:'dn_corv1', name:'Corvert (ibutilide fumarate)'},
		{id:'dn_COSO1', name:'Cosopt  Ophthalmic Solution (dorzolamide chloride/timolol maleate)'},
		{id:'dn_coso2', name:'Cosopt PF (drozolamide hydrachloride- timelol maleate opthalmic solution)'},
		{id:'dn_COZA1', name:'Cozaar (losartan potassium)'},
		{id:'dn_CREO1', name:'Creon (pancrelipase) '},
		{id:'dn_CRES1', name:'Crestor Tablets (rosuvastatin calcium)'},
		{id:'dn_CRIX1', name:'Crixivan (indinavir sulfate)'},
		{id:'gen_criz1', name:'crizotinib'},
		{id:'gen_crom1', name:'cromolyn sodium'},
		{id:'dn_CUPR1', name:'Cuprimine Capsules (penicillamine)'},
		{id:'gen_cyan1', name:'cyanocobalamin'},
		{id:'g160', name:'cyclobenzaprine HCl'},
		{id:'dn_cycl5', name:'Cyclomydril Ophthalmic Solution (cyclopentolate hydrochloride/phenylephrine hydrochloride)'},
		{id:'gen_cycl1', name:'cyclopentolate hydrochloride/phenylephrine hydrochloride'},
		{id:'g164', name:'cyclosporine'},
		{id:'g165', name:'cyclosporine capsules'},
		{id:'dn_cycl2', name:'Cyclosporine capsules (cyclosporine)'},
		{id:'g709', name:'cyclosporine ophthalmic emulsion'},
		{id:'dn_cycl3', name:'Cyclosporine oral solution (cyclosporine)'},
		{id:'dn_cykl1', name:'Cyklokapron (tranexamic acid)'},
		{id:'dn_CYMB1', name:'Cymbalta (duloxetine HCl)'},
		{id:'dn_CYST1', name:'Cystadane (betaine anhydrous for oral solution)'},
		{id:'dn_CYTO7', name:'Cytomel (liothyronine sodium)'},
		{id:'dn_CYTO2', name:'Cytotec (misoprostol)'},
		{id:'gen_dabi1', name:'dabigatran etexilate'},
		{id:'gen_dabr1', name:'dabrafenib'},
		{id:'dn_daco1', name:'Dacogen Injection (decitabine)'},
		{id:'gen_dalb1', name:'dalbavancin'},
		{id:'gen_dalf1', name:'dalfampridine'},
		{id:'dn_dali1', name:'Daliresp (roflumilast)'},
		{id:'g168', name:'dalteparin sodium'},
		{id:'dn_dalv1', name:'Dalvance (dalbavancin)'},
		{id:'gen_dapa1', name:'dapagliflozin'},
		{id:'gen_daps1', name:'dapsone'},
		{id:'g171', name:'darbepoetin alpha'},
		{id:'g848', name:'darunavir'},
		{id:'gen_dasa1', name:'dasatinib'},
		{id:'dn_DAYP1', name:'Daypro (oxaprozin)'},
		{id:'gen_deci1', name:'decitabine'},
		{id:'g842', name:'deferasirox'},
		{id:'g174', name:'delavirdine mesylate'},
		{id:'dn_DEMS1', name:'Demser Capsules (metyrosine capsules) '},
		{id:'gen_deni1', name:'denileukin diftitox'},
		{id:'gen_deno1', name:'denosumab'},
		{id:'dn_DEPA1', name:'Depakote (divalproex sodium)'},
		{id:'dn_DEPA2', name:'Depakote ER (divalproex sodium)'},
		{id:'dn_DEPO5', name:'Depo-Estradiol (estradiol cypionate)'},
		{id:'dn_DEPO6', name:'Depo-Medrol (sterile methylprednisolone acetate)'},
		{id:'dn_DEPO4', name:'Depo-Provera (medroxyprogesterone acetate)'},
		{id:'dn_depo7', name:'Depo-SubQ Provera 104 (medroxyprogesterone acetate injectable suspension)'},
		{id:'dn_depo8', name:'Depo-Testosterone (testosterone cypionate) '},
		{id:'g176', name:'desloratadine'},
		{id:'gen_desl1', name:'desloratadine/pseudoephedrine sulfate'},
		{id:'g177', name:'desmopressin acetate'},
		{id:'dn_deso1', name:'Desonate (desonide) Gel 0.05%'},
		{id:'gen_deso2', name:'desonide'},
		{id:'gen_deso1', name:'desonide foam'},
		{id:'gen_desv1', name:'desvenlafaxine'},
		{id:'dn_DESY1', name:'Desyrel Dividose (trazodone)'},
		{id:'dn_DETR1', name:'Detrol (tolterodine tartrate)'},
		{id:'gen_dexa2', name:'dexamethasone intravitreal implant'},
		{id:'gen_dexa1', name:'dexamethasone sodium phosphate'},
		{id:'dn_dexa1', name:'Dexamethasone sodium phosphate (dexamethasone sodium phosphate)'},
		{id:'g178', name:'dexamethasone tablets'},
		{id:'dn_dexi1', name:'Dexilant (dexlansoprazole)'},
		{id:'gen_dexl1', name:'dexlansoprazole'},
		{id:'gen_dexm1', name:'dexmethylphenidate HCl extended release'},
		{id:'g180', name:'dexrazoxane'},
		{id:'gen_dext1', name:'dextromethorphan hydrobromide and quinidine sulfate'},
		{id:'dn_dias2', name:'Diastat AcuDial  (diazepam rectal gel)'},
		{id:'dn_dias3', name:'Diastat Gel (diazepam rectal gel) '},
		{id:'g183', name:'diazepam'},
		{id:'gen_diaz2', name:'diazepam rectal gel'},
		{id:'gen_diaz1', name:'diazoxide'},
		{id:'gen_diba1', name:'dibasic sodium phosphate'},
		{id:'dn_dicl1', name:'Diclegis (doxylamine succinate pyridoxine hydrochloride)'},
		{id:'gen_dicl1', name:'diclofenac epolamine topical patch'},
		{id:'g184', name:'diclofenac sodium'},
		{id:'g185', name:'diclofenac sodium ophthalmic solution'},
		{id:'g186', name:'diclofenac sodium/misoprostol'},
		{id:'g187', name:'dicyclomine HCl'},
		{id:'dn_didr2', name:'Didrex (benzphetamine hydrochloride)'},
		{id:'dn_diff1', name:'Differin Gel (adapalene gel)'},
		{id:'dn_diff2', name:'Differin Lotion Pump (adapalene)'},
		{id:'dn_difi1', name:'Dificid (fidaxomicin)'},
		{id:'dn_difl2', name:'Diflucan (fluconazole)'},
		{id:'g194', name:'digoxin tablets'},
		{id:'g724', name:'dihydroergotamine mesylate'},
		{id:'dn_dila2', name:'Dilacor XR (diltiazem hydrochloride)'},
		{id:'dn_DILA1', name:'Dilantin (phenytoin)'},
		{id:'gen_dilt1', name:'diltiazem ER dilt-cd'},
		{id:'gen_dilt2', name:'diltiazem hydrochloride'},
		{id:'gen_dime1', name:'dimethyl fumarate'},
		{id:'dn_DIPE1', name:'Dipentum (olsalazine sodium)'},
		{id:'gen_diph1', name:'diphenoxylate/atropine'},
		{id:'gen_diph2', name:'diphtheria CRM197 protein'},
		{id:'dn_dipr2', name:'Diprolene AF (betamethasone dipropionate)'},
		{id:'g804', name:'disopyramide phosphate'},
		{id:'dn_DITR1', name:'Ditropan (oxybutynin chloride)'},
		{id:'dn_DITR2', name:'Ditropan XL (oxybutynin chloride)'},
		{id:'g199', name:'divalproex sodium'},
		{id:'g693', name:'dofetilide'},
		{id:'gen_dolu1', name:'dolutegravir'},
		{id:'g203', name:'donepezil HCI'},
		{id:'g204', name:'dornase alfa'},
		{id:'g205', name:'dorzolamide chloride/timolol maleate'},
		{id:'g206', name:'dorzolamide HCl ophthalmic solution'},
		{id:'g207', name:'doxazosin mesylate'},
		{id:'gen_doxe1', name:'doxepin'},
		{id:'dn_doxe1', name:'Doxepin Capsule (doxepin)'},
		{id:'g739', name:'doxercalciferol'},
		{id:'dn_DOXI1', name:'Doxil Injection (doxorubicin HCl liposome injection)'},
		{id:'g211', name:'doxorubicin HCl liposome injection'},
		{id:'gen_doxy1', name:'doxylamine succinate pyridoxine hydrochloride'},
		{id:'g213', name:'dronabinol'},
		{id:'gen_dron1', name:'dronedarone hydrochloride'},
		{id:'gen_dros1', name:'drospirenone/estradiol'},
		{id:'dn_DROX1', name:'Droxia (hydroxyurea)'},
		{id:'gen_droz1', name:'drozolamide hydrachloride/timelol maleate opthalmic solution'},
		{id:'dn_duac1', name:'Duac Topical Gel (clindamycin phosphate 1%, benzoyl peroxide 5%)'},
		{id:'dn_duav1', name:'Duavee (conjugated estrogens/bazedoxifene)'},
		{id:'dn_dule1', name:'Dulera (mometasone furoate/formoterol fumarate dihydrate)'},
		{id:'g752', name:'duloxetine HCl'},
		{id:'dn_DURA1', name:'Duragesic CII (fentanyl transdermal system)'},
		{id:'g214', name:'dutasteride'},
		{id:'gen_duta1', name:'dutasteride and tamsulosin'},
		{id:'dn_DYAZ1', name:'Dyazide (triamterene hydrochlorothiazide)'},
		{id:'dn_dyna2', name:'Dynacin (minocycline HCL)'},
		{id:'gen_ecal1', name:'ecallantide'},
		{id:'gen_ecul1', name:'eculizumab'},
		{id:'dn_EDEC1', name:'Edecrin Tablets (ethacrynic acid)'},
		{id:'dn_edur1', name:'Edurant (rilpivirne)'},
		{id:'g216', name:'efavirenz'},
		{id:'gen_efav1', name:'efavirenz/emtricitabine/tenofovir'},
		{id:'dn_EFFE1', name:'Effexor (venlafaxine HCl)'},
		{id:'dn_EFFE2', name:'Effexor XR (venlafaxine HCl)'},
		{id:'dn_effi1', name:'Effient (prasugrel)'},
		{id:'dn_elap1', name:'Elaprase (idursulfase)'},
		{id:'dn_elel1', name:'Elelyso (taliglucerase alfa)'},
		{id:'g690', name:'eletriptan HBr'},
		{id:'dn_ELID1', name:'Elidel (pimecrolimus)'},
		{id:'dn_elig1', name:'Eligard (leuprolide)'},
		{id:'dn_eliq1', name:'Eliquis (apixaban)'},
		{id:'dn_elit1', name:'Elitek (rasburicase)'},
		{id:'dn_ELMI1', name:'Elmiron (pentosan polysulfate sodium)'},
		{id:'dn_ELOC1', name:'Elocon (mometasone furoate)'},
		{id:'gen_eltr1', name:'eltrombopag'},
		{id:'gen_elvi1', name:'elvitegravir, cobicistat, emtricitabine, tenofovir disoproxil fumarate'},
		{id:'dn_emad1', name:'Emadine Ophthalmic solution (emedastine)'},
		{id:'dn_embe1', name:'Embeda CII (morphine sulfate and naltrexone hydrochloride)'},
		{id:'dn_EMCY1', name:'Emcyt (estramustine phosphate sodium)'},
		{id:'gen_emed1', name:'emedastine'},
		{id:'dn_EMEN1', name:'Emend (aprepitant)'},
		{id:'dn_emen2', name:'Emend for Injection (fosaprepitant dimeglumine)'},
		{id:'g715', name:'emtricitabine'},
		{id:'gen_emtr1', name:'emtricitabine oral solution'},
		{id:'gen_emtr2', name:'emtricitabine/rilpivirine/tenofovir disoproxil fumarate'},
		{id:'dn_EMTR1', name:'Emtriva (emtricitabine) '},
		{id:'dn_emtr2', name:'Emtriva Oral Solution (emtricitabine oral solution)'},
		{id:'gen_enal2', name:'enalapril maleate'},
		{id:'gen_enal1', name:'enalapril/hctz'},
		{id:'dn_ENBR1', name:'Enbrel (etanercept)'},
		{id:'gen_enfu1', name:'enfuvirtide'},
		{id:'dn_enge1', name:'Engerix-B'},
		{id:'g220', name:'enoxaparin sodium'},
		{id:'g818', name:'entecavir'},
		{id:'gen_entr1', name:'entravirine'},
		{id:'dn_epan1', name:'Epanova (omega-3-carboxylic acids)'},
		{id:'dn_epid1', name:'Epiduo (adapalene and benzoyl peroxide)'},
		{id:'gen_epin1', name:'epinephrine injection, USP'},
		{id:'dn_EPIV1', name:'Epivir (lamivudine)'},
		{id:'dn_EPIV2', name:'Epivir-HBV (lamivudine)'},
		{id:'g728', name:'eplerenone'},
		{id:'g223', name:'epoetin alfa'},
		{id:'g224', name:'epoetin alfa'},
		{id:'dn_EPOG1', name:'Epogen (epoetin alfa)'},
		{id:'g225', name:'epoprostenol'},
		{id:'g226', name:'eprosartan mesylate'},
		{id:'gen_epro1', name:'eprosartan mesylate hydrochlorothiazide'},
		{id:'dn_EPZI1', name:'Epzicom (abacavir sulfate and lamivudine) Tablets'},
		{id:'dn_eque1', name:'Equetro (carbamazepine)'},
		{id:'dn_erax1', name:'Eraxis (anidulafungin IV)'},
		{id:'dn_ERBI1', name:'Erbitux (cetuximab)'},
		{id:'gen_erib1', name:'eribulin mesylate'},
		{id:'dn_eriv1', name:'Erivedge (vismodegib)'},
		{id:'g759', name:'erlotinib'},
		{id:'dn_erwi1', name:'Erwinaze (asparaginase Erwinia chrysanthemi)'},
		{id:'g230', name:'esomeprazole magnesium'},
		{id:'gen_esom1', name:'esomeprazole sodium injection'},
		{id:'dn_estr8', name:'Estrace (estradiol)'},
		{id:'g232', name:'estradiol'},
		{id:'g790', name:'estradiol cypionate'},
		{id:'g233', name:'estradiol hemihydrate'},
		{id:'g234', name:'estradiol transdermal system'},
		{id:'g235', name:'estradiol vaginal ring'},
		{id:'g712', name:'estradiol/levonorgestrel'},
		{id:'g237', name:'estradiol/norethindrone acetate tablets'},
		{id:'g238', name:'estramustine phosphate sodium'},
		{id:'dn_ESTR3', name:'Estring (estradiol vaginal ring)'},
		{id:'g239', name:'estrogens conjugated'},
		{id:'g240', name:'estrogens conjugated/medroxyprogesterone'},
		{id:'g805', name:'estropipate'},
		{id:'g242', name:'etanercept'},
		{id:'gen_etha1', name:'ethacrynic acid'},
		{id:'g244', name:'ethionamide'},
		{id:'g245', name:'ethosuximide'},
		{id:'g249', name:'etodolac'},
		{id:'dn_ETOP1', name:'Etopophos (etoposide)'},
		{id:'g250', name:'etoposide'},
		{id:'gen_ever1', name:'everolimus'},
		{id:'dn_EVIS1', name:'Evista (raloxifene)'},
		{id:'dn_evox1', name:'Evoxac (cevimeline HCl)'},
		{id:'dn_EXEL1', name:'Exelon (rivastigmine tartrate)'},
		{id:'dn_exel3', name:'Exelon Patch (rivastigmine transdermal system)'},
		{id:'g252', name:'exemestane'},
		{id:'gen_exen1', name:'exenatide'},
		{id:'dn_exfo1', name:'Exforge (amlodipine and valsartan)'},
		{id:'dn_exfo2', name:'Exforge HCT (amiodipine valsartan hydrochlorothiazide) '},
		{id:'dn_exja1', name:'Exjade (deferasirox)'},
		{id:'dn_exta1', name:'Extavia (interferon beta-1b)'},
		{id:'gen_eyed1', name:'eye drops'},
		{id:'gen_eyeo1', name:'eye ointment'},
		{id:'gen_eyev1', name:'eye vitamin'},
		{id:'dn_eyes2', name:'Eye-Stream Irrigating Solution (balanced eye salt with preservatives)'},
		{id:'dn_eyle1', name:'Eylea (aflibercept)'},
		{id:'g748', name:'ezetimibe'},
		{id:'gen_ezet1', name:'ezetimibe/atorvastatin'},
		{id:'g747', name:'ezetimibe/simvastatin'},
		{id:'gen_ezog1', name:'ezogabine'},
		{id:'dn_fabi1', name:'Fabior (tazarotene) Foam'},
		{id:'dn_FABR1', name:'Fabrazyme (agalsidase beta)'},
		{id:'gen_fact1', name:'factor xiii concentrate'},
		{id:'g254', name:'famotidine tablets and oral suspension'},
		{id:'dn_fana1', name:'Fanapt (iloperidone)'},
		{id:'dn_FARE1', name:'Fareston (toremifene citrate)'},
		{id:'dn_farx1', name:'Farxiga (dapagliflozin)'},
		{id:'dn_FASL1', name:'Faslodex (fulvestrant)'},
		{id:'gen_faxt1', name:'faxtor ix complex'},
		{id:'gen_febu1', name:'febuxostat'},
		{id:'dn_feib1', name:'Feiba VH (anti-inhibitor coagulant)'},
		{id:'g255', name:'felbamate'},
		{id:'dn_FELB1', name:'Felbatol (felbamate)'},
		{id:'dn_FELD1', name:'Feldene (piroxicam)'},
		{id:'g256', name:'felodipine'},
		{id:'dn_FEMA1', name:'Femara (letrozole)'},
		{id:'g257', name:'fenofibrate'},
		{id:'gen_fent1', name:'fentanyl buccal'},
		{id:'g258', name:'fentanyl transdermal system'},
		{id:'dn_fent1', name:'Fentora (fentanyl buccal)'},
		{id:'dn_fera1', name:'Feraheme Injection (ferumoxytol)'},
		{id:'gen_ferr1', name:'ferric carboxymaltose'},
		{id:'gen_feru1', name:'ferumoxytol'},
		{id:'gen_feso1', name:'fesoterodine fumarate'},
		{id:'dn_fetz1', name:'Fetzima (levomilnacipran) Extended Release Capsules'},
		{id:'dn_fetz2', name:'Fetzima Titration Pack (levomilnacipran) Extended Release Capsules '},
		{id:'gen_fibr1', name:'fibrinogen concentrate'},
		{id:'g261', name:'filgrastim'},
		{id:'dn_fina1', name:'Finacea (azelaic acid) Gel 15%'},
		{id:'g262', name:'finasteride tablets'},
		{id:'gen_fing1', name:'fingolimod'},
		{id:'dn_fira1', name:'Firazyr (icatibant injection)'},
		{id:'dn_FLAG1', name:'Flagyl (metronidazole)'},
		{id:'dn_flar1', name:'Flarex (fluorometholone)'},
		{id:'dn_flec1', name:'Flector Patch (diclofenac epolamine topical patch)'},
		{id:'dn_FLEX1', name:'Flexeril (cyclobenzaprine HCl)'},
		{id:'dn_FLOL1', name:'Flolan (epoprostenol)'},
		{id:'dn_FLOM1', name:'Flomax (tamsulosin HCl)'},
		{id:'dn_FLON1', name:'Flonase (fluticasone propionate nasal spray)'},
		{id:'dn_FLOV1', name:'Flovent Diskus (fluticasone propionate)'},
		{id:'dn_FLOV2', name:'Flovent HFA (fluticasone propionate)'},
		{id:'dn_FLOX1', name:'Floxin (oxfloxacin)'},
		{id:'gen_fluc1', name:'flucinolone acetonide/hydroquinone/tretinoin'},
		{id:'gen_fluc2', name:'fluconazole'},
		{id:'g266', name:'flucytosine'},
		{id:'gen_fluo2', name:'fluorometholone'},
		{id:'g271', name:'fluoxetine HCl'},
		{id:'gen_flut2', name:'fluticasone furoate'},
		{id:'gen_flut3', name:'fluticasone furoate and vilanterol inhalation powder'},
		{id:'g275', name:'fluticasone propionate'},
		{id:'g277', name:'fluticasone propionate nasal spray'},
		{id:'g279', name:'fluticasone propionate rotadisk'},
		{id:'gen_flut1', name:'fluticasone propionate/salmeterol'},
		{id:'g280', name:'fluticasone propionate/salmeterol diskus'},
		{id:'dn_foca2', name:'Focalin XR (dexmethylphenidate HCl extended release)'},
		{id:'dn_foli1', name:'Folic Acid Tablets'},
		{id:'g282', name:'fondaparinux'},
		{id:'dn_FORA2', name:'Foradil Aerolizer (formoterol fumarate inhalation powder) '},
		{id:'g700', name:'formoterol fumarate inhalation powder'},
		{id:'dn_FORT3', name:'Forteo (teriparatide)'},
		{id:'dn_FOSA1', name:'Fosamax Tablets (alendronate sodium tablets)'},
		{id:'gen_fosa1', name:'fosamprenavir calcium'},
		{id:'g702', name:'fosamprenavir calcium tablets'},
		{id:'gen_fosa2', name:'fosaprepitant dimeglumine'},
		{id:'dn_fosr1', name:'Fosrenol (lanthanum carbonate)'},
		{id:'dn_FRAG1', name:'Fragmin (dalteparin sodium)'},
		{id:'dn_frov1', name:'Frova (frovatriptan succinate)'},
		{id:'gen_frov1', name:'frovatriptan succinate'},
		{id:'g286', name:'fulvestrant'},
		{id:'g287', name:'furosemide'},
		{id:'dn_fusi2', name:'Fusilev (levoleucovorin)'},
		{id:'dn_fuze1', name:'Fuzeon (enfuvirtide)'},
		{id:'g288', name:'gabapentin'},
		{id:'dn_GABI1', name:'Gabitril (tiagabine hydrochloride)'},
		{id:'g289', name:'galantamine HBr'},
		{id:'dn_GALZ1', name:'Galzin (zinc acetate)'},
		{id:'dn_gard1', name:'Gardasil (quadrivalent human papillomavirus) '},
		{id:'dn_gazy1', name:'Gazyva (obinutuzumab)'},
		{id:'g294', name:'gemcitabine HCl'},
		{id:'g295', name:'gemfibrozil'},
		{id:'dn_GEMZ1', name:'Gemzar (gemcitabine HCl)'},
		{id:'dn_GENG1', name:'Gengraf Capsules (cyclosporine capsules)'},
		{id:'dn_GENO1', name:'Genotropin (somatotropin)'},
		{id:'gen_gent1', name:'gentamicin'},
		{id:'dn_gent2', name:'Gentamicin Ophthalmic solution (gentamicin)'},
		{id:'dn_GEOD1', name:'Geodon (ziprasidone HCl)'},
		{id:'dn_gile1', name:'Gilenya (fingolimod)'},
		{id:'g297', name:'glatiramer acetate for injection'},
		{id:'dn_GLEE1', name:'Gleevec (imatinib mesylate)'},
		{id:'dn_glia1', name:'Gliadel Wafer (polifeprosan 20 with carmustine implant)'},
		{id:'g298', name:'glimepiride'},
		{id:'g299', name:'glipizide'},
		{id:'g300', name:'glipizide extended release'},
		{id:'dn_gluc7', name:'GlucaGen HypoKit (glucagon (rDNA) for injection)'},
		{id:'g302', name:'glucagon'},
		{id:'dn_GLUC1', name:'Glucagon (glucagon)'},
		{id:'g844', name:'glucagon (rDNA) for injection'},
		{id:'dn_GLUC2', name:'Glucophage (metformin HCl)'},
		{id:'dn_GLUC3', name:'Glucophage XR (metformin HCl)'},
		{id:'dn_GLUC4', name:'Glucotrol (glipizide)'},
		{id:'dn_GLUC5', name:'Glucotrol XL Extended Release (glipizide extended release)'},
		{id:'dn_GLUC6', name:'Glucovance (glyburide/metformin HCl)'},
		{id:'g304', name:'glyburide/metformin HCl'},
		{id:'gen_glyc2', name:'glycerol phenylbutyrate'},
		{id:'dn_glyn3', name:'Glynase PresTab (micronized glyburide) '},
		{id:'dn_GLYS1', name:'Glyset (miglitol)'},
		{id:'gen_goli1', name:'golimumab'},
		{id:'g305', name:'goserelin acetate implant'},
		{id:'g306', name:'granisetron'},
		{id:'dn_gran1', name:'Granix (tbo-filgrastim)'},
		{id:'gen_guan1', name:'guanfacine'},
		{id:'dn_hala1', name:'Halaven (eribulin mesylate)'},
		{id:'dn_halc1', name:'Halcion (triazolam USP)'},
		{id:'dn_HALD2', name:'Haldol Decanoate Injection (haloperidol decanoate injection)'},
		{id:'dn_HALD1', name:'Haldol Injectable (haloperidol injectable)'},
		{id:'gen_halo1', name:'haloperidol'},
		{id:'g310', name:'haloperidol decanoate injection'},
		{id:'g311', name:'haloperidol injectible'},
		{id:'dn_halo2', name:'Haloperidol Tablet (haloperidol) '},
		{id:'dn_havr1', name:'Havrix'},
		{id:'dn_HECT1', name:'Hectorol (doxercalciferol)'},
		{id:'dn_heli1', name:'Helixate FS (antihemophilic factor)'},
		{id:'dn_hema1', name:'Hemabate (carboprost tromethamine USP)'},
		{id:'dn_hemo1', name:'Hemofil-M (antihemophilic factor)'},
		{id:'gen_hepa1', name:'hepatitis a vaccine, inactivated'},
		{id:'dn_HEPS1', name:'Hepsera (adefoir dipivoxil)'},
		{id:'dn_HERC1', name:'Herceptin (trastuzumab)'},
		{id:'dn_hetl1', name:'Hetlioz (tasimelteon) '},
		{id:'dn_HEXA1', name:'Hexalen (altretamine)'},
		{id:'dn_hize1', name:'Hizentra Subcutaneous 20% (immune globulin)'},
		{id:'dn_HUMA2', name:'Humalog (insulin lispro injection)'},
		{id:'dn_huma5', name:'Humalog 50/50 (50% insulin lispro protamine suspension and 50% insulin lispro injection)'},
		{id:'dn_HUMA1', name:'Humalog 75/25 (75% insulin lispro protamine suspension and 25% insulin lispro injection)'},
		{id:'dn_huma4', name:'Humate-P (antihemophilic factor)'},
		{id:'dn_huma3', name:'Humatrope (somatropin [rDNA origin] for injection)'},
		{id:'dn_HUMI1', name:'Humira (adalimumab)'},
		{id:'dn_HUMU2', name:'Humulin 70/30 (insulin, human, 70 % NPH/30 % regular human insulin)'},
		{id:'dn_HUMU4', name:'Humulin N (insulin, human, isophane suspension, NPH)'},
		{id:'dn_HUMU5', name:'Humulin R (insulin, human, regular)'},
		{id:'dn_humu7', name:'Humulin R U-500 (regular insulin human injection)'},
		{id:'dn_HYAL1', name:'Hyalgan (sodium hyaluronate)'},
		{id:'g830', name:'hyaluronan'},
		{id:'dn_HYCA1', name:'Hycamtin (topotecan HCI)'},
		{id:'gen_hydr3', name:'hydralazine'},
		{id:'dn_hydr3', name:'Hydralazine Tablet (hydralazine)'},
		{id:'dn_HYDR1', name:'Hydrea (hydroxyurea)'},
		{id:'gen_hydr4', name:'hydrochlorothiazide'},
		{id:'dn_hydr4', name:'Hydrochlorothiazide Tablet (hydrochlorothiazide)'},
		{id:'g313', name:'hydrochlorothiazide/losartan potassium'},
		{id:'g737', name:'hydrocortisone'},
		{id:'gen_hydr2', name:'hydrocortisone butyrate'},
		{id:'gen_hydr1', name:'hydrocortisone/pramoxine'},
		{id:'g318', name:'hydroxychloroquine sulfate'},
		{id:'g319', name:'hydroxypropyl cellulose ophthalmic insert'},
		{id:'g320', name:'hydroxyurea'},
		{id:'g322', name:'hydroxyzine pamoate'},
		{id:'gen_hyla1', name:'hylan g-f 20'},
		{id:'dn_hyla1', name:'Hylatopic Plus Foam'},
		{id:'dn_HYTR1', name:'Hytrin (terazosin HCl)'},
		{id:'dn_HYZA1', name:'Hyzaar (hydrochlorothiazide/losartan potassium) '},
		{id:'dn_ibra1', name:'Ibrance (palbociclib)'},
		{id:'gen_ibru1', name:'ibrutinib'},
		{id:'g803', name:'ibuprofen'},
		{id:'gen_ibut1', name:'ibutilide fumarate'},
		{id:'dn_icap1', name:'ICaps Multivitamin Formula (eye vitamin)'},
		{id:'gen_icat1', name:'icatibant injection'},
		{id:'dn_IDAM1', name:'Idamycin (idarubicin HCl)'},
		{id:'g323', name:'idarubicin HCl'},
		{id:'gen_idur1', name:'idursulfase'},
		{id:'dn_ilar2', name:'Ilaris (canakinumab)'},
		{id:'gen_ilop1', name:'iloperidone'},
		{id:'g325', name:'imatinib mesylate'},
		{id:'dn_imbr1', name:'Imbruvica (ibrutinib)'},
		{id:'dn_IMDU1', name:'Imdur (isosorbide mononitrate)'},
		{id:'g326', name:'imiglucerase injection'},
		{id:'dn_IMIT1', name:'Imitrex Injection (sumatriptan succinate)'},
		{id:'dn_IMIT2', name:'Imitrex Nasal Spray (sumatriptan succinate)'},
		{id:'gen_immu1', name:'immune globulin'},
		{id:'g328', name:'immune globulin Rho (D)'},
		{id:'dn_IMOG1', name:'Imogam Rabies-HT (rabies immune globulin, human, post exposure basis only)'},
		{id:'dn_IMOV1', name:'Imovax Rabies Vaccine (rabies vaccine, human diploid cell, post exposure basis only)'},
		{id:'gen_inco1', name:'incobotulinumtoxinA'},
		{id:'gen_inda2', name:'indacaterol inhalation powder'},
		{id:'gen_inda1', name:'indapamide'},
		{id:'dn_inda1', name:'Indapamide Tablet (indapamide)'},
		{id:'dn_INDE1', name:'Inderal (propranolol HCl)'},
		{id:'dn_INDE2', name:'Inderal LA (propranolol HCl)'},
		{id:'g329', name:'indinavir sulfate'},
		{id:'g331', name:'infliximab'},
		{id:'dn_inhi1', name:'Inh (isoniazid)'},
		{id:'gen_inje1', name:'injectable poly-L-lactic acid'},
		{id:'dn_inje1', name:'Injectafer (ferric carboxymaltose)'},
		{id:'dn_inly1', name:'Inlyta Tablets (axitinib)'},
		{id:'dn_inno1', name:'InnoPran XL (propanolol)'},
		{id:'dn_INSP1', name:'Inspra (eplerenone)'},
		{id:'g717', name:'insulin aspart injection'},
		{id:'g846', name:'insulin detemir (rDNA) injection'},
		{id:'g835', name:'insulin glulisine'},
		{id:'g750', name:'insulin lispro injection'},
		{id:'gen_insu1', name:'insulin pen needle'},
		{id:'dn_inte1', name:'Intelence Tablets (entravirine)'},
		{id:'g332', name:'interferon alfa-2b'},
		{id:'g334', name:'interferon beta'},
		{id:'g335', name:'interferon beta-1a'},
		{id:'gen_inte1', name:'interferon beta-1a IM injection'},
		{id:'gen_inte2', name:'interferon beta-1b'},
		{id:'gen_inte3', name:'interferon-gamma-1b'},
		{id:'dn_INTR1', name:'Intron-A (interferon alfa-2b) for Injection'},
		{id:'dn_intu1', name:'Intuniv Extended Release Tablets (guanfacine)'},
		{id:'dn_inve1', name:'Invega (paliperidone)'},
		{id:'dn_inve2', name:'Invega Sustenna (paliperidone palmitate)'},
		{id:'dn_INVI1', name:'Invirase (saquinavir mesylate)'},
		{id:'dn_invo1', name:'Invokana (canagliflozin)'},
		{id:'dn_IOPI1', name:'Iopidine (apraclonidine)'},
		{id:'gen_ipil1', name:'ipilimumab'},
		{id:'gen_ipra1', name:'ipranolol ophthalmic solution'},
		{id:'g336', name:'ipratopium bromide'},
		{id:'g338', name:'ipratopium bromide/albuterol sulfate'},
		{id:'g339', name:'irbesartan'},
		{id:'g340', name:'irbesartan/hydrochlorothiazide'},
		{id:'g341', name:'irinotecan HCl'},
		{id:'g343', name:'iron sucrose'},
		{id:'dn_isen1', name:'Isentress (raltegravir)'},
		{id:'dn_ismo1', name:'Ismo (isosorbide mononitrate,10mg 20mg)'},
		{id:'gen_isoc1', name:'isocarboxazid'},
		{id:'gen_ison1', name:'isoniazid'},
		{id:'dn_ISOP1', name:'Isoptin SR (verapamil HCl)'},
		{id:'dn_ISOP2', name:'Isopto Carbachol (carbachol)'},
		{id:'dn_ISOP3', name:'Isopto Carpine (pilocarpine HCl)'},
		{id:'gen_isos1', name:'isosorbide dinitrate/hydralazine hydrochloride'},
		{id:'g346', name:'isosorbide mononitrate'},
		{id:'dn_isto1', name:'Istodax Injection (romidepsin)'},
		{id:'g350', name:'itraconazole'},
		{id:'gen_ivac1', name:'ivacaftor'},
		{id:'gen_ixab1', name:'ixabepilone'},
		{id:'dn_ixem1', name:'Ixempra (ixabepilone)'},
		{id:'dn_jaka1', name:'Jakafi (ruxolitinib)'},
		{id:'dn_jaly1', name:'Jalyn (dutasteride and tamsulosin)'},
		{id:'dn_jant1', name:'Jantoven (warfarin)'},
		{id:'dn_janu2', name:'Janumet Tablets (sitagliptin/metformin HCl)'},
		{id:'dn_janu3', name:'Janumet XR (sitagliptin/metformin HCl)'},
		{id:'dn_janu1', name:'Januvia (sitagliptin phosphate)'},
		{id:'dn_jent1', name:'Jentadueto (linagliptin and metformin hydrochloride)'},
		{id:'dn_jevt1', name:'Jevtana (cabazitaxel)'},
		{id:'dn_juvi1', name:'Juvisync Tablets (sitagliptin/simvastatin)'},
		{id:'dn_KDUR1', name:'K-Dur (potassium chloride) '},
		{id:'dn_kpho2', name:'K-Phos M.F. Tablets (potassium and sodium acid phosphate)'},
		{id:'dn_kpho1', name:'K-Phos No.2 Tablets (potassium and sodium acid phosphate)'},
		{id:'dn_kpho3', name:'K-Phos Original Tablet (potassium and sodium acid phosphate)'},
		{id:'dn_kadc1', name:'Kadcyla (ado-trastuzumab emtansine)'},
		{id:'dn_kalb1', name:'Kalbitor (ecallantide)'},
		{id:'dn_KALE1', name:'Kaletra Capsules (lopinavir/ritonavir)'},
		{id:'dn_KALE2', name:'Kaletra Oral Solution (lopinavir/ritonavir)'},
		{id:'dn_kaly1', name:'Kalydeco (ivacaftor)'},
		{id:'dn_kaza1', name:'Kazano (alogliptin and metformin HCl)'},
		{id:'dn_KEPI1', name:'Kepivance (palifermin)'},
		{id:'dn_KEPP1', name:'Keppra (levetiracetam)'},
		{id:'dn_kepp2', name:'Keppra XR (levetiracetam)'},
		{id:'gen_keto2', name:'ketorolac'},
		{id:'gen_keto3', name:'ketorolac tromethamine'},
		{id:'dn_keyt1', name:'Keytruda (pembrolizumab)'},
		{id:'dn_KINE1', name:'Kineret (anakinra)'},
		{id:'dn_KLON1', name:'Klonopin (clonazepam)'},
		{id:'dn_klor4', name:'Klor-Con 10m EQ (potassium chloride ER)'},
		{id:'dn_klor3', name:'Klor-Con 20m EQ (potassium chloride ER)'},
		{id:'dn_klor2', name:'Klor-Con 8m EQ (potassium chloride ER)'},
		{id:'dn_klor5', name:'Klor-Con Powder (potassium chloride)'},
		{id:'dn_koge1', name:'Kogenate FS (antihemophilic factor)'},
		{id:'dn_komb1', name:'Kombiglyze XR (saxagliptin and metformin hcl)  '},
		{id:'dn_korl1', name:'Korlym Tablets (mifepristone)'},
		{id:'dn_krys1', name:'Krystexxa (pegloticase)'},
		{id:'dn_kuva1', name:'Kuvan (sapropterin dihydrochloride)'},
		{id:'dn_kyna1', name:'Kynamro Injection (mipomersen sodium)'},
		{id:'dn_kypr1', name:'Kyprolis (carfilzomib)'},
		{id:'gen_labe1', name:'labetalol HCL'},
		{id:'gen_laco1', name:'lacosamide'},
		{id:'dn_LACR1', name:'Lacrisert Ophthalmic Insert (hydroxypropyl cellulose) '},
		{id:'dn_LAMI1', name:'Lamictal (lamotrigine) Tablets, Chewable Dispersible Tablets or Orally Disintegrating Tablets'},
		{id:'dn_lami4', name:'Lamictal ODT Patient Titration Kits (lamotrigine)'},
		{id:'dn_lami5', name:'Lamictal Starter Kit (lamotrigine)'},
		{id:'dn_lami3', name:'Lamictal XR (lamotrigine)'},
		{id:'dn_lami6', name:'Lamictal XR Patient Titration Kits (lamotrigine) '},
		{id:'dn_LAMI2', name:'Lamisil (terbinafine hydrochloride)'},
		{id:'g356', name:'lamivudine'},
		{id:'g357', name:'lamivudine/zidovudine'},
		{id:'g358', name:'lamotrigine'},
		{id:'dn_LANO3', name:'Lanoxin Tablets (digoxin)'},
		{id:'gen_lant1', name:'lanthanum carbonate'},
		{id:'dn_LANT1', name:'Lantus (insulin glargine)'},
		{id:'gen_lapa1', name:'lapatinib tablets'},
		{id:'g819', name:'laronidase'},
		{id:'dn_LASI1', name:'Lasix (furosemide)'},
		{id:'g361', name:'latanoprost'},
		{id:'dn_latu1', name:'Latuda (lurasidone)'},
		{id:'g362', name:'leflunomide'},
		{id:'gen_lena1', name:'lenalidomide'},
		{id:'dn_leta1', name:'Letairis (ambrisentan)'},
		{id:'g363', name:'letrozole'},
		{id:'dn_LEUK2', name:'Leukine (sagostim)'},
		{id:'gen_leup1', name:'leuprolide'},
		{id:'g365', name:'leuprolide acetate'},
		{id:'gen_leup2', name:'leuprolide acetate for depot suspension and norethindrone acetate'},
		{id:'dn_LEUS1', name:'Leustatin (cladribine)'},
		{id:'dn_LEVA1', name:'Levaquin (levofloxacin)'},
		{id:'dn_leve1', name:'Levemir (insulin detemir (rDNA) injection)'},
		{id:'g366', name:'levetiracetam'},
		{id:'g367', name:'levobunolol HCl'},
		{id:'g368', name:'levocarnitine'},
		{id:'g370', name:'levofloxacin'},
		{id:'gen_levo2', name:'levoleucovorin'},
		{id:'gen_levo3', name:'levomilnacipran'},
		{id:'g371', name:'levothyroxine sodium'},
		{id:'dn_LEVO3', name:'Levoxyl (levothyroxine sodium)'},
		{id:'dn_LEXI1', name:'Lexiva (fosamprenavir calcium) Tablets '},
		{id:'dn_lexi2', name:'Lexiva Oral Suspension (fosamprenavir calcium)'},
		{id:'dn_lial1', name:'Lialda (mesalamine)'},
		{id:'gen_lido1', name:'lidocaine topical'},
		{id:'gen_lina3', name:'linaclotide'},
		{id:'gen_lina1', name:'linagliptin'},
		{id:'gen_lina2', name:'linagliptin and metformin hydrochloride'},
		{id:'dn_LINC1', name:'Lincocin (lincomycin hcl)'},
		{id:'g797', name:'lincomycin hcl'},
		{id:'g375', name:'linezolid tablets'},
		{id:'dn_linz1', name:'Linzess (linaclotide)'},
		{id:'dn_lior2', name:'Lioresal Tablet (baclofen)'},
		{id:'g681', name:'liothyronine sodium'},
		{id:'dn_LIPI1', name:'Lipitor (atorvastatin calcium)'},
		{id:'dn_lipo1', name:'Lipofen (fenofibrate)'},
		{id:'dn_lipt1', name:'Liptruzet (ezetimibe/atorvastatin)'},
		{id:'gen_lira1', name:'liraglutide (rDNA) injection'},
		{id:'gen_lisd1', name:'lisdexamfetamine dimesylate'},
		{id:'g377', name:'lisinopril'},
		{id:'g378', name:'lisinopril/hydrochlorothiazide'},
		{id:'g379', name:'lithium carbonate'},
		{id:'dn_lith3', name:'Lithium Carbonate Capsule (lithium carbonate)'},
		{id:'dn_lith2', name:'Lithostat (acetohydroxamic acid)'},
		{id:'dn_lmxl1', name:'LMX (lidocaine topical)'},
		{id:'dn_loco1', name:'Locoid Lipocream (hydrocortisone butyrate)'},
		{id:'dn_LODI1', name:'Lodine (etodolac)'},
		{id:'dn_LODO1', name:'Lodosyn (carbidopa)'},
		{id:'gen_lodo1', name:'lodoxamide tromethamine'},
		{id:'dn_lomo1', name:'Lomotil Tablet (diphenoxylate/atropine)'},
		{id:'dn_lono1', name:'Lonox (diphenoxylate/atropine tablet)'},
		{id:'dn_LOPI1', name:'Lopid (gemfibrozil)'},
		{id:'g382', name:'lopinavir/ritonavir capsules'},
		{id:'g383', name:'lopinavir/ritonavir oral solution'},
		{id:'dn_lopr1', name:'Lopressor Tablet (metoprolol tartrate) '},
		{id:'gen_lora1', name:'lorazepam'},
		{id:'g386', name:'losartan potassium'},
		{id:'dn_lote3', name:'Lotemax (loteprednol etabonate ophthalmic suspension)'},
		{id:'dn_LOTE2', name:'Lotensin HCT (benazapril HCl/hydrochlorothiazide)'},
		{id:'gen_lote3', name:'loteprednol etabonate and tobramycin ophthalmic suspension'},
		{id:'gen_lote1', name:'loteprednol etabonate ophthalmic suspension'},
		{id:'dn_LOTR1', name:'Lotrel (amlodipine besylate/benazepril HCI)'},
		{id:'g387', name:'lovastatin tablets'},
		{id:'dn_lova1', name:'Lovaza Capsules (omega-3-acid ethyl esters)'},
		{id:'dn_LOVE1', name:'Lovenox (enoxaparin sodium)'},
		{id:'g834', name:'lubiprostone'},
		{id:'gen_lubr1', name:'lubricant eye drops'},
		{id:'dn_LUMI1', name:'Lumigan (bimatoprost)'},
		{id:'dn_lumi2', name:'Lumizyme (alglucosidase alfa)'},
		{id:'dn_lupa1', name:'Lupaneta Pack (leuprolide acetate for depot suspension and norethindrone acetate) Tablets'},
		{id:'dn_lupr3', name:'Lupron Depot GYN (leuprolide acetate)'},
		{id:'dn_lupr1', name:'Lupron Depot PED (leuprolide acetate)'},
		{id:'dn_LUPR2', name:'Lupron Depot URO (leuprolide acetate)'},
		{id:'gen_lymp1', name:'lymphocyte immune globulin/anti-thymocyte globulin'},
		{id:'dn_LYRI1', name:'Lyrica (pregabalin)'},
		{id:'dn_LYSO1', name:'Lysodren (mitotane)'},
		{id:'dn_mmrl1', name:'M-M-R ll (measles, mumps, and rubella virus vaccine live) '},
		{id:'gen_maci1', name:'macitentan'},
		{id:'dn_macu1', name:'Macugen injection (pegaptanb sodium)'},
		{id:'dn_magt1', name:'Mag-Tab SR (magnesium L-lactate dihydrate)'},
		{id:'gen_magn1', name:'magnesium L-lactate dihydrate'},
		{id:'dn_MALA1', name:'Malarone (atovaquone/proguanil HCI)'},
		{id:'gen_mara1', name:'maraviroc'},
		{id:'dn_MARI1', name:'Marinol (dronabinol) '},
		{id:'dn_marp1', name:'Marplan Tablets (isocarboxazid)'},
		{id:'dn_MATU1', name:'Matulane (procarbazine HCl)'},
		{id:'dn_MAVI1', name:'Mavik (trandolapril)'},
		{id:'dn_MAXA2', name:'Maxalt Tablets (rizatriptan benzoate) '},
		{id:'dn_MAXA3', name:'Maxalt-MLT Orally Disintegrating Tablets (rizatriptan benzoate)'},
		{id:'dn_maxi1', name:'Maxidex Sphthalmic Suspension (dexamethasone)'},
		{id:'dn_maxi2', name:'Maxitrol Ophthalmic Ointment (neomycin/polymyxin/dexamethasone)'},
		{id:'dn_MAXZ1', name:'Maxzide (triamterene hydrochlorothiazide)'},
		{id:'gen_meas1', name:'measles, mumps, and rubella virus vaccine live'},
		{id:'gen_mech1', name:'mechlorethamine'},
		{id:'g389', name:'meclizine HCl'},
		{id:'dn_MEDR1', name:'Medrol (methylprednisolone)'},
		{id:'g390', name:'medroxyprogesterone acetate'},
		{id:'gen_medr1', name:'medroxyprogesterone acetate injectable suspension'},
		{id:'dn_mega1', name:'Megace ES (megestrol oral suspension)'},
		{id:'gen_mege1', name:'megestrol oral suspension'},
		{id:'dn_meki1', name:'Mekinist (trametinib)'},
		{id:'g393', name:'meloxicam'},
		{id:'g743', name:'memantine hcl'},
		{id:'dn_mena1', name:'Menactra Meningococcal (Groups A, C, Y and W-135) Polysaccharide Diphtheria Toxoid Conjugate Vaccine'},
		{id:'gen_meni1', name:'meningococcal polysaccharide vaccine - groups A, C, Y and W-135 combined'},
		{id:'dn_meno1', name:'Menomune-A/C/Y/W-135 (meningococcal polysaccharide vaccine - groups A, C, Y and W-135 combined)'},
		{id:'dn_meno2', name:'Menostar (estradiol transdermal) '},
		{id:'dn_MEPH1', name:'Mephyton Tablets (phytonadione)'},
		{id:'dn_MEPR1', name:'Mepron (atovaquone)'},
		{id:'g397', name:'mercaptopurine'},
		{id:'gen_mero1', name:'meropenem for injection'},
		{id:'dn_merr1', name:'Merrem I.V. (meropenem for injection)'},
		{id:'g398', name:'mesalamine'},
		{id:'dn_MEST1', name:'Mestinon (pyridostigmine bromide)'},
		{id:'g401', name:'metaxalone'},
		{id:'g402', name:'metformin HCl'},
		{id:'gen_meth3', name:'Methenamine, Sodium Phosphate Monobasic, Phenyl Salicylate, Methylene Blue, Hyoscyamine Sulfate'},
		{id:'g404', name:'methotrexate sodium injection'},
		{id:'dn_METH1', name:'Methotrexate Tablet (methotrexate sodium)'},
		{id:'g405', name:'methoxsalen lotion & ultra'},
		{id:'g406', name:'methsuximide'},
		{id:'g407', name:'methylphenidate HCl'},
		{id:'gen_meth4', name:'methylphenidate hydrochloride'},
		{id:'g800', name:'methylprednisolone'},
		{id:'g409', name:'metipranolol HCl opthalmic solution'},
		{id:'dn_METI1', name:'Metipranolol Opthalmic Solution (metipranolol HCl)'},
		{id:'gen_meto1', name:'metoclopramide HCL'},
		{id:'g410', name:'metolazone'},
		{id:'g411', name:'metoprolol succinate'},
		{id:'gen_meto2', name:'metoprolol tartrate'},
		{id:'g792', name:'metronidazole'},
		{id:'g414', name:'metyrosine capsules'},
		{id:'dn_MEVA1', name:'Mevacor Tablets (lovastatin) '},
		{id:'g793', name:'micronized glyburide'},
		{id:'dn_micr2', name:'Microzide (hydrochlorothiazide)'},
		{id:'gen_mife1', name:'mifepristone'},
		{id:'g417', name:'miglitol'},
		{id:'dn_MIGR2', name:'Migranal (dihydroergotamine mesylate)'},
		{id:'gen_miln1', name:'milnacipran HCl'},
		{id:'dn_MINI1', name:'Minipress (prazosin HCI)'},
		{id:'dn_MINO1', name:'Minocin (minocycline HCl)'},
		{id:'g419', name:'minocycline HCl'},
		{id:'gen_mipo1', name:'mipomersen sodium'},
		{id:'dn_MIRA1', name:'Mirapex (pramipexole dihydrochloride)'},
		{id:'dn_mira2', name:'Mirapex Extended Release (pramipexole dihydrochloride)'},
		{id:'g420', name:'mirtazapine'},
		{id:'g421', name:'misoprostol'},
		{id:'g423', name:'mitotane'},
		{id:'dn_MOBI1', name:'Mobic (meloxicam)'},
		{id:'dn_mode1', name:'Moderiba (ribavirin)'},
		{id:'g427', name:'mometasone furoate'},
		{id:'g837', name:'mometasone furoate inhalation powder'},
		{id:'gen_mome1', name:'mometasone furoate/formoterol fumarate dihydrate'},
		{id:'dn_mono3', name:'Monoclate-P (antihemophilic factor)'},
		{id:'dn_mono5', name:'Monoket (isosorbide mononitrate,10mg 20mg)'},
		{id:'dn_mono4', name:'Mononine (coagulation factor IX)'},
		{id:'g429', name:'montelukast sodium tablets and chewable tablets'},
		{id:'gen_morp1', name:'morphine sulfate and naltrexone hydrochloride'},
		{id:'gen_morp2', name:'morphine sulfate extended-release'},
		{id:'dn_MOTR1', name:'Motrin (ibuprofen)'},
		{id:'g432', name:'moxifloxacin HCl'},
		{id:'gen_moxi1', name:'moxifloxacin hcl'},
		{id:'dn_mozo1', name:'Mozobil (plerixa)'},
		{id:'dn_uris2', name:'Multaq (dronedarone hydrochloride)'},
		{id:'g434', name:'mupirocin'},
		{id:'dn_MYCE1', name:'Mycelex Troche (clotrimazole)'},
		{id:'dn_MYCO1', name:'Mycobutin (rifabutin)'},
		{id:'g435', name:'mycophenolate mofetil'},
		{id:'g749', name:'mycophenolic acid'},
		{id:'dn_mydf1', name:'Mydfrin Ophthalmic Solution (phenylephrine)'},
		{id:'dn_mydr1', name:'Mydriacyl Ophthalmic Drops (tropicamide)'},
		{id:'dn_MYFO1', name:'Myfortic (mycophenolic acid)'},
		{id:'dn_myoz1', name:'Myozyme (alglucosidase alfa)'},
		{id:'dn_MYSO1', name:'Mysoline (primidone)'},
		{id:'g436', name:'nabumetone'},
		{id:'dn_nabu1', name:'Nabumetone Tablet (nabumetone)'},
		{id:'g679', name:'nadolol'},
		{id:'g806', name:'nafarelin acetate solution'},
		{id:'dn_name4', name:'Namenda Oral Solutions (memantine hcl)'},
		{id:'dn_NAME1', name:'Namenda Tablets (memantine hcl)'},
		{id:'dn_NAME2', name:'Namenda Titration Pak (memantine hcl)'},
		{id:'dn_name3', name:'Namenda XR Extended Release Capsules (memantine hcl)'},
		{id:'g707', name:'naphazoline hydrochloride'},
		{id:'dn_naph1', name:'Naphcon A Eye Drops (naphazoline hydrochloride and pheniramine maleate)'},
		{id:'dn_NAPR1', name:'Naprosyn (naproxen)'},
		{id:'g438', name:'naproxen'},
		{id:'gen_napr1', name:'naproxen and esomeprazole magnesium'},
		{id:'dn_NARD1', name:'Nardil (phenelzine sulfate)'},
		{id:'dn_nasc1', name:'Nascobal USP (cyanocobalamin)'},
		{id:'dn_NASO1', name:'Nasonex (mometasone furoate)'},
		{id:'dn_nata1', name:'Natacyn Ophthalmic Suspension (natamycin)'},
		{id:'gen_nata1', name:'natalizumab'},
		{id:'gen_nata2', name:'natamycin'},
		{id:'dn_natr1', name:'Natrecor (nesiritide)'},
		{id:'gen_nebi1', name:'nebivolol tablets'},
		{id:'g836', name:'nelarabine'},
		{id:'g443', name:'nelfinavir mesylate'},
		{id:'gen_neom1', name:'Neomycin/Polymyxin B/Hydrocortisone'},
		{id:'gen_neom2', name:'neomycin/polymyxin/dexamethasone'},
		{id:'dn_NEOR1', name:'Neoral (cyclosporine)'},
		{id:'g444', name:'neostigmine methylsulfate tablets'},
		{id:'dn_nesi1', name:'Nesina (alogliptin) '},
		{id:'g833', name:'nesiritide'},
		{id:'dn_NEUL1', name:'Neulasta (pegfilgrastim)'},
		{id:'dn_NEUM1', name:'Neumega (oprelvekin)'},
		{id:'dn_NEUP1', name:'Neupogen (filgrastim)'},
		{id:'dn_neup2', name:'Neupro (rotigotine transdermal system)'},
		{id:'dn_NEUR1', name:'Neurontin (gabapentin) '},
		{id:'g445', name:'nevirapine'},
		{id:'dn_nexa1', name:'Nexavar (sorafenib)'},
		{id:'dn_NEXI1', name:'Nexium (esomeprazole magnesium) '},
		{id:'dn_nexi3', name:'Nexium For Oral Suspension (esomeprazole magnesium) '},
		{id:'dn_nexi2', name:'Nexium I.V. Injection (esomeprazole sodium)'},
		{id:'g771', name:'nicotine nasal spray'},
		{id:'dn_NICO2', name:'Nicotrol (nicotine)'},
		{id:'g449', name:'nifedipine'},
		{id:'gen_nilo1', name:'nilotinib'},
		{id:'gen_nita1', name:'nitazoxanide'},
		{id:'gen_niti1', name:'nitisinone'},
		{id:'g454', name:'nitroglycerin'},
		{id:'gen_nitr1', name:'nitroglycerin sublingual'},
		{id:'dn_nitr8', name:'Nitromist Nitroglycerin Lingual Aerosol'},
		{id:'dn_nitr7', name:'Nitroquick Tablet (nitroglycerin sublingual)'},
		{id:'dn_NITR4', name:'Nitrostat (nitroglycerin)'},
		{id:'gen_nivo1', name:'nivolumab'},
		{id:'g455', name:'norethindrone acetate'},
		{id:'g826', name:'norgestimate/ethinyl estradiol'},
		{id:'dn_NORP1', name:'Norpace (disopyramide phosphate)'},
		{id:'gen_nort1', name:'nortriptyline HCL'},
		{id:'dn_NORV1', name:'Norvasc (amlodipine besylate)'},
		{id:'dn_NORV2', name:'Norvir Capsules (ritonavir)'},
		{id:'dn_NORV3', name:'Norvir Oral Solution (ritonavir)'},
		{id:'dn_novo10', name:'Novofine (insulin pen needle)'},
		{id:'dn_NOVO1', name:'Novolin 70/30 PenFill (insulin, human, 70 % NPH/30 % regular human insulin PenFill)'},
		{id:'dn_NOVO4', name:'Novolin N PenFill (insulin, human, isophane suspension NPH PenFill)'},
		{id:'dn_NOVO6', name:'Novolin R PenFill (insulin, human,  regular)'},
		{id:'dn_NOVO8', name:'NovoLog (insulin aspart injection)'},
		{id:'dn_NOVO9', name:'Novolog Mix 70/30 (insulin aspart protamine suspension 70% and 30% insulin aspart injection)'},
		{id:'dn_noxa2', name:'Noxafil Delayed Release Tablets (posaconazole)'},
		{id:'dn_noxa1', name:'Noxafil Oral Suspension (posaconazole)'},
		{id:'dn_npla1', name:'Nplate (romiplostim)'},
		{id:'dn_nucy1', name:'Nucynta immediate-release oral tablets C-II (tapentadol) '},
		{id:'dn_nued1', name:'Nuedexta (dextromethorphan hydrobromide and quinidine sulfate) '},
		{id:'dn_nulo1', name:'Nulojix (belatacept)'},
		{id:'dn_nuvi1', name:'Nuvigil (armodafinil)'},
		{id:'gen_obin1', name:'obinutuzumab'},
		{id:'g463', name:'octreotide acetate'},
		{id:'dn_ocuf1', name:'Ocuflox Ophthalmic Solution (ofloxacin)'},
		{id:'dn_OCUP1', name:'Ocupress (carteolol hydrochloride)'},
		{id:'gen_ofat1', name:'ofatumumab'},
		{id:'gen_oflo1', name:'ofloxacin'},
		{id:'dn_OGEN1', name:'Ogen (estropipate)'},
		{id:'g751', name:'olanzapine and fluoxetine HCl'},
		{id:'g464', name:'olanzepine'},
		{id:'g465', name:'olmesartan medoxomil'},
		{id:'gen_olme1', name:'olmesartan medoxomil/amlodipine/hydrocholorothiazide'},
		{id:'g772', name:'olmesartan medoxomil/hydrochlorothiazide'},
		{id:'gen_olop1', name:'olopatadine hydrochloride'},
		{id:'gen_olop2', name:'olopatadine hydrochloride ophthalmic solution'},
		{id:'g756', name:'olsalazine sodium'},
		{id:'dn_olux1', name:'Olux Foam (clobetasol propionate)'},
		{id:'dn_olux2', name:'Olux-E (clobetasol propionate)'},
		{id:'dn_olys1', name:'Olysio (simeprevir) '},
		{id:'gen_omac1', name:'omacetaxine mepesuccinate'},
		{id:'gen_omeg1', name:'omega-3-acid ethyl esters'},
		{id:'gen_omeg2', name:'omega-3-carboxylic acids'},
		{id:'g466', name:'omeprazole'},
		{id:'dn_omni4', name:'Omnipred Ophthalmic Suspension (prednisolone acetate)'},
		{id:'g467', name:'ondansetron HCl'},
		{id:'dn_ongl1', name:'Onglyza (saxagliptin)'},
		{id:'dn_onta1', name:'Ontak (denileukin diftitox)'},
		{id:'dn_opdi1', name:'Opdivo (nivolumab)'},
		{id:'gen_opht2', name:'ophthalmic solution'},
		{id:'g468', name:'oprelvekin'},
		{id:'dn_opsu1', name:'Opsumit (macitentan)'},
		{id:'dn_opti3', name:'Opticrom Opthalmic Solution (cromolyn sodium)'},
		{id:'dn_opti2', name:'OptiPranolol (ipranolol ophthalmic solution)'},
		{id:'dn_orac1', name:'Oracea Capsule (flucinolone acetonide/hydroquinone/tretinoin)'},
		{id:'dn_ORAP1', name:'Orap (pimozide)'},
		{id:'dn_oren1', name:'Orencia (abatacept)'},
		{id:'dn_oren2', name:'Orenitram (treprostinil)'},
		{id:'dn_orfa1', name:'Orfadin (nitisinone)'},
		{id:'dn_ORTH5', name:'Ortho Tri-Cyclen (norgestimate/ethinyl estradiol)'},
		{id:'dn_ORTH8', name:'Ortho-Cyclen Tablets (norgestimate/ethinyl estradiol)'},
		{id:'dn_ORTH10', name:'Orthovisc (hyaluronan)'},
		{id:'dn_osen1', name:'Oseni (alogliptin and pioglitazone) '},
		{id:'g788', name:'oxaprozin'},
		{id:'g473', name:'oxcarbazepine'},
		{id:'g475', name:'oxfloxacin'},
		{id:'dn_OXSO1', name:'Oxsoralen Lotion/Ultra (methoxsalen)'},
		{id:'g477', name:'oxybutynin chloride'},
		{id:'g478', name:'oxycodone HCl'},
		{id:'dn_OXYC1', name:'OxyContin (oxycodone HCl)'},
		{id:'dn_ozur1', name:'Ozurdex (dexamethasone intravitreal implant)'},
		{id:'g481', name:'paclitaxel'},
		{id:'gen_palb1', name:'palbociclib'},
		{id:'g816', name:'palifermin'},
		{id:'gen_pali1', name:'paliperidone'},
		{id:'gen_pali2', name:'paliperidone palmitate'},
		{id:'g482', name:'palivizumab'},
		{id:'g769', name:'palonosetron HCL injection'},
		{id:'dn_pame1', name:'Pamelor (nortriptyline HCL)'},
		{id:'dn_panc8', name:'Pancreaze Delayed-Release capsules (pancrelipase) '},
		{id:'g483', name:'pancrelipase'},
		{id:'gen_pani1', name:'panitumumab'},
		{id:'dn_panr1', name:'Panretin (alitretinoin)'},
		{id:'g485', name:'pantoprazole sodium'},
		{id:'dn_PARA1', name:'Parafon Forte DSC (chlorzoxazone)'},
		{id:'g486', name:'paroxetine HCl'},
		{id:'dn_pata1', name:'Pataday Ophthalmic Solution (olopatadine hydrochloride)'},
		{id:'dn_pata3', name:'Patanase (olopatadine hcl)'},
		{id:'dn_pata2', name:'Patanol (olopatadine hydrochloride ophthalmic solution)'},
		{id:'dn_PAXI1', name:'Paxil (paroxetine HCl)'},
		{id:'gen_pazo1', name:'pazopanib'},
		{id:'gen_pega1', name:'pegaptanb sodium'},
		{id:'dn_PEGA2', name:'Pegasys (pegylated interferon alfa-2a)'},
		{id:'g487', name:'pegfilgrastim'},
		{id:'g488', name:'peginterferon alfa-2b'},
		{id:'dn_pegi1', name:'Pegintron for Injection (peginterferon alfa-2b)'},
		{id:'gen_pegl1', name:'pegloticase'},
		{id:'g725', name:'pegvisomant'},
		{id:'g740', name:'pegylated interferon alfa-2a'},
		{id:'gen_pemb1', name:'pembrolizumab'},
		{id:'g718', name:'pemetrexed'},
		{id:'g766', name:'penicillamine'},
		{id:'gen_peni1', name:'penicillin G potassium'},
		{id:'dn_PENT1', name:'Pentasa (mesalamine)'},
		{id:'g491', name:'pentosan polysulfate sodium'},
		{id:'g492', name:'pentoxifylline'},
		{id:'dn_PEPC1', name:'Pepcid Tablets and Oral Suspension (famotidine) '},
		{id:'dn_perj1', name:'Perjeta (pertuzumab)'},
		{id:'gen_diso1', name:'pertuzumab'},
		{id:'dn_pfiz1', name:'Pfizerpen (penicillin G potassium)'},
		{id:'g495', name:'phenelzine sulfate'},
		{id:'gen_phen4', name:'phentermine HCI'},
		{id:'gen_phen3', name:'phenylephrine'},
		{id:'g496', name:'phenytoin'},
		{id:'dn_phos3', name:'Phoslyra (calcium acetate)'},
		{id:'g500', name:'phytonadione tablets'},
		{id:'g501', name:'pilocarpine HCl'},
		{id:'dn_PILO1', name:'Pilopine HS (pilocarpine HCl)'},
		{id:'g503', name:'pimecrolimus'},
		{id:'g504', name:'pimozide'},
		{id:'g507', name:'piroxicam'},
		{id:'dn_PLAQ1', name:'Plaquenil (hydroxychloroquine sulfate)'},
		{id:'dn_PLAV1', name:'Plavix (clopidogrel bisulfate)'},
		{id:'dn_PLEN1', name:'Plendil ER (felodipine)'},
		{id:'gen_pler1', name:'plerixafor'},
		{id:'dn_PLET1', name:'Pletal (cilostazol)'},
		{id:'gen_pneu1', name:'pneumococcal vaccine polyvalent'},
		{id:'dn_pneu1', name:'Pneumovax 23 (pneumococcal vaccine polyvalent)'},
		{id:'gen_poli1', name:'polifeprosan 20 with carmustine implant'},
		{id:'gen_poma1', name:'pomalidomide'},
		{id:'dn_poma1', name:'Pomalyst (pomalidomide)'},
		{id:'gen_posa1', name:'posaconazole'},
		{id:'gen_pota4', name:'potassium and sodium acid phosphate'},
		{id:'g511', name:'potassium chloride'},
		{id:'gen_pota3', name:'potassium chloride ER'},
		{id:'gen_pota1', name:'potassium citrate'},
		{id:'dn_poti1', name:'Potiga Tablets (ezogabine)'},
		{id:'dn_prad1', name:'Pradaxa (dabigatran etexilate)'},
		{id:'g514', name:'pramipexole dihydrochloride'},
		{id:'gen_pram1', name:'pramlintide acetate'},
		{id:'dn_pram1', name:'Pramosone (hydrocortisone/pramoxine)'},
		{id:'gen_pras1', name:'prasugrel'},
		{id:'dn_PRAV1', name:'Pravachol (pravastatin sodium)'},
		{id:'g515', name:'pravastatin sodium'},
		{id:'g516', name:'praziquantel'},
		{id:'gen_praz1', name:'prazosin'},
		{id:'dn_praz1', name:'Prazosin Capsule (prazosin)'},
		{id:'g517', name:'prazosin HCI'},
		{id:'dn_PREC1', name:'Precose (acarbose)'},
		{id:'dn_pred2', name:'Pred Forte (prednisolone)'},
		{id:'gen_pred1', name:'prednisolone'},
		{id:'gen_pred3', name:'prednisolone acetate'},
		{id:'gen_pred2', name:'prednisone'},
		{id:'dn_pred1', name:'Prednisone tablet (prednisone)'},
		{id:'dn_PREM1', name:'Premarin (conjugated estrogens)'},
		{id:'dn_PREM2', name:'Premphase (estrogens conjugated/medroxyprogesterone)'},
		{id:'dn_PREM3', name:'Prempro (estrogens conjugated/medroxyprogesterone)'},
		{id:'dn_prev1', name:'Prevnar 13 (diphtheria CRM197 protein)'},
		{id:'dn_prez1', name:'Prezista (darunavir)'},
		{id:'dn_pria1', name:'PrialtÂ InfusionÂ (ziconotide infusion)'},
		{id:'dn_prif1', name:'Priftin (rifapentine)'},
		{id:'dn_PRIL1', name:'Prilosec (omeprazole) '},
		{id:'g520', name:'primidone'},
		{id:'dn_prim3', name:'Primlev Oxycodone HCI/Acetaminophen'},
		{id:'dn_PRIN1', name:'Prinivil (lisinopril)'},
		{id:'dn_PRIN2', name:'Prinzide (lisinopril/hydrochlorothiazide)  '},
		{id:'dn_pris1', name:'Pristiq (desvenlafaxine)'},
		{id:'dn_priv1', name:'Privigen (immune globulin)'},
		{id:'dn_proa2', name:'ProAir HFA (albuterol sulfate inhalation aerosol)'},
		{id:'g522', name:'procarbazine HCl'},
		{id:'dn_PROC1', name:'Procardia (nifedipine)'},
		{id:'g523', name:'prochlorperazine'},
		{id:'dn_proc7', name:'Prochlorperazine Tablet (prochlorperazine)'},
		{id:'dn_PROC3', name:'Procrit (epoetin alfa)'},
		{id:'dn_prof1', name:'ProfilNine (faxtor ix complex)'},
		{id:'dn_prog2', name:'Proglycem Oral Suspension (diazoxide)'},
		{id:'dn_PROG1', name:'Prograf Capsules (tacrolimus)'},
		{id:'dn_prol3', name:'Prolia (denosumab)'},
		{id:'dn_prom4', name:'Promacta Tablets (eltrombopag)'},
		{id:'g526', name:'propafenone HCl'},
		{id:'gen_prop1', name:'propanolol'},
		{id:'g527', name:'propranolol HCl'},
		{id:'g528', name:'propranolol/hydrochlorothiazide'},
		{id:'gen_prop2', name:'propylthiouracil'},
		{id:'dn_prop6', name:'Propylthiouracil Tablet (propylthiouracil)'},
		{id:'dn_PROS1', name:'Proscar Tablets (finasteride) '},
		{id:'dn_pros4', name:'ProstaScint (capromab pendetide)'},
		{id:'dn_PROS2', name:'Prostigmin Tablets (neostigmine methylsulfate)'},
		{id:'dn_PROT1', name:'Protonix (pantoprazole sodium)'},
		{id:'dn_prov6', name:'Provenge (sipuleucel-t)'},
		{id:'dn_prov5', name:'Proventil HFA (albuterol sulfate) '},
		{id:'dn_PROV3', name:'Provera (medroxyprogesterone acetate)'},
		{id:'dn_PROZ1', name:'Prozac (fluoxetine HCl)'},
		{id:'dn_pulm4', name:'Pulmicort Flexhaler (budesonide inhalation powder)'},
		{id:'dn_PULM1', name:'Pulmicort Respules (budesonide) '},
		{id:'dn_PULM3', name:'Pulmozyme (dornase alfa)'},
		{id:'dn_PURI1', name:'Purinethol (mercaptopurine)'},
		{id:'g529', name:'pyridostigmine bromide'},
		{id:'dn_qnas1', name:'Qnasl (beclomethasone diproprionate)'},
		{id:'gen_quad1', name:'quadrivalent human papillomavirus'},
		{id:'gen_qual1', name:'qualaquin'},
		{id:'dn_quin4', name:'Qualaquin Capsule (quinine sulfate)'},
		{id:'g531', name:'quetiapine fumarate'},
		{id:'dn_quil1', name:'Quillivant XR (methylphenidate hydrochloride) for extended-release oral suspension '},
		{id:'g532', name:'quinapril HCl'},
		{id:'g533', name:'quinapril HCl/hydrochlorothiazide'},
		{id:'dn_QUIN3', name:'quinidine gluconate (generic)'},
		{id:'dn_qvar1', name:'Qvar (beclomethasone dipropionate)'},
		{id:'dn_rgen1', name:'R-Gene 10 Injection (arginine hydrochloride)'},
		{id:'dn_RABA1', name:'RabAvert (human rabies vaccine)'},
		{id:'g537', name:'rabies immune globulin, human, post exposure basis only'},
		{id:'g538', name:'rabies vaccine, human'},
		{id:'g539', name:'rabies vaccine, human diploid cell, post exposure basis only'},
		{id:'gen_radi1', name:'radium Ra 223 dichloride'},
		{id:'g540', name:'raloxifene'},
		{id:'gen_ralt1', name:'raltegravir'},
		{id:'g676', name:'ramipril'},
		{id:'dn_rane1', name:'Ranexa Extended Release Tablets (ranolazine) '},
		{id:'gen_niti2', name:'ranitidine'},
		{id:'gen_rano1', name:'ranolazine'},
		{id:'dn_rapa1', name:'Rapamune (sirolimus)'},
		{id:'gen_rasa1', name:'rasagiline'},
		{id:'gen_rasb1', name:'rasburicase'},
		{id:'dn_ravi1', name:'Ravicti (glycerol phenylbutyrate) '},
		{id:'dn_RAZA1', name:'Razadyne (galantamine HBr) Tablets and Oral Solution'},
		{id:'dn_raza2', name:'Razadyne ER (galantamine HBr) Extended-Release Capsules'},
		{id:'dn_REBI1', name:'Rebif (interferon beta-1a)'},
		{id:'g154', name:'recombinant'},
		{id:'dn_reco1', name:'Recombinate (antihemophilic factor)'},
		{id:'dn_reco2', name:'Recombivax HB (recombinant)'},
		{id:'dn_regl1', name:'Reglan (metoclopramide HCL)'},
		{id:'gen_rego1', name:'regorafenib'},
		{id:'dn_RELE1', name:'Relenza (zanamivir)'},
		{id:'dn_RELP1', name:'Relpax (eletriptan HBr)'},
		{id:'dn_REME1', name:'Remeron (mirtazapine)'},
		{id:'dn_REMI1', name:'Remicade (infliximab)'},
		{id:'dn_resc3', name:'Renvela (sevelamer carbonate)'},
		{id:'dn_REOP1', name:'Reopro Injection (abciximab)'},
		{id:'dn_REQU1', name:'Requip (ropinirole HCl)'},
		{id:'dn_requ2', name:'Requip XL (ropinirole)'},
		{id:'dn_RESC1', name:'Rescriptor (delavirdine mesylate)'},
		{id:'dn_REST1', name:'Restasis (cyclosporine ophthalmic emulsion)'},
		{id:'dn_rest2', name:'Restoril (temazepam)'},
		{id:'gen_reta1', name:'retapamulin'},
		{id:'dn_RETR1', name:'Retrovir (zidovudine)'},
		{id:'dn_REVA1', name:'Revatio (sildenafil citrate)'},
		{id:'dn_revl1', name:'Revlimid (lenalidomide) '},
		{id:'dn_REYA1', name:'Reyataz (atazanavir sulfate)'},
		{id:'dn_RHIN1', name:'Rhinocort Aqua (budesonide)'},
		{id:'dn_rias1', name:'RiaSTAP (fibrinogen concentrate)'},
		{id:'dn_riba1', name:'Ribasphere RibaPak (ribavirin)'},
		{id:'g545', name:'ribavirin'},
		{id:'gen_riba1', name:'ribavirin'},
		{id:'g547', name:'rifabutin'},
		{id:'gen_rifa1', name:'rifapentine'},
		{id:'gen_rilo1', name:'rilonacept'},
		{id:'gen_rilp1', name:'rilpivirne'},
		{id:'dn_RILU1', name:'Rilutek (riluzole)'},
		{id:'g548', name:'riluzole'},
		{id:'gen_rime1', name:'rimexolone'},
		{id:'gen_rioc1', name:'riociguat'},
		{id:'dn_RISP1', name:'Risperdal (risperidone)'},
		{id:'dn_RISP3', name:'Risperdal Consta (risperidone)'},
		{id:'dn_RISP2', name:'Risperdal M-TAB (risperidone)'},
		{id:'g821', name:'risperidone'},
		{id:'g550', name:'risperidone tablets and oral solution'},
		{id:'g551', name:'ritonavir capsules'},
		{id:'g552', name:'ritonavir oral solution'},
		{id:'dn_RITU1', name:'Rituxan (Rituximab)'},
		{id:'g553', name:'rituximab'},
		{id:'g554', name:'rivastigmine tartrate'},
		{id:'gen_riva1', name:'rivastigmine transdermal system'},
		{id:'gen_rivo1', name:'rivoroxiban'},
		{id:'g555', name:'rizatriptan benzoate orally disintegrating tablets'},
		{id:'g556', name:'rizatriptan benzoate tablets'},
		{id:'gen_rofl1', name:'roflumilast'},
		{id:'gen_romi2', name:'romidepsin'},
		{id:'gen_romi1', name:'romiplostim'},
		{id:'g558', name:'ropinirole HCl'},
		{id:'g559', name:'rosiglitazone maleate'},
		{id:'g701', name:'rosuvastatin calcium tablets'},
		{id:'gen_roti1', name:'rotigotine transdermal system'},
		{id:'dn_rowa2', name:'Rowasa Kit (mesalamine)'},
		{id:'dn_ROZE1', name:'Rozerem (ramelteon)'},
		{id:'gen_rufi1', name:'rufinamide'},
		{id:'gen_ruxo1', name:'ruxolitinib'},
		{id:'dn_RYTH1', name:'Rythmol SR (propafenone HCl)'},
		{id:'g561', name:'sagostim'},
		{id:'gen_sali1', name:'saline solution'},
		{id:'g563', name:'salmeterol xinafoate inhalation powder'},
		{id:'dn_sams1', name:'Samsca (tolvaptan)'},
		{id:'dn_sanc2', name:'Sancuso (granisetron)'},
		{id:'dn_SAND3', name:'Sandimmune (cyclosporine)'},
		{id:'dn_SAND2', name:'Sandostatin LAR Depot (octreotide acetate)'},
		{id:'dn_saph1', name:'Saphris (asenapine)'},
		{id:'gen_sapr1', name:'sapropterin dihydrochloride'},
		{id:'g565', name:'saquinavir mesylate'},
		{id:'dn_save1', name:'Savella (milnacipran HCl) '},
		{id:'dn_save2', name:'Savella Titration Pak (memantine hcl)'},
		{id:'gen_saxa1', name:'saxagliptin'},
		{id:'gen_saxa2', name:'saxagliptin and metformin hcl'},
		{id:'dn_scul1', name:'Sculptra (injectable poly-L-lactic acid)'},
		{id:'gen_sele1', name:'selegine hci'},
		{id:'dn_selz1', name:'Selzentry (maraviroc)'},
		{id:'dn_sens1', name:'Sensipar (cinacalcet)'},
		{id:'dn_SERE1', name:'Serevent Diskus Inhalation Powder (salmeterol xinafoate)'},
		{id:'dn_SERO2', name:'Seroquel (quetiapine fumarate) '},
		{id:'dn_sero4', name:'Seroquel XR (quetiapine fumarate)'},
		{id:'dn_SERO3', name:'Serostim (somatropin)'},
		{id:'g566', name:'sertraline HCl'},
		{id:'gen_seve1', name:'sevelamer carbonate'},
		{id:'g567', name:'sildenafil citrate'},
		{id:'gen_silt1', name:'siltuximab'},
		{id:'gen_sime1', name:'simeprevir'},
		{id:'dn_simp1', name:'Simponi  (golimumab)'},
		{id:'dn_simp3', name:'Simponi ARIA (golimumab)'},
		{id:'g568', name:'simvastatin tablets'},
		{id:'dn_sine3', name:'Sinemet CR (carbidopa/levo SR tablet)'},
		{id:'dn_SING1', name:'Singulair Tablets and Chewable Tablets (montelukast sodium)'},
		{id:'gen_sipu1', name:'sipuleucel-t'},
		{id:'gen_siro1', name:'sirolimus'},
		{id:'g845', name:'sitagliptin phosphate'},
		{id:'gen_sita1', name:'sitagliptin/metformin HCl'},
		{id:'gen_sita2', name:'sitagliptin/simvastatin'},
		{id:'dn_sive1', name:'Sivextro (tedizolid phosphate) '},
		{id:'dn_SKEL1', name:'Skelaxin (metaxalone)'},
		{id:'g571', name:'sodium hyaluronate'},
		{id:'gen_sodi2', name:'sodium oxybate'},
		{id:'gen_sofo1', name:'sofosbuvir'},
		{id:'dn_soli1', name:'Soliris (eculizumab)'},
		{id:'dn_solv1', name:'Solvadi (sofosbuvir)'},
		{id:'g572', name:'somatotropin'},
		{id:'g574', name:'somatropin'},
		{id:'g575', name:'somatropin for AIDS wasting'},
		{id:'gen_soma1', name:'somatropin [rDNA origin] for injection'},
		{id:'dn_SOMA1', name:'Somavert (pegvisomant)'},
		{id:'dn_sona1', name:'Sonata (zaleplon)'},
		{id:'dn_sona2', name:'Sonata CIV (zaleplon) '},
		{id:'gen_sora1', name:'sorafenib'},
		{id:'dn_SORI1', name:'Soriatane (acitretin)'},
		{id:'dn_sori2', name:'Sorilux Foam (calcipotriene)'},
		{id:'g576', name:'sotalol HCl'},
		{id:'dn_SPIR1', name:'Spiriva HandiHaler (tiotropium bromide inhalation powder)'},
		{id:'g779', name:'spironolactone'},
		{id:'g794', name:'spironolactone/hydrochlorothiazide'},
		{id:'dn_SPOR1', name:'Sporanox (itraconazole) Capsules and Oral Solution'},
		{id:'dn_spry1', name:'Sprycel (dasatinib)'},
		{id:'dn_STAL1', name:'Stalevo (carbidopa, levodopa, and entacapone) Tablets'},
		{id:'dn_stel2', name:'Stelara (ustekinumab)'},
		{id:'g791', name:'sterile methylprednisolone acetate'},
		{id:'gen_ster1', name:'steriod and antibiotic ointment'},
		{id:'dn_stim1', name:'Stimate (desmopressin acetate)'},
		{id:'dn_stiv1', name:'Stivarga (regorafenib)'},
		{id:'dn_STRA1', name:'Strattera (atomoxetine hydrochloride)'},
		{id:'dn_stri1', name:'Stribild Tablets (elvitegravir, cobicistat, emtricitabine, tenofovir disoproxil fumarate)'},
		{id:'gen_sucr1', name:'sucroferric oxyhydroxide'},
		{id:'gen_sulf2', name:'sulfacetamid sodium'},
		{id:'gen_sulf3', name:'sulfacetamide sodium/prednisolone sodium phosphate'},
		{id:'gen_sulf1', name:'sulfamethoxazole/trimethoprim DS'},
		{id:'g782', name:'sulfasalazine, enteric coated'},
		{id:'g586', name:'sumatriptan succinate injection'},
		{id:'g587', name:'sumatriptan succinate nasal spray'},
		{id:'gen_suma1', name:'sumatriptan/naproxen sodium'},
		{id:'g849', name:'sunitinib malate'},
		{id:'dn_supr2', name:'Suprenza Orally Disintegrating (phentermine HCI)'},
		{id:'dn_SUST1', name:'Sustiva (efavirenz)'},
		{id:'dn_sute1', name:'Sutent (sunitinib malate)'},
		{id:'dn_syla1', name:'Sylatron (peginterferon alfa-2b)'},
		{id:'dn_sylv1', name:'Sylvant (siltuximab) for infusion'},
		{id:'dn_symb2', name:'Symbicort (budesonide/formoterol fumarate dihydrate)'},
		{id:'dn_SYMB1', name:'Symbyax (olanzapine and fluoxetine HCl)'},
		{id:'dn_syml1', name:'SymlinPen (pramlintide acetate) Pen Injector'},
		{id:'dn_SYNA1', name:'Synagis (palivizumab)'},
		{id:'dn_SYNA2', name:'Synarel (nafarelin acetate solution)'},
		{id:'dn_synr1', name:'Synribo (omacetaxine mepesuccinate)'},
		{id:'dn_SYNT1', name:'Synthroid (levothyroxine sodium)'},
		{id:'dn_synv1', name:'Synvisc (hylan g-f 20)'},
		{id:'dn_synv2', name:'Synvisc-One (hylan g-f 20)'},
		{id:'dn_SYPR1', name:'Syprine Capsules (trientine HCl)'},
		{id:'dn_syst1', name:'Systane (eye drops)'},
		{id:'dn_syst2', name:'Systane Free Ophthalmic Solution (lubricant eye drops)'},
		{id:'dn_syst3', name:'Systane PM Ointment (eye ointment)'},
		{id:'dn_syst4', name:'Systane Ultra Ophthalmic Solution (lubricant eye drops) '},
		{id:'dn_syst5', name:'Systane Ultra Preservative-Free Ophthalmic Solution (lubricant eye drops) '},
		{id:'dn_tacl2', name:'Taclonex Scalp Topical Suspension (calcipotriene 0.005% and betamethasone dipropionate 0.064%)'},
		{id:'g589', name:'tacrolimus capsules'},
		{id:'gen_tada1', name:'tadalafil'},
		{id:'dn_tafi1', name:'Tafinlar (dabrafenib)'},
		{id:'gen_tafl1', name:'tafluprost ophthalmic solution'},
		{id:'gen_tali1', name:'taliglucerase alfa'},
		{id:'g591', name:'tamoxifen citrate'},
		{id:'dn_tamo1', name:'Tamoxifen citrate tablet (tamoxifen citrate)'},
		{id:'g592', name:'tamsulosin HCl'},
		{id:'dn_tanz1', name:'Tanzeum (albiglutide)'},
		{id:'gen_tape1', name:'tapentadol'},
		{id:'dn_TARC1', name:'Tarceva (erlotinib)'},
		{id:'dn_TARG1', name:'Targretin Capsule (bexarotene)'},
		{id:'dn_targ2', name:'Targretin Gel (bexarotene)'},
		{id:'dn_TARK1', name:'Tarka (trandolapril/verapamil)'},
		{id:'gen_tart1', name:'tartrate ophthalmic solution'},
		{id:'dn_tasi1', name:'Tasigna (nilotinib)'},
		{id:'gen_tasi1', name:'tasimelteon'},
		{id:'dn_TASM1', name:'Tasmar (tolcapone)'},
		{id:'g708', name:'tazarotene'},
		{id:'dn_TAZO1', name:'Tazorac (tazarotene)'},
		{id:'gen_tbof1', name:'tbo-filgrastim'},
		{id:'dn_tear2', name:'Tears Natural II Polyquad Ophthalmic Solution (lubricant eye drops) '},
		{id:'gen_tear1', name:'tears naturale forte drops'},
		{id:'dn_tear3', name:'Tears Naturale Forte Drops (tears naturale forte drops)'},
		{id:'gen_tear2', name:'tears naturale free'},
		{id:'dn_tear4', name:'Tears Naturale Free (tears naturale free)'},
		{id:'dn_tecf1', name:'Tecfidera (dimethyl fumarate)'},
		{id:'gen_tedi1', name:'tedizolid phosphate'},
		{id:'dn_TEGR1', name:'Tegretol (carbamazepine)'},
		{id:'dn_TEGR2', name:'Tegretol-XR (carbamazepine)'},
		{id:'dn_teka1', name:'Tekamlo (aliskiren amlodipine)'},
		{id:'dn_tekt1', name:'Tekturna (aliskiren)'},
		{id:'dn_tekt2', name:'Tekturna HCT (aliskiren and hydrochlorothiazide)'},
		{id:'gen_tela2', name:'telavancin'},
		{id:'gen_telm2', name:'telmisartan/amlodipine'},
		{id:'gen_tema1', name:'temazepam'},
		{id:'gen_tems1', name:'temsirolimus'},
		{id:'dn_teni1', name:'Tenivac (tetanus and diphtheria toxoids adsorbed)'},
		{id:'g598', name:'tenofovir disoproxil fumarate'},
		{id:'dn_TENO1', name:'Tenoretic (atenolol/chlorthalidone)'},
		{id:'dn_TENO2', name:'Tenormin Tablet (atenolol)'},
		{id:'dn_TERA1', name:'Terazol 3 Vaginal Cream (terconazole)'},
		{id:'dn_TERA3', name:'Terazol 7 Vaginal Cream (terconazole)'},
		{id:'g599', name:'terazosin HCl'},
		{id:'g600', name:'terbinafine hydrochloride'},
		{id:'g729', name:'terconazole'},
		{id:'g602', name:'terconazole vaginal suppositories'},
		{id:'g726', name:'teriparatide'},
		{id:'dn_TESS1', name:'Tessalon (benzonatate)'},
		{id:'gen_test1', name:'testosterone cypionate'},
		{id:'g605', name:'testosterone gel'},
		{id:'gen_teta2', name:'tetanus and diphtheria toxoids adsorbed'},
		{id:'gen_teta1', name:'tetanus, diphtheria, acellular pertussis vaccine'},
		{id:'gen_tetr1', name:'tetrabenazine'},
		{id:'dn_tevt1', name:'Tev-Tropin (somatropin)'},
		{id:'dn_TEVE1', name:'Teveten (eprosartan mesylate) '},
		{id:'dn_teve2', name:'Teveten HCT (eprosartan mesylate hydrochlorothiazide)'},
		{id:'g607', name:'thalidomide'},
		{id:'dn_THAL1', name:'Thalomid (thalidomide)'},
		{id:'g608', name:'theophylline'},
		{id:'dn_theo3', name:'Theophylline ER Tablet (theophylline)'},
		{id:'dn_THER1', name:'TheraCys BCG (bacillus Calmette-Guerin, live intravesical)'},
		{id:'dn_thym1', name:'Thymoglobulin [Anti-thymocyte Globulin (Rabbit)]'},
		{id:'g613', name:'thyroid desiccated'},
		{id:'g829', name:'tiagabine hydrochloride'},
		{id:'gen_tica1', name:'ticagrelor'},
		{id:'dn_TICL1', name:'Ticlid (ticlopidine HCl)'},
		{id:'g615', name:'ticlopidine HCl'},
		{id:'gen_tige1', name:'tigecycline IV'},
		{id:'dn_TIKO1', name:'Tikosyn (dofetilide)'},
		{id:'g620', name:'timolol maleate ophthalmic solution'},
		{id:'dn_timo7', name:'Timoptic in Occudose .25% (timolol maleate opthalmic solution)'},
		{id:'dn_timo6', name:'Timoptic in Occudose .5% (timolol maleate opthalmic solution)'},
		{id:'g754', name:'tiotropium bromide inhalation powder'},
		{id:'gen_tipr1', name:'tipranavir'},
		{id:'dn_tiro1', name:'Tirosint (levothyroxine sodium)'},
		{id:'dn_tivi1', name:'Tivicay (dolutegravir)'},
		{id:'g623', name:'tizanidine HCl'},
		{id:'dn_tobi1', name:'TOBI  (tobramycin inhalation solution USP)'},
		{id:'dn_tobi2', name:'TOBI Podhaler (tobramycin inhalation powder)'},
		{id:'dn_tobr1', name:'Tobradex Ointment (steriod and antibiotic ointment)'},
		{id:'dn_tobr2', name:'Tobradex ST (tobramycin ophthalmic)'},
		{id:'dn_tobr3', name:'Tobradex suspension (steriod and antibiotic solutions and suspentions)'},
		{id:'gen_tobr3', name:'tobramycin inhalation powder'},
		{id:'gen_tobr1', name:'tobramycin inhalation solution USP'},
		{id:'gen_tobr2', name:'tobramycin ophthalmic'},
		{id:'dn_tobr4', name:'Tobrex Ophthalmic Ointment (saline solution)'},
		{id:'gen_toci1', name:'tocilizumab'},
		{id:'gen_tofa1', name:'tofacitinib'},
		{id:'g625', name:'tolcapone'},
		{id:'g627', name:'tolterodine tartrate'},
		{id:'gen_tolv1', name:'tolvaptan'},
		{id:'dn_TOPA1', name:'Topamax (topiramate)'},
		{id:'dn_TOPA2', name:'Topamax Sprinkles (topiramate)'},
		{id:'g628', name:'topiramate'},
		{id:'g629', name:'topotecan HCI'},
		{id:'dn_TOPR1', name:'Toprol-XL (metoprolol succinate) '},
		{id:'g630', name:'toremifene citrate'},
		{id:'dn_tori1', name:'Torisel Injection (temsirolimus)'},
		{id:'dn_tovi1', name:'Toviaz (fesoterodine fumarate)'},
		{id:'dn_TRAC1', name:'Tracleer (bosentan)'},
		{id:'dn_trad1', name:'Tradjenta (linagliptin)'},
		{id:'g632', name:'tramadol HCl'},
		{id:'g633', name:'tramadol hydrochloride/acetaminophen'},
		{id:'gen_tram1', name:'trametinib'},
		{id:'dn_tran1', name:'Trandate (labetalol HCL)'},
		{id:'g634', name:'trandolapril'},
		{id:'g635', name:'trandolapril/verapamil'},
		{id:'gen_tran1', name:'tranexamic acid'},
		{id:'g637', name:'trastuzumab'},
		{id:'dn_TRAV1', name:'Travatan (travoprost)'},
		{id:'dn_trav2', name:'Travatan Z (ophthalmic solution)'},
		{id:'g638', name:'travoprost'},
		{id:'g639', name:'trazodone'},
		{id:'dn_trea1', name:'Treanda Injection (bendamustine HCl)'},
		{id:'dn_TREC1', name:'Trecator (ethionamide)'},
		{id:'dn_TREN1', name:'Trental (pentoxifylline)'},
		{id:'gen_trep1', name:'treprostinil'},
		{id:'dn_trex1', name:'Treximet (sumatriptan/naproxen sodium)'},
		{id:'g646', name:'triamterene hydrochlorothiazide'},
		{id:'gen_tria2', name:'triazolam USP'},
		{id:'dn_enzo1', name:'Tribenzor (olmesartan medoxomil/amlodipine/hydrocholorothiazide)'},
		{id:'g648', name:'trientine HCl capsules'},
		{id:'g689', name:'trifluridine'},
		{id:'dn_TRIL1', name:'Trileptal (oxcarbazepine)'},
		{id:'dn_TRIS1', name:'Trisenox Injection  (arsenic trioxide) '},
		{id:'dn_triu1', name:'Triumeq (abacavir, dolutegravir, and lamivudine)'},
		{id:'dn_TRIZ1', name:'Trizivir (abacavir sulfate/lamivudine/zidovudine)'},
		{id:'gen_trop1', name:'tropicamide'},
		{id:'dn_TRUS1', name:'Trusopt  Ophthalmic Solution (dorzolamide HCl) '},
		{id:'dn_TRUV1', name:'Truvada (emtricitabine,  tenofovir disoproxil fumarate)'},
		{id:'dn_tudo1', name:'Tudorza Pressair (aclidinium bromide inhalation powder)'},
		{id:'dn_twin1', name:'Twinrix'},
		{id:'dn_twyn1', name:'Twynsta Tablets (telmisartan/amlodipine)'},
		{id:'dn_tyga1', name:'Tygacil (tigecycline IV)'},
		{id:'dn_tyke1', name:'Tykerb (lapatinib tablets)'},
		{id:'dn_tysa1', name:'Tysabri IV Infusion (natalizumab)'},
		{id:'dn_tyze2', name:'Tyzeka (oxcarbazepine)'},
		{id:'dn_ulor1', name:'Uloric (febuxostat)'},
		{id:'dn_ULTR1', name:'Ultracet (tramadol hydrochloride/acetaminophen)'},
		{id:'dn_ULTR2', name:'Ultram (tramadol HCl)'},
		{id:'dn_ultr6', name:'Ultram ER (tramadol HCl) Extended-Release Tablets'},
		{id:'gen_umec1', name:'umeclidinium and vilanterol inhalation powder'},
		{id:'dn_urib1', name:'Uribel (Methenamine, Sodium Phosphate Monobasic, Phenyl Salicylate, Methylene Blue, Hyoscyamine Sulfate)'},
		{id:'dn_uroc1', name:'Urocit-K (potassium citrate)'},
		{id:'gen_uste1', name:'ustekinumab'},
		{id:'dn_VAGI1', name:'Vagifem (estradiol hemihydrate)'},
		{id:'dn_valc2', name:'Valchlor (mechlorethamine)'},
		{id:'dn_VALC1', name:'Valcyte (valganciclovir HCl)'},
		{id:'g655', name:'valganciclovir HCl'},
		{id:'dn_VALI1', name:'Valium (diazepam)'},
		{id:'dn_vaqt1', name:'Vaqta (hepatitis A vaccine, inactivated)'},
		{id:'g840', name:'varenicline'},
		{id:'gen_vari1', name:'varicella virus vaccine live'},
		{id:'gen_vari2', name:'varicella zoster immune globulin'},
		{id:'dn_vari1', name:'Varivax (varicella virus vaccine live)'},
		{id:'dn_vari3', name:'VariZIG (varicella zoster immune globulin)'},
		{id:'dn_vase1', name:'Vaseretic (enalapril/hctz)'},
		{id:'dn_vaso5', name:'Vasocidin Ophthalmic Solution (sulfacetamide sodium/prednisolone sodium phosphate)'},
		{id:'dn_vaso4', name:'Vasotec (enalapril maleate)'},
		{id:'dn_vect1', name:'Vectibix (panitumumab)'},
		{id:'gen_vela1', name:'velaglucerase alfa for injection'},
		{id:'dn_VELC1', name:'Velcade (bortezomib)'},
		{id:'dn_velp1', name:'Velphoro (sucroferric oxyhydroxide)'},
		{id:'dn_velt1', name:'Veltin Gel (clindamycin phosphate/tretinoin)'},
		{id:'gen_vemu1', name:'vemurafenib'},
		{id:'g660', name:'venlafaxine HCl'},
		{id:'dn_VENO1', name:'Venofer (iron sucrose)'},
		{id:'dn_VENT3', name:'Ventolin HFA (albuterol sulfate)'},
		{id:'dn_vera1', name:'Veramyst Nasal Spray (fluticasone furoate)'},
		{id:'g661', name:'verapamil HCl'},
		{id:'dn_verd1', name:'Verdeso (desonide foam)'},
		{id:'gen_vert1', name:'verteporfin'},
		{id:'dn_vexo1', name:'Vexol (rimexolone)'},
		{id:'dn_VFEN1', name:'Vfend (voriconazole)'},
		{id:'dn_VIAG1', name:'Viagra (sildenafil citrate)'},
		{id:'dn_viba1', name:'Vibativ (telavancin)'},
		{id:'dn_vict1', name:'Victoza (liraglutide (rDNA) injection)'},
		{id:'dn_vict2', name:'Victrelis (boceprevir)'},
		{id:'dn_vida1', name:'Vidaza (azacitidine)'},
		{id:'dn_viga1', name:'Vigamox (moxifloxacin hcl)'},
		{id:'dn_viib1', name:'Viibryd (vilazodone HCl)'},
		{id:'gen_vila1', name:'vilazodone HCl'},
		{id:'dn_vimo1', name:'Vimovo (naproxen and esomeprazole magnesium)'},
		{id:'dn_vimp1', name:'Vimpat (lacosamide)'},
		{id:'dn_VIRA1', name:'Viracept (nelfinavir mesylate)'},
		{id:'dn_vira6', name:'Viramune XR Tablets (nevirapine)'},
		{id:'dn_VIRE1', name:'Viread (tenofovir disoproxil fumarate)'},
		{id:'dn_VIRO1', name:'Viroptic Opthalmic Solution (trifluridine)'},
		{id:'gen_vism1', name:'vismodegib'},
		{id:'dn_VIST1', name:'Vistaril (hydroxyzine pamoate)'},
		{id:'dn_VIST2', name:'Vistide (cidofovir)'},
		{id:'dn_VISU1', name:'Visudyne (verteporfin)'},
		{id:'dn_VOLT2', name:'Voltaren (diclofenac sodium ophthalmic solution)'},
		{id:'dn_VOLT1', name:'Voltaren-XR (diclofenac sodium)'},
		{id:'gen_vora1', name:'vorapaxar'},
		{id:'g664', name:'voriconazole'},
		{id:'gen_vort1', name:'vortioxetine'},
		{id:'dn_votr1', name:'Votrient (pazopanib)'},
		{id:'dn_vpri1', name:'Vpriv (velaglucerase alfa for injection)'},
		{id:'dn_VYTO2', name:'Vytorin (ezetimibe/simvastatin)'},
		{id:'dn_vyva1', name:'Vyvanse (lisdexamfetamine dimesylate)'},
		{id:'gen_warf1', name:'warfarin'},
		{id:'dn_WELC1', name:'WelChol (colesevelam HCI)'},
		{id:'dn_WELL1', name:'Wellbutrin (bupropion HCl)'},
		{id:'dn_WELL2', name:'Wellbutrin SR (bupropion HCl)'},
		{id:'dn_WELL3', name:'Wellbutrin XL (bupropion HCl extended-release tablets)'},
		{id:'dn_WINR1', name:'WinRho SDF (Rho (D) Immune Globulin)'},
		{id:'dn_XALA1', name:'Xalatan (latanoprost)'},
		{id:'dn_xalk1', name:'Xalkori Capsules (crizotinib)'},
		{id:'dn_xana1', name:'Xanax (alprazolam)'},
		{id:'dn_xare1', name:'Xarelto (rivoroxiban)'},
		{id:'dn_xelj1', name:'Xeljanz (tofacitinib)'},
		{id:'dn_xena1', name:'Xenazine (tetrabenazine)'},
		{id:'dn_xeom1', name:'Xeomin (incobotulinumtoxinA)'},
		{id:'dn_xgev1', name:'Xgeva (denosumab)'},
		{id:'dn_xiaf1', name:'Xiaflex (collagenase clostridium histolyticum)'},
		{id:'dn_xofi1', name:'Xofigo (radium Ra 223 dichloride)'},
		{id:'dn_xynt1', name:'Xyntha Antihemophiliam Factor (recombinant)'},
		{id:'dn_xyre1', name:'Xyrem (sodium oxybate)'},
		{id:'dn_yerv1', name:'Yervoy (ipilimumab)'},
		{id:'gen_zale1', name:'zaleplon'},
		{id:'gen_zale2', name:'zaleplon'},
		{id:'dn_zalt1', name:'Zaltrap (ziv-aflibercept)'},
		{id:'dn_ZANA1', name:'Zanaflex (tizanidine HCl)'},
		{id:'g668', name:'zanamivir'},
		{id:'dn_zant4', name:'Zantac (ranitidine)'},
		{id:'dn_ZARO1', name:'Zarontin (ethosuximide)'},
		{id:'dn_ZARO2', name:'Zaroxolyn (metolazone)'},
		{id:'dn_zela1', name:'Zelapar (selegine hci)'},
		{id:'dn_zelb1', name:'Zelboraf (vemurafenib)'},
		{id:'dn_zema1', name:'Zemaira (alpha 1-proteinase inhibitor)'},
		{id:'dn_ZEST1', name:'Zestoretic (lisinopril/hydrochlorothiazide) '},
		{id:'dn_ZEST2', name:'Zestril (lisinopril)'},
		{id:'dn_ZETI1', name:'Zetia (ezetimibe)'},
		{id:'dn_ZIAC1', name:'Ziac (bisprolol fumarate/hydrochlorothiazide)'},
		{id:'dn_ZIAG1', name:'Ziagen (abacavir sulfate)'},
		{id:'gen_zico1', name:'ziconotide infusion'},
		{id:'g669', name:'zidovudine'},
		{id:'g670', name:'zileuton'},
		{id:'g671', name:'zinc acetate'},
		{id:'dn_ZINE1', name:'Zinecard (dexrazoxane)'},
		{id:'dn_ziop1', name:'Zioptan (tafluprost ophthalmic solution)'},
		{id:'g672', name:'ziprasidone HCl'},
		{id:'dn_ZITH3', name:'Zithromax (azithromycin)'},
		{id:'gen_ziva1', name:'ziv-aflibercept'},
		{id:'dn_ZMAX1', name:'Zmax (azithromycin extended release)'},
		{id:'dn_ZOCO1', name:'Zocor Tablets (simvastatin)'},
		{id:'dn_ZOFR5', name:'Zofran Orally Disintegrating Tablets (ondansetron HCl)'},
		{id:'dn_ZOFR2', name:'Zofran Tablets (ondansetron HCl)'},
		{id:'dn_ZOLA1', name:'Zoladex Implant (goserelin acetate)'},
		{id:'g673', name:'zoledronic acid'},
		{id:'g674', name:'zolmitriptan'},
		{id:'dn_ZOLO1', name:'Zoloft (sertraline HCl)'},
		{id:'g780', name:'zolpidem'},
		{id:'dn_ZOME1', name:'Zometa (zoledronic acid)'},
		{id:'dn_ZOMI1', name:'Zomig (zolmitriptan) '},
		{id:'dn_zomi3', name:'Zomig Nasal Spray (zolmitriptan) '},
		{id:'dn_ZOMI2', name:'Zomig ZMT (zolmitriptan)'},
		{id:'dn_ZONE1', name:'Zonegran (zonisamide)'},
		{id:'g675', name:'zonisamide'},
		{id:'dn_zont1', name:'Zontivity (vorapaxar)'},
		{id:'dn_zort1', name:'Zortress (everolimus)'},
		{id:'dn_zost1', name:'Zostavax (zoster vaccine live)'},
		{id:'gen_zost1', name:'zoster vaccine live'},
		{id:'dn_ZOVI1', name:'Zovirax (acyclovir)'},
		{id:'dn_zyfl2', name:'Zyflo CR Extended Release (zileuton)'},
		{id:'dn_zyka1', name:'Zykadia (ceritinib)'},
		{id:'dn_zyle1', name:'Zylet (loteprednol etabonate and tobramycin ophthalmic suspension)'},
		{id:'dn_zylo1', name:'Zyloprim (allopurinol)'},
		{id:'dn_ZYPR1', name:'Zyprexa (olanzepine)'},
		{id:'dn_zypr3', name:'Zyprexa Relprevv (olanzapine) Extended release injectible suspension'},
		{id:'dn_ZYPR2', name:'Zyprexa Zydis (olanzaprine) Orally Disintegrating Tablets'},
		{id:'dn_zyti1', name:'Zytiga (abiraterone acetate)'},
		{id:'dn_ZYVO1', name:'Zyvox Tablets (linezolid) '}];

	Drugs.getDrugs = function() {
		return _drugs;
	}

	Drugs.nameByCode = function(code) {
		for(var i=0;i<_drugs.length;i++) {
			if (_drugs[i].id==code) return _drugs[i].name;
		}
		return "";
	};

	Drugs.codeByName = function(name) {
		for(var i=0;i<_drugs.length;i++) {
			if (_drugs[i].name==name) return _drugs[i].id;
		}
		return "";
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

app.factory('prescreen', [function(){
	var prescreenform = {};

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

app.controller('questionController',['$scope', 'BenefitItems', function($scope, BenefitItems){

	$scope.months = [{id:1,name:"January"},{id:2,name:"February"},{id:3,name:"March"},{id:4,name:"April"},
		{id:5,name:"May"},{id:6,name:"June"},{id:7,name:"July"},{id:8,name:"August"},
		{id:9,name:"September"},{id:10,name:"October"},{id:11,name:"November"},{id:12,name:"December"}];

	$scope.tooltip = "<strong>Gross monthly income</strong> is your income before any deductions are taken. Please include yourself and your spouse (if applicable) in your calculations.";
	$scope.programs = BenefitItems.getBenefitItems();
	$scope.selectLinkText = "Select All";


	$scope.onStatusChange = function(){
		$scope.$root.prescreen.showCTA = ($scope.$root.prescreen.searchfor.code == '' || $scope.$root.prescreen.searchfor.code == 'self');
	}

	$scope.showSpouseVeteranStatus = function(){
		if ($scope.$root.prescreen.marital_status == undefined) {
			return false;
		} else {
			return (($scope.$root.prescreen.marital_status.code == 'married' || $scope.$root.prescreen.marital_status.code == 'married_living_sep' || $scope.$root.prescreen.marital_status.code == 'widowed') && $scope.$root.prescreen.veteran == 'n');
		}
	}

	$scope.showBenefits = function(){
		if ($scope.$root.prescreen.marital_status == undefined) {
			return false;
		} else {
			if ((($scope.$root.prescreen.marital_status.code == 'married' || $scope.$root.prescreen.marital_status.code == 'married_living_sep' || $scope.$root.prescreen.marital_status.code == 'widowed') && $scope.$root.prescreen.veteran == 'y')) {
				return true;
			} else if ((($scope.$root.prescreen.marital_status.code == 'married' || $scope.$root.prescreen.marital_status.code == 'married_living_sep' || $scope.$root.prescreen.marital_status.code == 'widowed') && $scope.$root.prescreen.veteran == 'n') && $scope.$root.prescreen.spouse_veteran_status) {
				return true;
			} else if (($scope.$root.prescreen.marital_status.code == 'divorced' || $scope.$root.prescreen.marital_status.code == 'single') && $scope.$root.prescreen.veteran) {
				return true;
			} else {
				return false;
			}
		}
	}

	$scope.addProgram = function(program){

		var benefitindex = $scope.$root.prescreen.programList[program.code];
		if(benefitindex == undefined){
			$scope.$root.prescreen.programList[program.code] = program;
		}else{
			delete $scope.$root.prescreen.programList[program.code];
		}

		if ((Object.keys($scope.$root.prescreen.programList).length == 12)) {
			$scope.selectLinkText = "Deselect All";
		} else {
			$scope.selectLinkText = "Select All";
		}
	}

	$scope.selectAll = function(){
		if(Object.keys($scope.$root.prescreen.programList).length == 12){
			$scope.$root.prescreen.programList = {};
			$('.benefits-selector-repeater').removeClass('checked');
			$scope.selectLinkText = "Select All";
		}else if(Object.keys($scope.$root.prescreen.programList).length >= 0){
			$scope.$root.prescreen.programList = {};
			for (var i=0;i<$scope.programs.length;i++) {
				$scope.$root.prescreen.programList[$scope.programs[i].code] = $scope.programs[i];
			}
			$('.benefits-selector-repeater').addClass('checked');
			$scope.selectLinkText = "Deselect All";
		}
	}

}]);

app.controller('preScreenController', ['$scope', 'localStorageService', 'prescreen', 'locationFinder', 'savePrescreen', '$timeout', '$state', 'BenefitItems', function($scope, localStorageService, prescreen, locationFinder, savePrescreen, $timeout, $state, BenefitItems){

	if(prescreen.questions == undefined) $state.transitionTo('prescreen');

	if ($scope.$root.prescreen == undefined) {
		$scope.$root.prescreen = {};
		$scope.$root.prescreen.programList = {};
	}

	$('.glyphicon-question-sign').popover();
	$scope.questions = prescreen.questions;
	$scope.canContinue = true;
	$scope.showquestions = false;
	$scope.$root.prescreen.showCTA = true;

	$scope.submitPrescreen = function() {

		prescreen.screenData = {};

		prescreen.screenData.formatted_address = $scope.$root.prescreen.zipcode_formatted;

		prescreen.screenData.searchingFor = $scope.$root.prescreen.searchfor.display;

		prescreen.screenData.date_of_birth = {
			"month": $scope.$root.prescreen.month.name,
			"year": $scope.$root.prescreen.year
		};

		prescreen.screenData.marital_status = $scope.$root.prescreen.marital_status;

		prescreen.screenData.veteran = (($scope.$root.prescreen.veteran == "y") || ($scope.$root.prescreen.spouse_veteran_status == "y")) ? "Yes" : "No";

		prescreen.screenData.benefits_categories = [];

		for (var programCatCode in $scope.$root.prescreen.programList) {
			prescreen.screenData.benefits_categories.push($scope.$root.prescreen.programList[programCatCode].name);
		}


		var request = {};

		request.zip = $scope.$root.prescreen.zipcode;
		request.dob_month = $scope.$root.prescreen.month.id;
		request.dob_year = $scope.$root.prescreen.year;
		request.state_id = $scope.$root.prescreen.stateId;
		request.st = $scope.$root.prescreen.stateId;

		request.client = $scope.$root.prescreen.searchfor.code;

		if (($scope.$root.prescreen.searchforother != undefined)&&($scope.$root.prescreen.searchforother != '')) {
			request.client_other = $scope.$root.prescreen.searchforother;
		}

		request.bcuqc_income_list = $scope.$root.prescreen.income.code;

		request.marital_stat = $scope.$root.prescreen.marital_status.code;

		request.veteran = $scope.$root.prescreen.veteran;

		if (($scope.$root.prescreen.spouse_veteran_status != undefined)&&($scope.$root.prescreen.spouse_veteran_status != '')) {
			request.sp_veteran = $scope.$root.prescreen.spouse_veteran_status;
		}

		for (var programCatCode in $scope.$root.prescreen.programList) {
			request[programCatCode] = 'y';
		}

		savePrescreen.post(request).success(function(data, status, headers, config) {
			prescreen.results = data;
			$state.go('prescreen.results');
		});
	}

	$scope.$watch('$root.prescreen.searchfor', function(){
		if (($scope.$root.prescreen.searchfor != undefined) && (!$('.dob').is(":visible"))) {
			setTimeout(function () {
				var test = document.querySelector('.dob');
				$('html,body').animate({
					scrollTop: $(test).offset().top + 'px'
				}, 500);
			}, 500);
		}
	});

	$scope.$watch('$root.prescreen.year', function(){
		if($scope.$root.prescreen.month != undefined && !$('.income').is(":visible")){
			setTimeout(function(){
				var test = document.querySelector('.income');
				$('html,body').animate({
					scrollTop: $(test).offset().top + 'px'
				}, 500);
			}, 500);
		}
	});

	$scope.$watch('$root.prescreen.month', function(){
		if($scope.$root.prescreen.year != undefined && !$('.income').is(":visible")){
			setTimeout(function(){
				var test = document.querySelector('.income');
				$('html,body').animate({
					scrollTop: $(test).offset().top + 'px'
				}, 500);
			}, 500);
		}
	});

	$scope.$watch('$root.prescreen.income', function(){
		if(($scope.$root.prescreen.income != undefined) && !$('.marital-status').is(":visible")){
			setTimeout(function(){
				var test = document.querySelector('.marital-status');
				$('html,body').animate({
					scrollTop: $(test).offset().top + 'px'
				}, 500);
			}, 500);
		}
	});

	$scope.$watch('$root.prescreen.marital_status', function(){
		if(($scope.$root.prescreen.marital_status != undefined) && !$('.veteran-status').is(":visible")){
			setTimeout(function(){
				var test = document.querySelector('.veteran-status');
				$('html,body').animate({
					scrollTop: $(test).offset().top + 'px'
				}, 500);
			}, 500);
		}
	});

	$scope.$watch('$root.prescreen.veteran', function(){
		if ($scope.$root.prescreen.marital_status != undefined) {
			if (($scope.$root.prescreen.marital_status.code == "married" ||
				$scope.$root.prescreen.marital_status.code == "married_living_sep" ||
				$scope.$root.prescreen.marital_status.code == "widowed") && $scope.$root.prescreen.veteran == "n" && !$('.partner-veteran-status').is(":visible")) {
				setTimeout(function () {
					var test = document.querySelector('.partner-veteran-status');
					$('html,body').animate({
						scrollTop: $(test).offset().top + 'px'
					}, 500);
				}, 500);
			} else if (($scope.$root.prescreen.marital_status.code == "married" ||
				$scope.$root.prescreen.marital_status.code == "married_living_sep" ||
				$scope.$root.prescreen.marital_status.code == "widowed") && $scope.$root.prescreen.veteran == "y" && !$('.benefits').is(":visible")) {
				setTimeout(function () {
					var test = document.querySelector('.benefits');
					$('html,body').animate({
						scrollTop: $(test).offset().top + 'px'
					}, 500);
				}, 500);
			} else if (($scope.$root.prescreen.marital_status.code == "divorced" || $scope.$root.prescreen.marital_status.code == "single") && !$('.benefits').is(":visible")) {
				setTimeout(function () {
					var test = document.querySelector('.benefits');
					$('html,body').animate({
						scrollTop: $(test).offset().top + 'px'
					}, 500);
				}, 500);
			}
		}
	});

	$scope.$watch('$root.prescreen.spouse_veteran_status', function(){
		if(($scope.$root.prescreen.spouse_veteran_status != undefined) && !$('.benefits').is(":visible")){
			setTimeout(function(){
				var test = document.querySelector('.benefits');
				$('html,body').animate({
					scrollTop: $(test).offset().top + 'px'
				}, 500);
			}, 500);
		}
	});

	$scope.disableSubmit = function(){
		return (Object.keys($scope.$root.prescreen.programList).length == 0);
	};

}]);

app.controller('preScreenInitalController', ['$scope', '$state', 'prescreenQuestions', 'prescreen', function($scope, $state, prescreenQuestions, prescreen){

	prescreenQuestions.get().success(function(data, status, headers, config) {
		prescreen.questions = data;
		if($state.current.name == "prescreen") $state.transitionTo('prescreen.questions');
	});
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

	var foundCount = 0;

	for (var i=0; i<prescreen.results.found_programs.length; i++) {
		foundCount = foundCount + prescreen.results.found_programs[i].count;
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

	$scope.found_programs = prescreen.results.found_programs;

	var foundCount = 0;

	for (var i=0; i<prescreen.results.found_programs.length; i++) {
		foundCount = foundCount + prescreen.results.found_programs[i].count;
	}

	od.update(foundCount);

	
	document.querySelector('.page-wrapper h1').scrollIntoView();

}]);

app.directive('divProgramsCategory',['BenefitItems', function(BenefitItems) {
	return {
		restrict: 'E',
		templateUrl:'/content/themes/ncoa/resources/views/directives/program/programs.category.html?'+(new Date()),
		link: function(scope, element) {
			scope.benefitItem = BenefitItems.getByCode(scope.found_program.category);
			scope.stateId = scope.$root.prescreen.stateId;
		},
		scope: {
			found_program:"=foundProgram"
		}
	}
}]);

app.directive("divKeyProgram",[function() {
	return {
		restrict: 'E',
		templateUrl:'/content/themes/ncoa/resources/views/directives/program/programs.key-program.html?'+(new Date()),
		scope: {
			program:"=program"
		},
		link: function(scope,element) {
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

app.controller('questionnaireResultsController', ['$scope', '$state', function($scope, $state){
	var el = document.querySelector('.odometer');

	od = new Odometer({
		el: el,
		value: 0
	});

	var odValue = 0;

	for (var i=0; i<$scope.$parent.questionnaire.found_programs.length;i++) {
		odValue = odValue + $scope.$parent.questionnaire.found_programs[i].count;
	}

	od.update(odValue);


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

    $('[data-toggle="popover"]').popover();   

}(window.jQuery);
