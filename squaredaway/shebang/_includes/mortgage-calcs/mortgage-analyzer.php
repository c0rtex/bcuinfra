<section class="calc-container">
	<?php
		echo shebang_get_constants();
		echo shebang_get_json_payload('calc_mortgage_rates');
	?>
	<!-- ================================= --> 
	<!-- ! Mortgage Analyzer Form/Inputs   --> 
	<!-- ================================= -->
	
	<form class="mtg-analyzer-form">
		<fieldset class="mtg-data-inputs">
			<section class="input-row">
				<div id="note-container" class="note-advanced note-analyzer"><p>Start here: How much your home is worth?</p><div class="note-arrow"><span class="right"></span></div></div>
				<div class="form-field-large-dollar mtg-data-input-group home-value-input-group col-1">
					<label class="home-value-label" for="home-value-input">Home Value:</label>
					<span class="dollar">$</span>
					<input id="home-value-input" name="home_value" type="number" placeholder="200000" step="1000" min="0">
				</div> <!-- /.col-1 -->
	
				<div class="form-field-large-dollar mtg-data-input-group mtg-amt-input-group col-2">
					<label class="mtg-amt-label" for="mtg-amt-input">Mortgage Amount:</label>
					<span class="dollar">$</span>
					<input id="mtg-amt-input" name="mortgage_amount" type="number" placeholder="150000" step="1000" max="200000" min="0">
				</div> <!-- /.col-2 -->
	
				<div class="mtg-length-slider-group mtg-data-input-group col-3">
					<label class="mtg-length-label info-box-before tip-trigger" for="mtg-length-slider">
						How Long You'll Keep the Mortgage: <strong class="mtg-length-yrs-group"><span class="mtg-length-yrs">10</span> yrs</strong>
						<div class="tooltip">Most people hold a mortgage about 7 years &mdash; longer if they stay in the house longer &mdash; but it typically makes sense to pay off the mortgage before you retire, or soon thereafter.</div>
					</label> 
					<input id="mtg-length-slider" class="mtg-length-slider slider-input" type="range" name="mortgage_holding_period_years" min="1" max="30" value="10">
				</div> <!-- /.col-3 -->

				<article class="advanced-btn-group">
					<a href="#" id="ma-advanced-trigger" class="advanced-btn trigger-advanced">Advanced<span class="advanced-arrow">&rsaquo;</span></a>
				</article> <!-- /.advanced-btn-group -->

			</section> <!-- /.input-row -->
		</fieldset>

	<!-- ================================= --> 
	<!-- ! Advanced   					   --> 
	<!-- ================================= -->	

	<section class="advanced-container">	
		<article id="ma-advanced" class="advanced-form hidden-advanced">
			<div class="col-1 adv-assume">
				<h3 class="adv-h">Advanced Options</h3>
			</div> <!-- /.col-1 -->
			<fieldset class="col-2 adv-assume-fieldset">
				<h3 class="adv-assume-h">Our Estimates Assume That You &hellip;</h3>

				<ul class="adv-assume-list">

					<li class="adv-assume-form-field mtg-int-form-field"> &hellip;
						<select name="itemize_flag" id="mtg-int" class="mtg-int-select assume-input">
							<option value="1" selected="selected">Deduct</option>
							<option value="0">Don't Deduct</option>
						</select>
						mortgage interest from your tax return
					</li>
	
					<li class="adv-assume-form-field marginal-tax-form-field"> 
						&hellip; are in a marginal tax bracket of 
						<select name="marginal_tax_rate" id="marginal-tax" class="marginal-tax-select assume-input">
							<option value="10">10%</option>
							<option value="15">15%</option>
							<option value="25">25%</option>
							<option value="28" selected="selected">28%</option>
							<option value="33">33%</option>
							<option value="35">35%</option>
						</select>
					</li>

					<li class="adv-assume-form-field closing-costs-form-field"> 
						&hellip; pay 
						<span class="unit-group">
							<span class="dollar">$</span>
							<input id="pay-pts" class="closing-costs-input assume-input" name="closing_cost_fixed_amount" type="number" placeholder="2,000" step="100">
						</span>
						in closing costs
					</li>
	
<!--
					<li class="adv-assume-form-field pay-pts-fixed-form-field"> 
						&hellip; pay 
						<select name="mortgage_discount_points_fixed" id="pay-pts-fixed" class="pay-pts-fixed-select assume-input">
							<option value="0">0</option>
							<option value="1">1</option>
							<option value="2" selected="selected">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
						</select>
						<span class="info-box tip-trigger">point(s) on a fixed-rate mortgage
						<div class="tooltip">Points are voluntary payments to the lender, expressed as percentage "points" of the loan amount, used to buy down the interest rate.</div></span>
					</li>
	
					<li class="adv-assume-form-field pay-pts-adj-form-field"> 
						&hellip; pay 
						<select name="mortgage_discount_points_arm" id="pay-pts-adj" class="pay-pts-adj-select assume-input">
							<option value="0" selected="selected">0</option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
						</select>
						<span class="info-box tip-trigger">point(s) on an adjustable-rate mortgage
						<div class="tooltip">Points are voluntary payments to the lender, expressed as percentage "points" of the loan amount, used to buy down the interest rate.</div></span>
					</li>
-->
				</ul> <!-- /.adv-assume-list -->
			</fieldset> <!-- /.col-2 -->
		</article> <!-- /.ma-advanced-form -->
	</section> <!-- /.advanced-container -->



	<!-- ================================= --> 
	<!-- ! Mortgage Analyzer Comparisons   --> 
	<!-- ================================= -->	
	
	<section class="compare-container ma-compare-container">
		<h3 class="site-section-h compare-h">Mortgage Prices &amp; Options</h3>
		
		<table id="ma-compare-table" class="ma-compare-table compare-table">
			<thead>
				<tr class="ma-compare-hdr-row">
					<th class="mtg-type-th">Mortgage Type</th>
					<th class="mtg-int-th">Interest Rate</th>
					<th class="mtg-payment-th">Payments / Mo.</th>
					<th class="mtg-payment-at-th"><span class="info-box tip-trigger">After Tax
						<div class="tooltip">Principle and interest payment not including taxes or insurance. Focus on the after-tax cost of your mortgage if you deduct mortgage interest on your tax return. See Explanations.</div></span></th>
					<th class="own-owe-th">
						After <span class="mtg-length-yrs">10</span> Yrs, What You Own &amp; Owe 
						<span class="supporting-th info-box tip-trigger">In Today's Dollars
							<div class="tooltip">We assume <strong>1. House prices rise</strong> with inflation &mdash; so the value of your house in today's dollars remain unchanged; and <strong>2. That inflation</strong>, in addition to paying down the mortgage over time, reduces the value of the remaining mortgage in today's dollars.</div></span></th>
				</tr>  <!-- /.ma-compare-hdr-row -->
			</thead>
			<tbody>
<!-- This is the basis of the template for a Mortgage row, but it does not need to be rendered into the DOM by the backend

			<tr class="mtg-group-30_fixed">
				<td class="mtg-type-data first">30-Year Fixed</td>
					<td class="mtg-int-data form-field-med-pct">
						<input id="mtg-int-current" class="mtg-int-input mtg-int-current" name="" type="number" placeholder="5.0" step="0.125">
						<span class="pct">%</span>
					</td>
				<td class="mtg-payment-data">
					<span class="dollar">$</span><span class="monthly_mortgage_payment_bt">1,557</span>
				</td>
				<td class="mtg-payment-data-at">
					<span class="dollar">$</span><span class="monthly_mortgage_payment_at">1,266</span>
				</td>
				<td class="own-owe-data last">
					<div class="own-bar home_equity" style="width: 8%; "><span class="own-fig owe-own-fig">$15,000 Owned</span></div><div class="owe-bar loan_remaining_current_dollars" style="width: 92%; "><span class="owe-fig owe-own-fig">$185,000 Owed</span></div>
				</td>
			</tr>

				<tr class="mtg-select-group mtg-group-51_arm">
					<td class="mtg-type-select">
						<select name="mtg-compare-select" id="mtg-compare-select" class="mtg-compare-select">
							<option value="default" selected="selected">Compare To</option>
							<option value="20_fixed">20-Year-Fixed</option>
							<option value="15_fixed">15-Year-Fixed</option>
							<option value="10_fixed">10-Year-Fixed</option>
							<option value="71_arm">7-1 Adjustable</option>
							<option value="51_arm">5-1 Adjustable</option>
						</select>
					</td>
					<td class="mtg-int-data form-field-med-pct">
						<input id="mtg-int-current" class="mtg-int-input mtg-int-current" name="" type="number" placeholder="5.0" step="0.125">
						<span class="pct">%</span>
					</td>
					<td class="mtg-payment-data">
						<span class="dollar">$</span><span class="monthly_mortgage_payment_bt">1134</span>
					</td>
					<td class="mtg-payment-data-at">
						<span class="dollar">$</span><span class="monthly_mortgage_payment_at">993</span>
					</td>
					<td class="own-owe-data last">
						<div class="own-bar home_equity"><span class="own-fig owe-own-fig">$0 Owned</span></div>
						<div class="owe-bar loan_remaining_current_dollars"><span class="owe-fig owe-own-fig">$0 Owed</div>
					</td>
				</tr>

				<tr class="mtg-group-71_arm_adjusted ma-adjustable-after-group last odd">
					<td class="mtg-type-data first">
						After 7 years
					</td>
					<td class="mtg-int-data mtg-int-data-adjusted">
						<span class="info-box tip-trigger"><span class="mtg-int-adjusted">5.25</span><span class="pct">%</span><div class="tooltip">Initial reset rate of 5.25% based on an estimated 2.25% index rate plus a 3% margin.</div></span>
					</td>
					<td class="mtg-payment-data">
						<span class="dollar">$</span><span class="monthly_mortgage_payment_bt">1,679</span>
					</td>
					<td class="mtg-payment-data-at"><span class="dollar">$</span><span class="monthly_mortgage_payment_at">1,347</span></td><td class="rates-jump last"><input id="rates-jump" class="rates-jump-checkbox checkbox-input" type="checkbox" name="use_adjustment" value="rates-jump"><label class="rates-jump-label checkbox-label" for="rates-jump">See what might happen if interest rates jump</label>
					</td>
				</tr>
 -->
 			</tbody>
		</table>

		<?php
		
		$morts = array('30_fixed', '20_fixed', '15_fixed', '10_fixed', '71_arm', '51_arm');
		foreach($morts as $mort){
			$post = 'mort_desc_'.$mort;
			$pi = get_post_info($post);
			if ($pi->ID){
				echo '<article class="compare-explainer" id="'.$pi->post_name.'" data-wp-id="'.$pi->ID.'">';
				echo '<h3 class="compare-explainer-h">'.$pi->post_title.'</h3>';
				echo '<p>'.wpautop($pi->post_content).'</p>';
				echo '<p>'.get_shebang_edit_link($pi->ID, 'Edit Description').'</p>';
				echo '</article><!-- ma-compare-explainer -->';
			} 
		}
			
		?>		
	</section> <!-- /.ma-compare-container -->


	<!-- ================================= --> 
	<!-- ! Explanations				       --> 
	<!-- ================================= -->	
	
	<section class="explanations-container ma-explanations-container">
		<!-- ! Explanations Trigger --> 		
		<a class="explanations-trigger ma-explanations-trigger"><em class="i-circle tip-trigger">i<div class="tooltip">Click to learn more about the assumptions and equations used on this page</div></em>Explanations</a>
	
		<!-- ! Explanations Box --> 		
		<section class="explanations-section explanations-hidden">
			<p><strong>Mortgage interest is tax deductible</strong>, and the after-tax payment shown is your initial after-tax payment, based on the tax rate in Advanced. The interest you pay and your tax deduction decline as you pay down the loan, so your after-tax payment in dollars will rise. But due to inflation, your after-tax expense in today's dollars will generally decline.</p>
			<p><strong>Note that it becomes increasingly difficult</strong> to get a mortgage as the payment before taxes, plus real estate taxes, insurance, and your other debt payments approaches 45% of your household income.</p>
	</section> <!-- /.ma-explanations-container -->
	
	</form> <!-- /.mtg-analyzer-form -->
</section> <!-- /.calc-container -->

<script type="text/javascript" src="/wp-content/themes/shebang/js/number-utils.js"></script>
