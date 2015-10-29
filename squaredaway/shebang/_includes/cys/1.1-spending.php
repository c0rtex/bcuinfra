    
		<section class="frame-container" data-nav-section="step-1" data-nav-page="spending-page">

		<!-- ================================= --> 
		<!-- ! Where the Money Goes			   --> 
		<!-- ================================= -->
			
			<article class="frame where-money-goes" data-nav="Where the Money Goes">
			
				<div class="frame-title-container">
					<p class="frame-title">Where the money goes</p>
				</div> <!-- frame-title-container -->

				<hgroup class="frame-hgroup">
					<h1 class="frame-h1">Where people spend.<br />Where you can save.</h1>
					<h2 class="frame-h3">Take a look at how a typical household spends its money &mdash; and where the savings are. Enter your own information to personalize the chart.</h2>
				</hgroup>

				<!-- ================================= --> 
				<!-- ! Income/Life Stage form		   --> 
				<!-- ================================= -->

				<form id="cex-age-income-form">

					<!-- Annual Income Form -->

					<div class="col-1">
						<fieldset id="cex-income">
							<div class="annual-income-group">
								<span class="dollar-annual">$</span>
								<label for="annual-income" class="cex-annual-label">Annual household income</label>
								<?php
								echo '<input name="annual-income" type="text" id="cex-annual-input" value="'.cys_get_usermeta('annual_income', '70,000').'">';
								?>
								</div> <!-- annual -->


							<!-- Monthly Income Form -->

							<div class="monthly-income-group">
								<span class="dollar-monthly">$</span>
								<input name="monthly-income" type="text" id="cex-monthly-input" value="5,835">
								<label for="monthly-income" class="cex-monthly-label">/ month</label>
							</div> <!-- monthly -->
						</fieldset>

						<!-- Note: Enter Your Info -->
						
						<div id="note-container" class="enter-income-note">
							<div class="note-arrow"><span class="right"></span></div>
							<p>Enter your information<p>
						</div> <!-- note -->

					</div> <!-- col-1 -->


					<!-- Life Stage Form -->

					<div class="col-2">
						<fieldset id="cex-life-stage">
							<label for="life-stage" class="form-label-block">Life stage</label>
							<select name="life-stage" id="cex-life-stage-select">
								<option value="young adult">New worker</option>
								<option value="middle age">Mid-career</option>
								<option value="approaching retirement" selected="selected">Approaching retirement</option>
								<option value="retired">Retired</option>
							</select>
						</fieldset>
					</div> <!-- input container col-2 -->
						
				</form>


				<!-- ================================= --> 
				<!-- ! CEX Chart					   --> 
				<!-- ================================= -->
				
				<div class="cex-container">

					<!-- Col: Savings Notes -->

					<div class="col-1 savings-notes">	

						<!-- Small Expenses -->
		
						<div class="small-savings-note">
							<div class="bracket"></div>
							<p class="text-graphic">Where you can find lots of <strong>small savings</strong> that add up and won't change your lifestyle<p>
						</div> <!-- note -->
		
		
						<!-- Big Expenses -->
		
						<div class="large-savings-note">
							<div class="bracket"></div>
							<p class="text-graphic">Where you can <strong>save big</strong> if you make big changes<p>
						</div> <!-- note -->
					
					</div> <!-- savings-notes -->


					<!-- Col: CEX Canvas -->
				
					<div id="cex-canvas" class="col-2">
						<div class="hidden">
							<div class="bar small-cat-bar" data-label="Entertainment / Eating Out" data-pcts="9.62, 10.49, 9.53, 9.16, 7.2"></div>
							<div class="bar small-cat-bar" data-label="Groceries, personal care, household" data-pcts="12.75, 11.1, 8.7, 7.44, 4.59"></div>
							<div class="bar small-cat-bar" data-label="Utilities / Communication" data-pcts="10.53, 9.98, 8.05, 5.97, 3.51"></div>
							<div class="bar small-cat-bar" data-label="Household" data-pcts="6.17, 6.42, 5.46, 5.07, 4.46"></div>
							<div class="bar small-cat-bar" data-label="Apparel" data-pcts="4.05, 3.77, 3.15, 2.62, 2.23"></div>
							<div class="bar small-cat-bar" data-label="Miscellaneous & Education" data-pcts="8.1, 6.11, 6.48, 4.91, 5.74"></div>
							<div class="bar small-cat-bar" data-label="Health Care" data-pcts="7.59, 8.04, 6.94, 5.4, 3.19"></div>
							<div class="bar large-cat-bar" data-label="Housing" data-pcts="25.3, 22.1, 19.8, 16.03, 12.3"></div>
							<div class="bar large-cat-bar" data-label="Transportation" data-pcts="13.36, 16.5, 15.08, 13.66, 9.56"></div>
							
							
							
							<div class="bar muted-cat-bar" data-label="Taxes" data-pcts="-3, 8, 10, 15, 25"></div>
							
							<div class="bar muted-cat-bar" data-label="Savings" data-pcts="5.53, -2.51, 6.81, 14.74, 22.22"></div>
						</div>
					</div> <!-- cex-canvas -->
				
				</div> <!-- cex-container -->
				
				<div class="footnote">
					<p>Data from 2009 Consumer Expenditure Survey, U.S. Department of Labor.</p>
				</div>

			</article>

		</section> <!-- frame-container -->


		<!-- ================================= --> 
		<!-- ! Footer Nav					   --> 
		<!-- ================================= -->
