var ajax = '/wp-content/themes/shebang/_ajax/';
var isMarried = true;

function trace(msg){
	try {
		console.log(msg);
	} catch(e){}
}

$(document).ready(function(){
	initHowMuch();
	recalcAll();
	updateMortgageSpending();
});

function initHowMuch(){
	initMarriedStatus();
	$('.monthly-income-field').bind('click change', updateMonthlyCombinedIncome);
	
	$('.annual-to-month').bind('click change', updateMonthlyFromAnnual);
	$('.month-to-annual').bind('click change', updateAnnualFromMonthly);
	
	$('.annual-income-field').bind('click change', updateMonthlyCombinedIncome);
	
	$('#other_retirement_expenses').bind('click change', updateExtraExpenses);
	
	$('.ret-savings-amt').change(updateRetSavings);
	
	$('#monthly_mortgage_payment').bind('click change keyup', onMortgageChange);
	$('#annual_btax_earnings_self').each(shebangInstantSave);
	$('#annual_btax_earnings_self').blur(shebangInstantSave);
	$('#annual_btax_earnings_spouse').blur(shebangInstantSave);
	
	$('input[name="marital_stat"]').click(onMarriedStatusChange);
	
	$('.ret-savings-rate').bind('click change keyup', onContRateChange);
	$('.ret-savings-amt').bind('click change keyup', onContAmtChange);
	
	$('#target_consumption_delta').bind('mousemove click change', onLivingStandardChange);
	$('#target_consumption_delta').bind('mouseup mouseout click', onLivingStandardSet);
	/* Make sure this guy goes last */
	$('input').bind('change click', recalcAll);
	$('form#target-how-much input').change(recalcAll);
	redrawBarGraph(getHowMuchMaxVal());
	//$(window).resize(onHowMuchScroll);
	//$(window).scroll(onHowMuchScroll);
	$('#ret_savings_amount_spouse').trigger('blur');
	$('#ret_savings_amount_spouse').trigger('focus');
	$('.self-employed-checkbox').change(onSelfEmployedClick);
	$('#how-much-output .graph-overall-container').fixedScroll({fixedClass:'output-fixed', absClass:'output-relative', container:$('.interactive-box'), offset:$('#treatment-mini').height()});
}

function onSelfEmployedClick(e){
	var cb = $(this);
	if (cb.is(':checked')){
		shebangSaveValue(cb.data('field'), true);
	} else {
		shebangSaveValue(cb.data('field'), false);
	}
}

function onHowMuchScroll(){
	var wt = $(window).scrollTop();
	var toFix = $('#how-much-output .graph-overall-container');
	var topLimit = 50;
	var gt = 0;
	if (toFix.data('oy')){
		gt = toFix.data('oy');
	} else {
		gt = toFix.offset().top;
		toFix.data('oy', gt);
	}
	var dist = gt - wt;
	if (dist < topLimit){
		toFix.addClass('output-fixed');
	} else {
		toFix.removeClass('output-fixed');
	}
}

function updateTargetMonthlyConsumption(){
	var delta = $('#target_consumption_delta').val();
	var bookiss = setTargetMonthlyConsumption(delta);	
	shebangSaveValue('target_consumption_delta', delta);
	var target = $('#target_monthly_consumption').text();
	trace('target = ' + target); 
	shebangSaveValue('target_monthly_consumption_safe', toNumber(target));
	shebangSaveValue('target_monthly_consumption', toNumber(target));
	updateTargetPercent();
	
}

function updateTargetPercent(){
	var cmi = shebangGetValue('current_monthly_income');
	var tmi = shebangGetValue('target_ret_income');
	var tmPct = Math.round(tmi/cmi * 100);
	shebangSaveValue('target_percent_of_current_income', tmPct);
	shebangUpdatePageValue('target_percent_of_current_income', tmPct);
}

function setTargetMonthlyConsumption(delta){
	var consump = getMonthlySpending();
	var pdelta = delta/100;
	var diff = pdelta * consump;
	var target = consump + diff;
	updateBarGraphBar('graph-target_monthly_consumption', Math.round(target));
	redrawBarGraph(getHowMuchMaxVal());
	return target;
}

function onLivingStandardSet(e){
	updateTargetMonthlyConsumption();
	var delta = $('#target_consumption_delta').val();
	shebangSaveValue('target_consumption_delta', delta);
}

function onLivingStandardChange(e){
	var delta = e.target.value;
	if (delta){
		setTargetMonthlyConsumption(delta);
	}
}

function getUseClass(field){
	var useClass = 'field-self';
	if (field.hasClass('field-spouse')){
		useClass = 'field-spouse';
	}
	return useClass;
}

function onContAmtChange(e){
	var field = $(this);
	var amt = field.val();
	shebangSaveValue(field.attr('id'), amt);
	//Now calculate for the corresponding rate field
	var useClass = getUseClass(field);
	var mincome = $('.monthly_btax_earnings.'+useClass).val();
	var pct = 100 * (amt/mincome);
	var selector = '.ret-savings-rate.'+useClass;
	var targetField = $(selector);
	targetField.val(Math.round(pct));
	shebangSaveValue(targetField.attr('id'), Math.round(pct));
}

function onContRateChange(e){
	var field = $(this);
	var val = field.val();
	shebangSaveValue(field.attr('id'), val);
	//Now calculate for the corresponding amount field
	var useClass = getUseClass(field);
	var mincome = $('.monthly_btax_earnings.'+useClass).val();
	var pct = val / 100;
	var mcont = mincome * pct;
	var targetField = $('.ret-savings-amt.'+useClass);
	targetField.val(Math.round(mcont));
	shebangSaveValue(targetField.attr('id'), Math.round(mcont));
}

function initMarriedStatus(){
	var status = $.totalStorage('marital_stat');
	if (status == null){
		status = 1;
	}
	updateMarriedStatus(status);
}

function updateMarriedStatus(status){
	if (status == 1){
		isMarried = true;
		$('.group-spouse').fadeIn();
	} else {
		isMarried = false;
		$('.group-spouse').fadeOut();
	}	
	shebangSaveValue('marital_stat', status);
}

function onMarriedStatusChange(e){
	var status = e.target.value;
	updateMarriedStatus(toNumber(status));
	recalcAll();
}

function updateMonthlyFromAnnual(){
	var input = $(this);
	var monthlyID = input.attr('data-match-monthly');
	var val = Math.round(input.val() / 12);
	$('#'+monthlyID).val(val);
	shebangSaveValue(monthlyID, val);
}

function updateAnnualFromMonthly(){
	var input = $(this);
	var matchID = input.attr('data-match-annual');
	$('#'+matchID).val(Math.round(input.val() * 12));
}

function onMortgageChange(){
	updateMortgageSpending();
}

function updateMortgageSpending(){
	var mm = $('input#monthly_mortgage_payment').val();
	updateBarGraphBar('monthly_mortgage_payment', mm);
	shebangSaveValue('monthly_mortgage_payment', mm);
}

/* BAR GRAPH
========================== */

function getHowMuchMaxVal(){
	var tamt = 0;
	$('#graph-target-howmuch-current .bar-graph-bar:visible').each(function(){
		var addTo = toNumber($(this).data('value'));
		if (addTo < 0){
			$(this).hide();
		} else {
			tamt += addTo;
		}
	});
	var maxVal = toNumber($('#current_monthly_income').text());
	return Math.max(maxVal, tamt);
}



/* GETS 
========================== */

function getCombinedMontlyEarnings(){
	var selfNum = $('#monthly_btax_earnings_self').val();
	var selfAmt = toNumber(selfNum);
	var ret = selfAmt;
	if (isMarried){
		var spouseNum = $('#monthly_btax_earnings_spouse').val();
		var spouseAmt = toNumber(spouseNum);
		ret += spouseAmt;
	}
	var otherAmt = toNumber($('#other_income').val());
	ret += otherAmt;
	return ret;
}

function getIncomeTaxAtRate(earnings, rate){
	return earnings * rate;
}

function getIncomeTax(earnings, married, isTempRetired){
	var tr = getIncomeTaxRate(earnings, married, isTempRetired);
	var ret = tr * earnings;
	return ret;
}

function getIncomeTaxRate(earnings, married, isTempRetired){
	var hhLookup = Math.round(Math.round(earnings) / 1000) * 1000;
	hhLookup = Math.min(hhLookup, 249000);
	var resCol;
	if (isMarried){
		if (isTempRetired){
			resCol = 'data-ret_married';
		} else {
			resCol = 'data-work_married';
		}
	} else {
		if (isTempRetired){
			resCol = 'data-ret_single';
		} else {
			resCol = 'data-work_single';
		}
	}
	var sel = '#table-pln_target_income_tax .lookup-'+hhLookup;
	var row = $(sel);
	var pct = row.attr(resCol); 
	if (!pct){
		pct = 0;
	}
	return pct / 100;
}

function getContributions(){
	var selfSavingsMonth = toNumber($('#ret_savings_amount_self').val());
	var totalSavingsMonth = Math.round(selfSavingsMonth);
	if (isMarried){
		var spouseSavingsMonth = toNumber($('#ret_savings_amount_spouse').val());
		totalSavingsMonth += Math.round(spouseSavingsMonth);
	}
	return totalSavingsMonth;
}

function getPayrollTaxAmt(){
	var selfPayrollTaxRate = .0765;
	if ($('#self_employed_self').attr('checked')){
		selfPayrollTaxRate *= 2;
	}
	var selfAmt = toNumber($('#annual_btax_earnings_self').val());
	if (selfAmt > 106800){
		selfAmt = 106800;
	}
	var ret = selfAmt * selfPayrollTaxRate;
	/* Spouse calcs */
	if (isMarried){
		var spousePayrollTaxRate = .0765;
		if ($('#self_employed_spouse').attr('checked')){
			spousePayrollTaxRate *= 2;
		}
		var spouseAmt = toNumber($('#annual_btax_earnings_spouse').val());
		if (spouseAmt > 106800){
			spouseAmt = 106800;
		}	
		var retSpouse = spouseAmt * spousePayrollTaxRate;
		ret = ret + retSpouse
	}
	return ret / 12;
}

function getMonthlySpending(){
	var totalEarn = toNumber(getCombinedMontlyEarnings());
	var contributions = toNumber(getContributions());
	var mort = toNumber($('#monthly_mortgage_payment').val());
	var ssaPayroll = Math.round(toNumber(getPayrollTaxAmt()));
	var incomeTax = getIncomeTax(totalEarn * 12, isMarried, false);
	incomeTax /= 12;
	var extra = toNumber($('#other_retirement_expenses').val());
	var spending = totalEarn - mort;
	spending -= contributions;
	spending -= ssaPayroll;
	spending -= extra;
	spending -= incomeTax;
	if (spending < 0){
		return 0;
	}
	return spending;
}

/* GENERAL CALCS 
========================== */

function recalcAll(){
	updateMonthlyCombinedIncome();
	updatePayrollTaxAmt();
	updateMortgageSpending();
	updateIncomeTax();
	updateMonthlySpending();
	updateRetSavings();
	updateTargetMonthlyConsumption();
	updateTargetTaxes();
	updateTargetIncome();
	updateTargetPercent();
	
}

function getTargetEstimatedSSABenefit(retAge){
	var selfIncome = toNumber($('#annual_btax_earnings_self').val());
	var ssab = calcRealSSABenefit(55, retAge, selfIncome);
	var retSpending = toNumber($('#target_monthly_consumption').text());
	if (isMarried){
		var spouseIncome = toNumber($('#annual_btax_earnings_spouse').val());
		ssab += calcRealSSABenefit(55, retAge, spouseIncome);
	}
	return ssab;
}

function getTargetSSARetirementTaxRate(retSpending){
	var estimatedSSABeneift = getTargetEstimatedSSABenefit(65);
	var ttsb = (retSpending - (estimatedSSABeneift * .5)) * 12;
	if (isMarried){
		if (ttsb < 32000){
			return 0;
		} else if (ttsb < 44000) {
			return .5;
		} else {
			return .85;
		}
	} else {
		if (ttsb < 25000){
			return 0;
		} else if (ttsb < 34000){
			return .5;
		} else {
			return .85;
		}
	}
	return 0;
}

function updateTargetTaxes(){
	var retSpending = getBarGraphValue('target_monthly_consumption');
	var retirementSSATaxRate = getTargetSSARetirementTaxRate(toNumber(retSpending));
	var extraMedical = getBarGraphValue('medical_expenses_dollar');
	var ssaBenefit = getTargetEstimatedSSABenefit(65);
	var taxableSSABenefit = ssaBenefit * retirementSSATaxRate;
	var totalMonthlyTaxBase = retSpending - ssaBenefit + taxableSSABenefit;
	var totalAnnualTaxBase = totalMonthlyTaxBase * 12;
	
	var annualIncomeTax = getIncomeTax(totalAnnualTaxBase, isMarried, true);
	var monthlyRetirementIncomeTax = annualIncomeTax/12;
	
	trace('monthlyRetirementIncomeTax ' + monthlyRetirementIncomeTax);
	if (monthlyRetirementIncomeTax < 0){
		monthlyRetirementIncomeTax = 0;
	} else {
		var atot = getIncomeTax(toNumber(totalAnnualTaxBase + annualIncomeTax), isMarried, true);
		var mtot = atot / 12;
		monthlyRetirementIncomeTax = mtot;
	}
	updateBarGraphBar('post_retirement_monthly_income_tax_amount', Math.round(monthlyRetirementIncomeTax));
	shebangSaveValue('post_retirement_monthly_income_tax_amount', Math.round(monthlyRetirementIncomeTax));
}

function updateTargetIncome(){
	var tamt = 0;
	$('#target-how-much-retirement .bar-graph-bar').each(function(){
		tamt += toNumber($(this).find('.amount').text());
	});
	
	shebangUpdatePageValue('target_ret_income', addCommas(roundTo(tamt, 100)));
	
	//$('#target_ret_income').html(tamt);
	shebangSaveValue('target_ret_income', tamt);
	shebangSaveValue('target_ret_income_orig', tamt);
	
}

function updateIncomeTax(){
	var isRetired = false;
	var cmit = Math.round(getIncomeTax(getCombinedMontlyEarnings()*12, isMarried, false)); 
	cmit = Math.round(cmit/12);
	updateBarGraphBar('pre_retirement_monthly_income_tax_amount', cmit);
	shebangSaveValue('pre_retirement_monthly_income_tax_amount', cmit);
	
}

function updateMonthlySpending(){
	var spending = getMonthlySpending();
	var ce = getCombinedMontlyEarnings();
	updateBarGraphBar('current_monthly_consumption', Math.round(spending), ce);
	shebangSaveValue('current_monthly_consumption', Math.round(spending));
	redrawBarGraph(getHowMuchMaxVal());
	updateBarGraphBar('current_monthly_consumption', Math.round(spending), ce);
}

function updateMonthlyCombinedIncome(){
	var cearn = getCombinedMontlyEarnings();
	shebangUpdatePageValue('current_monthly_income', addCommas(roundTo(cearn, 100)));
	shebangSaveValue('current_monthly_income', cearn);
}

function updatePayrollTaxAmt(){
	var payrollTaxAmt = getPayrollTaxAmt();
	shebangSaveValue('payroll_tax_amt_combined', Math.round(payrollTaxAmt));
	updateBarGraphBar('payroll_tax_amt_combined', payrollTaxAmt);
	redrawBarGraph(getHowMuchMaxVal());
}

function updateRetSavings(){
	var totalSavingsMonth = getContributions();
	shebangSaveValue('hh_monthly_retirement_saving_amount', totalSavingsMonth)
	updateBarGraphBar('hh_monthly_retirement_saving_amount', totalSavingsMonth);
	redrawBarGraph(getHowMuchMaxVal());
}

function updateExtraExpenses(){
	var val = toNumber($('#other_retirement_expenses').val());
	shebangSaveValue('other_retirement_expenses', val)
	updateBarGraphBar('other_retirement_expenses', val);
	redrawBarGraph(getHowMuchMaxVal());
}