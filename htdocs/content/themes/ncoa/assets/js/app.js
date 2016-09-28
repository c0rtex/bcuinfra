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



