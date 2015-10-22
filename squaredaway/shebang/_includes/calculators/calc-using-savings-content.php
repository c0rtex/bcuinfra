<!-- ======================================== --> 
<!-- ! Enter a Goal				 			  --> 
<!-- ======================================== -->

<article class="enter-goal-box interactive-box">
	<div class="enter-goal-container interactive-container">	
		<!-- Enter Goal: Header -->

		<header class="enter-goal-header">
			<hgroup id="enter-goal-picker">
				<h3 class="enter-goal-h1" data-goal="Choose Your Goal" id="enter-goal-select">
					<form id="enter-goal-form">
						<label for="Goal select" class="goal-label-prefix" >
							Goal: </label>
							<select name="Goal select" id="goal-select" class="goal-select-input ls-value" data-field="cys_goal_slug">
								<option value="default" selected="selected">Choose a Goal</option>
								<option value="debt" data-interest-rate="7" data-default-amount="7000">Get Out of Debt</option>
								<option value="retirement"  data-interest-rate-type="savings" data-interest-rate="-4.3" data-default-amount="7000">Prepare for Retirement</option>
								<option value="reserve" data-interest-rate="0" data-default-amount="7000">Build a Reserve</option>
								<option value="credit-card" data-interest-rate-type="loan" data-interest-rate="12" data-default-amount="7000">Pay off Credit Card Debt</option>
								<option value="college" data-interest-rate="-2.3"  data-default-amount="7000">Save for College</option>
								<option value="house" data-interest-rate="0" data-default-amount="7000">Buy a House</option>
								<option value="car" data-interest-rate="0" data-default-amount="7000">Buy a Car</option>
								<option value="trip" data-interest-rate="0" data-default-amount="7000">Take a Trip</option>
								<option value="home-improvement" data-interest-rate="0" data-default-amount="7000">Improve Home</option>
								<option value="big-ticket-item" data-interest-rate="0" data-default-amount="7000">Get a Big Ticket Item</option>
								<option value="custom" data-interest-rate="0">Enter Your Own</option>
							</select> <!-- goal-select -->
					</form>
				</h3>

				<h3 class="custom-goal-h1" data-goal="custom">
					<form id="custom-goal-form">
						<label for="custom goal input" class="goal-label-prefix">
						Goal: </label>
						<input id="custom-goal-input" name="custom goal input" type="text" placeholder="Enter Your Own" value="3000" data-field="cys_custom_goal" class="ls-value">
					</form>
				</h3>
			</hgroup>
		</header>
		
		<div class="enter-goal-body">
			
			<!-- Enter Goal: Tabs -->
			
			<ul class="enter-goal-toggle" data-start-index="<?php echo cys_get_usermeta('cys_goal_tab', '0');?>">
				<li id="save-by-date-toggle" class="enter-goal-toggle-item"><a href="#set-amount">
					A Specific Amount</a></li>
				<li id="save-by-month-toggle" class="enter-goal-toggle-item"><a href="#cut-spending">
					Amount Each Month</a></li>
			</ul>
			

			<!-- Enter Goal: Form -->
			
			<form id="enter-goal-form" class="enter-goal-form">
				
				<!-- Save by date -->
			
				<fieldset id="save-by-date" class="pane">
				
						<div class="overall-savings-wrap save-by-date-split">
							<label class="overall-savings-label col-1" for="overall-savings-input" type="number">
								Amount:</label>
							<div class="form-field-large-dollar col-2">
								<span class="dollar">$</span>
								<input id="overall-savings-input" name="overall-savings-input" type="number" step="100" placeholder="0" data-field="overall-savings-input" class="ls-value">
							</div> <!-- /.form-field-large-dollar /.col-2 -->
						</div> <!-- /.overall-savings-wrap -->


						<div class="finish-wrap save-by-date-split">
							<label class="finish-label col-1" for="finish-month-year">
								By:</label>
							
							<div class="form-field-large col-2">
								<select name="finish-month-year" id="finish-month-select" class="finish-month-year-select ls-value" data-field="finish-month-select">
									<option value="Default" selected="selected">Month</option>
									<option value="1">Jan</option>
									<option value="2">Feb</option>
									<option value="3">Mar</option>
									<option value="4">Apr</option>
									<option value="5">May</option>
									<option value="6">Jun</option>
									<option value="7">Jul</option>
									<option value="8">Aug</option>
									<option value="9">Sep</option>
									<option value="10">Oct</option>
									<option value="11">Nov</option>
									<option value="12">Dec</option>
								</select> <!-- /.finish-month -->
		
								<select name="finish-month-year" id="finish-year-select" class="finish-month-year-select ls-value" data-field="finish-year-select">
									<option value="Default" selected="selected">Year</option>
									<?php
										$d = date('Y');
										for ($i = $d; $i<$d+20; $i++){
											echo '<option value="'.$i.'">'.$i.'</option>';
										}
									?>
								</select> <!-- /.finish-month -->
							</div> <!-- /.form-field-large-dollar /.col-2 -->
						</div> <!-- /.finish-wrap -->

					<div id="cys-interest-rate-group" class="save-by-date-split">
						<label class="int-rate-label col-1" for="cys-user-interest-rate">Interest Rate:</label>
						<div class="form-field-med-pct col-2">
							<input type="number" step="0.1" data-field="cys-user-interest-rate" value="0" class="ls-value instant-save int-rate-input col-2" id="cys-user-interest-rate"/>
							<span class="pct">%</span>
						</div>
					</div> <!-- /#cys-interest-rate-group -->

				</fieldset> <!-- /.save-by-date -->

				<!-- Save by month -->
					
				<fieldset id="save-by-month" class="pane form-field">
					
						<!-- Monthly Income Form -->
						<div class="monthly-income-group">
							<label class="monthly-savings-label">
							How Much Less to Spend:</label>
							<span class="dollar">$</span>
							<span class="time-tag">/ month</span>
							<input id="monthly-savings-input" type="number" placeholder="0" step="10" value="<?php echo cys_get_usermeta('cys_monthly_goal', ''); ?>">
						</div> <!-- /.monthly-income-group -->

						<!-- Annual Income Form -->
						<div class="annual-income-group">
							<label for="annual-income" class="time-tag">/ year</label>
							<span class="dollar">$</span>
							<input name="annual-income" type="number" id="goal-annual-input" step="100" value="0">
						</div> <!-- /.annual-income-group -->
						
				</fieldset> <!-- /.save-by-month -->
					
			</form> <!-- /.enter-goal-form -->


			<!-- Enter Goal: Summary --> 
			
			<p class="enter-goal-summary">
				<strong>To Reach Your Goal: </strong>
				Spend <span class="todo-target"><span class="dollar">$</span><span class="value goal"><?php echo cys_get_usermeta('cys_monthly_goal', '0'); ?></span></span> less each month
			</p> <!-- /.enter-goal-summary -->

			<footer class="enter-goal-footer">
				<div class="col">
					<?php
						echo '<a class="enter-goal-btn" href="'.get_next_slide_link().'">';
					?>
					
						Next
					<span class="arrow-right-large"></span></a>
				</div> <!-- /.col -->
			</footer> <!-- /.enter-goal-footer -->									

		</div> <!-- /.enter-goal-body -->
	</div> <!-- /.enter-goal-container -->		
</article> <!-- /.enter-goal-box -->
