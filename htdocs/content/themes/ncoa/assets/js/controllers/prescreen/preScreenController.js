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

		console.log(prescreen.data.screenData);

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
