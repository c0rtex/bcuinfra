
<?php
	echo '<script type="text/javascript" src="'.get_bloginfo('template_url').'/js/shebang-ssa.js"></script>';
	
	echo '<script type="text/javascript" src="'.get_bloginfo('template_url').'/js/calculators-target-your-retirement-how-much-youll-need-2.js"></script>';

	echo shebang_get_table('pln_target_income_tax', 'hh_earnings');

	echo shebang_hidden_constant('ssa_wage_growth');
	echo shebang_hidden_constant('ss_wage_base');
	echo shebang_hidden_constant('ssa_bp_growth_rate');
	echo shebang_hidden_constant('inflation_rate');
	echo shebang_hidden_constant('cola_rate');
	echo shebang_get_bp_table();
	echo "\n";
	echo shebang_get_pia_table();
	echo "\n";
	echo shebang_get_spousal_benefit_table();
?>

<section class="how-much-box interactive-box">
	<div class="how-much-container interactive-container">
		<form id="target-how-much-form" class="col-1">
			<h3 class="enter-info-label">Enter Your Information <span class="form-label-light">to see what you'll need</span></h3>

			<fieldset class="marital-status">
				<span class="inline-input">
					<h3 class="form-label">Are you...</h3>
					<input type="radio" id="u-single" name="marital_stat" value="0" class="ls-value" data-field="marital_stat" />
					<label for="u-single">Single</label>
				</span> <!-- inline-input -->

				<span class="inline-inputs">
					<input type="radio" id="u-married" name="marital_stat" value="1" checked="checked" class="ls-value" data-field="marital_stat"/>
					<label for="u-married">
						Married
					</label>
				</span> <!-- inline-input -->
			</fieldset>

			<fieldset class="earnings">
				<h3 class="form-label">Annual Earnings from Work</h3>
				<div class="col-1 group-you">

					<div class="form-field-large-dollar">
						<h4 class="form-label-small">You</h4>
						<span class="dollar">$</span>
						<input type="number" id="annual_btax_earnings_self" data-field="annual_btax_earnings_self" value="45000" class="instant-save annual-to-month annual-income-field field-self annual_btax_earnings ls-value" data-match-monthly="monthly_btax_earnings_self" step="500" min="0"/>
					</div> <!-- /.form-field -->

					<div class="form-field-med-dollar">
						<span class="dollar">$</span>
						<input type="number" id="monthly_btax_earnings_self" data-field="monthly_btax_earnings_self" value="3625" class="normal-save monthly-income-field month-to-annual field-self monthly_btax_earnings ls-value" data-match-annual="annual_btax_earnings_self" step="25" min="0"/>
						<span class="field-mod-txt">/ month</span>
					</div> <!-- /.form-field -->

					<div class="checkbox-container">
						<input type="checkbox" id="self_employed_self" data-field="self_employed_self" class="checkbox-input ls-value self-employed-checkbox" value="true" />
						<label class="checkbox-label" for="self_employed_self">Self-employed</label>
					</div> <!-- /.form-field -->

				</div> <!-- /.col-1 -->

				<div class="col-2 group-spouse">

					<div class="form-field-large-dollar">
						<h4 class="form-label-small">Your Spouse</h4>
						<span class="dollar">$</span>
						<input type="number" id="annual_btax_earnings_spouse" value="23500" class="instant-save annual-to-month annual-income-field field-spouse annual_btax_earnings ls-value" data-field="annual_btax_earnings_spouse" data-match-monthly="monthly_btax_earnings_spouse"  step="500" min="0"/>
					</div> <!-- /.form-field -->

					<div class="form-field-med-dollar">
						<span class="dollar">$</span>
						<input type="number" id="monthly_btax_earnings_spouse" value="2500" class="normal-save monthly-income-field month-to-annual field-spouse monthly_btax_earnings ls-value" data-match-annual="annual_btax_earnings_spouse" data-field="monthly_btax_earnings_spouse" step="25" min="0"/>
						<span class="field-mod-txt">/ month</span>
					</div> <!-- /.form-field -->

					<div class="checkbox-container">
						<input type="checkbox" id="self_employed_spouse" data-field="self_employed_spouse" class="ls-value self-employed-checkbox" value="true"/>
						<label for="self_employed_spouse">Self-employed</label>
					</div> <!-- /.form-field -->
				</div> <!-- /.col-2 -->
			</fieldset> <!-- /.earnings -->

			<fieldset class="monthly-contributions">
				<h3 class="form-label">Monthly Contributions <span class="form-label-light">to 401(k), IRA, other plans</span></h3>
				<div class="col-1 group-you">

					<div class="form-field-large-dollar ret-savings-amt-group">
						<span class="dollar">$</span>
						<input type="number" id="ret_savings_amount_self" class="instant-save ret-savings-amt field-self ls-value" value="109" step="10" min="0" data-field="ret_savings_amount_self" />
					</div> <!-- form-field-large -->

					<div class="form-field-med ret-savings-rate-group">
						<input type="number" id="ret_savings_rate_self" class="field-self ret-savings-rate pct-from-amt" data-num="ret_savings_amount_self" data-den="monthly_btax_earnings_self" value="" step="1" min="0" data-field="ret_savings_rate_self" />
						<span class="pct">%</span>
					</div> <!-- form-field-med -->

				</div> <!-- /..col-1 group-you -->

				<div class="col-2 group-spouse">

					<div class="form-field-large-dollar ret-savings-amt-group">
						<span class="dollar">$</span>
							<input type="number" id="ret_savings_amount_spouse" class="instant-save ret-savings-amt field-spouse ls-value" value="75"  step="10" min="0" data-field="ret_savings_amount_spouse" />
					</div> <!-- form-field-large -->

					<div class="form-field-med ret-savings-rate-group">
						<input type="number" id="ret_savings_rate_spouse" class="field-spouse ret-savings-rate pct-from-amt" data-num="ret_savings_amount_spouse" data-den="monthly_btax_earnings_spouse" value="" step="1" min="0" data-field="ret_savings_rate_spouse" />
						<span class="pct">%</span>
					</div> <!-- form-field-med -->
				</div> <!-- /.col-2 group-spouse -->

			</fieldset> <!-- /.monthly-contributions -->

			<fieldset class="monthly-mortgage">
				<h3 class="form-label info-box tip-trigger">Monthly Mortgage <span class="form-label-light">principal &amp; interest</span><div class="tooltip"><?php echo get_editable_furniture(388); ?></div></h3>

				<div class="form-field-large-dollar monthly-mtg-payment-group">
					<span class="dollar">$</span>
					<input type="number" id="monthly_mortgage_payment" value="625" class="instant-save  ls-value monthly-mtg-payment-field" min="0" data-field="monthly_mortgage_payment" step="25"/>
				</div> <!-- form-field-large -->

			</fieldset> <!-- /.monthly-mortgage -->

			<fieldset class="planned-ret-age">
				<div class="form-field-large planned-ret-age-group">
					<h3 class="form-label info-box tip-trigger"><?php echo get_editable_title(6781); ?>
						<div class="tooltip"><?php echo get_editable_furniture(6781); ?></div>
					</h3>
					<input type="number" id="planned_ret_age" data-field="retirement_age" value="65" class="instant-save ls-value" step="1" min="62" max="70">
				</div>
			</fieldset>

			<!-- Advanced button -->
			<section class="advanced-btn-container">
				<a href="#" id="ss-benefit-trigger" class="advanced-btn trigger-advanced" title="Good if you have other income or big expenses">Advanced<span class="advanced-arrow">&rsaquo;</span></a>

			<div id="note-container" class="note-advanced">
				<p><?php echo get_editable_furniture(391); ?></p>
				<div class="note-arrow"><span class="right"></span></div>
			</div> <!-- note-advanced -->

			</section> <!-- /.advanced-container -->


			<section id="how-much-advanced" class="hidden-advanced" >
				<fieldset class="other-income-fieldset form-field-large-dollar">
					<h3 class="form-label"><strong>Other Income</strong> <span class="form-label-light">such as rents or dividends</span></h3>
					<span class="dollar">$</span>
					<input type="number" id="other_income" value="0" min = "0" step = "25" class="instant-save ls-value" data-field="other_income" />
				</fieldset>

				<fieldset class="extra-expenses-fieldset form-field-large-dollar">
					<h3 class="form-label"><strong>Extra Expenses</strong> <span class="form-label-light">that won't continue, such as tuitions</span></h3>
					<span class="dollar">$</span>
					<input type="number" id="other_retirement_expenses" value="0"  min="0" step="25" class="instant-save ls-value" data-field="other_retirement_expenses"/>
				</fieldset>

				<fieldset class="standard-of-living-fieldset">
					<h3 class="form-label"><strong><?php echo get_editable_title(6802);?></strong> <span class="form-label-light"><?php echo get_editable_furniture(6802);?></span></h3>
					<div class="slider-input-container">
						<input type="range" min="-20" max="20" id="target_consumption_delta" class="slider-input ls-value instant-save" value="0" data-field="target_consumption_delta" />
					</div> <!-- /.slider-input-container -->
				</fieldset> <!-- /.standard-of-living -->
			</section>

		</form>

		<section class="col-2 output" id="how-much-output">

			<div class="graph-overall-container">
				<div id="target-how-much-current" class="col-1">
					<hgroup class="graph-hgroup">
						<h3 class="graph-header">Current Monthly Income</h3>
						<h2 class="monthly-earnings-both graph-number"><span class="dollar">$</span> <span id="current_monthly_income" data-field="current_monthly_income" class="ls-value">5000</span></h2>
					</hgroup>

					<article class="graph-container cur-graph">
						<div class="graph" id="graph-target-howmuch-current">
							<div id="graph-monthly_mortgage_payment" class="bar-graph-bar bar-graph-blue-dark">
								<h4 class="graph-category"><span class="col-1 graph-cat-text">Mortgage</span> <span class="col-2 amount-group">$<span class="amount ls-value" id="monthly_mortgage_payment" data-field="monthly_mortgage_payment">0</span></span></h4>
							</div>

							<div id="graph-hh_monthly_retirement_saving_amount" class="bar-graph-bar bar-graph-blue">
								<h4 class="graph-category"><span class="col-1 graph-cat-text">Retirement contributions</span> <span class="col-2 amount-group">$<span class="amount ls-value" data-field="hh_monthly_retirement_saving_amount">0</span></span></h4>
							</div>

							<div id="graph-payroll_tax_amt_combined" class="bar-graph-bar bar-graph-blue-light">
								<h4 class="graph-category"><span class="col-1 graph-cat-text">Social Security payroll tax</span> <span class="col-2 amount-group">$<span class="amount ls-value" data-field="payroll_tax_amt_combined">0</span></span></h4>
							</div>

							<div id="graph-other_retirement_expenses" class="bar-graph-bar bar-graph-blue-lighter">
								<h4 class="graph-category"><span class="col-1 graph-cat-text">Extra expenses</span> <span class="col-2 amount-group">$<span class="amount ls-value" data-field="other_retirement_expenses">0</span></span></h4>
							</div>

							<div id="graph-pre_retirement_monthly_income_tax_amount" class="bar-graph-bar bar-graph-canary">
								<h4 class="graph-category"><span class="col-1 graph-cat-text">Income Tax</span> <span class="col-2 amount-group">$<span class="amount ls-value" id="pre_retirement_monthly_income_tax_amount" data-field="pre_retirement_monthly_income_tax_amount">0</span></span></h4>
							</div>

							<div id="graph-current_monthly_consumption" class="bar-graph-bar bar-graph-green">
								<h4 class="graph-category"><span class="col-1 graph-cat-text">Monthly Spending</span> <span class="col-2 amount-group">$<span id="current_montly_consumption" class="amount ls-value" data-field="current_monthly_consumption">3875</span></span></h4>
							</div>
						</div> <!-- /.graph -->
					</article> <!-- /.graph-container -->
				</div> <!-- /.target-how-much-current .col-1 -->



				<div id="target-how-much-retirement" class="col-2">
					<hgroup class="graph-hgroup">
						<h3 class="graph-header">Retirement Income Target</h3>
						<h2 class="graph-number"><span class="dollar">$</span><span id="target_ret_income" data-field="target_ret_income" class="ls-value">0</span></h2>
						<p class="graph-text"><span id="target_percent_of_current_income" data-field="target_percent_of_current_income" class="ls-value">70</span>% of current income</p>
					</hgroup>

					<article class="graph-container ret-graph">

						<div class="graph">
							<div id="graph-medical_expenses_dollar" class="bar-graph-bar bar-graph-gold">
								<h4 class="graph-category"><span class="col-1 graph-cat-text">Added medical expenses</span><span class="col-2 amount-group">$<span class="amount ls-value" id="medical_expenses_dollar" data-field="medical_expenses_dollar">300</span></span></h4>
							</div>

							<div id="graph-post_retirement_monthly_income_tax_amount" class="bar-graph-bar bar-graph-canary">
								<h4 class="graph-category"><span class="col-1 graph-cat-text">Income Tax</span> <span class="col-2 amount-group">$<span class="amount ls-value" id="post_retirement_monthly_income_tax_amount" data-field="post_retirement_monthly_income_tax_amount">0</span></span></h4>
							</div>
							<div id="graph-target_monthly_consumption" class="bar-graph-bar bar-graph-green">
								<h4 class="graph-category"><span class="col-1 graph-cat-text">Monthly Spending</span> <span class="col-2 amount-group">$<span class="amount ls-value" id="target_monthly_consumption" data-field="target_monthly_consumption">3875</span></span></h4>
							</div>
						</div> <!-- /.graph -->
					</article> <!-- /.graph-container -->

					<small class="estimate-note">
						<?php echo get_editable_furniture(259); ?>
					</small>

				</div> <!-- /.target-how-much-retirement .col-2 -->

			</div> <!-- /.graph-overall-container -->

		</section> <!-- /.output -->
	</div> <!-- /.how-much-container -->
</section> <!-- /.how-much-box -->
