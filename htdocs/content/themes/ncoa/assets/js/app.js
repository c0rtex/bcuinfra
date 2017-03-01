var app = angular.module('ncoa', ['ngAnimate', 'ngRoute', 'LocalStorageModule', 'ui.router', 'angular-loading-bar']);

app.config(['cfpLoadingBarProvider', function(cfpLoadingBarProvider) {
  cfpLoadingBarProvider.includeSpinner = false;
}]);

// Use sessionStorage instead of localStorage
app.config(function (localStorageServiceProvider) {
  localStorageServiceProvider
      .setStorageType('sessionStorage');
});

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

app.filter('unsafe', function($sce) { return $sce.trustAsHtml; });
