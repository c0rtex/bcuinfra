var isMarried;
var target_ret_income;
var target_death_income;
var alive = {self:true, spouse:true};
var firstRun = true;
var globalMult = 1;
var targetReductions = Object();
targetReductions.cys = 0;
targetReductions.house = 0;


function trace(msg){
	try {
		console.log(msg);
	} catch(e){}
}

$(window).load(function(){
	initTargetSliders();
	initTargetDownsize();
	initRevMortgage();
	initDeaths();

	plannerTargetTargetRefresh();



})



$(document).ready(function(){


	initPrint();

	target_ret_income = toNumber(shebangGetValue('target_ret_income_orig'));
	var tr = shebangGetValue('targetReductions');
	if (tr && tr != null){
		targetReductions = shebangGetValue('targetReductions');
	}
	if (!target_ret_income){
		target_ret_income = shebangGetValue('target_ret_income');
		shebangSaveValue('target_ret_income_orig', target_ret_income);
	}
	isMarried = toBoolean(shebangGetValue('marital_stat'));
	if ($('body').hasClass('congrats')){
		restoreDeaths();
		redrawBarGraph(getTargetMaxVal());
		updateShortCalc();
		initCongratsMessages();
	} else {
		if ($('body').hasClass('what-you-can-do')){
			reduceTargetIncomeByObject(targetReductions);
		}


		// DS: Deferring these until later to ensure form populated.
		// initTargetSliders();
		// initTargetDownsize();
		// initRevMortgage();
		// initDeaths();

		$('input').bind('change click', plannerTargetTargetRefresh);
		plannerTargetTargetRefresh();
		$('#short-output .graph-overall-container').fixedScroll({fixedClass:'output-fixed', absClass:'output-relative', container:$('.interactive-box'), offset:$('#treatment-mini').height()});
	}
	setTimeout(function(){
		firstRun = false;
	}, 3000);
});

function initPrint(){
	$('.trigger-print').click(function(e){
		e.preventDefault();
		window.print();
	});
}

function initCongratsMessages(){
	var retAge = shebangGetValue('retirement_age');
	if (retAge < 65){
		$('.result-retire-early').show();
		$('.result-retire-later').hide();
	} else {
		$('.result-retire-early').hide();
		$('.result-retire-later').show();
	}
	if (!shebangGetValue('downsize-house') && !shebangGetValue('reverse-mortgage')){
		$(".how-item.use-your-house").hide();
	}

}

function initTargetSliders(){
	$('#effect-spendless-pct').bind('click change', onSpendLessSliderAdjust);
	$('#effect-retire-age-slider').bind('click change', onRetireAgeAdjust);
	$('#effect-retire-age').bind('click change', onRetireAgeAdjust)
	$('.slider-group').sliderGroup();
	$('#effect-spendless-amt').bind('click change keyup blur', onSpendLessInputAdjust);
}


/* RETIRE LATER
==================== */

function onRetireAgeAdjust(e){
	var age = $(e.target).val();
	var age_self = shebangGetValue('age_self');
	if (age < age_self){
		age = age_self;
		$('#effect-retire-age').attr('min', age_self);
	}
	$(e.target).val(age);
	shebangSaveValue('retirement_age', Math.round(age));
	plannerTargetTargetRefresh();
}

/* SPEND LESS
==================== */

function onSpendLessSliderAdjust(e){
	trace('onSpendLessSliderAdjust');
	var pct = $(e.target).val();
	pct = pct / 100;
	var spending = shebangGetValue('target_ret_income');
	$('#effect-spendless-amt').attr('max', Math.round(spending * .12));
	targetReductions.cys = spending * pct;
	reduceTargetIncomeByObject(targetReductions, globalMult);
	trace('pct = ' + pct);
	trace(targetReductions);
	$('#effect-spendless-amt').val(Math.round(targetReductions.cys));
	shebangSaveValue('effect-spendless-pct', pct * 100);
	shebangSaveValue('effect-spendless-amt', Math.round(targetReductions.cys));
}

function onSpendLessInputAdjust(e){
	trace('onSpendLessInputAdjust');
	var less = $(e.target).val();
	var spending = toNumber(shebangGetValue('target_ret_income'));
	$('#effect-spendless-amt').attr('max', Math.round(spending * .12));
	var pct = 100 * (less / spending);
	$('#effect-spendless-pct').val(Math.round(pct));
	updateBarGraphBar('graph-spendless-amt', less);
	targetReductions.cys = less;
	reduceTargetIncomeByObject(targetReductions, globalMult);
	shebangSaveValue('effect-spendless-amt', less);
}

function updateSpendingAmountByAmt(lessSpent){
	trace('updateSpendingAmountByAmet');
	lessSpent = Math.round(lessSpent);
	updateBarGraphBar('graph-spendless-amt', lessSpent);
	//shebangUpdatePageValue("effect-spendless-amt", roundTo(lessSpent, 10));
	var spending = shebangGetValue('target_ret_income');
	shebangSaveValue('effect-spendless-total', Math.round(spending - lessSpent));
	shebangSaveValue('effect-spendless-amt', lessSpent);
}

function updateSpendingAmountByPct(spending, pct){
	trace('updateSpendingAmountByPct');
	var lessSpent = Math.round(spending * pct);
	//shebangUpdatePageValue("effect-spendless-amt", roundTo(lessSpent, 10));
	shebangSaveValue('effect-spendless-amt', lessSpent);
	shebangSaveValue('effect-spendless-pct', Math.round(pct*100));
	shebangSaveValue('effect-spendless-total', Math.round(spending - lessSpent));
	updateBarGraphBar('graph-spendless-amt', lessSpent);
	return lessSpent;
}

function setTargetIncomeTo(spending){
	target_ret_income = spending;
	shebangSaveValue('target_ret_income_temp', Math.round(spending));
	// DS: Round to 10 to match bar graph
	// shebangUpdatePageValue('target_ret_income', addCommas(roundTo(spending, 100)));
	shebangUpdatePageValue('target_ret_income', addCommas(roundTo(spending, 10)));
}

function reduceTargetIncomeByObject(obj, mult){
	var ti = shebangGetValue('target_ret_income');
	var reduction = 0;
	for (var key in obj){
		if (key != 'deaths' && key != 'mult'){
			reduction += toNumber(obj[key]);
		}
	}
	ti = ti - reduction;
	if (mult){
		obj.deaths = ti * (1-mult);
		reduction += obj.deaths;
		ti = ti - obj.deaths;
		obj.mult = mult;
	} else {
		obj.deaths = 0;
		obj.mult = 1;
	}
	trace('reduction = ' + reduction);
	// DS: Round to 10 to match bar graph
	// shebangUpdatePageValue('target_ret_income', addCommas(roundTo(ti, 100)));
	shebangUpdatePageValue('target_ret_income', addCommas(roundTo(ti, 10)));
	shebangSaveValue('target_ret_income_temp', ti);
	updateBarGraphBar('graph-spendless-amt', reduction);
	//shebangSaveValue('effect-spendless-amt', reduction);
	shebangSaveValue('targetReductions', obj);
	setTargetIncomeTo(ti);
	return ti;
}

function plannerTargetTargetRefresh(skipCongrats){
	var retAge = getRetAge();
	var ben = calcSSABenefit(retAge);
	updateRetIncomePerMonth(retAge);
	updatePensionAmount();
	updateShortCalc(skipCongrats);
	updateShortBarGraph();
}

function showCongrats(){
	if ($('#reached_goal').val() == 'true' || $('#reached_goal').val() == true){
		return;
	}
	if ($('#reached_goal').length || firstRun){
		$('#reached_goal').val('true');
	} else {
		//lets show it
		$('#target-success-modal').modal();
		var rg = $('<input type="hidden" id="reached_goal" value="true" />');
		$('body').append(rg);
	}
}

function updateShortCalc(skipCongrats){
	var tamt = 0;
	$('.bar-graph-bar:visible').not('#graph-short_by, #graph-spendless-amt').each(function(){
		tamt += toNumber($(this).find('.amount').text());
	});
	var shortBy = Math.round(shebangGetValue('target_ret_income_temp') - tamt);
	// DS: Roundinf to nearest 10
	// $('#target_short_by.amount').text(addCommas(roundTo(Math.abs(shortBy), 5)));
	$('#target_short_by.amount').text(addCommas(roundTo(Math.abs(shortBy), 10)));
	if (shortBy > 0){
		$('.target-short-group .graph-key-label').text('Short');
		$('#target_short_by.amount').removeClass('surplus');
	} else {
		if ($('body').hasClass('target-calculator')){
			if(!skipCongrats){
				showCongrats();
			}
		}
		$('.target-short-group .graph-key-label').text('Surplus');
		hideBarGraphBar('graph-short_by');
		$('#target_short_by.amount').addClass('surplus');
	}
	tamt = Math.round(tamt);
	shebangSaveValue('target_short_by', shortBy);
	shebangSaveValue('target_ret_estimate', tamt);
	shebangUpdatePageValue('target_short_by', addCommas(roundTo(shortBy, 10)));
	shebangUpdatePageValue('target_ret_estimate', addCommas(roundTo(tamt, 10)));
	updateBarGraphBar("short_by", shortBy);
	//updateKeyValuePosition();
}

function getTargetMaxVal(){
	var tamt = getGraphMaxVal();
	var newTarget = shebangGetValue('target_ret_income_temp');
	var oldTarget = shebangGetValue('target_ret_income');
	var diffTarget = oldTarget - newTarget;
	var maxVal = shebangGetValue('target_ret_income_temp') + diffTarget;
	return Math.max(maxVal, tamt);
}

function updateShortBarGraph(){
	redrawBarGraph(getTargetMaxVal());
}

function calcSSABenefit(retAge){
	//getSSABenefit(ageSelf, retAge, selfIncome, ageSpouse, spouseIncome);
	var ageSelf = shebangGetValue('age_self');
	var selfIncome = shebangGetValue('annual_btax_earnings_self');
	var ageSpouse = 0;
	var spouseIncome = 0;
	if (isMarried){
		ageSpouse = shebangGetValue('age_spouse');
		spouseIncome = shebangGetValue('annual_btax_earnings_spouse');
	}
	if (isMarried && (!alive.spouse || !alive.self)){
		var selfSSA = getSSABenefitSingle(ageSelf, retAge, selfIncome);
		var spouseSSA = getSSABenefitSingle(ageSpouse, retAge, spouseIncome);
		var ssaTotal = Math.max(spouseSSA, selfSSA);
	} else {
		trace(ageSelf + ', ' + retAge + ', ' + selfIncome + ', ' + ageSpouse + ', ' + spouseIncome);
		var ssaTotal = getSSABenefit(ageSelf, retAge, selfIncome, ageSpouse, spouseIncome);
	}
	shebangSaveValue('ssa_benefit_amount', Math.round(ssaTotal));
	updateBarGraphBar('ssa_benefit_amount', Math.round(ssaTotal));
	return Math.round(ssaTotal);
}


/* Overall calcs
====================== */

function getRetAge(){
	var ra = shebangGetValue('retirement_age');
	if ($('body').hasClass('what-you-can-do')){
		if ($('a.trigger-work-longer.active').length){
			//work longer is active
			return 70;
		}
		return 62;
	}
	return ra;
}

function updateRetIncomePerMonth(retAge){
	var ipm = calcRetIncomePerYear(retAge) / 12;
	var maxVal = getTargetMaxVal();
	if (ipm){
		updateBarGraphBar('ret_savings_combined', Math.round(ipm));
		shebangSaveValue('ret_savings_combined', Math.round(ipm));
	}
}

function calcRetIncome(retAge){
	var selfAge = shebangGetValue('age_self');
	var selfSavings = toNumber(shebangGetValue('ret_savings_self'));
	var selfPerYear = toNumber(shebangGetValue('empl_match_amount_self'));
	var selfPersonal = shebangGetValue('ret_savings_amount_self');
	selfPerYear = toNumber(selfPersonal) + toNumber(selfPerYear);
	selfPerYear *= 12;

	if (targetReductions.cys != null){
		var spendLessYearly = toNumber(targetReductions.cys) * 12;
		selfPerYear += spendLessYearly;
	}
	var totalSavings = toNumber(getSavingsAtRetirement(selfAge, retAge, selfSavings, selfPerYear));
	if (isMarried){
		var spAge = shebangGetValue('age_spouse');
		var spSavings = shebangGetValue('ret_savings_spouse');
		if (spSavings == ''){
			spSavings = 0;
		}
		var spPerYear = shebangGetValue('empl_match_amount_spouse');
		var spPersonal = shebangGetValue('ret_savings_amount_spouse');
		spPerYear = toNumber(spPersonal) + toNumber(spPerYear);
		spPerYear *= 12;
		var spouseTotal = toNumber(getSavingsAtRetirement(spAge, retAge, spSavings, spPerYear));
		totalSavings += spouseTotal;
	}
	// DS: Saving totalSavings in savings_at_retirement, as in the version of this funciton in "will you be short"
	shebangSaveValue('savings_at_retirement', totalSavings);

	totalSavings += toNumber(shebangGetValue('savings_from_house'));
	var mortAmt = shebangGetValue('monthly_mortgage_payment');
	var mortYearsLeft = shebangGetValue('mortgage_years_left');
	if (mortAmt && mortYearsLeft > 0){
		var mortCost = getMortgageCost(mortAmt, mortYearsLeft);
		totalSavings -= mortCost;
	}
	return totalSavings;
}


function calcRetIncomePerYear(retAge){
	var totalSavings = calcRetIncome(retAge);
	var drawDownPct = toNumber(getWithdrawalPct(retAge));
	drawDownPct = .04;
	var spm = drawDownPct * totalSavings;
	return spm;
}


/* SAR
===================*/

function calcSavingsAtRetirement(curAge, retAge, baseSaving, perYear){
	var ytr = retAge - curAge;

	var ror = $('#real_ror').val();

	if ($('#market-tanks:checked').length){
		shebangSaveValue('market-tanks', true);
		ror = $('#low_ror').val();
	} else {
		shebangSaveValue('market-tanks', false);
	}
	if (!ror){
		ror = 4.5;
	}
	ror = ror / 100;
	ror += 1;
	var saving = baseSaving;
	for (var i = 0; i<ytr; i++){
		saving = (toNumber(saving) + toNumber(perYear)) * ror;
	}

	if (saving){
		return saving;
	}
}
function getSavingsAtRetirement(curAge, retAge, baseSaving, perYear){
	var savingsAtRetirement = calcSavingsAtRetirement(curAge, retAge, baseSaving, perYear);
	shebangSaveValue('savings_at_retirement', savingsAtRetirement);
	return savingsAtRetirement;
}

function getWithdrawalPct(retAge){
	var row = $('#table-pln_target_withdrawal .lookup-'+retAge);
	var pct = row.attr('data-pct');
	if (!pct){
		pct = 0;
	}
	return pct;
}

function getSavingsAtRetirementPerMonth(curAge, retAge, baseSaving, perYear, mAmt, mYears){
	var totalSavings = getSavingsAtRetirement(curAge, retAge, baseSaving, perYear);
	var drawDownPct = toNumber(getWithdrawalPct(retAge));
	var spm = drawDownPct * totalSavings;
	return spm;
}


/* Mortgage Stuff
====================== */

function getMortgageCost(monthly, yearsRemain){
	var row = $('#table-pln_target_mortgage_payment .lookup-'+yearsRemain);
	var prince = toNumber(row.attr('data-principal'));
	return prince * monthly;
}

/* Downsizing
===================== */

function initTargetDownsize(){
	$('#downsize-house').click(onDownsizeClick);
	$('#home_val, #home_val_new, #downsizing_savings_other').bind('click blur change', shebangInstantSave);
	$('#home_val, #home_val_new, #downsizing_savings_other').bind('click blur change', function(){
		if ($('#downsize-house:checked').length){
			updateDownsizeIncome(true);
		}
	});

	/*
	if ($('#downsize-house:checked').length){
		updateDownsizeIncome(true);
	} else {
		updateDownsizeIncome(false);
	}
	*/

	if($('#downsize-house:checkbox').length) {
		updateDownsizeIncome($('#downsize-house:checkbox').prop("checked"));
	}

}

function onDownsizeClick(e){
	updateDownsizeIncome(e.target.checked);
	var id = $(e.target).attr('id');
	shebangSaveValue(id, e.target.checked);
}

function updateDownsizeIncome(on){

	if (on){
		var oldHomeVal = toNumber(shebangGetValue('home_val'));
		if (!oldHomeVal){
			oldHomeVal = 175000;
		}
		var newHomeVal = toNumber(shebangGetValue('home_val_new'));
		if (!newHomeVal){
			newHomeVal = 125000;
			shebangSaveValue('home_val_new', 125000);
		}
		var transCostPct = $('#downsizing_transaction_cost_percent').val();
		var downsizeIncomeTotal = getDownsizeHomeEquity(oldHomeVal, newHomeVal, transCostPct);
		var drawPerYear = getWithdrawalPct(getRetAge()) * downsizeIncomeTotal;
		//Other savings from utils
		var otherSavings = toNumber($('#downsizing_savings_other').val());
		// updated 8_19_2012 to avoid double counting lower costs: drawPerYear += (otherSavings * 12);
		var downsizing_savings = Math.round(drawPerYear / 12);
		shebangSaveValue('downsizing_savings', downsizing_savings);
		updateBarGraphBar('graph-downsizing_savings', downsizing_savings);

		// DS: Shouldn't this be downsizing_savings?
		targetReductions.house = otherSavings;
		// targetReductions.house = downsizing_savings;

	} else {
		shebangSaveValue('downsizing_savings', 0);
		updateBarGraphBar('graph-downsizing_savings', 0);
		targetReductions.house = 0;

	}

	reduceTargetIncomeByObject(targetReductions, globalMult);
	// DS: I think we need to update the bar graph after doing this
	plannerTargetTargetRefresh();

}

function getDownsizeHomeEquity(oldHomeVal, newHomeVal, transCostPct){
	transCostPct = transCostPct/100;
	var homeEq = oldHomeVal - newHomeVal - (oldHomeVal * transCostPct);
	return homeEq;
}

/* Reverse Mortgage
======================== */

function getRMLumpSum(curAge, homeVal){
	var ageDiff = curAge - 62;
	var agePct = ageDiff * Math.pow(.01, 10);
	var totalPct = .355 + agePct;
	return homeVal * totalPct;
}

function getRevMortgageIncome(curAge, homeVal){
	var hecmCap = $('#hecm_cap').val();
	if (!hecmCap){
		hecmCap = 625000;
	}
	var lumpSum = getRMLumpSum(curAge, homeVal);
	var drawPerYear = getWithdrawalPct(getRetAge()) * lumpSum;
	var drawPerMonth = drawPerYear / 12;
	return Math.round(drawPerMonth);
}

function updateRevMortgageIncome(on){
	if (on){
		var curAge = shebangGetValue('age_self');
		var homeVal = shebangGetValue('home_val');
		if ($('#downsize-house:checked').length){
			//base on downsize
			homeVal = shebangGetValue('home_val_new');
		}
		var drawPerMonth = getRevMortgageIncome(curAge, homeVal);
		updateBarGraphBar('graph-monthly_income_rm', drawPerMonth);
		shebangSaveValue('monthly_income_rm', drawPerMonth);
	} else {
		updateBarGraphBar('graph-monthly_income_rm', 0);
		shebangSaveValue('monthly_income_rm', 0);
	}
}

function initRevMortgage(){
	$('#reverse-mortgage').bind('click change', function(e){
		updateRevMortgageIncome(e.target.checked);
		var id = $(e.target).attr('id');
		var bool = e.target.checked;
		shebangSaveValue(id, bool);
	});
	$('#home_val, #home_val_new, #downsizing_savings_other').bind('click blur change', function(){
		if ($('#reverse-mortgage:checked').length){
			updateRevMortgageIncome(true);
		}
	});
}

/* DEATH!!!! stuff
===================== */

function initDeaths(){
	if (!isMarried){
		$('#spouse-dies-wrapper').hide();
		$('#you-die-wrapper').hide();
	}
	$('.target-death').change(function(e){

		updateDeaths (e.target.value, $(e.target).attr('id'), !e.target.checked);

		/*
		// DS: re-factoring into named function so we can call independently of the change event

		// DS: Revising to account for pension reductions
		var person = e.target.value;
		var otherID
		var pension = otherPension = "pension_benefit";
		var id = $(e.target).attr('id');
		var living = !e.target.checked;
		if (person == 'death-spouse'){
			trace('death of spouse');
			alive.spouse = living;
			otherID = 'you-die';
			pension += "_spouse";
			otherPension += "_self";
		}
		if (person == 'death-self'){
			trace('I DIE');
			alive.self = living;
			otherID = 'spouse-dies';
			pension += "_self";
			otherPension += "_spouse";
		}

		// DS: Reduce/restore pension
		restorePension(pension);
		restorePension(otherPension);

		if(!living) {
			reducePension (pension, 70);
			reducePension (otherPension, 40);
		}

		var mult = .7;
		if ($('.target-death:checked').length == 2){
			//both are checked
			$('#'+otherID).removeAttr('checked');
			shebangSaveValue(otherID, 'false');
			trace(otherID + ' is false');

		} else if (!$('.target-death:checked').length){
			//both are unchecked
			alive.spouse = alive.self = true;
			mult = 1;
		}
		globalMult = mult;
		shebangSaveValue(id, !living);
		reduceTargetIncomeByObject(targetReductions, mult);
		plannerTargetTargetRefresh(true);
		*/
	});
	$('.target-death:checked').trigger('change');
}

function restoreDeaths () {
	if(shebangGetValue("you-die")) {
		updateDeaths("death-self", "you-die", true);
	}

	if (shebangGetValue("spouse-dies")) {
		updateDeaths("death-spouse", "spouse-dies", true);
	}
}

function updateDeaths (person, id, living) {
		// DS: Revising to account for pension reductions
		// var person = e.target.value;
		var otherID;
		var pension = otherPension = "pension_benefit";
		// var id = $(e.target).attr('id');
		// var living = !e.target.checked;
		if (person == 'death-spouse'){
			trace('death of spouse');
			alive.spouse = living;
			otherID = 'you-die';
			pension += "_spouse";
			otherPension += "_self";
		}
		if (person == 'death-self'){
			trace('I DIE');
			alive.self = living;
			otherID = 'spouse-dies';
			pension += "_self";
			otherPension += "_spouse";
		}

		// DS: Reduce/restore pension
		restorePension(pension);
		restorePension(otherPension);

		if(!living) {
			reducePension (pension, 70);
			reducePension (otherPension, 40);
		}

		var mult = .7;
		if ($('.target-death:checked').length == 2){
			//both are checked
			$('#'+otherID).removeAttr('checked');
			shebangSaveValue(otherID, 'false');
			trace(otherID + ' is false');

		} else if (!$('.target-death:checked').length){
			//both are unchecked
			alive.spouse = alive.self = true;
			mult = 1;
		}
		globalMult = mult;
		shebangSaveValue(id, !living);
		reduceTargetIncomeByObject(targetReductions, mult);
		plannerTargetTargetRefresh(true);
}

function reducePension (key, pct) {
	var prevValue = toNumber(shebangGetValue(key));
	shebangSaveValue(key+"_orig", prevValue);
	shebangSaveValue(key, prevValue * (1 - (pct/100)));
}

function restorePension (key) {
	var storedValue = shebangGetValue(key+"_orig") || shebangGetValue(key) || 0;
	shebangSaveValue(key, storedValue);
}


/* Pension Stuff
===================== */

function getPensionPct(retAge){
	if (retAge == 62){
		return .8;
	}
	if (retAge == 63){
		return .87;
	}
	if (retAge == 64){
		return .93;
	}
	return 1;
}

function updatePensionAmount(){
	// DS: Changing to read from local storage since these form inputs don't exist
	// var pensionTotal = getFieldByPerson('pension-benefit', 'self');
	var pensionTotal = toNumber(shebangGetValue("pension_benefit_self"));
	if (isMarried){
		// pensionTotal += getFieldByPerson('pension-benefit', 'spouse');
		pensionTotal += toNumber(shebangGetValue("pension_benefit_spouse"));
	}
	var hh_pension_income = pensionTotal * getPensionPct(getRetAge());
	updateBarGraphBar('hh_pension_income', Math.round(hh_pension_income));
	shebangSaveValue('hh_pension_income', Math.round(hh_pension_income));
}
