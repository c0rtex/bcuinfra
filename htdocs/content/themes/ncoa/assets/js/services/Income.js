app.factory('Income', [function(){

	var income = {};

	var _incomes = [
		{
			title: 'Social Security Retirement and Survivor Benefits',
			description: 'Income you get from Social Security.'
		},
		{
			title: 'Social Security Disability',
			description: 'Social Security Disability Insurance (SSDI) is a cash benefit you and certain members of your family may get if you worked long enough and paid Social Security taxes.'	
		},
		{
			title: 'Supplemental Security Income',
			description: 'Supplemental Security Income (SSI) is a cash benefit you may get if you have limited income and resources, and are 65 years of age or older, disabled or blind.'	
		},
		{
			title: 'Pension and Retirement Benefits',
			description: 'A Pension or Retirement Benefit is a fixed amount of money based on the number of years you worked and how much you earned at jobs you have had.'	
		},
		{
			title: 'Work Income',
			description: 'Income you get from a job.'	
		},
		{
			title: 'Dividends and Interest',
			description: 'Dividends are amounts of money, stock, or other property paid to you by a corporation. Interest income includes money you get from savings you have in banks, credit unions, and other organizations.'
		},
		{
			title: 'Veteran Benefits',
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'	
		},
		{
			title: 'Cash Assistance',
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'	
		},
		{
			title: 'TANF',
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'	
		},
		{
			title: 'Unemployment Insurance',
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'	
		},
		{
			title: 'Railroad Retirement Benefits',
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'	
		},
		{
			title: 'Workers Compensation',
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'	
		},
		{
			title: 'Senior Community Service Employment Program (SCSEP)',
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'	
		},
		{
			title: 'Other Non Work Income',
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'	
		}
	];

	income.getIncomes = function(){
		return _incomes;
	}


	return income;
}]);