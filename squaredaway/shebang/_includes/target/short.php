<?php
	echo '<script type="text/javascript" src="'.get_bloginfo('template_url').'/js/shebang-ssa.js"></script>';
	echo '<script type="text/javascript" src="'.get_bloginfo('template_url').'/js/calculators-target-your-retirement-will-you-be-short.js"></script>';

?>

<section class="will-you-be-short-box interactive-box">
	<div class="will-you-be-short-container interactive-container">
		<form id="target-short-form" class="col-1">
			<h3 class="enter-info-label">Enter Your Information <span class="form-label-light">to see what you'll have</span></h3>

			<?php
				echo shebang_hidden_constant('ssa_wage_growth');
				echo shebang_hidden_constant('ss_wage_base');
				echo shebang_hidden_constant('ssa_bp_growth_rate');
				echo shebang_hidden_constant('inflation_rate');
				echo shebang_hidden_constant('cola_rate');

				// DS: Adding real_ror

				echo shebang_hidden_constant('real_ror');

				echo shebang_get_bp_table();
				echo "\n";
				echo shebang_get_pia_table();
				echo "\n";
				echo shebang_get_spousal_benefit_table();
				echo "\n";
				echo shebang_get_table('pln_target_mortgage_payment', 'years_remain');
				echo "\n";
				echo shebang_get_table('pln_target_withdrawal', 'age');
			?>

			<fieldset class="age-fieldset">
				<h3 class="form-label">Age</h3>

				<div class="col-1 group-you">
					<div class="form-field-large">
						<h4 class="form-label-small">You</h4>
						<input type="number" id="age_self" value="55" class="instant-save cur-age field-self ls-value" data-field="age_self" min="18" max="62"/>
					</div> <!-- /.form-field-large -->
				</div> <!-- /.group-you -->

				<div class="col-2 group-spouse">
					<div class="form-field-large">
						<h4 class="form-label-small">Your Spouse</h4>
						<input type="number" id="age_spouse" value="53" data-field="age_spouse" class="instant-save cur-age field-spouse ls-value" min="18" max="62" />
					</div> <!-- /.form-field-large -->
				</div> <!-- /.group-you -->
			</fieldset> <!-- /.age-fieldset -->

			<fieldset class="ret-savings-fieldset">
				<h3 class="form-label">Retirement Savings <span class="form-label-light">in 401(k), IRA, or other plans</span></h3>
				<div class="col-1 group-self form-field-large-dollar ret-savings-group">
					<span class="dollar">$</span>
					<input type="number" id="ret_savings_self" data-field="ret_savings_self" class="instant-save ret-savings field-self ls-value" value="40000" step="100"/>
				</div> <!-- /.col-1 .group-self -->

				<div class="col-2 group-spouse form-field-large-dollar ret-savings-group">
					<span class="dollar">$</span>
					<input type="number" id="ret_savings_spouse" data-field="ret_savings_spouse" class="instant-save ret-savings field-spouse ls-value" value="20000" step="100"/>
				</div> <!-- /.col-2 .group-spouse -->
			</fieldset> <!-- /.ret-savings-fieldset -->

			<fieldset class="employer-cont-fieldset">
				<h3 class="form-label">Monthly Employer 401k Contributions <span class="form-label-light"></span></h3>
				<div class="col-1 group-self calc-group">
					<input class="hidden annual-earnings ls-value" data-field="annual_btax_earnings_self" value="35000" type="hidden"/>
					<div class="form-field-large-dollar empl-match-amount-group">
						<span class="dollar">$</span>
						<input type="number" id="empl_match_amount_self" data-field="empl_match_amount_self" class="empl-match-amount field-self" value="0" step="10"/>
					</div> <!-- /.form-field-large -->

					<div class="form-field-med empl-match-pct-group">
						<input type="number" id="empl_match_percent_self" class="empl-match-pct field-self ls-value instant-save " value="2" data-field="empl_match_percent_self"/> <span class="field-mod-txt" step="0.5">/ month</span>
						<span class="pct">%</span>
					</div> <!-- /.form-field-med -->

				</div> <!-- /.col-1 .group-self-->

				<div class="col-2 group-spouse calc-group">
					<input class="hidden annual-earnings ls-value" data-field="annual_btax_earnings_spouse" value="35000" type="hidden"/>
					<div class="form-field-large-dollar empl-match-amount-group">
						<span class="dollar">$</span>
						<input type="number" id="empl_match_amount_spouse" class=" empl-match-amount field-spouse" value="75" step="10" data-field="empl_match_amount_spouse" />
					</div> <!-- /.form-field-large -->

					<div class="form-field-med empl-match-pct-group">
						<input type="number" id="empl_match_percent_spouse" data-field="empl_match_percent_spouse" class="empl-match-pct field-self ls-value instant-save" value="1" step="0.5"/> <span class="field-mod-txt">/ month</span>
						<span class="pct">%</span>
					</div> <!-- /.form-field-med -->
				</div> <!-- /.col-2 .group-spouse-->

			</fieldset> <!-- /.ret-savings-fieldset -->

			<?php
				echo '<fieldset class="mortgage-yrs-fieldset form-field-large ls-boolean-display" data-field="monthly_mortgage_payment">
				<h3 class="form-label info-box tip-trigger">'.get_editable_furniture(251).'Years Remaining <span class="form-label-light">on your mortgage</span><div class="tooltip">'. get_editable_furniture('mi-mortgage-years-left').'</div></h3>';
				//echo '<span class="years">years</span>';
				echo '<input type="number" id="mortgage_years_left" class="instant-save" value="10" max="30" min="0"/>';
				echo '</fieldset> <!-- /.mortgage-yrs-fieldset -->';
			?>

			<fieldset class="pension-fieldset">
				<h3 class="form-label">Pension <span class="form-label-light">at age 65, if you have one</span></h3>
				<div class="col-1 group-self pension-group form-field-large-dollar">
					<span class="dollar">$</span>
					<input type="number" id="pension_benefit_self" data-field="pension_benefit_self" class="instant-save pension-benefit field-self ls-value" value="0" />
				</div>

				<div class="col-2 group-spouse pension-group form-field-large-dollar">
					<span class="dollar">$</span>
					<input type="number" id="pension_benefit_spouse" data-field="pension_benefit_spouse" class="instant-save pension-benefit field-spouse ls-value" value="0" />
				</div>

			</fieldset> <!-- /.pension-fieldset -->

			<!-- Advanced button -->
			<div class="advanced-btn-container">
				<a href="#" id="ss-benefit-trigger" class="advanced-btn trigger-advanced">Advanced<span class="advanced-arrow">&rsaquo;</span></a>
			</div> <!-- /.advanced-container -->

			<fieldset id="ss-benefit-advanced" class="ss-benefit-fieldset hidden-advanced">
				<p class="ss-benefit-intro"><?php echo get_editable_furniture(254); ?></p>
				<h3 class="form-label-h2"><?php echo get_editable_furniture(256); ?></h3>
				<table id="ss-claim-table">
					<tr>
						<th class="form-label-small-bold age-header-label">Age</th>
						<th class="form-label-small-bold you-header-label">You</th>
						<th class="form-label-small-bold spouse-header-label">Spouse</th>
					</tr>
					<tr>
						<td class="age-label">62</td>
						<td class="form-field-large-dollar">
							<span class="dollar">$</span>
							<input type="number" id="ss_claim_62_self" class="ss-claim-cell" />
						</td>
						<td class="form-field-large-dollar">
							<span class="dollar">$</span>
							<input type="number" id="ss_claim_62_spouse" class="ss-claim-cell" />
						</td>
					</tr>

					<tr>
						<td class="age-label">66</td>
						<td class="form-field-large-dollar">
							<span class="dollar">$</span>
							<input type="number" id="ss_claim_66_self" class="ss-claim-cell" />
						</td>
						<td class="form-field-large-dollar">
							<span class="dollar">$</span>
							<input type="number" id="ss_claim_66_spouse" class="ss-claim-cell" />
						</td>
					</tr>

					<tr>
						<td class="age-label">70</td>
						<td class="form-field-large-dollar">
							<span class="dollar">$</span>
							<input type="number" id="ss_claim_70_self" class="ss-claim-cell" />
						</td>
						<td class="form-field-large-dollar">
							<span class="dollar">$</span>
							<input type="number" id="ss_claim_70_spouse" class="ss-claim-cell" />
						</td>
					</tr>
				</table>
			</fieldset> <!-- /.ss-benefit-fieldset -->

		</form>

		<section id="short-output" class="col-2 output">
			<div class="graph-overall-container">

				<h2 class="graph-header">Retirement Income</h2>
				<h2 id="monthly_btax_earnings_both"></h2>

				<?php
					include('graph-target.php');
				?>

				<small class="estimate-note">
					<?php echo get_editable_furniture(259); ?>
				</small>
			</div> <!-- /.graph-overall-container -->
		</section> <!-- /.#short-output /.col-2 /.output -->
	</div> <!-- interactive-box -->
</section> <!-- interactive-container -->
