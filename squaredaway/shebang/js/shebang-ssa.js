function calcIncomeAt60(curAge, btax){
	var ssaCap = $('#ss_wage_base').val();
	var btax = Math.min(btax, ssaCap);
	var ssaWageGrowth = Number($('#ssa_wage_growth').val()) / 100;
	var mult = Math.pow((1 + ssaWageGrowth), (60-curAge));
	var age60Income = btax * mult; 
	return age60Income;
}

function calcIncomeAfter60(curAge, retAge, income){
	var sixtyToRetire = retAge - 60;
	n = sixtyToRetire;
	var incomeAt60 = calcIncomeAt60(curAge, income);
	var ssaWageGrowth = toNumber($('#ssa_wage_growth').val()) / 100;
	ssaWageGrowth += 1;
	var after = 0;
	for (var i = 0; i<n+1; i++){
		var j = i+1;
		var pow = Math.pow(ssaWageGrowth, j);
		var af = incomeAt60 * pow;
		after += af;
	}
	return after;
}

function calcIncomeBefore60New(curAge, retAge, income){
	var ytr = retAge - curAge;
	var incomeAt60 = calcIncomeAt60(curAge, income);
	var rgap = retAge - 60;
	var yearsAccum = 35 - rgap;
	var inflationRate = Math.round(toNumber($('#ssa_wage_growth').val()) * 10) / 1000; //inflation rate is .028
	var bef = 0;
	for (var i = 0; i<yearsAccum; i++){
		bef += incomeAt60;
		bef = bef * (1 + inflationRate); //multiply the total each year by 1.028
	}
	return bef;
}

function calcIncomeBefore60(curAge, retAge, income){
	var ytr = retAge - curAge;
	var incomeAt60 = calcIncomeAt60(curAge, income);
	var rgap = retAge - 60;
	var yearsAccum = 35 - rgap;
	var bef = incomeAt60 * yearsAccum;
	return bef;
}

function getAIME(curAge, retAge, income){
	return calcPrimaryInsuranceAmt(curAge, retAge, income) / 420;
}

function calcTotalIndextedMonthlyEarnings(curAge, retAge, income){
	var incomeAfter60 = calcIncomeAfter60(curAge, retAge, income);
	var incomeBefore60 = calcIncomeBefore60(curAge, retAge, income);
	return incomeBefore60 + incomeAfter60;
}

function calcPrimaryInsuranceAmt(curAge, retAge, income){
	var incomeAt60 = calcIncomeAt60(curAge, income);
	var incomeAfter60 = calcIncomeAfter60(curAge, retAge, income);
	var incomeBefore60 = calcIncomeBefore60(curAge, retAge, income);
	var totalIndexedMonthlyEarnings = incomeBefore60 + incomeAfter60;
	return totalIndexedMonthlyEarnings;
}

function getBendPoints(ytr){
	var sel = '#table-bend-points input[data-tyr="'+ytr+'"]';
	var offsets = 0;
	if (ytr > $('#table-bend-points input').length - 1){
		offsets = ytr - $('#table-bend-points input').length - 1;
		ytr = $('#table-bend-points input').length - 1;
	}
	var row = $('#table-bend-points input').eq(ytr);
	var ret = {};
	ret.bp_1 = row.attr('data-bp1');
	ret.bp_2 = row.attr('data-bp2');
	if (offsets){
		var gr = $('#ssa_bp_growth_rate').val();
		gr *= .01;
		gr += 1;
		ret.bp_1 = ret.bp_1 * Math.pow(gr, offsets);
		
		ret.bp_2 = ret.bp_2 * Math.pow(gr, offsets);
	}
	ret.diff = ret.bp_2 - ret.bp_1;
	return ret;
}


function getYearBorn(curAge){
	var cdate = new Date();
	var cyear = cdate.getFullYear();
	var yearBorn = cyear - curAge;
	return yearBorn;
}

function getPiaFactor(curAge, retAge){
	var yearBorn = getYearBorn(curAge);
	if (yearBorn < 1955){
		yearBorn = 1955;
	}
	if (yearBorn > 1961){
		yearBorn = 1961;
	}
	var sel = '#table-pia-factor .year-born-'+yearBorn;
	var row = $(sel);
	var factor = row.attr('data-f'+retAge);
	return factor;
}

function calcPia(curAge, retAge, income){
	var ytr = retAge - curAge;
	var bendPoints = getBendPoints(ytr);
	var pia0 = .9 * Math.min(bendPoints.bp_1, getAIME(curAge, retAge, income));
	var pia1 = .32 * Math.min(bendPoints.diff, Math.max(0, getAIME(curAge, retAge, income)-bendPoints.bp_1));
	var pia2 = .15 * Math.max(0, getAIME(curAge, retAge, income) - bendPoints.bp_2);
	var pia = pia0 + pia1 + pia2;
	return pia;
}

function getIncome(person){
	return $('.annual-btax-earnings.field-'+person).val();
}

function calcPiaCola(curAge, retAge, income){
	var colaRate = $('#cola_rate').val() * .01;
	var pia = calcPia(curAge, retAge, income);
	/* var cola = Math.pow(colaRate, retAge-62); <-- this was giving exponentially small values */ 
	var cola = Math.pow(1 + colaRate, retAge-62); /* <--- this seems to return sensible calculations */
	var piaCola =  pia * cola;
	return piaCola;
}	

function calcNominalSSABenefit(curAge, retAge, income){
	var factor = getPiaFactor(curAge, retAge);
	return factor * calcPiaCola(curAge, retAge, income);
}

function calcRealSSABenefit(curAge, retAge, income){
	var nom = calcNominalSSABenefit(curAge, retAge, income);
	var inflationRate = $('#inflation_rate').val() / 100;
	var ytr = retAge - curAge;
	var ret = nom * Math.pow(1 - inflationRate, ytr);
	return ret;
}

function getSpousalBenefitFactor(retAgeDiff){
	if (!retAgeDiff){
		return 1;
	}
	var sel = '#table-spousal-benefit .year-diff-'+retAgeDiff;
	var row = $(sel);
	var ans = row.attr('data-pct');
	if (!ans){
		ans = 0;
	}
	return ans;
}

function calcPotentialSpousalBenefit(curAge, retAge, income, myCurAge, myIncome){
	var work = calcRealSSABenefit(curAge, retAge, income);
	var yearBorn = toNumber(getYearBorn(curAge));
	var nra = 67;
	if (yearBorn <= 1940){
		nra = 65;
	} else if (yearBorn <= 1957){
		nra = 66;
	}
	var me = calcRealSSABenefit(myCurAge, nra, myIncome);
	var spouse = calcRealSSABenefit(curAge, nra, income);
	var greaterIncome = Math.max(me, spouse) * .5;
	var nraDiff = nra - retAge;
	if (nraDiff < 0){
		nraDiff = 0;
	}
	var benFactor = getSpousalBenefitFactor(nraDiff);
	return greaterIncome * benFactor;
}

function getSSABenefitSingle(ageSelf, retAge, selfIncome){
	var ssaSelf = calcRealSSABenefit(ageSelf, retAge,selfIncome);
	return ssaSelf;
}

function getSSASpousalBenefit(ageSelf, retAge, selfIncome, ageSpouse, spouseIncome){
	return calcPotentialSpousalBenefit(ageSpouse, retAge, spouseIncome, ageSelf, selfIncome);
}

function getSSABenefit(ageSelf, retAge, selfIncome, ageSpouse, spouseIncome){
	var ssaSelf = calcRealSSABenefit(ageSelf, retAge,selfIncome);
	if (isMarried){
		var ssaSpouse = calcRealSSABenefit(ageSpouse, retAge, spouseIncome);
		var ssaPotential = calcPotentialSpousalBenefit(ageSpouse, retAge, spouseIncome, ageSelf, selfIncome);
		var least = Math.min(ssaSelf, ssaSpouse, ssaPotential);
		var sum = ssaSelf + ssaSpouse + ssaPotential;
		var elim = sum - least;
		return elim;
	} 
	return ssaSelf;
}