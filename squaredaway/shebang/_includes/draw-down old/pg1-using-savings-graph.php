<section class="drawdown-main-container interactive-container">	
	<section class="estimator-wrap interactive-box">	
	
		<!-- ================================= --> 
		<!-- ! Estimator Form   			   --> 
		<!-- ================================= -->

		<form id="drawdown-estimator" class="drawdown-estimator-form col-1">

			<article class="form-need-group">
				<h2 class="enter-info-label form-label-h1">What You Need Each Month</h2>
				
				<fieldset class="expenses-per-month">
					<h3 class="form-label-h2">...to Cover the Basics?</h3>
					<p class="form-label-txt">It's all right to guess &mdash; we just need to set a target</p>
					<div class="form-field-large-dollar">
						<span class="dollar">$</span><input type="number" id="current_monthly_consumption" data-field="current_monthly_consumption" value="3000" class="ls-value" step="50" min="0"> <span class="time-element">/ month</span>
				</fieldset>
				
				
			</article> <!-- /. form-need-group -->

			<article class="form-have-group">			
				<h2 class="enter-info-label form-label-h1">What You Already Have</h2>
				<fieldset class="social-security ss-group">
					<h3 class="form-label form-label-h2">Social Security 
					<p class="form-label-txt"> Enter your monthly benefits</p></h3>
					
					<div class="ss-dbl-input-group">
						<div class="col-1 group-self social-security-group form-field-large-dollar">
							<h4 class="form-label-small">You</h4>
							<span class="dollar">$</span>
							<input type="number" id="ss_benefit_amount_self" data-field="ss_benefit_amount_self" class="instant-save ls-value social-security-benefit" value="0" step="50">
						</div>
						<div class="col-2 group-spouse social-security-group form-field-large-dollar">
							<h4 class="form-label-small">Your Spouse</h4>
							<span class="dollar">$</span>
							<input type="number" id="ss_benefit_amount_spouse" data-field="ss_benefit_amount_spouse" class="instant-save social-security-benefit field-spouse ls-value" value="0" step="50">
						</div>
					</div> <!-- /.ss-dbl-input-group -->
					<div class="claimed-check-group checkbox-container">
					<input type="checkbox" id="social_security_claim_flag" class="ls-value instant-save" data-field="social_security_claim_flag"><label for="social_security_claim_flag">Have You Claimed Social Security?</label>
					</div>
				</fieldset>
				
				<fieldset class="other-income other-income-group">
					<h3 class="form-label form-label-h2 tip-trigger info-box">Other Income
					<p class="form-label-txt"> Enter pensions, rents and other income. Do not include dividends & interest.<div class="tooltip">For simplicity, we assume this income continues for life and rises in line with prices</div></p></h3>
					<div class="form-field-large-dollar">
						<span class="dollar">$</span>
						<input type="number" id="other_income" data-field="other_income" value="500" class="instant-save ls-value" step="5" min="0"> <span class="time-element">/ month</span>
					</div>
				</fieldset>
			</article> <!-- /. form-need-group -->

		</form> <!-- /.drawdown-estimator-form -->
				
				
				
		<!-- ================================= --> 
		<!-- ! Estimator Graph   			   --> 
		<!-- ================================= -->
						
		<section id="estimator-output" class="col-2 output">
			<div class="graph-overall-container">


				<!-- Graph -->
				
				<h4 class="bg-bar total-mo-expenses-h">
					<div class="graph-category">
						<span class="col-1 graph-cat-text">Total Monthly Expenses</span>
						<span class="col-2 amount-group">$<span class="rec-value" data-field="current_monthly_consumption"></span></span>
					</div> <!-- /.graph-category -->
				</h4>
				
				<article class="graph-container">
					<div id="graph-drawdown" class="graph col-1">
		
						<!-- Short bar -->
						<div id="graph-gap" class="bg-bar bar-graph-white">
						</div>
		
						<!-- Other Income bar -->
						<div id="graph-other_income" class="bg-bar">
							<h4 class="graph-category"><span class="col-1 graph-cat-text">Other Income</span>
								<span class="col-2 amount-group">$<span class="amount ls-value" data-field="other_income"></span></span></h4>	
						</div>
		
						<!-- Social Security bar -->
						<div id="graph-ss_benefit_amount_combined" class="bg-bar">
							<h4 class="graph-category"><span class="col-1 graph-cat-text">Social Security</span> 
								<span class="col-2 amount-group">$<span class="amount ls-value" data-field="ss_benefit_amount_combined"></span></span></h4>
						</div>
		
					</div> <!-- / #graph-drawdown -->
				</article> <!-- /.graph-container -->
				
				<!-- Graph Figures -->
					
				<article class="graph-figures estimator-key">
					<hgroup class="key-need-hgroup">
						<h4 class="graph-key-label">Income You Need from Savings</h4>
						<h3 class="graph-key-number">
							<div class="col-1 graph-key-mo">
								<span class="dollar">$</span><span class="key-fig ls-value rec-value" data-field="monthly_income_gap"></span><span class="time-element">/ mo</span></div>
							<div class="col-2 graph-key-yr">
								<span class="dollar">$</span></span><span class="key-fig ls-value rec-value" data-field="yearly_income_gap"></span><span class="time-element">/ yr</span></div>
						</h3> <!-- /.graph-key-number -->
					</hgroup>		
				</article> <!-- /.graph-figures -->	
				
				<small class="estimate-note">
					Estimates given in current dollars, so you'll get a better idea of what you'll be able to buy in retirement.					</small>
	
			</div> <!-- /.graph-overall-container -->

		</article> <!-- /.estimator-output -->
				
	</section> <!-- /.drawdown-main-box -->
</section> <!-- /.drawdown-main-container -->