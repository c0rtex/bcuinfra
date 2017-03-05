app.factory('BenefitItems', [function(){

	var BenefitItems = {};

	var _BenefitItems = [
		{
			name: 'Medication',
			code: 'bcuqc_category_rx',
			image: '/content/themes/ncoa/resources/assets/images/categories/category_medicine.svg',
			alt: 'Medicine Pills',
			title: 'Medicine Pills',
			sort: 1
		},
		{
			name: 'Health Care',
			code: 'bcuqc_category_medicaid',
			image: '/content/themes/ncoa/resources/assets/images/categories/category_health.svg',
			alt: 'Doctor Symbols',
			title: 'Doctor Symbol',
			sort: 2
		},
		{
			name: 'Income Assistance',
			code: 'bcuqc_category_income',
			image: '/content/themes/ncoa/resources/assets/images/categories/category_income.svg',
			alt: 'Money',
			title: 'Money',
			sort: 3
		},
		{
			name: 'Food & Nutrition',
			code: 'bcuqc_category_nutrition',
			image: '/content/themes/ncoa/resources/assets/images/categories/category_food.svg',
			alt: 'Basket of Food',
			title: 'Basket of Food',
			sort: 4
		},
		{
			name: 'Housing & Utilities',
			code: 'bcuqc_category_utility',
			image: '/content/themes/ncoa/resources/assets/images/categories/category_housing.svg',
			alt: 'House',
			title: 'House',
			sort: 5
		},
		{
			name: 'Tax Relief',
			code: 'bcuqc_category_property_taxrelief',
			image: '/content/themes/ncoa/resources/assets/images/categories/category_taxRelief.svg',
			alt: 'Piggy Bank',
			title: 'Piggy Bank',
			sort: 6
		},
		{
			name: 'Veterans',
			code: 'bcuqc_category_veteran',
			image: '/content/themes/ncoa/resources/assets/images/categories/category_veteran.svg',
			alt: 'Medal',
			title: 'Medal',
			sort: 7
		},
		{
			name: 'Employment',
			code: 'bcuqc_category_employment',
			image: '/content/themes/ncoa/resources/assets/images/categories/category_employment.svg',
			alt: 'Briefcase',
			title: 'Briefcase',
			sort: 8
		},
		{
			name: 'Transportation',
			code: 'bcuqc_category_transportation',
			image: '/content/themes/ncoa/resources/assets/images/categories/category_transportation.svg',
			alt: 'Automobile',
			title: 'Automobile',
			sort: 9
		},
		{
			name: 'Education',
			code: 'bcuqc_category_education',
			image: '/content/themes/ncoa/resources/assets/images/categories/category_education.svg',
			alt: 'Apple on Book',
			title: 'Apple on Book',
			sort: 10
		},
		{
			name: 'Discount',
			code: 'bcuqc_category_discounts',
			image: '/content/themes/ncoa/resources/assets/images/categories/category_discounts.svg',
			alt: 'Percent Off',
			title: 'Percent Off',
			sort: 11
		},
		{
			name: 'Other Assistance',
			code: 'bcuqc_category_other_assistance',
			image: '/content/themes/ncoa/resources/assets/images/categories/category_assistance.svg',
			alt: 'Information',
			title: 'Information',
			sort: 12
		}
	];

	BenefitItems.returnAllCodes = function() {
		var codes = [];
		_BenefitItems.forEach(function(element) {
			codes.push(element.code);
		});

		return codes;
	}

	BenefitItems.getBenefitItems = function() {
		return _BenefitItems;
	};

	BenefitItems.getByCode = function(code) {
		for(var i=0;i<_BenefitItems.length;i++) {
			if (_BenefitItems[i].code == code) return _BenefitItems[i];
		}
		return undefined;
	}

	BenefitItems.programsInStructure = function(struct) {
		var retVal = 0;
		for (var i in struct) {
			if (BenefitItems.getByCode(i) != undefined) retVal++;
		}
		return retVal;
	}

	return BenefitItems;
}]);
