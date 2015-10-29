<div class="graph-container">

	<div id="graph-short" class="graph col-1">

		<!-- Short bar -->

		<div id="graph-spendless-amt" class="bar-graph-bar bar-graph-white">

			<span class="amount ls-value" id="target_spendless-amt" data-field="effect-spendless-amt">0</span>
			<h4 class="graph-original">
				<div class="graph-category graph-category-orig">
				<span class="col-1 graph-cat-text graph-orig-txt">Original Target </span>
					<span class="col-2 amount-group">$<span class="amount-original-target ls-value" data-field="target_ret_income">0</span></div>
			</h4>
		</div>

		<div id="graph-short_by" class="bar-graph-bar bar-graph-white">
			<span class="amount ls-value" id="target_short_by" data-field="target_short_by">0</span>

		</div>

		<!-- Retirement bar -->
		<div id="graph-ret_savings_combined" class="bar-graph-bar">
			<h4 class="graph-category"><span class="col-1 graph-cat-text">Retirement Savings </span>
				<span class="col-2 amount-group">$<span class="amount ls-value" data-field="ret_savings_combined">5000</span></span></h4>
		</div>

		<!-- Pension bar -->
		<div id="graph-hh_pension_income" class="bar-graph-bar">
			<h4 class="graph-category"><span class="col-1 graph-cat-text">Pension </span>
				<span class="col-2 amount-group">$<span class="amount ls-value" data-field="hh_pension_income">0</span></span></h4>
		</div>

		<!-- Downsizing bar -->
		<div id="graph-downsizing_savings" class="bar-graph-bar">
			<h4 class="graph-category"><span class="col-1 graph-cat-text">Downsizing Income </span>
				<span class="col-2 amount-group">$<span class="amount ls-value" data-field="downsizing_savings">0</span></span></h4>
		</div>

		<!-- Reverse Mortgage bar -->
		<div id="graph-monthly_income_rm" class="bar-graph-bar">
			<h4 class="graph-category"><span class="col-1 graph-cat-text">Reverse Mortgage Income</span>
				<span class="col-2 amount-group">$<span class="amount ls-value" data-field="monthly_income_rm">0</span></span></h4>
		</div>



		<!-- Social Security bar -->
		<div id="graph-ssa_benefit_amount" class="bar-graph-bar">
			<h4 class="graph-category"><span class="col-1 graph-cat-text">Social Security Benefit </span>
				<span class="col-2 amount-group">$<span class="amount ls-value" data-field="ssa_benefit_amount">0</span></span></h4>
		</div>

	</div> <!-- /#.graph-short -->

	<div class="graph-figures">

		<!-- Target Number -->
		<h2 class="target-ret-income-group"><div class="graph-key-label">Target Income</div>
			<div class="graph-key-number"><span class="dollar">$</span><span id="target_ret_income" data-field="target_ret_income_temp" data-field-fallback="target_ret_income" class="ls-value round-to-10">0</span></div></h2>

		<!-- Short Number -->
		<h2 class="target-short-group"><div class="graph-key-label">Short</div>
			<div class="graph-key-number"><span class="dollar">$</span><span id="target_short_by" class="amount ls-value round-to-10" data-field="target_short_by">0</span></div></h2>

		<!-- Estimate Number -->
		<h2 class="target-ret-estimate-group"><div class="graph-key-label">Estimated Income</div>
			<div class="graph-key-number"><span class="dollar">$</span><span id="target_ret_estimate" data-field="target_ret_estimate" class="ls-value">0</span></div></h2>

	</div> <!-- /.graph-figures -->

</div> <!-- /.graph-container -->