<section class="calc-container">
	<?php
		echo shebang_get_constants();
		echo shebang_get_json_payload('calc_mortgage_rates');
	?>
	<!-- ================================= -->
	<!-- ! Refinance Form/Inputs  		   -->
	<!-- ================================= -->

	<form class="refi-form">
		<fieldset class="mtg-data-inputs">

			<article class="input-row mtg-row">
				<div id="note-container" class="note-advanced note-refi"><p>Start here:<br />What's your Monthly Payment?</p><div class="note-arrow"><span class="right"></span></div></div>
                <div class="form-field-large-dollar mtg-data-input-group mtg-left-input-group">
                    <label class="mtg-left-label" for="mtg-left-input">Monthly Payments:</label>
                    <span class="dollar">$</span>
                    <input id="mtg-payment-current" class="mtg-payment-input mtg-payment-current" name="current_mortgage_payment" type="number" placeholder="2,000" step="100" min="0">
                </div>

				<div class="form-field-large-dollar mtg-data-input-group mtg-left-input-group">
					<label class="mtg-left-label" for="mtg-left-input">Mortgage Remaining:</label>
                    <span class="dollar">$</span>
					<input id="mtg-left-input" name="mortgage_amount_remaining" type="number" placeholder="200,000" step="1000">
				</div>

				<div class="form-field-large-dollar mtg-data-input-group home-val-input-group">
					<label class="home-val-label" for="home-val-input">Home Value:</label>
					<span class="dollar">$</span>
					<input id="home-val-input" name="home_value" type="number" placeholder="280,000" step="1000" min="0">
				</div>

				<div class="mtg-length-slider-group mtg-data-input-group">
					<label class="mtg-length-label info-box-before tip-trigger" for="mtg-length-slider">
						How Long You'll Keep the New Mortgage: <strong class="mtg-length-yrs-group"><span class="mtg-length-yrs">10</span> yrs</strong>
						<div class="tooltip">Most people hold a mortgage about 7 years &mdash; longer if they stay in the house longer &mdash; but it typically makes sense to pay off the mortgage before you retire, or soon thereafter.</div>
					</label>
					<input id="mtg-length-slider" class="mtg-length-slider slider-input" type="range" name="mortgage_holding_period_years" min="1" max="30" value="10">
				</div>

				<article class="advanced-btn-group">
					<a href="#" id="refi-advanced-trigger" class="advanced-btn trigger-advanced">Advanced<span class="advanced-arrow">&rsaquo;</span></a>
				</article> <!-- /.advanced-btn-group -->

			</article> <!-- /.input-row -->

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

					<li class="adv-assume-form-field closing-costs-form-field">
						&hellip; pay
						<span class="unit-group">
							<span class="dollar">$</span>
							<input id="pay-pts" class="closing-costs-input assume-input" name="closing_cost_fixed_amount" type="number" placeholder="1,500" step="100">
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

					<li class="adv-assume-form-field mtg-int-form-field"> &hellip;
						<select name="itemize_flag" id="mtg-int" class="mtg-int-select assume-input">
							<option value="1" selected="selected">Deduct</option>
							<option value="0">Don't Deduct</option>
						</select>
						mortgage interest from your tax return
					</li>

					<li class="adv-assume-form-field marginal-tax-form-field">
						&hellip; And your marginal tax bracket is
						<select name="marginal_tax_rate" id="marginal-tax" class="marginal-tax-select assume-input">
							<option value="10">10%</option>
							<option value="15">15%</option>
							<option value="25">25%</option>
							<option value="28" selected="selected">28%</option>
							<option value="33">33%</option>
							<option value="35">35%</option>
						</select>
					</li>

				</ul> <!-- /.adv-assume-list -->
			</fieldset> <!-- /.col-2 -->
		</article> <!-- /.ma-advanced-form -->
	</section> <!-- /.advanced-container -->



	<!-- ================================= -->
	<!-- ! Refinance Comparisons  		-->
	<!-- ================================= -->

	<section class="compare-container refi-compare-container">
		<h3 class="site-section-h compare-h">Current Mortgage vs. Refinanced Mortgage</h3>

		<table id="refi-compare-table" class="refi-compare-table compare-table">
			<thead>
				<tr class="refi-compare-hdr-row">
					<th class="mtg-compare-th"></th>
					<th class="mtg-type-th">Mortgage Type</th>
					<th class="mtg-int-th">Interest Rate</th>
					<th class="mtg-payment-th">Payments / Mo.</th>
					<th class="mtg-payment-at-th"><span class="info-box tip-trigger">After Tax
						<div class="tooltip">Principal and interest payment not including taxes or insurance. Focus on the after-tax cost of your mortgage if you deduct mortgage interest on your tax return. See Explanations.</div></span></th>
				</tr>  
			</thead>
			<tbody>
<!--
				<tr class="current-mtg-group">
					<td class="mtg-compare-data">Current Mortgage</td>
					<td class="mtg-type-data form-field-med">
						<select name="mtg-compare-select" id="mtg-type-select" class="mtg-compare-select">
							<option value="30_fixed" selected="selected">30-Year-Fixed</option>
							<option value="25_fixed">25-Year-Fixed</option>
							<option value="20_fixed">20-Year-Fixed</option>
							<option value="15_fixed">15-Year-Fixed</option>
							<option value="10_fixed">10-Year-Fixed</option>
							<option value="71_arm">7-1 Adjustable</option>
							<option value="51_arm">5-1 Adjustable</option>
						</select>
					</td>
					<td class="mtg-int-data form-field-med-pct">
						<input id="mtg-int-current" class="mtg-int-input mtg-int-current" name="" type="number" placeholder="7.0" step="0.1">
						<span class="pct">%</span>
					</td>

                    <td class="mtg-payment-data">
                        <span class="dollar">$</span><span class="mtg-payment-data-refi">1,200</span>						</td>

					<td class="mtg-payment-data-at">
						<span class="dollar">$</span><span class="mtg-payment-data-at-current">993</span>
					</td>
				</tr>

				<tr class="refi-mtg-group">
					<td class="mtg-compare-data">Refinanced Mortgage</td>
					<td class="mtg-type-data form-field-med">
						<select name="mtg-compare-select" id="mtg-type-select" class="mtg-compare-select">
							<option value="30_fixed">30-Year-Fixed</option>
							<option value="25_fixed">25-Year-Fixed</option>
							<option value="20_fixed" selected="selected">20-Year-Fixed</option>
							<option value="15_fixed">15-Year-Fixed</option>
							<option value="10_fixed">10-Year-Fixed</option>
							<option value="71_arm">7-1 Adjustable</option>
							<option value="51_arm">5-1 Adjustable</option>
						</select>
					</td>
					<td class="mtg-int-data form-field-med-pct">
						<input id="mtg-int-current" class="mtg-int-input mtg-int-current" name="" type="number" placeholder="4.0" step="0.1">
						<span class="pct">%</span>
					</td>
					<td class="mtg-payment-data">
						<span class="dollar">$</span><span class="mtg-payment-data-refi">945</span>
					</td>
					<td class="mtg-payment-data-at">
						<span class="dollar">$</span><span class="mtg-payment-data-at-refi">805</span>
					</td>
				</tr>

				<tr class="refi-mtg-group-adjusted ma-adjustable-after-group">
					<td class="mtg-compare-data"><span class="info-box tip-trigger">After 7 Years <div class="tooltip">Initial reset rate of 6.75% based on an estimated 3.75% index rate plus a 3% margin.</div></span></td>
					<td class="rates-jump last">
						<input id="rates-jump" class="rates-jump-checkbox checkbox-input" type="checkbox" name="use_adjustment" checked="checked" value="rates-jump"><label class="rates-jump-label checkbox-label" for="rates-jump">If interest rates jump</label></td>
					<td class="mtg-int-data mtg-int-data-adjusted"><span class="mtg-int-adjusted">4.75</span><span class="pct">%</span></td><td class="mtg-payment-data"><span class="dollar">$</span><span class="mtg-payment-data-refi">635</span></td>
					<td class="mtg-payment-data-at"><span class="dollar">$</span><span class="mtg-payment-data-at-refi">515</span></td>
				</tr>
-->
			</tbody>
		</table>
	</section> <!-- /.ma-compare-container -->

		<section class="compare-explainer">
			<article class="compare-overview">
				<dl class="what-if-list compare-overview">
					<!-- If You Refinance -->
					<article class="what-if-title-data">
						<dt class="what-if-title lower-payment-title">If You Refinance with this Loan:</dt>
						<dd class="what-if-data lower-payment-data">
							<ul class="what-if-sublist">
								<li class="what-if-subitem">
									<p>Your
									<span class="arm-only">initial</span>
									monthly payment would be about
									<span class="same-dollar-show">the same amount as you currently pay.</span>
									<span class="same-dollar-hide">
										<strong class="highlight-fig monthly_at">$xxx</strong> after taxes.
									</span></p>
								</li> <!-- /.what-if-subitem -->
								
								<li class="what-if-subitem">
									<p>We estimate closing costs of <strong class="highlight-fig closing-costs">$xxx</strong><span class="cc-calcs">, which the savings would cover in about <strong><span class="exp-yrs-to-cover">3</span> year<span class="yrs-to-cover-plural">s</span></strong></span>.<a href="#" class="trigger-closing-costs-change">Change</a></p>
								</li> <!-- /.what-if-subitem -->
								
								<li class="what-if-subitem">
									<p>After the <strong><span class="mtg-length-yrs">xx</span> years</strong>
									you intend to hold the mortgage, the amount you owe would be about
									<span class="same-pct-show">the same</span>
									<span class="same-pct-hide">
										<strong>
											<span class="highlight-fig amt-owed-diff">$xxx,xxx</span>
											<span class="amount-owed-gt-lt">more</span>
										</strong>
									</span>
									in today's dollars &mdash;
									<strong class="highlight-fig amt-owed-refi">$xxx,xxx</strong> vs.
									<strong class="highlight-fig amt-owed-current">$xxx,xxx</strong>.</p>
								</li> <!-- /.what-if-subitem -->
							</ul>
						</dd>
					</article>
				</dl>

			</article> <!-- compare-overview -->

			<article class="what-if-group">
				<h4 class="what-if-h">What If You Want To ...</h4>
				<dl class="what-if-list">
					<!-- Lower Your Monthly Payment? -->
					<article class="what-if-title-data">
						<dt class="what-if-title lower-payment-title">Lower Your Monthly Payment?</dt>
						<dd class="what-if-data lower-payment-data">
							<p>This <span class="is-isnt-switch">isn't</span> a good option, because you'll pay about
							<span class="same-dollar-show">the same amount as you currently pay</span>
							<span class="same-dollar-hide">
								<strong>
									<span class="highlight-fig payment-diff-at more">$xxx</span>
									<span class="mo-payment-gt-lt">more</span>
								</strong>
							</span>
							after taxes each month.</p>
						</dd>
					</article>
					<!-- Pay Off Your Mortgage Faster? -->
					<article class="what-if-title-data">
						<dt class="what-if-title pay-faster-title">Pay Off Your Mortgage Faster?</dt>
						<dd class="what-if-data pay-faster-data">
							<p>This <span class="is-isnt-switch">is</span> a good option, because you'll owe about
							<span class="same-pct-show">the same amount</span>
							<span class="same-pct-hide">
								<strong>
									<span class="highlight-fig amt-owed-diff">$xxx,xxx</span>
									<span class="amount-owed-gt-lt">more</span>
								</strong>
							</span>
							at the end of the <span class="mtg-length-yrs">10</span> years you intend to hold the mortgage.</p>
						</dd>
					</article>
					<!-- Cash Out or Consolidate Debt? -->
					<article class="what-if-title-data">
						<dt class="what-if-title cash-out-title">Cash Out or Consolidate Debt?</dt>
						<dd class="what-if-data cash-out-data">
                            <p>
                                <span class="cash-out-exists-show">
                                    You could take out a maximum of <strong class="highlight-fig cash-out-max">$xxx,xxx</strong> in cash
                                </span>
                                <span class="cash-out-exists-hide">
                                    You can't take out any cash by refinancing this mortgage
                                </span>
                                <span class="i-circle tip-trigger">i
                                    <span class="tooltip">Here's why: The mortgage on a "cash-out" refinance is usually limited to 75% of your current home value. If your house is worth <strong class="home-value">$xxx,xxx</strong>, the limit is <strong class="cash-out-limit">$xx,xxx</strong>. If closing costs are <strong class="closing-costs">$1,500</strong>, the most you could get is <strong class="cash-out-max">$xx,xxx</strong>.</span> <!-- /.tooltip -->
                                </span>.
                            </p>
                        <div class="cash-out-checkbox-group">
							<input id="cash-out" class="cash-out-checkbox checkbox-input" type="checkbox" name="get_cash_out_impact" value="cash-out"><label class="cash-out-label checkbox-label" for="cash-out">See what happens if you take out the maximum</label>
						</div> <!-- /.cash-out-checkbox-group -->
											
						</dd>
					</article>
				</dl> <!-- /.what-if-list -->
			</article> <!-- /.what-if-group -->

		</section> <!-- /.compare-explainer -->

	<!-- ================================= -->
	<!-- ! Explanations				       -->
	<!-- ================================= -->

	<section class="explanations-container ma-explanations-container">
		<!-- ! Explanations Trigger -->
		<a class="explanations-trigger ma-explanations-trigger"><em class="i-circle tip-trigger">i<div class="tooltip">Click to learn more about the assumptions and equations used on this page</div></em>Explanations</a>

		<!-- ! Explanations Box -->
		<section class="explanations-section explanations-hidden">
			<p><strong>Closing costs and points</strong>, if any, are added to the refinanced mortgage. Use the advanced menu to see the values we use (and adjust them).</p>
			<p><strong>If your current mortgage is an Adjustable Rate Mortgage (ARM)</strong>, to estimate the
amount remaining on your current loan at the end of the period you intend to hold the refinanced
loan: <strong>1.</strong> As future reset rates for Adjustable Rate Mortgages (ARMs) are unknown, we use an
estimated 6.75% interest rate, based on an estimated 3.75% index rate plus a 3% margin; and <strong>2.</strong> If your current interest rate is within 1% of that estimate rate we assume you are in the first year of paying the reset rate, otherwise we assume you are within one year of paying the reset rate.</p>
			<p><strong>Mortgage interest is tax deductible</strong>, and the after-tax payment shown is your initial after-tax payment, based on the tax rate in Advanced. The interest you pay and your tax deduction decline as you pay down the loan, so your after-tax payment in dollarswill rise. But due to inflation, your after-tax expense in today's dollars will generally decline.</p>
			<p><strong>Note that it becomes increasingly difficult to get a mortgage</strong> as the payment before taxes, plus real estate taxes and insurance, rise above 30% of your household income.</p>
	</section> <!-- /.ma-explanaations-container -->

	</form> <!-- /.mtg-analyzer-form -->
</section> <!-- /.calc-container -->

<script type="text/javascript" src="/wp-content/themes/shebang/js/number-utils.js"></script>