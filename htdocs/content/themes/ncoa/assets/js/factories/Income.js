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
