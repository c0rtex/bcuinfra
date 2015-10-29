var isMarried;
var plannedRetAge;

$(document).ready(function(){
	plannedRetAge = shebangGetValue('retirement_age');
	$('#graph-monthly_income_rm').remove();
	$('#graph-downsizing_savings').remove();
	$('#graph-spendless-amt').remove();
	initMortgageDisplay();
	initMarriedStatus();
	calcEmpAmtFromPct();
	calcPensions();
	$('input').not('.empl-match-pct').bind('change click blur', plannerTargetShortRefresh);
	$('.empl-match-pct').bind('click blur', plannerTargetShortRefresh);
	$('.ret-savings').bind('click blur keyup change', plannerTargetShortRefresh);
	$('#mortgage_years_left').bind('click change keyup', shebangInstantSave);
	plannerTargetShortRefresh();
	$('#short-output .graph-overall-container').fixedScroll({fixedClass:'output-fixed', absClass:'output-relative', container:$('.interactive-box'), offset:$('#treatment-mini').height()});
	plannerTargetShortRefresh();
	updateHeaderWithAge(62, plannedRetAge);
});
$(window).load(function(e) {
    plannerTargetShortRefresh();
});

function updateHeaderWithAge(cAge, tAge){
	var t = $('.frame-h2').html();
	t = t.replace(cAge, tAge);
	$('.frame-h2').html(t);
}

function initMortgageDisplay(){
	var ma = shebangGetValue('monthly_mortgage_payment');
	if (ma == 625){
		$('.mortgage-yrs-fieldset').hide();
	}

}

function plannerTargetShortRefresh(){
	calcSSABenefit(plannedRetAge);
	updateRetIncomePerMonth(plannedRetAge);
	updateShortCalc();
	redrawBarGraph();
}

function initMarriedStatus(){
	var status = shebangGetValue('marital_stat');
	updateMarriedStatus(status);
}

function updateMarriedStatus(status){
	if (status == 1){
		isMarried = true;
		$('.group-spouse').show();
	} else {
		isMarried = false;
		$('.group-spouse').hide();
	}
}

function updateShortCalc(){
	var tamt = 0;
	$('.bar-graph-bar:visible').not('#graph-short_by').each(function(){
		tamt += toNumber($(this).find('.amount').text());
	});
	var shortBy = toNumber($('#target_ret_income').text()) - tamt;
	$('#target_short_by.amount').text(addCommas(Math.abs(shortBy)));
	if (shortBy > 0){
		$('#graph-short_by').show();
		$('.target-short-group .graph-key-label').text('Short');
		$('#target_short_by.amount').removeClass('surplus');
	} else {
		$('#graph-short_by').hide();
		$('.target-short-group .graph-key-label').text('Surplus');
		$('#target_short_by.amount').addClass('surplus');
	}
	shebangUpdatePageValue('target_short_by', addCommas(roundTo(shortBy, 10)));
	// shebangUpdatePageValue('target_ret_estimate', addCommas(roundTo(tamt, 100)));
	shebangUpdatePageValue('target_ret_estimate', addCommas(roundTo(tamt, 10)));
	updateBarGraphBar("short_by", shortBy);
	//redrawBarGraphBar("short_by", shortBy, getShortMaxVal());
}

function getShortMaxVal(){
	var tamt = 0;
	$('.bar-graph-bar:visible').each(function(){
		var addTo = toNumber($(this).find('.amount').text());
		if (addTo < 0){
			$(this).hide();
		} else {
			tamt += addTo;
		}
	});
	var maxVal = toNumber($('#target_ret_income').text());
	return Math.max(maxVal, tamt);
}

function calcEmpAmtFromPct(){
	//$('.empl-match-pct').each(onCalcEmpAmtFromPct);
	$('.empl-match-pct').change(onCalcEmpAmtFromPct);
	$('.empl-match-pct').click(onCalcEmpAmtFromPct);
	$('.empl-match-pct').each(onCalcEmpAmtFromPct);
	trace($('.empl-match-pct'));

	$('.empl-match-amount').change(onCalcEmpPctFromAmt);
	$('.empl-match-amount').click(onCalcEmpPctFromAmt);
}

function calcSSABenefit(retAge){
	//getSSABenefit(ageSelf, retAge, selfIncome, ageSpouse, spouseIncome);
	var ageSelf = shebangGetValue('age_self');
	var selfIncome = shebangGetValue('annual_btax_earnings_self');
	var ssaTotal;
	if (isMarried){
		var ageSpouse = shebangGetValue('age_spouse');
		var spouseIncome = shebangGetValue('annual_btax_earnings_spouse');
		ssaTotal = getSSABenefit(ageSelf, retAge, selfIncome, ageSpouse, spouseIncome);
	} else {
		ssaTotal = getSSABenefitSingle(ageSelf, retAge, selfIncome);
	}
	trace(ageSelf + ', ' + retAge + ', ' + selfIncome + ', ' + ageSpouse + ', ' + spouseIncome);
	shebangSaveValue('ssa_benefit_amount', Math.round(ssaTotal));
	updateBarGraphBar('ssa_benefit_amount', Math.round(ssaTotal), getShortMaxVal());
	return Math.round(ssaTotal);
}


/* Overall calcs
====================== */

function updateRetIncomePerMonth(retAge){
	var ipm = calcRetIncomePerYear(retAge) / 12;
	var maxVal = getShortMaxVal();
	updateBarGraphBar('ret_savings_combined', Math.round(ipm), maxVal);

	// DS: Saving value as in "planner-target-target"
	shebangSaveValue('ret_savings_combined', Math.round(ipm));

	return ipm;
}

function getRetIncomePerMonth(retAge){
	$('#target_ret_estimate').html(totalPerMonth.toFixed(2));
	shebangSaveValue('target_ret_estimate', totalPerMonth.toFixed(2));
	return calcRetIncome(retAge);
}

function calcRetIncome(retAge){
	var selfAge = shebangGetValue('age_self');
	var selfSavings = shebangGetValue('ret_savings_self');
	var selfPerYear = getFieldByPerson('empl-match-amount', 'self');

	var selfPersonal = shebangGetValue('ret_savings_amount_self');
	selfPerYear = toNumber(selfPersonal) + toNumber(selfPerYear);
	selfPerYear *= 12;

	var totalSavings = toNumber(getSavingsAtRetirement(selfAge, retAge, selfSavings, selfPerYear));
	if (isMarried){
		var spAge = shebangGetValue('age_spouse');
		var spSavings = shebangGetValue('ret_savings_spouse');
		var spPerYear = getFieldByPerson('empl-match-amount', 'spouse');
		var spPersonal = shebangGetValue('ret_savings_amount_spouse');
		spPerYear = toNumber(spPersonal) + toNumber(spPerYear);
		spPerYear *= 12;
		var spouseTotal = toNumber(getSavingsAtRetirement(spAge, retAge, spSavings, spPerYear));
		totalSavings += spouseTotal;
	}
	shebangSaveValue('savings_at_retirement', totalSavings);
	totalSavings += toNumber(shebangGetValue('savings_from_house'));
	var mortAmt = toNumber(shebangGetValue('monthly_mortgage_payment'));
	var mortYearsLeft = toNumber(shebangGetValue('mortgage_years_left'));
	if (mortAmt && mortYearsLeft > 0){
		var mortCost = getMortgageCost(mortAmt, mortYearsLeft);
		totalSavings -= toNumber(mortCost);
	}
	return totalSavings;
}


function calcRetIncomePerYear(retAge){
	var totalSavings = calcRetIncome(retAge);

	/*var drawDownPct = toNumber(getWithdrawalPct(retAge));*/
	var drawDownPct = .04;
	var spm = drawDownPct * totalSavings;
	return spm;
}


/* SAR
===================*/

function calcSavingsAtRetirement(curAge, retAge, baseSaving, perYear){
	var ytr = retAge - curAge;
	var ror = $('#real_ror').val();
	if (!ror){
		ror = 4.5;
	}
	ror = ror / 100;
	ror += 1;
	var saving = baseSaving;
	for (var i = 0; i<ytr; i++){
		trace('loooo');
		saving = (toNumber(saving) + toNumber(perYear)) * ror;
	}
	return saving;
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


/* Pension Stuff
====================== */

function calcPensions(){
	$('.pension-benefit').bind('change click blur', onPensionChange);
	// DS: Update pension too

	onPensionChange();
}

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

function onPensionChange(e){
	var pensionTotal = 0;
	$('.pension-benefit:visible').each(function(){
		var val = toNumber($(this).val());
		pensionTotal += val;
	});
	var hh_pension_income = pensionTotal * getPensionPct(plannedRetAge);
	updateBarGraphBar('hh_pension_income', Math.round(hh_pension_income), 6000);
	shebangSaveValue('hh_pension_income', Math.round(hh_pension_income));

}

function onCalcEmpAmtFromPct(){
	trace('onCalc gooooo!!!');
	var input = $(this);
	var pct = toNumber(input.val());
	shebangSaveValue(input.attr('id'), pct);
	var group = input.closest('.calc-group');
	var earnings = toNumber(group.find('.annual-earnings').val());
	var amount = (pct/100) * (earnings/12);
	var amtField = group.find('.empl-match-amount');
	amtField.val(Math.round(amount));
	var field = amtField.data('field');
	shebangSaveValue(field, Math.round(amount));
}

function onCalcEmpPctFromAmt(){
	var input = $(this);
	var amt = toNumber(input.val());
	var group = input.closest('.calc-group');
	var earnings = toNumber(group.find('.annual-earnings').val());
	var pct = amt/(earnings/12);
	pct *= 100;
	var pctField = group.find('.empl-match-pct');
	pctField.val(Math.round(pct));
	var field = pctField.data('field');
	shebangSaveValue(field, Math.round(pct));
	//shebangSaveValue(input.attr('id'), pct.toFixed(2));
}