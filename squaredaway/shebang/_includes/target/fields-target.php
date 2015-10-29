<?php

	/*
	echo shebang_hidden_field('other_income', 'other-income');
	echo shebang_hidden_field('target_ret_income', 'target_ret_income_orig');
	echo '<input type="hidden" value="'.shebang_get_user_meta('target_ret_income', 0).'" class="target_ret_income_orig" />';
	echo shebang_hidden_field('annual_btax_earnings_self', 'annual-btax-earnings field-self');
	echo shebang_hidden_field('annual_btax_earnings_spouse', 'annual-btax-earnings field-spouse');
	
	//echo shebang_hidden_field('target_short_by');
	$sb = shebang_get_user_meta('target_short_by');
	if ($sb < 0){
		echo '<input type="hidden" id="reached_goal" value="true" />';
	}
	
	echo shebang_hidden_field('monthly_mortgage_payment');
	echo shebang_hidden_field('mortgage_years_left');
	echo shebang_hidden_field('target_monthly_consumption');
	echo shebang_hidden_field('age_self', 'cur-age field-self self');
	echo shebang_hidden_field('ret_savings_self', 'ret-savings field-self self');
	echo shebang_hidden_field('ret_savings_amount_self', 'ret-personal-savings field-self self');
	echo shebang_hidden_field('empl_match_amount_self', 'empl-match-amount field-self self');
	echo shebang_hidden_field('pension_benefit_self', 'pension-benefit field-self');
	echo shebang_hidden_field('marital_stat');
	echo shebang_hidden_field('age_spouse', 'cur-age field-spouse spouse', 53);
	echo shebang_hidden_field('ret_savings_spouse', 'ret-savings field-spouse spouse');
	echo shebang_hidden_field('ret_savings_amount_spouse', 'ret-personal-savings field-spouse spouse');
	echo shebang_hidden_field('empl_match_amount_spouse', 'empl-match-amount field-spouse spouse');
	echo shebang_hidden_field('pension_benefit_spouse', 'pension-benefit field-spouse');
	*/
	echo shebang_hidden_constant('ssa_wage_growth');
	echo shebang_hidden_constant('ss_wage_base');
	echo shebang_hidden_constant('ssa_bp_growth_rate');
	echo shebang_hidden_constant('inflation_rate');
	echo shebang_hidden_constant('cola_rate');
	echo shebang_hidden_constant('real_ror');
	echo shebang_hidden_constant('low_ror');
	echo shebang_hidden_constant('downsizing_transaction_cost_percent');
	
	echo shebang_get_bp_table();
	echo "\n";
	echo shebang_get_pia_table();
	echo "\n";
	echo shebang_get_spousal_benefit_table();
	echo "\n";
	echo shebang_get_table('pln_target_mortgage_payment', 'years_remain');
	echo "\n";
	echo shebang_get_table('pln_target_withdrawal', 'age');
	
	echo '<input type="hidden" id="savings_from_house" value="0" />';
	
?>