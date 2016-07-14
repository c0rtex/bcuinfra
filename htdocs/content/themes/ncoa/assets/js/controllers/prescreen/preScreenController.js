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
