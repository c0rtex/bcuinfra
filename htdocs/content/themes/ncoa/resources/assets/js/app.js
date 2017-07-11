var app = angular.module('ncoa', ['ngAnimate', 'ngRoute', 'LocalStorageModule', 'ui.router', 'angular-loading-bar', 'ngSanitize']);

app.config(['cfpLoadingBarProvider', function(cfpLoadingBarProvider) {
    cfpLoadingBarProvider.includeSpinner = false;
}]);

// Use sessionStorage instead of localStorage
app.config(['localStorageServiceProvider', function(localStorageServiceProvider) {
    localStorageServiceProvider
        .setStorageType('sessionStorage');
}]);

app.config(['$stateProvider', '$urlRouterProvider', function($stateProvider, $urlRouterProvider){

    $urlRouterProvider.otherwise("/");

    $stateProvider
        .state('prescreen', {
            url: "/",
            templateUrl: '/content/themes/ncoa/resources/views/pages/benefits-checkup/prescreen/prescreen.questions.html?'+(new Date()),
            controller: 'preScreenController'
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
                prev: "/"
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
            url: "/fact-sheets/:programCode/:stateId/:short/:zipcode/:elegible",
            templateUrl: function($stateParams) {
                if ($stateParams.short == "y") {
                    return '/fact-sheets/factsheet_' + $stateParams.programCode + "/?state=" + $stateParams.stateId + "&short_layout=y&short=y&zipcode=" + $stateParams.zipcode + "&elegible=" + $stateParams.elegible;
                } else {
                    return '/fact-sheets/factsheet_' + $stateParams.programCode + "/?state=" + $stateParams.stateId + "&short_layout=y&zipcode=" + $stateParams.zipcode + "&elegible=" + $stateParams.elegible;
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
                scope.caption = "Continue to Full Questionnaire";
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

app.directive('drugsList', ['screening', 'Drugs', '$state', function(screening, Drugs, $state) {
    return {
        restrict: 'E',
        templateUrl: '/content/themes/ncoa/resources/views/directives/drugs-list/drugs-list.html?'+(new Date()),
        link: function (scope, element, attr) {
            scope.genericDrugsAlert = false;
            scope.brandDrugsAlert = false;
            scope.brandDrugs = {};
            scope.genericDrugs = {};
            var currentDrug = '';
            Object.keys(scope.$root.answers.health).forEach(function(code) {
                if(code.indexOf('drug_') == 0) {
                    currentDrug = code.substr(5);

                    var brand = Drugs.isCodeBindToProgram(currentDrug,$state.params["programCode"]);

                    if (brand) {

                        if (currentDrug.indexOf('dn_') == 0) {
                            scope.brandDrugsAlert = true;
                            scope.brandDrugs[currentDrug] = Drugs.nameByCode(currentDrug);
                        }
                        if ((currentDrug.indexOf('gen_') == 0)||(/g\d+/.exec(currentDrug))) {
                            scope.genericDrugsAlert = true;
                            for (var i=0;i<brand.length;i++) {
                                if (!scope.genericDrugs[brand[i].code]) scope.genericDrugs[brand[i].code] = brand[i].name;
                            }
                        }
                    }
                }
            });
        }
    };
}]);

app.factory('Months',[function(){
    return [{id:1,name:"January"},{id:2,name:"February"},{id:3,name:"March"},{id:4,name:"April"},
        {id:5,name:"May"},{id:6,name:"June"},{id:7,name:"July"},{id:8,name:"August"},
        {id:9,name:"September"},{id:10,name:"October"},{id:11,name:"November"},{id:12,name:"December"}];
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

app.factory('AnswersByCategories', [function() {
    var retVal = {};

    var _retVal = {}

    retVal.getCategory = function(answerCode) {
        return _retVal[answerCode];
    }

    retVal.setCategory = function(answerCode, category, type) {
        _retVal[answerCode] = {'category':category,'type':type};
    }

    return retVal;

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
    var _category = {};
    _category.currentCategory = function() {
        if ($state.params.category == undefined) {
            return "prescreen";
        } else {
            return $state.params.category;
        }
    }
    return _category;
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

app.directive('grid', ['$state', 'AnswersByCategories',function ($state, AnswersByCategories) {
    return {
        restrict: 'E',
        scope: {
            title: "@",
            description: "@",
            code: "@",
            type: "@",
            request: "@",
            answer_field: "=answerField"
        },
        templateUrl: '/content/themes/ncoa/resources/views/directives/grid/grid-tpl.html?'+(new Date()),
        link: function (scope, element, attr) {

            scope.category = $state.params.category;

            var cat = AnswersByCategories.getCategory('marital_stat');

            scope.isMarital = false;

            if (cat != undefined) {
                if (scope.$root.answers[cat.category] != undefined) {
                    if (scope.$root.answers[cat.category].marital_stat != undefined) {
                        if (scope.$root.answers[cat.category].marital_stat.code == 'married' || scope.$root.answers[cat.category].marital_stat.code == 'widowed') {
                            scope.isMarital = true;
                        }
                    }
                }
            }

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


            scope.setForJoint = function(code) {

                var s = scope.$root.answers[scope.category][scope.self_code + code] == undefined ? 0 : scope.$root.answers[scope.category][scope.self_code + code];
                var sp = scope.$root.answers[scope.category][scope.spouse_code + code] == undefined ? 0 : scope.$root.answers[scope.category][scope.spouse_code + code];
                var s_sp = scope.$root.answers[scope.category][scope.joint_code+code] == undefined ? 0 : scope.$root.answers[scope.category][scope.joint_code+code];

                if (s_sp < s + sp) {
                    scope.$root.answers[scope.category][scope.joint_code + code] = s+sp;
                }
            };


            scope.calcTotal = function(code) {
                var suffix = ((code == "hh_income_")||(code == "hh_asset_")) ? "_simple" : "";
                if (scope.$root.answers[scope.category] == undefined) scope.$root.answers[scope.category] = {};
                scope.$root.answers[scope.category][code+"total_complete"+suffix] = 0;
                scope.$root.answers[scope.category][code+"total_unearned"+suffix] = 0;
                for (var i in scope.$root["grid_"+code+"_"+scope.type]) {
                    if (scope.$root.answers[scope.category][code+i+suffix] != undefined) {
                        scope.$root.answers[scope.category][code + "total_complete"+suffix] =
                            scope.$root.answers[scope.category][code + "total_complete"+suffix] +
                            scope.$root.answers[scope.category][code + i + suffix];

                        if (scope.$root["grid_" + code + "_" + scope.type][i] == 0) {
                            scope.$root.answers[scope.category][code + "total_unearned"+suffix] =
                                scope.$root.answers[scope.category][code + "total_unearned"+suffix] +
                                scope.$root.answers[scope.category][code + i + suffix];

                        }
                    }

                }
                scope.$root.answers[scope.category][code+"total_earned"+suffix] = scope.$root.answers[scope.category][code+"total_complete"+suffix] - scope.$root.answers[scope.category][code+"total_unearned"+suffix];


                var total_self = scope.$root.answers[scope.category][scope.self_code+"total_complete"] == undefined ? 0 : scope.$root.answers[scope.category][scope.self_code+"total_complete"] + 0;
                var total_spouse = scope.$root.answers[scope.category][scope.spouse_code+"total_complete"] == undefined ? 0 : scope.$root.answers[scope.category][scope.spouse_code+"total_complete"] + 0;
                var total_joint = scope.$root.answers[scope.category][scope.joint_code+"total_complete"] == undefined ? 0 : scope.$root.answers[scope.category][scope.joint_code+"total_complete"] + 0;
                var total_hh = scope.$root.answers[scope.category][scope.household_code+"total_complete_simple"] == undefined ? 0 : scope.$root.answers[scope.category][scope.household_code+"total_complete_simple"] + 0;

                scope.$root.answers[scope.category][scope.household_code+"total_complete"] = total_self + total_spouse + total_hh;

                total_self = scope.$root.answers[scope.category][scope.self_code+"total_unearned"] == undefined ? 0 : scope.$root.answers[scope.category][scope.self_code+"total_unearned"] + 0;
                total_spouse = scope.$root.answers[scope.category][scope.spouse_code+"total_unearned"] == undefined ? 0 : scope.$root.answers[scope.category][scope.spouse_code+"total_unearned"] + 0;
                total_joint = scope.$root.answers[scope.category][scope.joint_code+"total_unearned"] == undefined ? 0 : scope.$root.answers[scope.category][scope.joint_code+"total_unearned"] + 0;
                total_hh = scope.$root.answers[scope.category][scope.household_code+"total_unearned_simple"] == undefined ? 0 : scope.$root.answers[scope.category][scope.household_code+"total_unearned_simple"] + 0;

                scope.$root.answers[scope.category][scope.household_code+"total_unearned"] = total_self + total_spouse + total_hh;

                scope.$root.answers[scope.category][scope.household_code+"total_earned"] = scope.$root.answers[scope.category][scope.household_code+"total_complete"] - scope.$root.answers[scope.category][scope.household_code+"total_unearned"];
            }

            scope.$watch("$root.answers."+scope.category+"."+scope.self_code+scope.answer_field.code,function() {
                if (scope.$root["grid_"+scope.self_code+"_"+scope.type] == undefined) scope.$root["grid_"+scope.self_code+"_"+scope.type] = {};
                scope.$root["grid_"+scope.self_code+"_"+scope.type][scope.answer_field.code] = scope.answer_field.earned;
                scope.calcTotal(scope.self_code);
            });

            scope.$watch("$root.answers."+scope.category+"."+scope.spouse_code+scope.answer_field.code,function() {
                if (scope.$root["grid_"+scope.spouse_code+"_"+scope.type] == undefined) scope.$root["grid_"+scope.spouse_code+"_"+scope.type] = {};
                scope.$root["grid_"+scope.spouse_code+"_"+scope.type][scope.answer_field.code] = scope.answer_field.earned;
                scope.calcTotal(scope.spouse_code);
            });

            scope.$watch("$root.answers."+scope.category+"."+scope.joint_code+scope.answer_field.code,function() {
                if (scope.$root["grid_"+scope.joint_code+"_"+scope.type] == undefined) scope.$root["grid_"+scope.joint_code+"_"+scope.type] = {};
                scope.$root["grid_"+scope.joint_code+"_"+scope.type][scope.answer_field.code] = scope.answer_field.earned;
                scope.calcTotal(scope.joint_code);
            });

            scope.$watch("$root.answers."+scope.category+"."+scope.household_code+scope.answer_field.code+"_simple",function() {
                if (scope.$root["grid_"+scope.household_code+"_"+scope.type] == undefined) scope.$root["grid_"+scope.household_code+"_"+scope.type] = {};
                scope.$root["grid_"+scope.household_code+"_"+scope.type][scope.answer_field.code] = scope.answer_field.earned;
                scope.calcTotal(scope.household_code);
            });


            scope.$root.answers[scope.category][scope.self_code+scope.code] = 0;

            scope.$root.answers[scope.category][scope.spouse_code+scope.code] = 0;

            scope.$root.answers[scope.category][scope.joint_code+scope.code] = 0;

            scope.$root.answers[scope.category][scope.household_code+scope.code+'_simple'] = 0;

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
app.directive('medicationSelector',['Drugs', '$state', function(Drugs, $state){
    return {
        restrict: 'E',
        scope: {answer_field:"=answerField"},
        templateUrl: '/content/themes/ncoa/resources/views/directives/med-selector/medication-selector.html?'+(new Date()),
        link: function(scope, elm){

            Drugs.setDrugs(scope.answer_field.options);

            scope.category = $state.params.category;

            var drugs = Drugs.getDrugs();

            for(var i=0; i<drugs.length; i++) {
                var option = $("<option/>",{value:drugs[i].code, text:drugs[i].display});
                option.appendTo($("#multiselect"));
            }

            $("#multiselect").multiSelect({
                selectableHeader: "<p class='bold'>Available Medications</p><input type='text' class='form-control' autocomplete='off' placeholder='Search...'>",
                selectionHeader: "<p class='bold'>My Medication List</p>",
                selectableFooter: "<button class='btn btn-secondary add' disabled>Add to My List</button>",
                selectionFooter: "<button class='btn btn-secondary remove' disabled>Remove from My List</button>",
                afterInit: function(ms){
                    var that = this,
                        $selectableSearch = that.$selectableUl.prev(),
                        selectableSearchString = '#'+that.$container.attr('id')+' .ms-elem-selectable:not(.ms-selected)';

                    that.qs1 = $selectableSearch.quicksearch(selectableSearchString,{
                        'prepareQuery': function (val) {
                            return new RegExp('^'+val,'i');
                        },
                        'testQuery': function (query, txt, _row) {
                            return query.test(txt);
                        }
                    }).on('keydown', function(e){
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
                for (var i=0;i<selected.length;i++) {
                    scope.$root.answers[scope.category][selected[i]] = 'y';
                    scope.$root.answers[scope.category]['drug_' + selected[i]] = 'y';
                    console.log(scope.$root.answers[scope.category]);
                }
            });

            $('.ms-selection').on('click', 'button.remove', function(){
                var selected = $('.ms-selection .ms-list .selected span').map(function(){
                    return Drugs.codeByName($(this).html());
                }).get();
                $('#multiselect').multiSelect('deselect', selected);
                for (var i=0;i<selected.length;i++) {
                    delete scope.$root.answers[scope.category][selected[i]];
                    delete scope.$root.answers[scope.category]['drug_' + selected[i]];
                }
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
            scope.currentProgramsList =scope.programs.slice(0,10);
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
                scope.currentProgramsList =scope.programs.slice((scope.currentPage-1)*10, scope.currentPage*10);
                return false;
            }
        }
    }

}]);

app.directive('pageSwitch',['$rootScope', '$state', 'prescreen', 'screening', 'saveScreening', 'ScreeningRoutes', function($rootScope, $state, prescreen, screening, saveScreening, ScreeningRoutes){
    return {
        link: function (scope, elm) {
            if ($state.current.name == 'questionnaire.results') {
                scope.isResults = true;
            }

            if ($state.params.category == undefined) {
                scope.prev = "prescreen";
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
                if ((stateName == "prescreen")||(stateName == "screening-start")||(stateName == "questionnaire.initial-results")) {
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
                        $rootScope.showLoader = true;
                        document.querySelector('.container').scrollIntoView();
                    }

                    request.answers = scope.$root.answers[$state.params.category] == undefined ? {} : scope.$root.answers[$state.params.category];

                    saveScreening.post(request).success(function (data, status, headers, config) {
                        if (stateName == "questionnaire.loader") {
                            screening.data.answers = scope.$root.answers;
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
                            screening.data.answers = scope.$root.answers;
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


app.directive('profile', ['prescreen','screening', 'BenefitItems', '$state', 'Drugs', 'CronicConditions', function (prescreen,screening, BenefitItems, $state, Drugs, CronicConditions) {
    return {
        restrict: 'A',
        templateUrl: '/content/themes/ncoa/resources/views/directives/profile/profile.html?'+(new Date()),
        link: function (scope, element, attr) {
            scope.screenData = prescreen.data.screenData;
            //scope.questionnaire.prevScreening = prescreen.results.screening;
            // @TODO: Options were disabled as per requested in ticket BCURD-105
            scope.showOptions = false;
            //scope.showOptions = ($state.current.name.split('.')[1] == "results" || $state.current.name.split(".")[1] == "initial-results");

            scope.programs_calculated=false;

            scope.is_full_q = false;
            scope.found_programs = [];
            if ($state.current.name == 'questionnaire.results' ||
                $state.current.name == 'screening') {
                scope.is_full_q = true;
                scope.found_programs_categories = prescreen.data.results.found_programs;
            }

            if ($state.current.name == 'questionnaire.results') {
                scope.print_button = true;
            }
            else {
                scope.print_button = false;
            }

            scope.BenefitItems = BenefitItems;

            if (screening.data.results.found_programs != undefined) {
                scope.programs_calculated=screening.data.results.found_programs.length>0;
            }

            scope.slugs={};
            scope.noSlugs = false;
            scope.limitReached = false;

            scope.closeErrorModal = function() {
                $('#modalError').modal('hide');
            };

            scope.generatePrintUrl = function(checkSlugs) {
                if (Object.keys(scope.slugs).length > 0) {
                    var slugs = '';
                    var firstSlug = '';
                    var url = '';
                    var i = 0;
                    for (var key in scope.slugs) {
                        if (scope.slugs[key] === true) {
                            if (i == 0) {
                                firstSlug = key;
                            }
                            else {
                                slugs = slugs +";" + key;
                            }
                            i++;
                        }
                    }

                    if (i > 0) {
                        scope.noSlugs = false;

                        if (i > 10) {
                            scope.limitReached = true;
                            if (checkSlugs !== true) {
                                $('#modalError').modal('show');
                            }
                            return false;
                        }
                    }
                    else {
                        scope.noSlugs = true;
                        scope.limitReached = false;
                        if (checkSlugs !== true) {
                            $('#modalError').modal('show');
                        }
                        return false;
                    }

                    if (firstSlug.length > 0) {
                        scope.limitReached = false;
                        scope.noSlugs = false;

                        if (checkSlugs === true) {
                            return true;
                        }

                        scope.noSlugs = false;
                        slugs = slugs.substring(1);
                        url = '/fact-sheets/factsheet_' + firstSlug + "/?state=" + prescreen.data.answers.stateId + "&zipcode=" + prescreen.data.answers.zipcode+'&slugs='+slugs+'&pdf=y';

                        return url;
                    }
                }

                return false;
            };

            scope.selectAllCategory = function(category_id) {
                var checked = angular.element('#' + category_id).is(':checked');
                $('.' + category_id + ' input[type=checkbox]').each(function(index) {
                    checkbox_id = $(this).attr('id');
                    scope.slugs[checkbox_id] = checked;
                });
            };

            scope.printReport = function() {
                url = scope.generatePrintUrl(false);

                if (url !== false) {
                    scope.noSlugs = false;
                    window.open(url);
                }
            };

            scope.selectAll = function() {
                for (var key in scope.slugs) {
                    if (scope.slugs.hasOwnProperty(key)) {
                        scope.slugs[key] = true;
                    }
                }
                $('.category-headline input[type=checkbox]').prop('checked', true);
            };
            scope.deselectAll = function() {
                for (var key in scope.slugs) {
                    if (scope.slugs.hasOwnProperty(key)) {
                        scope.slugs[key] = false;
                    }
                }
                $('.category-headline input[type=checkbox]').prop('checked', false);
            };

            if (scope.programs_calculated) {
                scope.programs_calculated=true;
                scope.found_programs = screening.data.results.found_programs;

                for (var i=0;i<scope.found_programs.length;i++) {
                    var program_category = BenefitItems.getByCode(scope.found_programs[i].category);
                    scope.found_programs[i].name= program_category.name;
                    scope.found_programs[i].sort = program_category.sort;

                    scope.found_programs[i].programs.forEach(function(element) {
                        scope.slugs[element.code] = false;
                    });
                }
            }

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

            $(elm).children('.program-header').click(function(){
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
        "citizen":directivePath+"citizen.html",
        "sp_veteran":directivePath+"sp_veteran.html",
        "sp_dob":directivePath+"sp_dob.html",
        "incomegrid":directivePath+"incomegrid.html",
        "assetgrid":directivePath+"assetgrid.html"};

    return questionTemplates;
}]);

app.directive('question',['questionTemplates', 'AnswersByCategories', 'category', 'localStorageService', 'BenefitItems', function(questionTemplates, AnswersByCategories,category, localStorageService, BenefitItems) {
    return {
        restrict: 'E',
        template:"<span ng-show='checkRule()' ng-include='question_template_link'></span>",
        link: function(scope,element,ngShow) {

            if (scope.$root.answers[category.currentCategory()] == undefined) {
                scope.$root.answers[category.currentCategory()] = {};
            }

            for (var i=0; i<scope.question.answer_fields.length;i++) {
                var code = scope.question.answer_fields[i].code;
                if ((scope.question.answer_fields[i].default != undefined) && (scope.$root.answers[category.currentCategory()][code] == undefined)) {
                    scope.$root.answers[category.currentCategory()][code] = scope.question.answer_fields[i].default;
                }
                AnswersByCategories.setCategory(code,category.currentCategory(),scope.question.answer_fields[i].type);
            }

            if (scope.question.rule == undefined) {
                scope.checkRule = function() {return true};
            } else if (scope.question.rule == '') {
                scope.checkRule = function() {return true};
            } else {
                if (scope.question.rulecode.indexOf('question_dep_') != 0) {
                    scope.checkRule = function() {return true};
                } else {
                    scope.checkRule = function () {
                        if (scope.question.rule == undefined) return true;
                        if (scope.question.rule == '') return true;

                        var ruleArray = scope.question.rule.split('#');
                        var evalString = '';
                        for (var i = 0; i < ruleArray.length; i++) {
                            var isVar = i % 2 == 1;
                            if (isVar) {
                                var val = '';
                                try {
                                    var ans = ruleArray[i].trim();
                                    var cat = AnswersByCategories.getCategory(ans);
                                    switch (cat.type) {
                                        case 'select':
                                            val = '\'' + scope.$root.answers[cat.category][ans].code + '\'';
                                            break;
                                        case 'yn':
                                            val = '\'' + scope.$root.answers[cat.category][ans] + '\'';
                                            break;
                                        default:
                                            val = scope.$root.answers[cat.category][ans];
                                            break;
                                    }
                                } catch (err) {
                                    val = 'undefined';
                                }
                                evalString = evalString + val;
                            } else {
                                evalString = evalString + ruleArray[i];
                            }
                        }
                        var retVal = false;
                        try {
                            retVal = eval(evalString);
                        } catch (err) {
                            retVal = false;
                        }
                        if (retVal) {
                            return retVal;
                        } else {
                            return retVal;
                        }
                    }
                }
            }

            scope.category=category.currentCategory();
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

app.directive('setDefaultAnswer',[function(){
    return {
        link: function(scope, element, attr) {
            if (scope.$root.answers[scope.category] == undefined) scope.$root.answers[scope.category] = {};
            var val = scope.value;
            if (scope.$root.answers[scope.category]) {
                if (scope.$root.answers[scope.category][scope.answer_field.code]) {
                    val = scope.$root.answers[scope.category][scope.answer_field.code];
                } else if (scope.answer_field.default) {
                    val = scope.answer_field.default;
                }
            } else if (scope.answer_field.default) {
                val = scope.answer_field.default;
            }
            scope.$root.answers[scope.category][scope.answer_field.code] = val;
        },
        scope: {
            category:"@",
            answer_field:"=answerField",
            value:"@"
        }
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
                        $('.bene-panel').css('height', 'auto');
                        break;
                    case '20':
                        scope.sel = 'mid';
                        $('.bene-panel').css('height', 'auto');
                        break;
                    default:
                        scope.sel = 'max';
                        $('.bene-panel').css('height', '284px');
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
            scope.category = category.currentCategory();
            if (scope.$root.answers[category.currentCategory()][scope.code] == undefined) {
                scope.$root.answers[category.currentCategory()][scope.code] = scope.years[66];
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

            scope.category = category.currentCategory();

            scope.regPattern = "\\d{5}";
            scope.$root.isZipValid = false;
            scope.zipValid = '';
            scope.$root.isZipCodeValidating = false;

            scope.updateZip = function(){
                scope.$root.isZipCodeValidating = true;
                locationFinder.getLocation(scope.$root.answers[scope.category].zip).success(function(data, status, headers, config) {
                    validateZip(data);
                    scope.$root.isZipCodeValidating = false;
                });
            };


            if (localStorageService.get('v_zipcode') != undefined) {
                scope.zipCodeLabel = "Update Zip Code";
                scope.$root.answers[category.currentCategory()].zip = localStorageService.get('v_zipcode');
                localStorageService.remove('v_zipcode');
                scope.updateZip();
            } else {
                scope.zipCodeLabel = "Let's Get Started";
            }



            scope.resetZip = function(){
                scope.$root.isZipEdit = true;
                $('#zipcode').focus();
            }

            function validateZip(data){
                if (scope.$root.answers[category.currentCategory()].zip.length != 5) {
                    scope.$root.isZipValid = false;
                    scope.zipValid = '';
                    scope.$parent.zipCodeCheckResult = "Error!"
                    scope.$parent.zipCodeDescription = "Please enter a valid zip code in the United States.";
                    scope.$parent.zipCodeUpdated=true;
                    return;
                }
                if(data.status == "OK"){

                    var isZipInvalid=true;
                    var zipCode = "";

                    for (var i=0;i<data.results[0].address_components.length;i++) {
                        for(var j=0;j<data.results[0].address_components[i].types.length;j++) {
                            if (((data.results[0].address_components[i].types[j] == "country")||
                                (data.results[0].address_components[i].types[j] == "political"))&&
                                (data.results[0].address_components[i].short_name == "US")) {
                                isZipInvalid=false;
                            }

                            if (data.results[0].address_components[i].types[j] == "postal_code") {
                                scope.$root.answers[category.currentCategory()].zipcode = data.results[0].address_components[i].long_name;
                            }

                            if (data.results[0].address_components[i].types[j] == "administrative_area_level_1") {
                                scope.$root.answers[category.currentCategory()].stateId = data.results[0].address_components[i].short_name;
                                scope.zipCodeLabel = "Update Zip Code";
                            }

                            if (data.results[0].address_components[i].types[j] == "administrative_area_level_2") {
                                scope.$root.answers[category.currentCategory()].county = data.results[0].address_components[i].short_name.toUpperCase().replace(' COUNTY','');
                            }
                        }
                    }

                    if(!isZipInvalid){
                        scope.$root.answers[category.currentCategory()].zipcode_formatted = $filter('limitTo')(data.results[0].formatted_address, data.results[0].formatted_address.lastIndexOf(','), 0);
                        scope.$root.isZipValid = true;
                        scope.zipValid = '1';
                        scope.$parent.zipCodeCheckResult = "Success!"
                        scope.$parent.zipCodeDescription = scope.$root.answers[category.currentCategory()].zipcode_formatted;
                    }else{
                        scope.$root.isZipValid = false;
                        scope.zipValid = '';
                        scope.$parent.zipCodeCheckResult = "Error!"
                        scope.$parent.zipCodeDescription = "Please enter a valid zip code in the United States.";
                    }
                }else{
                    scope.$root.isZipValid = false;
                    scope.zipValid = '';
                    scope.$parent.zipCodeCheckResult = "Error!"
                    scope.$parent.zipCodeDescription = "Please enter a valid zip code in the United States.";
                }
                scope.$parent.zipCodeUpdated=true;
            }

            if (scope.$root.answers != undefined) {
                if (scope.$root.answers[category.currentCategory()] != undefined) {
                    if (scope.$root.answers[category.currentCategory()].zipcode != undefined) {
                        scope.updateZip();
                    }
                }
            }
        }
    }
}]);

app.factory('BenefitItems', [function(){

    var BenefitItems = {};

    var _BenefitItems = [
        {
            name: 'Medication',
            code: 'bcuqc_category_rx',
            image: '/content/themes/ncoa/resources/assets/images/categories/category_medicine.svg',
            alt: 'Medicine Pills',
            title: 'Medicine Pills',
            sort: 1
        },
        {
            name: 'Health Care',
            code: 'bcuqc_category_medicaid',
            image: '/content/themes/ncoa/resources/assets/images/categories/category_health.svg',
            alt: 'Doctor Symbols',
            title: 'Doctor Symbol',
            sort: 2
        },
        {
            name: 'Income Assistance',
            code: 'bcuqc_category_income',
            image: '/content/themes/ncoa/resources/assets/images/categories/category_income.svg',
            alt: 'Money',
            title: 'Money',
            sort: 3
        },
        {
            name: 'Food & Nutrition',
            code: 'bcuqc_category_nutrition',
            image: '/content/themes/ncoa/resources/assets/images/categories/category_food.svg',
            alt: 'Basket of Food',
            title: 'Basket of Food',
            sort: 4
        },
        {
            name: 'Housing & Utilities',
            code: 'bcuqc_category_utility',
            image: '/content/themes/ncoa/resources/assets/images/categories/category_housing.svg',
            alt: 'House',
            title: 'House',
            sort: 5
        },
        {
            name: 'Tax Relief',
            code: 'bcuqc_category_property_taxrelief',
            image: '/content/themes/ncoa/resources/assets/images/categories/category_taxRelief.svg',
            alt: 'Piggy Bank',
            title: 'Piggy Bank',
            sort: 6
        },
        {
            name: 'Veterans',
            code: 'bcuqc_category_veteran',
            image: '/content/themes/ncoa/resources/assets/images/categories/category_veteran.svg',
            alt: 'Medal',
            title: 'Medal',
            sort: 7
        },
        {
            name: 'Employment',
            code: 'bcuqc_category_employment',
            image: '/content/themes/ncoa/resources/assets/images/categories/category_employment.svg',
            alt: 'Briefcase',
            title: 'Briefcase',
            sort: 8
        },
        {
            name: 'Transportation',
            code: 'bcuqc_category_transportation',
            image: '/content/themes/ncoa/resources/assets/images/categories/category_transportation.svg',
            alt: 'Automobile',
            title: 'Automobile',
            sort: 9
        },
        {
            name: 'Education',
            code: 'bcuqc_category_education',
            image: '/content/themes/ncoa/resources/assets/images/categories/category_education.svg',
            alt: 'Apple on Book',
            title: 'Apple on Book',
            sort: 10
        },
        {
            name: 'Discount',
            code: 'bcuqc_category_discounts',
            image: '/content/themes/ncoa/resources/assets/images/categories/category_discounts.svg',
            alt: 'Percent Off',
            title: 'Percent Off',
            sort: 11
        },
        {
            name: 'Other Assistance',
            code: 'bcuqc_category_other_assistance',
            image: '/content/themes/ncoa/resources/assets/images/categories/category_assistance.svg',
            alt: 'Information',
            title: 'Information',
            sort: 12
        }
    ];

    BenefitItems.returnAllCodes = function() {
        var codes = [];
        _BenefitItems.forEach(function(element) {
            codes.push(element.code);
        });

        return codes;
    }

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
    _routes.basics = {"prev":"questionnaire.initial-results", "next":"health", pgno:1};
    _routes.health = {"prev":"basics", "next":"household", pgno:2};
    _routes.household = {"prev":"health", "next":"finances", pgno:3};
    _routes.finances = {"prev":"household", "next":"questionnaire.loader", pgno:4};

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

    Drugs.drugByCode = function (code) {
        for(var i=0;i<_drugs.length;i++) {
            if (_drugs[i].code==code) return _drugs[i];
        }
        return undefined;
    }

    Drugs.nameByCode = function(code) {
        var drug = Drugs.drugByCode(code);
        if (drug) {
            return drug.display;
        }
        return undefined;
    };

    Drugs.isCodeBindToProgram = function(drugCode,programCode) {
        var drug = Drugs.drugByCode(drugCode);
        if (drug) {
            if (drug.type == "brand") {
                return drug.programs.indexOf(programCode) != -1;
            } else {
                var brands = [];
                for (var i=0; i<drug.programs.length;i++) {
                    if (drug.programs[i].program == programCode) {
                        brands.push({"code":drug.programs[i].brand_code,"name":drug.programs[i].brand_name});
                    }
                }
                if (brands.length>0) {
                    return brands;
                } else {
                    return false;
                }
            }
        }
        return false;
    }

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

app.service('factSheet',['$http', function ($http) {
    this.get = function(slug) {
        return $http.get('/wp-json/wp/v2/fact-sheets?slug='+slug);
    };
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
    this.get = function(category,prescreen,state) {
        return $http.get(window.webServiceUrl+'/rest/backend/questionnaire/'+category+'/'+prescreen+'/'+state);
    }
}]);

app.factory('prescreen', ['localStorageService', '$window', 'orderByFilter', function(localStorageService, $window, orderBy){
    var prescreenform = {};

    var reorder = function (data) {
        return orderBy(data, 'sort');
    };

    var _data = localStorageService.get('prescreen');

    prescreenform.clear = function() {
        localStorageService.remove('prescreen');
    };

    if (_data == undefined) {
        prescreenform.data = {};
    } else {
        if (_data.name==$window.name) {
            prescreenform.data = _data;
        } else {
            localStorageService.remove('prescreen');
            prescreenform.data = {};
        }
    }

    if (prescreenform.data.answers == undefined) {
        prescreenform.data.answers = {};
    }

    prescreenform.save = function() {
        prescreenform.data.name=$window.name;
        if (typeof prescreenform.data.results !== 'undefined') {
            if (typeof prescreenform.data.results.found_programs !== 'undefined') {
                prescreenform.data.results.found_programs = reorder(prescreenform.data.results.found_programs);
            }
        }
        localStorageService.set('prescreen', prescreenform.data);
    };

    return prescreenform;
}]);

app.factory('screening', ['localStorageService', '$window', 'ScreeningRoutes', 'orderByFilter', function(localStorageService, $window, ScreeningRoutes, orderBy) {
    var screening = {};

    var reorder = function (data) {
        return orderBy(data, 'sort');
    };

    var _data = localStorageService.get('screening');

    if (_data != undefined) {
        if (_data.name != $window.name) {
            _data == undefined;
            localStorageService.remove('screening');
        }
    }

    if (_data == undefined) {
        _data = {};
        _data.questions = {};
        _data.answers = {};
        _data.results = {};
        _data.results.screening = {};
    } else if (_data.answers == undefined) {
        _data.answers = {};
    }

    if (Object.keys(_data.answers).length != Object.keys(ScreeningRoutes).length) {
        _data.answers = {};
        for (i in ScreeningRoutes) {
            _data.answers[i] = {};
        }
    }

    screening.data = _data;

    screening.save = function() {
        if (typeof screening.data.results !== 'undefined') {
            if (typeof screening.data.results.found_programs !== 'undefined') {
                screening.data.results.found_programs = reorder(screening.data.results.found_programs);
            }
        }
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

app.controller('questionController',['$scope', 'category', 'BenefitItems', 'AnswersByCategories', 'Months', function($scope, category, BenefitItems, AnswersByCategories, Months){

    $scope.category = category.currentCategory();

    $scope.months = Months;

    $scope.programs = BenefitItems.getBenefitItems();

    if (BenefitItems.programsInStructure($scope.$root.answers[category.currentCategory()]) == $scope.programs.length) {
        $scope.selectLinkText = "Deselect All";
    } else {
        $scope.selectLinkText = "Select All";
    }

    $scope.showSpouseVeteranStatus = function(){
        if ($scope.$root.answers[category.currentCategory()].marital_stat == undefined) {
            return false;
        } else {
            return (($scope.$root.answers[category.currentCategory()].marital_stat.code == 'married' || $scope.$root.answers[category.currentCategory()].marital_stat.code == 'married_living_sep' || $scope.$root.answers[category.currentCategory()].marital_stat.code == 'widowed') && $scope.$root.answers[category.currentCategory()].veteran == 'n');
        }
    }

    $scope.showBenefits = function(){
        return ($scope.$root.answers[category.currentCategory()].veteran != undefined)&&($scope.$root.answers[category.currentCategory()].marital_stat != undefined);
    }

    $scope.addProgram = function(program){

        var benefitindex = $scope.$root.answers[category.currentCategory()][program.code];
        if(benefitindex == undefined){
            $scope.$root.answers[category.currentCategory()][program.code] = 'y';
        }else{
            delete $scope.$root.$root.answers[category.currentCategory()][program.code];
        }

        $scope.$root.areProgramsAdded = BenefitItems.programsInStructure($scope.$root.answers[category.currentCategory()]) == 0 ? undefined : '1';

        if (BenefitItems.programsInStructure($scope.$root.answers[category.currentCategory()]) == $scope.programs.length) {
            $scope.selectLinkText = "Deselect All";
        } else {
            $scope.selectLinkText = "Select All";
        }
    }

    $scope.programAdded = function(programCode) {
        return $scope.$root.$root.answers[category.currentCategory()][programCode] != undefined;
    }

    $scope.selectAll = function(){
        if(BenefitItems.programsInStructure($scope.$root.answers[category.currentCategory()]) == $scope.programs.length){
            for (var i=0;i<$scope.programs.length;i++) {
                delete $scope.$root.$root.answers[category.currentCategory()][$scope.programs[i].code];
            }
            $('.benefits-selector-repeater').removeClass('checked');
            $scope.selectLinkText = "Select All";
        }else {
            for (var i=0;i<$scope.programs.length;i++) {
                $scope.$root.answers[category.currentCategory()][$scope.programs[i].code] = 'y';
            }
            $('.benefits-selector-repeater').addClass('checked');
            $scope.selectLinkText = "Deselect All";
        }
        $scope.$root.areProgramsAdded = BenefitItems.programsInStructure($scope.$root.answers[category.currentCategory()]) == 0 ? undefined : '1';
    }
}]);

app.controller('preScreenController', ['$scope', 'localStorageService', 'prescreen', 'locationFinder', 'savePrescreen', '$timeout', '$state', 'BenefitItems', 'prescreenQuestions','screening', function($scope, localStorageService, prescreen, locationFinder, savePrescreen, $timeout, $state, BenefitItems, prescreenQuestions,screening){

    $scope.category = "prescreen";
    $scope.showLoader = false;

    if ($scope.$root.answers == undefined) {
        $scope.$root.answers = {};
    }


    $scope.$root.answers.prescreen = prescreen.data.answers;

    $scope.sibmitDisabled = true;

    if ($scope.$root.prescreen == undefined) {
        $scope.$root.prescreen = {};
        $scope.$root.prescreen.programList = {};
    }

    $scope.canContinue = true;
    $scope.showquestions = false;
    $scope.$root.prescreen.showCTA = true;
    $scope.$root.areProgramsAdded = BenefitItems.programsInStructure($scope.$root.answers.prescreen) == 0 ? undefined : '1';

    prescreenQuestions.get().success(function(data, status, headers, config) {
        prescreen.data.questions = data;
        $scope.questionSet = prescreen.data.questions;
    });


    $scope.submitPrescreen = function() {
        $scope.showLoader = true;
        document.querySelector('.container').scrollIntoView();

        $scope.sibmitDisabled = true;

        prescreen.data.screenData = {};

        prescreen.data.screenData.formatted_address = $scope.$root.answers[$scope.category].zipcode_formatted;

        prescreen.data.screenData.searchingFor = $scope.$root.answers[$scope.category].client.display;

        prescreen.data.screenData.date_of_birth = {
            "month": $scope.$root.answers[$scope.category].dob_month.name,
            "year": $scope.$root.answers[$scope.category].dob_year
        };

        prescreen.data.screenData.marital_status = $scope.$root.answers[$scope.category].marital_stat.display;

        prescreen.data.screenData.veteran = $scope.$root.answers[$scope.category].veteran == "y" ? "Yes" : "No";

        prescreen.data.screenData.benefits_categories = [];
        prescreen.data.screenData.benefits_categories_codes = [];

        for (var programCatCode in $scope.$root.answers[$scope.category]) {
            if (BenefitItems.getByCode(programCatCode) != undefined) {
                prescreen.data.screenData.benefits_categories.push(BenefitItems.getByCode(programCatCode));
                prescreen.data.screenData.benefits_categories_codes.push(programCatCode);
            }
        }

        var request = $scope.$root.answers[$scope.category];

        request.state_id = $scope.$root.answers[$scope.category].stateId;
        request.st = $scope.$root.answers[$scope.category].stateId;

        savePrescreen.post(request).success(function(data, status, headers, config) {
            $scope.sibmitDisabled = false;
            prescreen.data.answers = $scope.$root.answers[$scope.category];
            prescreen.data.results = data;

            prescreen.save();

            screening.data.results.screening.id = undefined;

            $scope.showLoader = false;
            localStorageService.remove("screening");
            for (var key in $scope.$root.answers) {
                if (key != 'prescreen') $scope.$root.answers[key] = {};
            }
            $state.go('questionnaire.initial-results');
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

    $scope.disableSubmit = function(){
        if (this.prescreenForm == undefined) return true;
        return !this.prescreenForm.$valid;
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

    document.querySelector('.page-wrapper').scrollIntoView();

    $scope.tooltipAccuracy = "You will receive more accurate results if you provide more details.";
    $scope.tooltipExpenses = "Expenses are the amount of money you spend on things like rent, utilities, and other costs of living."

    $scope.goScreening = function(){
        $state.transitionTo('screening',{category:"basics",state:prescreen.data.answers.stateId});
    }

    var el = document.querySelector('.odometer');

    od = new Odometer({
        el: el,
        value: 0,
    });

    $scope.foundCount = 0;

    for (var i=0; i<prescreen.data.results.found_programs.length; i++) {
        $scope.foundCount = $scope.foundCount + prescreen.data.results.found_programs[i].count;
    }

    od.update($scope.foundCount);
}]);

app.controller('questionnaireBasicController', ['$scope','$state', 'questionnaire', function($scope, $state, questionnaire){

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

app.controller('screeningController', ['$rootScope', '$scope', '$state', '$stateParams', 'prescreen', 'screening', 'screeningQuestions', function($rootScope, $scope, $state, $stateParams, prescreen, screening, screeningQuestions){

    $rootScope.showLoader = false;

    if ($scope.$root.answers == undefined) {
        $scope.$root.answers = screening.data.answers;
    }

    if ($scope.$root.questions == undefined) {
        $scope.$root.questions = screening.data.questions;
    }

    if (($state.params.category != undefined) && ($state.params.state != undefined)) {

        $scope.category = $state.params.category;

        if ($scope.$root.answers[$state.params.category] == undefined) {
            $scope.$root.answers[$state.params.category] = screening.data.answers[$state.params.category];
        }

        screeningQuestions.get($state.params.category,prescreen.data.results.screening.id,$state.params.state).success(function(data){
            screening.data.questions[$state.params.category] = data;
            $scope.$root.questions[$state.params.category] = data;
        });
    } else {
        $state.transitionTo('screening',{category:"basics",state:prescreen.data.answers.stateId});
    }

    $scope.isBasicTab = false;
    if ($stateParams.category == 'basics') {
        $scope.isBasicTab = true;
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
app.controller('questionnairePrescreenResultsController', ['$scope', '$state', 'BenefitItems', 'prescreen', function($scope, $state, BenefitItems, prescreen){
    var el = document.querySelector('.odometer');

    od = new Odometer({
        el: el,
        value: 0
    });

    var returned_programs = [];
    $scope.found_programs = [];
    $scope.available_fact_sheets = {};

    prescreen.data.results.found_programs.forEach(function(element, index) {
        if (prescreen.data.answers[element.category]) {
            // -- BCURD-336 -- //
            if (element.category == 'bcuqc_category_veteran' && prescreen.data.answers.veteran == 'n') {
                var emptyProgram = {
                    'category': element.category,
                    'count': 0,
                    'programs': []
                };

                $scope.found_programs.push(emptyProgram);
                prescreen.data.results.found_programs[index] = emptyProgram;
            }
            else {
                $scope.found_programs.push(element);
            }
            // -- BCURD-336 -- //

            returned_programs.push(element.category);
        }

        $scope.available_fact_sheets[element.category] = [];
        element.programs.forEach(function(program) {
            $scope.available_fact_sheets[element.category].push(program.code);
        });
    });

    // BCURD-300: List of categories & programs.
    //console.log(encodeURIComponent(JSON.stringify($scope.available_fact_sheets)));

    // Find empty programs
    var programs_diff = $(prescreen.data.screenData.benefits_categories_codes).not(returned_programs).get();
    programs_diff.forEach(function(element) {
        $scope.found_programs.push({
            'category': element,
            'count': 0,
            'programs': []
        });
    });

    $scope.foundCount = 0;

    for (var i=0; i<prescreen.data.results.found_programs.length; i++) {
        $scope.foundCount = $scope.foundCount + prescreen.data.results.found_programs[i].count;
    }

    od.update($scope.foundCount);

    document.querySelector('.page-wrapper h1').scrollIntoView();

    $scope.goScreening = function(){
        $state.transitionTo('screening',{category:"basics",state:prescreen.data.answers.stateId});
    }

}]);

app.directive('divProgramsCategory',['BenefitItems', 'prescreen', '$sce', function(BenefitItems,prescreen, $sce) {
    return {
        restrict: 'E',
        templateUrl:'/content/themes/ncoa/resources/views/directives/program/programs.category.html?'+(new Date()),
        link: function(scope, element) {
            scope.benefitItem = BenefitItems.getByCode(scope.found_program.category);
            scope.stateId = prescreen.data.answers.stateId;
            scope.defaultLangsPre = window.defaultLangsPre;
            scope.defaultLangsFull = window.defaultLangsFull;
            scope.zipcode = prescreen.data.answers.zip;
        },
        scope: {
            found_program:"=foundProgram",
            short:"@",
            elegible:"@"
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

app.directive('divProgramDesc',['factSheet',function(factSheet) {
    return {
        restrict: 'E',
        //templateUrl:'/content/themes/ncoa/resources/views/pages/benefits-checkup/programs/programs.category.html?'+(new Date()),
        link: function(scope, element) {
            factSheet.get('factsheet_'+scope.program_code).success(function(data, status, headers, config) {
                element.append("<p>"+data[0].program_short_summary+"</p>");
            });
        },
        scope: {
            program_code:"=programCode"
        }
    }
}]);

app.controller('questionnaireResultsController', ['$scope', '$state', 'screening', function($scope, $state, screening){
    var el = document.querySelector('.odometer');

    od = new Odometer({
        el: el,
        value: 0
    });

    var odValue = 0;

    $scope.foundCount = 0;

    for (var i=0; i<screening.data.results.found_programs.length;i++) {
        $scope.foundCount = $scope.foundCount + screening.data.results.found_programs[i].count;
    }

    od.update($scope.foundCount);

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

            var retZipCode = "";

            if(data.status == "OK"){
                $scope.isZipInvalid=true;
                for (var i=0;i<data.results[0].address_components.length;i++) {
                    for(var j=0;j<data.results[0].address_components[i].types.length;j++) {
                        if (((data.results[0].address_components[i].types[j] == "country")||
                            (data.results[0].address_components[i].types[j] == "political"))&&
                            (data.results[0].address_components[i].short_name == "US")) {
                            $scope.isZipInvalid=false;
                        }

                        if (data.results[0].address_components[i].types[j] == "postal_code") {
                            retZipCode = data.results[0].address_components[i].long_name;
                        }
                    }
                }

                if(!$scope.isZipInvalid){
                    localStorageService.set('v_zipcode', data.results[0].address_components[0].long_name);
                    $window.location.href = '/find-my-benefits';
                }
            }else{
                $scope.isZipInvalid=true;
            }
        });
    }

}]);

app.controller('dobController', ['$scope', 'category', 'AnswersByCategories', function($scope, category, AnswersByCategories) {

    $scope.calcDob = function() {
        if (($scope.$root.answers[category.currentCategory()].dob_month != undefined)&&($scope.$root.answers[category.currentCategory()].dob_year != undefined)) {

            AnswersByCategories.setCategory('dob',category.currentCategory(),'integer');

            $scope.$root.answers[category.currentCategory()].dob = (new Date().getFullYear()) - $scope.$root.answers[category.currentCategory()].dob_year;
            if ((new Date().getMonth() + 1) < $scope.$root.answers[$scope.category].dob_month.id) {
                $scope.$root.answers[category.currentCategory()].dob = $scope.$root.answers[category.currentCategory()].dob - 1;
            }
        }
    }

    var yearWatch = '$root.answers.'+category.currentCategory()+'.dob_year';

    $scope.$watch(yearWatch, function() {
        $scope.calcDob();
    });

    var monthWatch = '$root.answers.'+category.currentCategory()+'.dob_month';

    $scope.$watch(monthWatch, function() {
        $scope.calcDob();
    });
}]);


app.filter('unsafe', function($sce) { return $sce.trustAsHtml; });

app.filter('removeNbsp', function() {
    return function(input) {
        return input.replace(/&nbsp;/g,' ');
    }
});