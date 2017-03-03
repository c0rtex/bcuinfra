app.factory('Asset', [function(){

	var asset = {};

	var _assets = [
		{
			title: 'Cash and Cash Equivalent',
			code: 'cash',
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'
		},
		{
			title: 'Primary Car',
			code: 'auto1',
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'
		},
		{
			title: 'Value of Home',
			code: 'home',
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'
		},
		{
			title: 'Second Car',
			code: 'auto2',
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'
		},
		{
			title: 'Life Insurance: Face Value',
			code: 'life_face',
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'
		},
		{
			title: 'Life Insurance: Cash Value',
			code: 'life_cash',
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'
		},
		{
			title: 'Retirement Accounts',
			code: 'retirement',
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'
		},
		{
			title: 'Investment Accounts',
			code: 'stocks',
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'
		},
		{
			title: 'Burial Accounts: Irrevocable',
			code: 'irrevocable',
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'
		},
		{
			title: 'Burial Accounts: Revocable',
			code: 'revocable',
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'
		},
		{
			title: 'Other Assets',
			code: 'other_a',
			description: 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.'
		}
	];

	asset.getAssets = function(){
		return _assets;
	}

	return asset;
}]);
