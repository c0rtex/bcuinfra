<section class="drawdown-main-container interactive-container">	
	<section class="estimator-wrap interactive-box">	
	
		<!-- ================================= --> 
		<!-- ! Estimator Form   			   --> 
		<!-- ================================= -->

		<form id="drawdown-estimator" class="drawdown-estimator-form col-1">
        
        <article class="form-info-group">	
        		<div class="other-income col-1 form-field-large">		
                    <h2 class="enter-info-label form-label-h1">Your Information</h2>
                    <fieldset class="current-age">
                        <h3 class="form-label form-label-h2">Current Age</h3>
                        <input type="number" id="age_self" data-field="retirement_age" value="65" class="instant-save ls-value" step="1" min="62" max="70">
                        <p class="form-label-txt"> Or Age you Want to Retire</p>
                    </fieldset>
                </div>
                
				<div class="other-income col-2">
                    <fieldset class="other-income other-income-group">
                        <h3 class="form-label form-label-h2">Marital Status</h3>
                        <select id="marital_status_gender" class="select-input-large instant-save marital-status-select ls-value" data-field="marital_status_gender">
                        <option value="0">Single, Male</option>
                        <option value="1">Single, Female</option>
                        <option value="3" selected="selected">Married</option>
                		</select>
                    </fieldset>
                </div>
                
                
                
                <div class="other-income col-3 form-field-large">
                
                	 <fieldset class="other-income other-income-group">
                        <h3 class="form-label-h2">Retirement Savings</h3>
                        <div class="form-field-large-dollar">
                            <span class="dollar uys">$</span><input type="number" id="ret_savings" data-field="ret_savings" value="100000" class="ls-value instant-save" step="2000" min="0"> 
                    </fieldset>
                
                	<!--
                
                    <fieldset class="other-income other-income-group">
                    <h3 class="form-label form-label-h2">Retirement Savings</h3>
   				    <span class="dollar savings-dollar">$</span><input type="number" id="ret_savings" data-field="ret_savings" value="3000" class="ls-value instant-save" step="500" min="0">
                    </fieldset>
                    
                    -->
                    </div>
			</article> <!-- /. form-info-group -->


<article class="form-have-group">	
<h2 class="enter-info-label form-label-h1">What You Already Have <span class="light">...or will when you retire</span></h2>
                        <div class="col-1">		
                            
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
                	</div>
                
				<div class="other-income col-2">
				<fieldset class="other-income other-income-group">
					<h3 class="form-label form-label-h2 tip-trigger info-box">Other Income
					<p class="form-label-txt"> Enter pensions, rents and other income. Do not include dividends & interest.<div class="tooltip">For simplicity, we assume this income continues for life and rises in line with prices</div></p></h3>
					<div class="form-field-large-dollar">
						<span class="dollar uys">$</span>
						<input type="number" id="other_income" data-field="other_income" value="500" class="instant-save ls-value" step="5" min="0"> <span class="time-element">/ month</span>
					</div>
				</fieldset>
                </div>
			</article> <!-- /. form-need-group -->


			<article class="form-need-group">
               <div class="col-1">
                    
                    <fieldset class="expenses-per-month">
                        <h3 class="form-label-h2">What You Need Each Month</h3>
                        
                        <div class="form-field-large-dollar">
                            <span class="dollar uys">$</span><input type="number" id="current_monthly_consumption" data-field="current_monthly_consumption" value="3000" class="ls-value instant-save" step="50" min="0"> 
                        </div>
                        <p class="form-label-txt">It's all right to guess &mdash; we just need to set a target</p>
                    </fieldset>
               </div>
               
                <div class="col-2">
                    <fieldset class="expenses-per-month">
                        <h3 class="form-label-h2">Could You Cut Your Spending?</h3>
                        
                        <div class="form-field-large-dollar">
                            <input type="number" id="drawdown_cut_pct" data-field="drawdown_cut_pct" value="5" class="ls-value instant-save" step="1" min="0" max="20"><span id="drawdown_cut_pct_label">%</span>
                        </div>
                        <p class="form-label-txt">Most households can cut spending by 5-10% without major lifestyle changes.</p>
                    </fieldset>
               </div>
 
			</article> <!-- /. form-need-group -->
			
			
            <article class="form-button-group">
				<a class="btn-dark-big make-a-plan-button" href="<?php echo get_next_slide()->permalink; ?>">Make a Plan</a>
			</article> <!-- /. form-need-group -->
		</form> <!-- /.drawdown-estimator-form -->
				
				
				
		<!-- ================================= --> 
		<!-- ! Estimator Graph   			   --> 
		<!-- ================================= -->
						
		<section id="estimator-output" class="col-2">
			<article class="viz-figure-col-container-header">In Retirement</article>
				<div class="your-info">
                	<img src="/wp-content/themes/shebang/_images/male.png" class="viz-figure-col-male viz-figure" />
                    <img src="/wp-content/themes/shebang/_images/female.png" class="viz-figure-col-female viz-figure" />
                </div>
                <div class="your-income">
                	<h4 class="graph-key-label">Yearly Income</h4>
                	<h2 class="yearly-income-total"><span class="dollar">$</span><span id="drawdown_yearly_income" data-field="drawdown_yearly_income" class="ls-value">1,000</h2>
                </div>
                <div class="your-expenses">
                    <h4 class="graph-key-label">Yearly Expenses</h4>
                    <h2 class="yearly-expenses-total"><span class="dollar">$</span><span id="drawdown_yearly_expenses" data-field="drawdown_yearly_expenses" class="ls-value">1,000</span></h2>
                    <h4 class="graph-key-label bottom" id="text-drawdown_yearly_expenses_cys"><strong id="drawdown_yearly_expenses_cys">$47,000</strong> if you reduce your spending by <span class="ls-value" data-field="drawdown_cut_pct">5</span>%</h4>
                </div>
                <div class="your-savings-needs">
                    <h4 class="graph-key-label">What You Need From Savings, <br />Per Year</h4>
                    <h2 class="yearly-savings-needs-total"><span class="dollar">$</span><span id="drawdown_need_from_savings" data-field="drawdown_need_from_savings" class="ls-value">1,000</span></h2>
                    <h4 class="graph-key-label"><span id="text-drawdown_need_from_savings_cys"><strong id="drawdown_need_from_savings_cys">1,000</strong> if you cut your spending</h4>
                </div>
			</article> <!-- /.estimator-output -->
		</section>
	</section> <!-- /.drawdown-main-box -->
</section> <!-- /.drawdown-main-container -->