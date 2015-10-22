/* Functions for Drawdown */

// given constants
var ret_savings = 100000;
var retirement_age = 65;
var current_monthly_consumption = 4000;
var cut_in_pinch_percent = 0.08;
var cut_in_pinch_amount = 0;
var ss_benefit_amount_self = 1800;
var ss_benefit_amount_spouse = 1300;
var other_income = 200;
var draw_percent = 0.04;
var draw_amount = 4000;
var drawdown_option = 0;
var drawdown_option_amount = 0;
var age_projection = 89;
var marital_status_gender = 3;
var interest_above_inflation = 0.0075;

// my constants
var MIN_RET = 62;
var DEFAULT_START = 65;
var MAX_AGE = 100;
var ALDA_AMOUNT = 20000;
var readyHasFired = false;

$(document).ready(function() {
	if ($('body').hasClass('my-action-plan')){
		//thanks! but we dont need you
		return;
	}
	if (readyHasFired == false) {
		initSetup();
		readyHasFired = true;
	}
});

/* ------------------------------------------- */

/* 	Init Functions	 */

/* ------------------------------------------- */

// initialize setup
function initSetup() {
	if ($('body').hasClass('using-your-savings-in-retirement')){
		return;
	}
	getLocalStorageVars();
	if ($('#interest_above_inflation_slider').length) {
	   var retage = $('#retirement_age').val();
	} else {
	   retage = DEFAULT_START;
	}
	equalizeBars(retage, 'savings-graph-bar', 'income-graph-bar', 'savingsgraph', 'incomegraph', 'age_projection');
	resetDataBars();
	bindHandlers();
	initializeDataBars();
	if ($('#interest_above_inflation_slider').length) {
		changeSetAmountValues();
		allOptions();
		loadSavingsSliderPctsFromDefaults();
	} 
	if ($('.option-list-radio-btn').length) {
		selectOption();
	}
	recalculateTop();
	var income = $('#incomegraph-89').children('.yearly-income').data('val');
   var savingsRemaining = $('#savingsgraph-89').children('.savings-remaining').data('val');

	$('#likely_income2').html(addCommas(roundTo(income, 10)));
   $('#likely_savings2').html(addCommas(roundTo(savingsRemaining, 100)));
	
	var ageTable = getJsonTable('drawdown_age_odds');
	var maleOdds = Math.floor(Math.min((ageTable[89-1].male/ageTable[65-1].male), 1) * 100) + '%';
	var femaleOdds = Math.floor(Math.min((ageTable[89-1].female/ageTable[65-1].female), 1) * 100) + '%';
	fillPictographs(maleOdds, femaleOdds);
	
	var maritalGender = $('#marital_status_gender').val();
	
	if (maritalGender == 0 && $('#interest_above_inflation_slider').length) {
		$('.female-stat-bar').hide();
		//$('.alive-statistic').hide();
		$('.male-stat-bar').show();
	} else if (maritalGender == 1 && $('#interest_above_inflation_slider').length) {
		$('.female-stat-bar').show();
		//$('.alive-statistic').hide();
		$('.male-stat-bar').hide();
	} else {
		$('.female-stat-bar').show();
		//$('.alive-statistic').show();
		$('.male-stat-bar').show();
	}
	
	$('.age-tick-td.last .age-tick-yr').text(MAX_AGE);
	$('#age_projection').attr('max', MAX_AGE);
	initFixedScroll();
}

function initFixedScroll(){
	$('#drawdown-viz-wrap').fixedScroll({fixedClass:'fixed', topLimit:0, container:'.drawdown-wrap.with-viz', relativeOffset:-600, noStop:true});
}

function getLocalStorageVars() {
	var retirementAge = parseFloat(shebangGetValue('retirement_age'));
	//var retirementAge = parseFloat(shebangGetValue('age_self'));

	var retSavings = toNumber(shebangGetValue('ret_savings'));
	var maritalGender = parseFloat(shebangGetValue('marital_status_gender'));
	
	var ssIncomeYou = parseFloat(shebangGetValue('ss_benefit_amount_self'));
	var ssIncomeSpouse = parseFloat(shebangGetValue('ss_benefit_amount_spouse'));
	
	var monthlyConsumption = parseFloat(shebangGetValue('current_monthly_consumption'));
	var cutInPinchResult = parseFloat(shebangGetValue('cut_in_pinch_result'));
	var otherIncome = parseFloat(shebangGetValue('other_income'));
	
	if (retirementAge == null) {
		retirementAge = 65;
	}
	if (retirementAge < MIN_RET) {
	   retirementAge = MIN_RET;
	}
	if (retSavings == null || retSavings == '' || isNaN(retSavings)) {
		retSavings = 100000;
	}
	if (maritalGender == null) {
		maritalGender = 3;
	}
	if (ssIncomeYou == null) {
		ssIncomeYou = 1800;
	}
	if (ssIncomeSpouse == null) {
		ssIncomeSpouse = 0;
	}
	if (monthlyConsumption == null) {
		monthlyConsumption = 4000;
	}
	
	var whatYouNeed = parseFloat(shebangGetValue('drawdown_need_from_savings'));

	if (isNaN(whatYouNeed)) {
	   whatYouNeed = 6500;
	}

	if (cutInPinchResult == null) {
		cutInPinchResult = Math.floor(whatYouNeed - (whatYouNeed*0.08));
	}
	
	//var whatYouNeed = 12*(monthlyConsumption - ssIncomeYou - ssIncomeSpouse - otherIncome);
	
	//var reallyNeed = 12*(cutInPinchResult - ssIncomeYou - ssIncomeSpouse - otherIncome);
	var reallyNeed = Math.floor(whatYouNeed*0.8);
	if (shebangGetValue('drawdown_need_from_savings_cys')){
		reallyNeed = parseInt(shebangGetValue('drawdown_need_from_savings_cys'));
	}
	trace('reallyNeed = ' + reallyNeed);
	// set these values on page
	if (!$('#interest_above_inflation_slider').length) {
	   retirementAge = 65;
	   maritalGender = 3;
	   whatYouNeed = shebangGetValue('drawdown_default_need');
	   if (whatYouNeed == null) {
	      whatYouNeed = 6500;
	   }
	}
	$('#retirement_age').val(retirementAge);
	if ($('#savings_page_2').length) {
		$('#ret_savings').val(100000);
	} else {
		$('#ret_savings').val(retSavings);
		$('#initial_savings').html(addCommas(retSavings));
		$('#income_goal').html(addCommas(whatYouNeed));
	}
	$('#marital_status_gender').val(maritalGender);
	
	var greaterSs = 0;
	if (ssIncomeYou >= ssIncomeSpouse) {
		greaterSs = ssIncomeYou;
	} else {
		greaterSs = ssIncomeSpouse;
	}
	$('.interactive-chart-container').append('<input type="hidden" id="ss_income" value="'+greaterSs+'" />');
	
	$('#what-you-need').html(addCommas(whatYouNeed));
	$('#really-need').html(addCommas(reallyNeed));
	setSliderMaxes(retSavings);
}

function setSliderMaxes(retSavings) {
	if ($('#interest_above_inflation_slider').length) {
		var ssIncome = parseFloat($('#ss_income').val()) * 12;
		var retAge = parseFloat($('#retirement_age').val());
		var savings = parseFloat(retSavings);
		var maxSavings = calcMaxSsSavings(savings, ssIncome, retAge);
		var delayClaimingMax = savings;
		if (maxSavings[1] < savings) {
			var roundedMax = Math.floor(maxSavings[1]);
			delayClaimingMax = Math.round(roundedMax/100)*100;
			console.log(delayClaimingMax);
		}
		$('#interest_above_inflation_slider').attr('max', retSavings);
		$('#set_amount_slider').attr('max', retSavings);
		$('#set_percent_slider').attr('max', retSavings);
		$('#rmd_slider').attr('max', retSavings);
		$('#inflation_proof_annuity_slider').attr('max', retSavings);
		//$('#delay_claiming_slider').attr('max', retSavings);
		$('#delay_claiming_slider').attr('max', delayClaimingMax);
		$('#alda_slider').attr('max', retSavings);
		var fivePercent = retSavings * 0.05;
		$('#interest_above_inflation_slider').attr('step', fivePercent);
		$('#set_amount_slider').attr('step', fivePercent);
		$('#set_percent_slider').attr('step', fivePercent);
		$('#rmd_slider').attr('step', fivePercent);
		$('#inflation_proof_annuity_slider').attr('step', fivePercent);
		$('#delay_claiming_slider').attr('step', (delayClaimingMax*0.05));
		$('#alda_slider').attr('step', fivePercent);
	}
}

function saveAll() {
	$('.instant-save').each(function() {
		var field = $(this).attr('data-field');
		var id = $(this).attr('id');
		if (!field){
			field = id;
		}
		var val = $(this).val();
		$.totalStorage(field, val);
	});
}

// bind handlers to inputs
function bindHandlers() {
	// for "make a plan" page
	if ($('#interest_above_inflation_slider').length) {
		$('#ret_savings').bind('change', changeSavings);
		$('#ret_savings').bind('change', allOptions);
		$('#ret_savings').bind('mouseup', changeSavings);
		$('#ret_savings').bind('mouseup', allOptions);
		$('#age_projection').bind('change', recalculateTop);
		$('#retirement_age').bind('change', changeRetAge);
		$('#retirement_age').bind('change', allOptions);
		$('#retirement_age').bind('mouseup', changeRetAge);
		$('#retirement_age').bind('mouseup', allOptions);
		$('#marital_status_gender').bind('change', allOptions);
		
		$('#interest_above_inflation_slider').bind('mouseup', allOptions);
		$('#set_amount_slider').bind('mouseup', allOptions);
		$('#set_amount_slider').bind('mouseup', changeSetAmountValues);
		$('#set_percent_slider').bind('mouseup', allOptions);
		$('#rmd_slider').bind('mouseup', allOptions);
		$('#inflation_proof_annuity_slider').bind('mouseup', allOptions);
		$('#delay_claiming_slider').bind('mouseup', allOptions);
		$('#alda_slider').bind('mouseup', allOptions);
		
		$('#set_amount_dollar_plan').bind('change', allOptions);
		$('#set_percentage_plan').bind('change', allOptions);
		
		$('.slider-input').bind('change mouseup', onSavingsSliderAdjust);
		
		$('.income-graph-bar').bind('click', setCurrentYearInfo);
		$('.income-graph-bar').bind('mousemove', onBarMouseMove);
		$('.drawdown-income-graph').bind('mouseleave', function() {
		   $('.graph-tooltip').hide();
		});
		
		$('#things_go_badly').bind('change', toggleThingsGoBadly);
		
		$('.sliderUp').bind('click', stepSlider);
		$('.sliderDown').bind('click', stepSlider);
		
	} else { // for "consider your options" page
		$('#ret_savings').bind('change', changeSavings);
		$('#ret_savings').bind('change', selectOption);
		$('#ret_savings').bind('mouseup', changeSavings);
		$('#ret_savings').bind('mouseup', selectOption);
		$('#age_projection').bind('change', recalculateTop);
		$('#retirement_age').bind('change', changeRetAge);
		$('#retirement_age').bind('change', selectOption);
		$('#retirement_age').bind('mouseup', changeRetAge);
		$('#retirement_age').bind('mouseup', selectOption);
		$('#marital_status_gender').bind('change', selectOption);
		
		$('input[name="drawdown_option"]').bind('change', selectOption);
		
		$('#set_amount_dollar').bind('change', selectOption);
		$('#set_percentage').bind('change', selectOption);
		
		$('.income-graph-bar').bind('click', setCurrentYearInfo);
		$('.income-graph-bar').bind('mousemove', onBarMouseMove);
		$('.drawdown-income-graph').bind('mouseleave', function() {
		   $('.graph-tooltip').hide();
		});
	}
	
	$('#things_go_badly').bind('change', toggleThingsGoBadly);

	//jareds function to bind the draggeer
	$('.viz-graph-col.col-2').bind('click', stopSliderDrag);
	$('.viz-graph-col.col-2').bind('mouseenter', startSliderDrag);
	$('.viz-graph-col').css('position', 'relative');
	startSliderDrag();
	onSetAgeSliderToAge($('#age_projection').val());

}

function stepSlider(e) {
   var $slider = $(e.target).closest('tr').find('.slider-input');

   var max = parseFloat($slider.attr('max'));
   var fivePct = max*0.05;
   var currVal = parseFloat($slider.val());
   
   if ($(e.target).hasClass('sliderUp') && ((currVal + fivePct) <= max)) {
      $slider.val(currVal + fivePct);
      console.log($slider.val());
      $slider.trigger('mouseup');
   }
   if ($(e.target).hasClass('sliderDown') && ((currVal - fivePct) >= 0)) {
      $slider.val(currVal - fivePct);
      $slider.trigger('mouseup');
   }
   $('#total_pct').html(Math.round(getSavingsSliderTotalPct()));
}

/* ------------------------------------------- */

/* 	Input Change Functions	 */

/* ------------------------------------------- */

function stopSliderDrag(){
	$('#age_projection').unbind('change blur mousemove mousedown', onAgeSliderDrag);
	$('.viz-graph-col').unbind('mousemove', onAgeSliderHover);
}

function startSliderDrag(){
	$('#age_projection').bind('change blur mousemove mousedown', onAgeSliderDrag);
	$('.viz-graph-col').bind('mousemove', onAgeSliderHover);
}

function getSavingsSliderPcts(){
	var pcts = shebangGetValue('drawdown-pcts');
	if (!pcts || pcts == null){
		pcts = new Array($('.slider-input').length);
	}
	return pcts;
}

function getSavingsSliderTotalPct(){
	/*var pcts = getSavingsSliderPcts();
	var pct = 0;
	for(var i = 0; i<pcts.length; i++){
		if (pcts[i]){
			pct += pcts[i].pct;
		}
	}
	*/
	/* calc changed by jared on 4/1 */
	/* Steve says what they want is how much from your savings you used as opposed to sum of sliders */
	var pct = toNumber($('#total_amount').html()) / toNumber($('#initial_savings').html());
	pct *= 100;
	return pct;
}

function onSavingsSliderAdjust(e){
	var slider = $(this);
	var id = slider.attr('id');
	var field = 'drawdown-pct-'+id;
	var pct = 100 * (toNumber(slider.val()) / toNumber(slider.attr('max')));
	shebangSaveValue(field, pct);
	var pcts = getSavingsSliderPcts();
	var title = slider.data('action-plan-name');
	var obj = {field:field, pct:pct, title:title};
	var index = $('.slider-input').index(slider) - 1;
	pcts[index] = obj;
	shebangSaveValue('drawdown-pcts', pcts);
	shebangSaveValue('drawdown-pct-skip-defaults', true);
	trace('settign!!!');
	var age = $('#current-selected-age').html();
	outputCurrentYearInfo(age);
	setCurrentYearInfo(null);
}

function loadSavingsSliderPctsFromDefaults(){
	var skip = shebangGetValue('drawdown-pct-skip-defaults');
	if (skip){
		//assign what we have to pcts
		$('.slider-input').each(onSavingsSliderAdjust);
		return;
	}
	$('.slider-input').each(loadSavingsSliderDefault);
	$('.slider-input').trigger('change');
}

function loadSavingsSliderDefault(e){
	var slider = $(this);
	var id = slider.attr('id');
	var field = 'drawdown-pct-'+id;
	var pct = shebangGetValue(field);
	if (pct){
		pct = pct/100;
		var max = slider.attr('max');
		slider.val(pct * max);
	}
}

function onAgeSliderDrag(e){
	var age = e.target.value;
	onSetAgeSliderToAge(age);
}

function onSetAgeSliderToAge(age){
	/* This sets the corresponding DOM elements based on the age set in the slider */
	var ageSel = $('#viz-age-selector');
	ageSel.find('.current-selected-age').text(age);
	var ageRange = {min:$('#age_projection').attr('min'), max:MAX_AGE};
	var pixRange = {min:-14, max:479};
	var ar = (age - ageRange.min) / (ageRange.max - ageRange.min);
	var pixGap = pixRange.max - pixRange.min;
	var pr = ar * pixGap;
	pr += pixRange.min;
	ageSel.css('left', pr + 'px');
	$('.savings-graph-bar').removeClass('bar-active');
	$('.income-graph-bar').removeClass('bar-active');
	$('#savingsgraph-'+age).addClass('bar-active');
	$('#incomegraph-'+age).addClass('bar-active');
}

function onAgeSliderHover(e){
	var parentOffset = $(this).offset().left;
	var x = e.pageX - parentOffset;
	var pct = x/$(this).width();
	var ageRange = {min:toNumber($('#age_projection').attr('min')), max:MAX_AGE};
	var age = pct * (ageRange.max - ageRange.min) + toNumber(ageRange.min);
	$('#age_projection').val(Math.round(age));
	$('#age_projection').trigger('change');
}

function changeSavings() {
	var retSavings = $('#ret_savings').val();
	if (!retSavings || isNaN(retSavings)){
		retSavings = 100000;
	}
	setSliderMaxes(retSavings);
}

// fires on retirement age change
function changeRetAge() {
	var retirementAge = $('#retirement_age').val();
	var sliderAge = $('#age_projection').val();
	
	// if current age surpasses slider age, move slider so it's never
	// less than the current age
	if (retirementAge >= sliderAge) {
		$('#age_projection').val(retirementAge);
		onSetAgeSliderToAge(retirementAge);
	}
	var retSavings = parseFloat($('#ret_savings').val());
	setSliderMaxes(retSavings);
	recalculateTop();
}

function recalculateTop() {
	var sliderValue = $('#age_projection').val();
	var currentAge = $('#retirement_age').val();
	var maritalGender = $('#marital_status_gender').val();
	var newStats = changeSliderAgeStats(sliderValue, currentAge, maritalGender, 'drawdown_age_odds');
	var elementArray = new Array('current-selected-age2', 'odds_alive', 'likely_savingsasdfasdf2', 'bad_case_savings', 'likely_income2', 'bad_case_income');
	if (currentAge > 69) {
		$('#delay_claiming').parent().parent().hide();
	} else {
		$('#delay_claiming').parent().parent().show();
	}
	redrawSliderAgeStats(newStats, elementArray);
	saveAll();
}

/* This function fires when an option is selected on the "Consider Your Options"
 * page. Bars are first reset to the defaults, then the new bar heights are 
 * assigned based on which (one) option has been selected. */
function selectOption(e) {
	var selectedOption = $('input[name="drawdown_option"]:checked').val();
	var input = $('input[name="drawdown_option"]:checked');
	$('.drawdown-option-item').removeClass('option-active');
	input.closest('li').addClass('option-active');
	resetDataBars();
	var savingsInput = new Array();
	for (var i=MIN_RET; i<=MAX_AGE; i++) {
		var newArr = new Array();
		newArr.push($('#savingsgraph-'+i).children('.savings-remaining').data('val'));
		newArr.push($('#savingsgraph-'+i).children('.savings-badly').data('val'));
		savingsInput.push(newArr);
	}
	
	var retirementAge = $('#retirement_age').val();
	var savingsAmt = $('#ret_savings').val();
	//var incomeAmt = $('#what-you-need').val();
	var setAmtDollar = $('#set_amount_dollar').val();
	var setPercentage2 = $('#set_percentage').val();
	var setPercentage = setPercentage2.toString().replace('.', '_');
	var maritalGender = $('#marital_status_gender').val();
	//var ssIncome = parseFloat(shebangGetValue('current_monthly_consumption'));
	var ssIncome = toNumber($('#ss_income').val());
	var whatYouNeed = toNumber($('#what-you-need').html());
	var ssFlag = shebangGetValue('social_security_claim_flag');
	if (ssFlag == 'on') {
		$('#delay_claiming').parent().parent().hide();
	}
	
	var textForTop = $('input[name="drawdown_option"]:checked').parent().siblings('.option-description').children('.option-label').children('.option-label-h').html();
	$('#dd_selected_option_name').html(textForTop);
	if (selectedOption == 3) {
		$('#year-income-heading').html('<span class="dollar">$</span>'+setAmtDollar+'/year');
	} else if (selectedOption == 4) {
		$('#year-income-heading').html(setPercentage2+'%/year');
	} else {
		$('#year-income-heading').html('');
	}
	
	switch(selectedOption) {
		case '1':
			var results = interestOnly('drawdown_interest_only_factors', savingsInput, retirementAge);
			redrawSavingsGraph(results[0], results[1], savingsAmt);
			redrawIncomeGraph(results[2], results[3], whatYouNeed);
			$('#selected_option_title').html('Live on the Interest');
			break;
		case '2':
			var results = interestAboveInflation(savingsInput, interest_above_inflation, retirementAge);
			redrawSavingsGraph(results[0], results[1], savingsAmt);
			redrawIncomeGraph(results[2], results[3], whatYouNeed);
			$('#selected_option_title').html('Live on the Interest Above Inflation');
			break;
		case '3':
			var results = setAmount(setAmtDollar, 'drawdown_dollar', savingsInput, retirementAge);
			redrawSavingsGraph(results[0], results[1], savingsAmt);
			redrawIncomeGraph(results[2], results[3], whatYouNeed);
			var amt = addCommas(parseFloat($('#set_amount_dollar').val()));
			$('#selected_option_title').html('Draw $<span id="selected-option-title-amount">'+amt+'</span> from Savings');
			break;
		case '4':
			var results = setPercent(setPercentage, 'drawdown_factors', savingsInput, retirementAge);
			redrawSavingsGraph(results[0], results[1], savingsAmt);
			redrawIncomeGraph(results[2], results[3], whatYouNeed);
			var amt = $('#set_percentage').val();
			$('#selected_option_title').html('Draw <span id="selected-option-title-amount">'+amt+'</span>% from Savings');
			break;
		case '5':
			var results = drawRmd(retirementAge, 'drawdown_rmd', savingsInput);
			redrawSavingsGraph(results[0], results[1], savingsAmt);
			redrawIncomeGraph(results[2], results[3], whatYouNeed);
			$('#selected_option_title').html('Draw the Required Minimum Distribution');
			break;
		case '6':
			var results = inflationProtectedAnnuity(retirementAge, maritalGender, 'drawdown_inflation_protected_annuity', savingsInput);
			redrawSavingsGraph(results[0], results[1], savingsAmt);
			redrawIncomeGraph(results[2], results[3], whatYouNeed);
			$('#selected_option_title').html('Buy an Inflation-Proof Annuity');
			break;
		case '7':
			var results = delayClaiming(retirementAge, ssIncome, 'drawdown_delay_claiming', savingsInput);
			redrawSavingsGraph(results[0], results[1], savingsAmt);
			redrawIncomeGraph(results[2], results[3], whatYouNeed);
			$('#selected_option_title').html('Delay Claiming Social Security');
			break;
		case '8':
			var results = buyAlda(maritalGender, 'drawdown_alda', savingsInput, true, retirementAge);
			redrawSavingsGraph(results[0], results[1], savingsAmt);
			redrawIncomeGraph(results[2], results[3], whatYouNeed);
			$('#selected_option_title').html('Buy an Annuity that Begins at Age 85');
			break;
		default:
			console.log('error: invalid value selected');
	}
	recalculateTop();
}

/* Works similarly to selectOption, except instead of just making the calculations for
 * one option, it makes the calculations for all the options. For each option, the four 
 * arrays (likelySavings, badCaseSavings, likelyIncome, and badCaseIncome) are calculated 
 * as a function of the income allocated to each option. The resulting 7 arrays are then 
 * summed and the totals drawn on the graph.
*/
function allOptions(e) {
	var retirementAge = $('#retirement_age').val();
	var savingsAmt = parseFloat($('#ret_savings').val());
	var incomeAmt = $('#what-you-need').val();
	var setAmtDollar = $('#set_amount_dollar_plan').val();
	var setPercentage = $('#set_percentage_plan').val();
	setPercentage = setPercentage.toString().replace('.', '_');
	var maritalGender = $('#marital_status_gender').val();
	var whatYouNeed = toNumber($('#what-you-need').html());
	
	var ssIncome = parseFloat($('#ss_income').val());
	var ssFlag = shebangGetValue('social_security_claim_flag');
	
	var interestAboveInflationSavings = parseFloat($('#interest_above_inflation_slider').val());
	var setAmountSavings = parseFloat($('#set_amount_slider').val());
	var setPercentSavings = parseFloat($('#set_percent_slider').val());
	var rmdSavings = parseFloat($('#rmd_slider').val());
	var inflationProofAnnuitySavings = parseFloat($('#inflation_proof_annuity_slider').val());
	var delayClaimingSavings = parseFloat($('#delay_claiming_slider').val());
	var aldaSavings = parseFloat($('#alda_slider').val());
	
	$('td .slider-input-container .slider-input').each(function() {
		if ($(this).val() == 0) {
			$(this).parent().parent().parent().addClass('inactive-slider-row');
		} else {
			$(this).parent().parent().parent().removeClass('inactive-slider-row');
		}
	});
	
	var totalSavings = interestAboveInflationSavings + setAmountSavings + setPercentSavings + rmdSavings + inflationProofAnnuitySavings + delayClaimingSavings + aldaSavings;
	
	$('#interest_above_inflation_amount').html(addCommas(interestAboveInflationSavings));
	$('#set_amount_amount').html(addCommas(setAmountSavings));
	$('#set_percent_amount').html(addCommas(setPercentSavings));
	$('#rmd_amount').html(addCommas(rmdSavings));
	$('#inflation_proof_annuity_amount').html(addCommas(inflationProofAnnuitySavings));
	$('#delay_claiming_amount').html(addCommas(delayClaimingSavings));
	$('#alda_amount').html(addCommas(aldaSavings));
	$('#total_amount').html(addCommas(totalSavings));
	
	if (totalSavings > savingsAmt) {
		$('.total-row').addClass('exceed-active');
	} else {
		$('.total-row').removeClass('exceed-active');
	}
	
	$('#total_pct').html(Math.round(getSavingsSliderTotalPct()));
	
	var interestAboveInflationArray = new Array();
	var setAmountArray = new Array();
	var setPercentArray = new Array();
	var rmdArray = new Array();
	var inflationProofAnnuityArray = new Array();
	var delayClaimingArray = new Array();
	var aldaArray = new Array();
	
	for (var i=MIN_RET; i<=MAX_AGE; i++) {
		interestAboveInflationArray.push(interestAboveInflationSavings);
		setAmountArray.push(setAmountSavings);
		setPercentArray.push(setPercentSavings);
		rmdArray.push(rmdSavings);
		inflationProofAnnuityArray.push(inflationProofAnnuitySavings);
		delayClaimingArray.push(delayClaimingSavings);
		aldaArray.push(aldaSavings);
	}
	
	var interestAboveInflationResults = interestAboveInflation(interestAboveInflationArray, interest_above_inflation, retirementAge);
	var setAmountResults = setAmount(setAmtDollar, 'drawdown_dollar', setAmountArray, retirementAge);
	var setPercentResults = setPercent(setPercentage, 'drawdown_factors', setPercentArray, retirementAge);
	var rmdResults = drawRmd(retirementAge, 'drawdown_rmd', rmdArray);
	var inflationProofAnnuityResults = inflationProtectedAnnuity(retirementAge, maritalGender, 'drawdown_inflation_protected_annuity', inflationProofAnnuityArray);

	if (ssFlag == 'on' || retirementAge > 69) {
		$('#delay_claiming_amount').parent().parent().hide();
		var delayClaimingResults = [delayClaimingArray, delayClaimingArray, delayClaimingArray, delayClaimingArray];
	} else {
		$('#delay_claiming_amount').parent().parent().show();
		if (delayClaimingSavings == 0) {
			delayClaimingResults = [delayClaimingArray, delayClaimingArray, delayClaimingArray, delayClaimingArray];
		} else {
			var delayClaimingResults = delayClaiming(retirementAge, ssIncome, 'drawdown_delay_claiming', delayClaimingArray);
		}
	}
	
	var aldaResults = buyAlda(maritalGender, 'drawdown_alda', aldaArray, false, retirementAge);
	
	var currentAgeIndex = retirementAge - MIN_RET + 1;
	
	$('#interest_above_inflation_initial_savings').html(addCommas(Math.floor(interestAboveInflationResults[0][currentAgeIndex])));
	$('#set_amount_initial_savings').html(addCommas(Math.floor(setAmountResults[0][currentAgeIndex])));
	$('#set_percent_initial_savings').html(addCommas(Math.floor(setPercentResults[0][currentAgeIndex])));
	$('#rmd_initial_savings').html(addCommas(Math.floor(rmdResults[0][currentAgeIndex])));
	$('#inflation_proof_annuity_initial_savings').html(addCommas(Math.floor(inflationProofAnnuityResults[0][currentAgeIndex])));
	$('#delay_claiming_initial_savings').html(addCommas(Math.floor(delayClaimingResults[0][currentAgeIndex])));
	$('#alda_initial_savings').html(addCommas(Math.floor(aldaResults[0][currentAgeIndex])));
	$('#total_initial_savings').html(addCommas(Math.floor(interestAboveInflationResults[0][currentAgeIndex] + setAmountResults[0][currentAgeIndex] + setPercentResults[0][currentAgeIndex] + rmdResults[0][currentAgeIndex] + inflationProofAnnuityResults[0][currentAgeIndex] + delayClaimingResults[0][currentAgeIndex] + aldaResults[0][currentAgeIndex])));
	
	$('#interest_above_inflation_initial_income').html(addCommas(Math.floor(interestAboveInflationResults[2][currentAgeIndex])));
	$('#set_amount_initial_income').html(addCommas(Math.floor(setAmountResults[2][currentAgeIndex])));
	$('#set_percent_initial_income').html(addCommas(Math.floor(setPercentResults[2][currentAgeIndex])));
	$('#rmd_initial_income').html(addCommas(Math.floor(rmdResults[2][currentAgeIndex])));
	$('#inflation_proof_annuity_initial_income').html(addCommas(Math.floor(inflationProofAnnuityResults[2][currentAgeIndex])));
	$('#delay_claiming_initial_income').html(addCommas(Math.floor(delayClaimingResults[2][currentAgeIndex])));
	$('#alda_initial_income').html(addCommas(Math.floor(aldaResults[2][currentAgeIndex])));
	$('#total_initial_income').html(addCommas(Math.floor(interestAboveInflationResults[2][currentAgeIndex] + setAmountResults[2][currentAgeIndex] + setPercentResults[2][currentAgeIndex] + rmdResults[2][currentAgeIndex] + inflationProofAnnuityResults[2][currentAgeIndex] + delayClaimingResults[2][currentAgeIndex] + aldaResults[2][currentAgeIndex])));
	
	var likelySavingsMaster = new Array();
	var badCaseSavingsMaster = new Array();
	var likelyIncomeMaster = new Array();
	var badCaseIncomeMaster = new Array();
	
	for (var i=0; i<=(MAX_AGE-MIN_RET); i++) {
		likelySavingsMaster.push((savingsAmt - interestAboveInflationSavings - setAmountSavings - setPercentSavings - rmdSavings - inflationProofAnnuitySavings - delayClaimingSavings - aldaSavings) + (interestAboveInflationResults[0][i] + setAmountResults[0][i] + setPercentResults[0][i] + rmdResults[0][i] + inflationProofAnnuityResults[0][i] + delayClaimingResults[0][i] + aldaResults[0][i]));
		badCaseSavingsMaster.push((savingsAmt - interestAboveInflationSavings - setAmountSavings - setPercentSavings - rmdSavings - inflationProofAnnuitySavings - delayClaimingSavings - aldaSavings) + (interestAboveInflationResults[1][i] + setAmountResults[1][i] + setPercentResults[1][i] + rmdResults[1][i] + inflationProofAnnuityResults[1][i] + delayClaimingResults[1][i] + aldaResults[1][i]));
		likelyIncomeMaster.push((interestAboveInflationResults[2][i] + setAmountResults[2][i] + setPercentResults[2][i] + rmdResults[2][i] + inflationProofAnnuityResults[2][i] + delayClaimingResults[2][i] + aldaResults[2][i]));
		badCaseIncomeMaster.push((interestAboveInflationResults[3][i] + setAmountResults[3][i] + setPercentResults[3][i] + rmdResults[3][i] + inflationProofAnnuityResults[3][i] + delayClaimingResults[3][i] + aldaResults[3][i]));
	}
	redrawSavingsGraph(likelySavingsMaster, badCaseSavingsMaster, savingsAmt);
	redrawIncomeGraph(likelyIncomeMaster, badCaseIncomeMaster, whatYouNeed);
	recalculateTop();
}

/* ------------------------------------------- */

/* 	Data Processing Functions	 */

/* ------------------------------------------- */

/* Returns JSON table that has been embedded in the page. */
function getJsonTable(tableId) {
	var jsonText = $('#'+tableId).html();
	var jsonObject = $.parseJSON(jsonText);
	return jsonObject;
}

/* Sets up data bars at defaults for beginning */
function initializeDataBars() {
	var savingsVal = toNumber($('#ret_savings').val());
	var whatYouNeed = toNumber($('#what-you-need').html());
		
	var incomeVal = 0;
	var likelySavings = new Array();
	var badCaseSavings = new Array();
	var likelyIncome = new Array();
	var badCaseIncome = new Array();
	
	for (var i=MIN_RET; i<MAX_AGE; i++) {
		likelySavings.push(savingsVal);
		badCaseSavings.push(savingsVal);
		likelyIncome.push(incomeVal);
		badCaseIncome.push(incomeVal);
	}
	
	redrawSavingsGraph(likelySavings, badCaseSavings, savingsVal);
	redrawIncomeGraph(likelyIncome, badCaseIncome, whatYouNeed);
}

function onBarMouseMove(e){
	var age = parseFloat($(e.target).closest('.income-graph-bar').attr('id').split('-')[1]);
	$('.graph-tooltip').show();
	$('.graph-tooltip').css('top', ((e.clientY - 200) + 'px'));
	$('.graph-tooltip').css('left', ((e.clientX - 93) + 'px'));
	outputCurrentYearInfo(age);
}

function outputCurrentYearInfo(age) {
	if ($('#things_go_badly').is(':checked')) {
		var income = $('#incomegraph-'+age).children('.yearly-income-badly').data('val');
		var savingsRemaining = $('#savingsgraph-'+age).children('.savings-badly').data('val');
	} else {
		var income = $('#incomegraph-'+age).children('.yearly-income').data('val');
		var savingsRemaining = $('#savingsgraph-'+age).children('.savings-remaining').data('val');
	}
	var ageTable = getJsonTable('drawdown_age_odds');
	
	var maritalGender = $('#marital_status_gender').val();
	var currentAge = $('#retirement_age').val();
	
	var maleOdds = Math.floor(Math.min((ageTable[age-1].male/ageTable[currentAge-1].male), 1) * 100) + '%';
	var femaleOdds = Math.floor(Math.min((ageTable[age-1].female/ageTable[currentAge-1].female), 1) * 100) + '%';
	var coupleOdds = Math.floor(Math.min((ageTable[age-1].couple/ageTable[currentAge-1].couple), 1) * 100) + '%';
	
	//$('#male_bar').css('height', maleOdds);
   //$('#female_bar').css('height', femaleOdds);
   /*
   if (parseFloat(maritalGender) == 0) {
      $('#alive-percentage').html(maleOdds);
   } else if (parseFloat(maritalGender) == 1) {
      $('#alive-percentage').html(femaleOdds);
   } else {
      $('#alive-percentage').html(coupleOdds);
   }
   */
	var useOdds = coupleOdds;
	maritalGender = parseInt(maritalGender);
	$('.viz-alive-group .label-padding').text('Chance that one of you is alive');
	if (maritalGender == 0){
		useOdds = maleOdds;
		$('.viz-alive-group .label-padding').text('Chance that you are alive');
	} else if (maritalGender == 1){
   		useOdds = femaleOdds;
   		$('.viz-alive-group .label-padding').text('Chance that you are alive');
	}
	$('.viz-alive-group span.pct').text(useOdds);
	$('#current-selected-age').html(age);
	$('#likely_income').html(addCommas(roundTo(income, 10)));
	$('#likely_savings').html(addCommas(roundTo(savingsRemaining, 100)));
}

function setCurrentYearInfo(e) {
	trace('setCurrentYearInfo');
	var age = $('#current-selected-age').html();
	var income = $('#likely_income').html();
	var savings = $('#likely_savings').html();
   
	$('#current-selected-age2').html(age);
	$('#likely_income2').html(income);
	$('#likely_savings2').html(savings);
	//jared
   	updateAlivePictosAndPct();
	
	
}

function updateAlivePictosAndPct(){
	var sliderAge = $('#age_projection').val();
	var currentAge = $('#retirement_age').val();
   	var ageTable = getJsonTable('drawdown_age_odds');
   
	var maleOdds = Math.floor(Math.min((ageTable[sliderAge-1].male/ageTable[currentAge-1].male), 1) * 100) + '%';
	var femaleOdds = Math.floor(Math.min((ageTable[sliderAge-1].female/ageTable[currentAge-1].female), 1) * 100) + '%';
	var coupleOdds = Math.floor(Math.min((ageTable[sliderAge-1].couple/ageTable[currentAge-1].couple), 1) * 100) + '%';
	
	var maritalGender = parseInt($('#marital_status_gender').val());
	$('.viz-odds-alive-group span.alive-label').text('chance that you are alive');
	if (maritalGender == 0){
		$('#alive-percentage').text(maleOdds);
	} else if (parseFloat(maritalGender) == 1) {
		$('#alive-percentage').text(femaleOdds);
	} else {
		$('#alive-percentage').text(coupleOdds);
		$('.viz-odds-alive-group span.alive-label').text('chance that one of you is alive');
	}
	fillPictographs(maleOdds, femaleOdds);
}

function resetDataBars() {
	var savingsVal = $('#ret_savings').val();
	var incomeVal = 0;
	$('.savings-graph-bar').each(function(index) {
		$(this).children('.savings-remaining').data('val',savingsVal);
		$(this).children('.savings-badly').data('val',savingsVal);
	});
	$('.income-graph-bar').each(function(index) {
		$(this).children('.yearly-income').data('val',0);
		$(this).children('.yearly-income-badly').data('val',0);
	});
}

function setDataBars(barClass, delta) {
	$('.'+barClass).each(function(index) {
		$(this).data('val',delta[index]);
	});
}

// takes in two arrays. multiplies them. returns results
function factorDelta(inputTable, factorTable, ageIndex, factorField) {
	var diff = inputTable.length - factorTable.length;
	if (diff > 0) {
		for (var i=0; i<diff; i++) {
			var blankobject = {};
			blankobject[factorField] = 0;
			factorTable.push(blankobject);
		}
	}
	var outputTable = new Array();
	for (var i=0; i<inputTable.length; i++) {
		if (i < ageIndex) {
			if (factorField.indexOf('income') != -1) {
				outputTable[i] = 0;
			} else {
				outputTable[i] = parseFloat(inputTable[i]);
			}
		} else {
			outputTable[i] = parseFloat(inputTable[i]) * parseFloat(factorTable[i-ageIndex][factorField]);
/*
			trace(factorField);
			try {
			outputTable[i] = parseFloat(inputTable[i]) * parseFloat(factorTable[i-ageIndex][factorField]);
			} catch(e){
				trace('Error with ' + factorField);
			}
*/
		}
		if (isNaN(outputTable[i])) {
			outputTable[i] = 0;
		}
	}
	return outputTable;
}

/* ------------------------------------------- */

/* 	Graphics Functions	 */

/* ------------------------------------------- */

// changes number of graph bars displaying depending on what the starting age is.
// also changes the min of the slider range to match starting age.
function equalizeBars(startAge, savingsBarClass, incomeBarClass, savingsBarId, incomeBarId, sliderId) {
	if (startAge >= MIN_RET) {
		var firstBarId = $('.'+incomeBarClass+':visible:first').attr('id');
		if (firstBarId){
			var firstBar = firstBarId.split('-');
			if (firstBar.length){
				if (parseFloat(firstBar[1]) > startAge) {
					for (var i=startAge; i<firstBar[1]; i++) {
						$('#'+savingsBarId+'-'+i).show();
						$('#age-tick-'+i).show();
						$('#'+incomeBarId+'-'+i).show();
					}
				}
				console.log('firstBar[1] = '+firstBar[1]);
				console.log('startAge = '+startAge);
				if (parseFloat(firstBar[1]) < startAge) {
					for (var i=firstBar[1]; i<startAge; i++) {
						$('#'+savingsBarId+'-'+i).hide();
						$('#age-tick-'+i).hide();
						$('#'+incomeBarId+'-'+i).hide();
					}
				}
			}
		}
		$('#'+sliderId).attr('min', startAge);
	}
}

function changeSetAmountValues() {
	var setAmountSavings = parseFloat($('#set_amount_slider').val());
	var amtPct = setAmountSavings / 100000;
	$('#set_amount_dollar_plan > option').each(function() {
		var oldVal = parseFloat($(this).attr('value'));
		$(this).html('$'+addCommas(roundTo(amtPct * oldVal, 10)));
	});
}

function redrawSavingsGraph(savingsStats, badCaseStats, comparisonInput) {
	setDataBars('savings-badly', badCaseStats);
	setDataBars('savings-remaining', savingsStats);
	maxSavings = comparisonInput;
	for (var i=0; i<savingsStats.length; i++) {
		if (savingsStats[i] > maxSavings) {
			maxSavings = savingsStats[i];
		}
	}
	$('.savings-remaining').each(function(index) {
		var cssHeight = $(this).parent().css('height');
		cssHeight = cssHeight.split('px');
		var totalPercent = ($(this).data('val')/(maxSavings));
		var badCasePercent = ($('.savings-badly:eq('+index+')').data('val')/maxSavings);
		var remainderPercent = totalPercent-badCasePercent;
		
		// if it's empty, show a tiny bit to demonstrate that the bar is still there
		if (remainderPercent <= 0.03 && badCasePercent <= 0.03) {
			remainderPercent = 0.03;
			badCasePercent = 0.03;
		} else {
			if (remainderPercent <= 0.03) {
				remainderPercent = 0.03;
				badCasePercent = Math.abs(badCasePercent - 0.03);
			}
			if (badCasePercent <= 0.03) {
				badCasePercent = 0.03;
				remainderPercent = Math.abs(remainderPercent - 0.03);
			}
		}
		$('.savings-badly:eq('+index+')').css('height', (cssHeight[0]*badCasePercent) + 'px');
		$(this).css('height', (cssHeight[0]*remainderPercent) + 'px');
	});
}

function toggleThingsGoBadly(e) {
   if ($('#things_go_badly').is(':checked')) {
      //$('.viz-need-group').show();
      //$('.viz-really-need-group').show();
      $('.yearly-income').hide();
   } else {
      $('.viz-need-group').hide();
      $('.viz-really-need-group').hide();
      $('.yearly-income').show();
   }
}

function redrawIncomeGraph(incomeStats, badCaseStats, whatYouNeed) {
	// determine what the max number in the graph will be. if there is a number in the 
	// input that's greater than the whatYouNeed value, use that.
	var comparisonInput = whatYouNeed;
	var maxIncome = 0;
	var moveLines = false;
	for (var i=0; i<incomeStats.length; i++) {
		if (incomeStats[i] > maxIncome) {
			maxIncome = incomeStats[i];
		}
	}
	if (maxIncome > comparisonInput) {
		comparisonInput = maxIncome;
		moveLines = true;
	}
	
	setDataBars('yearly-income-badly', badCaseStats);
	setDataBars('yearly-income', incomeStats);
	$('.yearly-income').each(function(index) {
		var cssHeight = $(this).parent().css('height');
		cssHeight = cssHeight.split('px');
		var totalPercent = ($(this).data('val')/comparisonInput);
		var badCasePercent = ($('.yearly-income-badly:eq('+index+')').data('val')/comparisonInput);
		var remainderPercent = totalPercent-badCasePercent;
		
		// if it's empty, show a tiny bit to demonstrate that the bar is still there
		if (remainderPercent <= 0.01 && badCasePercent <= 0.01) {
			remainderPercent = 0.01;
			badCasePercent = 0.01;
		} else {
			if (remainderPercent <= 0.01) {
				remainderPercent = 0.01;
				badCasePercent = Math.abs(badCasePercent - 0.01);
			}
			if (badCasePercent <= 0.01) {
				badCasePercent = 0.01;
				remainderPercent = Math.abs(remainderPercent - 0.01);
			}
		}
		
		// move lines
		var whatYouNeed = toNumber($('#what-you-need').html());
		var reallyNeed = toNumber($('#really-need').html());
		var whatYouNeedPercent = whatYouNeed/comparisonInput;
		var reallyNeedPercent = reallyNeed/comparisonInput;
		var cssHeight2 = $('.drawdown-income-graph td').css('height');
		cssHeight2 = cssHeight2.split('px');
		
		var newTop = cssHeight2[0] - (cssHeight2[0]*whatYouNeedPercent);
		var newTop2 = cssHeight2[0] - (cssHeight2[0]*reallyNeedPercent);
		
		if (moveLines) {
			$('.viz-need-group').css('top', newTop);
			$('.viz-really-need-group').css('top', newTop2);
		} else {
			$('.viz-need-group').css('top', 0);
			$('.viz-really-need-group').css('top', newTop2);
		}
		
		$('.yearly-income-badly:eq('+index+')').css('height', (cssHeight[0]*badCasePercent) + 'px');
		$(this).css('height', (cssHeight[0]*remainderPercent) + 'px');
	});
}

// takes in two arrays, one of data, one of element ids, and sticks the
// data into the elements.
function redrawSliderAgeStats(sliderStats, statsElements) {
	for (var i=0; i<sliderStats.length; i++) {
		var val = sliderStats[i];
		if (val > 1000){
			val = addCommas(roundTo(val, 100));
		}
		//$('#'+statsElements[i]).html(val);
	}
}

// fill unintuitive pictographs
function fillPictographs(pctmale, pctfemale) {
   $('#male_bar').css('height', pctmale);
   $('#female_bar').css('height', pctfemale);
}

/* ------------------------------------------- */

/* 	Calculation Functions	 */

/* ------------------------------------------- */

/* Upper Input Changes */


function changeSliderAgeStats(sliderAge, currentAge, maritalGender, tableId) {
	var ageTable = getJsonTable(tableId);
	var statsValues = new Array();
	statsValues[0] = sliderAge;
		
	// odds of being alive are calculated by dividing odds for the end age
	// by odds for the start age, then rounding to nearest hundredth
	var aliveOdds;
	
	if (maritalGender == 0) {
		var sliderOdds = ageTable[sliderAge-1].male;
		var currentOdds = ageTable[currentAge-1].male;
		aliveOdds = sliderOdds / currentOdds
	} else if (maritalGender == 1) {
		aliveOdds = ageTable[sliderAge-1].female/ageTable[currentAge-1].female;
	} else {
		aliveOdds = ageTable[sliderAge-1].couple/ageTable[currentAge-1].couple;
	}
	
	var maleOdds = Math.floor(Math.min((ageTable[sliderAge-1].male/ageTable[currentAge-1].male), 1) * 100) + '%';
	var femaleOdds = Math.floor(Math.min((ageTable[sliderAge-1].female/ageTable[currentAge-1].female), 1) * 100) + '%';
	//fillPictographs(maleOdds, femaleOdds);
	
	statsValues[1] = Math.floor(Math.min(aliveOdds, 1) * 100) + '%';
	statsValues[2] = Math.round(($('#savingsgraph-'+sliderAge).children('.savings-remaining').data('val')*100)/100);
	statsValues[3] = Math.round(($('#savingsgraph-'+sliderAge).children('.savings-badly').data('val')*100)/100);
	statsValues[4] = Math.round(($('#incomegraph-'+sliderAge).children('.yearly-income').data('val')*10)/10);
	statsValues[5] = Math.round(($('#incomegraph-'+sliderAge).children('.yearly-income-badly').data('val')*10)/10);
	
	return statsValues;
}

function calcMaxSsSavings(income, ssIncome, age) {
	var delayTable = getJsonTable('drawdown_delay_claiming');
	var indexAge = age - MIN_RET - 1;
	indexAge = Math.max(0, indexAge);
	var income = ssIncome * parseFloat(delayTable[indexAge].income_increment);
	var maxSavings = income / parseFloat(delayTable[indexAge].annuity_factor);
	//console.log(income +' = '+);
	return [income, maxSavings, parseFloat(delayTable[indexAge].annuity_factor)];
}

/* Option Selection Changes */

/* Savings input vs. predictions for drawing interest only each year.
 * Savings and income both decline uniformly. */
function interestOnly(tableId, savingsInput, retAge) {
	var interestTable = getJsonTable(tableId);
	//var ageDiff = retAge - MIN_RET + 1;
	var ageDiff = retAge - MIN_RET;
	var likelySavings = factorDelta(savingsInput, interestTable, ageDiff, 'likely_savings');
	var badCaseSavings = likelySavings;
	var likelyIncome = factorDelta(savingsInput, interestTable, ageDiff, 'likely_income');
	var badCaseIncome = likelyIncome;
	return [likelySavings, badCaseSavings, likelyIncome, badCaseIncome];
}

/* Every year, factors savings against the inflation rate.
 * Savings are steady at original amount; do not change at all.
 * Income is steady at the inflation rate. */
function interestAboveInflation(savingsInput, interestAboveInflationRate, retAge) {
	var likelySavings = new Array();
	var badCaseSavings = new Array();
	var likelyIncome = new Array();
	var badCaseIncome = new Array();
	//var ageDiff = retAge - MIN_RET + 1;
	var ageDiff = retAge - MIN_RET;
	for (var i=0; i<savingsInput.length; i++) {
		likelySavings[i] = parseFloat(savingsInput[i]);
		badCaseSavings[i] = parseFloat(savingsInput[i]);
		likelyIncome[i] = parseFloat(savingsInput[i]) * interestAboveInflationRate;
		badCaseIncome[i] = 0;
	}
	return [likelySavings, badCaseSavings, likelyIncome, badCaseIncome];
}

/* Savings input vs. predictions for drawing a set amount each year.
 * Savings decline uniformly. 
 * Income is steady at the selected amount till the savings run out. */
function setAmount(amount, tableId, savingsInput, retAge) {
	var dollarTable = getJsonTable(tableId+'_'+amount);
	var likelySavings = new Array();
	var badCaseSavings = new Array();
	var likelyIncome = new Array();
	var badCaseIncome = new Array();
	//var ageDiff = retAge - MIN_RET + 1;
	var ageDiff = retAge - MIN_RET;
	
	var newAmt = (parseFloat(savingsInput[0]) / 100000) * parseFloat(amount);
	
	for (var i=0; i<savingsInput.length; i++) {
		if (i < ageDiff) {
			likelySavings[i] = parseFloat(savingsInput[i]);
			badCaseSavings[i] = parseFloat(savingsInput[i]);
			likelyIncome[i] = 0;
			badCaseIncome[i] = 0;
		} else {
			likelySavings[i] = parseFloat(savingsInput[i]) * parseFloat(dollarTable[i-ageDiff]['likely_savings']);
			badCaseSavings[i] = parseFloat(savingsInput[i]) * parseFloat(dollarTable[i-ageDiff]['bad_case_savings']);
			if (likelySavings[i] < newAmt) {
				likelyIncome[i] = likelySavings[i];
			} else {
				likelyIncome[i] = newAmt;
			}
			
			if (badCaseSavings[i] < newAmt) {
				badCaseIncome[i] = badCaseSavings[i];
			} else {
				badCaseIncome[i] = newAmt;
			}
		}
	}
	return [likelySavings, badCaseSavings, likelyIncome, badCaseIncome];
}

/* Factors savings input against predictions for drawing a set percent each year.
 * Both savings and income decline uniformly. */
function setPercent(rate, tableId, savingsInput, retAge) {
	var percentTable = getJsonTable(tableId+'_'+rate);
	//var ageDiff = retAge - MIN_RET + 1;
	var ageDiff = retAge - MIN_RET;
	var likelySavings = factorDelta(savingsInput, percentTable, ageDiff, 'likely_savings');
	var badCaseSavings = factorDelta(savingsInput, percentTable, ageDiff, 'bad_case_savings');
	var likelyIncome = factorDelta(savingsInput, percentTable, ageDiff, 'likely_income');
	var badCaseIncome = factorDelta(savingsInput, percentTable, ageDiff, 'bad_case_income');
	return [likelySavings, badCaseSavings, likelyIncome, badCaseIncome];
}

/* Factors savings input against RMD percentages depending on year.
 */
function drawRmd(age, tableId, savingsInput) {
	var rmdTable = getJsonTable(tableId+'_'+age);
	//var ageDiff = age - MIN_RET + 1;
	var ageDiff = age - MIN_RET;
	var likelySavings = factorDelta(savingsInput, rmdTable, ageDiff, 'likely_savings');
	var badCaseSavings = factorDelta(savingsInput, rmdTable, ageDiff, 'bad_case_savings');
	var likelyIncome = factorDelta(savingsInput, rmdTable, ageDiff, 'likely_income');
	var badCaseIncome = factorDelta(savingsInput, rmdTable, ageDiff, 'bad_case_income');
	return [likelySavings, badCaseSavings, likelyIncome, badCaseIncome];
}

/* Assumes all savings go into purchasing an annuity. Income is calculated by gender
 * and age at which the annuity is purchased (current age).
 * Savings are steady at 0.
 * Income is steady at whatever the calculated annuity income amount is. */
function inflationProtectedAnnuity(age, maritalGender, tableId, savingsInput) {
	var annuityTable = getJsonTable(tableId);
	var likelySavings = new Array();
	var badCaseSavings = new Array();
	var likelyIncome = new Array();
	var badCaseIncome = new Array();
	var indexAge = age - MIN_RET;
	console.log(maritalGender);
	for (var i=0; i<savingsInput.length; i++) {
		if (i < indexAge) {
			likelySavings[i] = parseFloat(savingsInput[i]);
			badCaseSavings[i] = parseFloat(savingsInput[i]);
			likelyIncome[i] = 0;
			badCaseIncome[i] = 0;
		} else {
			likelySavings[i] = 0;
			badCaseSavings[i] = 0;
			if (maritalGender == 0) {
				likelyIncome[i] = parseFloat(annuityTable[indexAge].income_men) * parseFloat(savingsInput[i]);
				badCaseIncome[i] = parseFloat(annuityTable[indexAge].income_men) * parseFloat(savingsInput[i]);
			} else if (maritalGender == 1) {
				likelyIncome[i] = parseFloat(annuityTable[indexAge].income_women) * parseFloat(savingsInput[i]);
				badCaseIncome[i] = parseFloat(annuityTable[indexAge].income_women) * parseFloat(savingsInput[i]);
			} else {
				likelyIncome[i] = parseFloat(annuityTable[indexAge].income_couples) * parseFloat(savingsInput[i]);
				badCaseIncome[i] = parseFloat(annuityTable[indexAge].income_couples) * parseFloat(savingsInput[i]);
			}
		}
	}
	return [likelySavings, badCaseSavings, likelyIncome, badCaseIncome];
}

/* Factors savings input against age's income factor * years till age 70.
 * Savings decrease till age 70, then remain steady.
 * Income remains steady. */
function delayClaiming(age, ssIncome, tableId, savingsInput) {
	var claimingTable = getJsonTable(tableId);
	var likelySavings = new Array();
	var badCaseSavings = new Array();
	var likelyIncome = new Array();
	var badCaseIncome = new Array();
	var indexAge = age - MIN_RET;
	var startingSavings = parseFloat(savingsInput[0]);
	var remainingSavings = 0;
	var newSsIncome = ssIncome * 12;
	
	for (var i=0; i<savingsInput.length; i++) {
		if (age > 69) {
			likelySavings[i] = parseFloat(savingsInput[i]);
			badCaseSavings[i] = parseFloat(savingsInput[i]);
			likelyIncome[i] = 0;
			badCaseIncome[i] = 0;
		} else {
			var maxSavings = calcMaxSsSavings(startingSavings, newSsIncome, age);
			if (i < indexAge) {
				likelySavings[i] = parseFloat(savingsInput[i]);
				badCaseSavings[i] = parseFloat(savingsInput[i]);
				likelyIncome[i] = 0;
				badCaseIncome[i] = 0;
			} else {
				if (maxSavings[1] < parseFloat(savingsInput[i])) {
					likelySavings[i] = parseFloat(savingsInput[i]) - maxSavings[1];
					badCaseSavings[i] = parseFloat(savingsInput[i]) - maxSavings[1];
					likelyIncome[i] = parseFloat(maxSavings[0]);
					badCaseIncome[i] = parseFloat(maxSavings[0]);
				} else {
					likelySavings[i] = 0;
					badCaseSavings[i] = 0;
					likelyIncome[i] = parseFloat(savingsInput[i]) * parseFloat(maxSavings[2]);
					badCaseIncome[i] = parseFloat(savingsInput[i]) * parseFloat(maxSavings[2]);
				}
			}
		}
	}
	return [likelySavings, badCaseSavings, likelyIncome, badCaseIncome];
}

/* Assumes entirety of savings input goes into an annuity.
 * Annuity kicks in at age 85. Annuity amount is calculated according to gender.
 * Savings are steady at 0.
 * Income is steady at 0 until 85, then it is steady at the calculated amount till death. */
function buyAlda(maritalGender, tableId, savingsInput, usePreset, retAge) {
	var aldaTable = getJsonTable(tableId);
	var likelySavings = new Array();
	var badCaseSavings = new Array();
	var likelyIncome = new Array();
	var badCaseIncome = new Array();
	var indexAge = retAge - MIN_RET;
	for (var i=0; i<savingsInput.length; i++) {
		if (i < indexAge) {
			likelySavings[i] = parseFloat(savingsInput[i]);
			badCaseSavings[i] = parseFloat(savingsInput[i]);
			likelyIncome[i] = 0;
			badCaseIncome[i] = 0;
		} else {
			if (usePreset) {
				if ((i+MIN_RET) >= 85) {
					likelySavings[i] = parseFloat(savingsInput[i]) - ALDA_AMOUNT;
					badCaseSavings[i] = parseFloat(savingsInput[i]) - ALDA_AMOUNT;
					if (maritalGender == 0) {
						likelyIncome[i] = parseFloat(aldaTable[indexAge].male_factor) * ALDA_AMOUNT;
						badCaseIncome[i] = parseFloat(aldaTable[indexAge].male_factor) * ALDA_AMOUNT;
					} else if (maritalGender == 1) {
						likelyIncome[i] = parseFloat(aldaTable[indexAge].female_factor) * ALDA_AMOUNT;
						badCaseIncome[i] = parseFloat(aldaTable[indexAge].female_factor) * ALDA_AMOUNT;
					} else {
						likelyIncome[i] = parseFloat(aldaTable[indexAge].married_factor) * ALDA_AMOUNT;
						badCaseIncome[i] = parseFloat(aldaTable[indexAge].married_factor) * ALDA_AMOUNT;
					}
				} else {
					likelySavings[i] = parseFloat(savingsInput[i]) - ALDA_AMOUNT;
					badCaseSavings[i] = parseFloat(savingsInput[i]) - ALDA_AMOUNT;
					likelyIncome[i] = 0;
					badCaseIncome[i] = 0;
				}
			} else {
				if ((i+MIN_RET) >= 85) {
					likelySavings[i] = 0;
					badCaseSavings[i] = 0;
					if (maritalGender == 0) {
						likelyIncome[i] = parseFloat(aldaTable[indexAge].male_factor) * parseFloat(savingsInput[i]);
						badCaseIncome[i] = parseFloat(aldaTable[indexAge].male_factor) * parseFloat(savingsInput[i]);
					} else if (maritalGender == 1) {
						likelyIncome[i] = parseFloat(aldaTable[indexAge].female_factor) * parseFloat(savingsInput[i]);
						badCaseIncome[i] = parseFloat(aldaTable[indexAge].female_factor) * parseFloat(savingsInput[i]);
					} else {
						likelyIncome[i] = parseFloat(aldaTable[indexAge].married_factor) * parseFloat(savingsInput[i]);
						badCaseIncome[i] = parseFloat(aldaTable[indexAge].married_factor) * parseFloat(savingsInput[i]);
					}
				} else {
					likelySavings[i] = 0;
					badCaseSavings[i] = 0;
					likelyIncome[i] = 0;
					badCaseIncome[i] = 0;
				}
			}
		}
	}
	return [likelySavings, badCaseSavings, likelyIncome, badCaseIncome];
}