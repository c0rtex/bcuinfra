		<section class="frame-container action-frame" data-nav-section="step-3" data-nav-page="action-page">

			<!-- ======================================== --> 
			<!-- ! Action Plan header					  --> 
			<!-- ======================================== -->
	
			<header class="action-header">
				<hgroup class="action-header-group">
					<div class="col">
						<h1 class="action-h1">My Action Plan</h1>
					</div> <!-- col -->
					
					<div class="col">
						<div class="action-progress">
							<div class="action-prog-text">
								<div class="col-1">
									<p class="pct-complete"><span class="pct-complete-number">50%</span> complete!</p>
								</div> <!-- /.col -->
								<div class="col-2">
									<p class="next-step"><span class="next-step-label">Next step:</span> Set up a reminder</p>
								</div> <!-- /.col -->
							</div> <!-- /.action-prog-text -->
							<div class="action-prog-bar">
								<div class="action-prog-bar-leader"></div>
							</div>
						</div> <!-- action-progress -->
					</div> <!-- col -->
				</hgroup>
				
				<article class="action-explainer"> 
					<a class="action-close-btn"><span class="action-close-x"></span><span class="action-close-txt">Close</span></a> 
					<h3 class="action-explainer-h1">Welcome to your Action Plan!</h3> 
					<p class="action-explainer-h2">This page summarizes what you can do to reach your goals. Use it to help follow through by setting up e-mail reminders, checking off to-do items, and <a class="todo-print-link" href="#">printing out your plan</a> so you can stay on task even when you're not online.</p> 
				</article> 
	
			</header> 
			
	
			<!-- ======================================== --> 
			<!-- ! Remind Me							  --> 
			<!-- ======================================== -->
	
			<div class="remind-container">
				<header class="col remind-header">
					<img src="<?php echo get_template_directory_uri(); ?>/_images/icon-reminder.png" class="remind-icon">
					<hgroup class="imageblock-content">
						<h2 class="action-h2">Remind Me</h2>
						<p class="action-h2-sub">Stay on track with e-mail reminders</p>
					</hgroup> <!-- imageblock-content -->
				</header> <!-- col -->
				
				<div class="col">
					<form class="remind-form">
						<fieldset class="remind-inputs">
							<div class="col">
								<label for="remind-time" class="remind-time-label">Remind Me:</label>
								<select name="life-stage" id="remind-time-select" class="remind-time-select">
									<option value="young adult">Daily</option>
									<option value="approaching retirement" selected="selected">Weekly</option>
									<option value="middle age">Monthly</option>
								</select>
							</div> <!-- col 1 -->
							<div class="col">
								<label for="remind-email" class="remind-email-label">E-mail Address:</label>
								<input name="remind-email" id="remind-email-input" class="remind-email-input" placeholder="Enter your email">
							</div> <!-- col 2 -->
							<div class="col">
								<a class="remind-button">Remind Me!</a>
							</div> <!-- col 3 -->
						</fieldset> <!-- reminder-inputs -->
					</form>

					<div class="remind-complete-msg">
						<hgroup class="remind-complete-hgroup">
							<h4 class="remind-complete-h1">Your reminder is set!</h4>
							<a href="#" class="change-remind-btn">Change settings</a>
						</hgroup>
						<p>We'll send a <a href="#" id="remind-time-output" class="change-remind-link">weekly</a> reminder to <a href="#" id="remind-email-output" class="change-remind-link">tito@upstatement.com</a> until you finish</p>
					</div> <!-- reminder-complete-msg -->
				
				</div> <!-- col -->
			
			</div> <!-- action-container -->
	
	
			<!-- ======================================== --> 
			<!-- ! To Dos								  --> 
			<!-- ======================================== -->
	
			<div class="todo-container">
	
				<header class="todo-header">
					<a href="#" class="todo-print-btn"><span class="printer-icon"></span>Print</a>
					<img src="<?php echo get_template_directory_uri(); ?>/_images/icon-todo.png" class="todo-icon">
					<hgroup class="imageblock-content">
						<h2 class="todo-h2">To Dos</h2>
						<p class="todo-h2-sub">Follow these steps to control your spending. Check each one off as you finish.</p>
					</hgroup> <!-- imageblock-content -->
				</header> <!-- to do header -->
				
				<section class="todo-body">
	
	
					<!-- ======================================== --> 
					<!-- ! To Dos: Move Your Money				  --> 
					<!-- ======================================== -->
	
					<article class="todo-move todo-section">
						<hgroup class="todo-hgroup">
							<h3 class="todo-h1">Move Your Money from Spending to Saving</h3>
						</hgroup>
		
						<table class="todo-table">
		
							<thead class="todo-table-head">
								<tr>
									<th class="blank" colspan="2"></th>
								</tr>
							</thead>
						
							<tbody class="todo-table-body">
								<tr class="checkoff-todo row-1">
									<td class="checkbox-container">
										<input type="checkbox" name="take-money-out" value="Take $250 out of your pocket" class="checkbox-input"></td>
									<td class="todo-type">
										<label for="take-money-out" class="checkbox-label">
										Take <span class="todo-target"><span class="dollar">$</span>250</span> out of your pocket.</label></td>
								</tr>
								</tbody>
							</table> <!-- todo table -->
					</article> <!-- todo-move -->
	
	
					<!-- ======================================== --> 
					<!-- ! To Dos: Make Targeted Changes		  --> 
					<!-- ======================================== -->
					
					<article class="todo-changes todo-section">
	
						<hgroup class="todo-hgroup">
							<a href="#" class="arrow-button-small">Help Me Do It <span class="arrow-small">&raquo;</span></a>
							<h3 class="todo-h1">Make Your Targeted Changes to Save <span class="todo-target"><span class="dollar">$</span>250</span></h3>
						</hgroup>
	
					<table class="todo-table">
					
						<thead class="todo-table-head one-time-table-head">
							<tr>
								<th class="todo-type" colspan="2">One-Time Changes</th>
								<th class="todo-savings">Monthly Savings</th>
								<th class="todo-link"></th>
							</tr>
						</thead>
	
						<tbody class="todo-table-body">
							<tr class="checkoff-todo row-1">
								<td class="checkbox-container">
									<input type="checkbox" name="downsize" value="Downsize your house" class="checkbox-input"></td>
								<td class="todo-type unchecked">
									<label for="downsize" class="checkbox-label">
									Downsize your house.</label></td>
								<td class="todo-savings"><span class="dollar">$</span>500</td>
								<td class="todo-link"><a href="#" class="link-text">Help Me Do It &raquo;</a></td>
							</tr>
	
							<tr class="checkoff-todo row-2">
								<td class="checkbox-container">
									<input type="checkbox" name="fsbo" value="Sell your house yourself." class="checkbox-input">
								<td class="todo-type checked">
									<label for="fsbo" class="checkbox-label">Sell your house yourself.</label></td>
								<td class="todo-savings"><span class="dollar">$</span>425</td>														<td class="todo-link"><a href="#" class="link-text">Help Me Do It &raquo;</a></td>
							</tr>
							</tbody>
						</table> <!-- todo table -->
	
					<table class="todo-table">
					
						<thead class="todo-table-head everyday-table-head">
							<tr>
								<th class="todo-type" colspan="2">Everyday Changes</th>
								<th class="todo-savings"></th>
								<th class="todo-link"></th>
							</tr>
						</thead>
	
						<tbody class="todo-table-body">
							<tr class="checkoff-todo row-1">
								<td class="checkbox-container">
									<input type="checkbox" name="tires" value="Keep tires inflated and engine tuned" class="checkbox-input"></td>
								<td class="todo-type unchecked">
									<label for="tires" class="checkbox-label">
									Keep tires inflated &amp; engine tuned.</label></td>
								<td class="todo-savings"><span class="dollar">$</span>50</td>
								<td class="todo-link"><a href="#" class="link-text">Help Me Do It &raquo;</a></td>
							</tr>
	
							<tr class="checkoff-todo row-2">
								<td class="checkbox-container">
									<input type="checkbox" name="eat-out" value="Eat out less frequently." class="checkbox-input">
								<td class="todo-type unchecked">
									<label for="eat-out" class="checkbox-label">Eat out less frequently.</label></td>
								<td class="todo-savings"><span class="dollar">$</span>100</td>														<td class="todo-link"><a href="#" class="link-text">Help Me Do It &raquo;</a></td>
							</tr>
	
							<tr class="checkoff-todo row-3">
								<td class="checkbox-container">
									<input type="checkbox" name="lattes" value="Skip the lattes, make coffee at home." class="checkbox-input">
								<td class="todo-type unchecked">
									<label for="lattes" class="checkbox-label">Skip the lattes, make coffee at home</label></td>
								<td class="todo-savings"><span class="dollar">$</span>25</td>														<td class="todo-link"><a href="#" class="link-text">Help Me Do It &raquo;</a></td>
							</tr>
							</tbody>
						</table> <!-- todo table -->
	
					</article> <!-- todo-changes -->
	
	
	
					<!-- ======================================== --> 
					<!-- ! To Dos: Goal-Related Tips	 	      --> 
					<!-- ======================================== -->
	
					<article class="todo-extras todo-section">
						<hgroup class="todo-hgroup">
							<h3 class="todo-h1">Plan for Retirement</h3>
						</hgroup>
		
						<table class="todo-table">
		
							<thead class="todo-table-head">
								<tr>
									<th class="blank" colspan="2"></th>
									<th class="todo-link blank"></th>
								</tr>
							</thead>
						
							<tbody class="todo-table-body">
								<tr class="row-1">
									<td class="checkbox-container">
										<input type="checkbox" name="target" value="Downsize your house" class="checkbox-input"></td>
									<td class="todo-type">
										<label for="target" class="checkbox-label">
										Go to "Target Your Retirement"</label></td>
									<td class="todo-link">
										<a href="#" class="arrow-button-small">Help Me Do It <span class="arrow-small">&raquo;</span></a></td>
								</tr>
								</tbody>
							</table> <!-- todo table -->
					</article> <!-- todo-goal -->
					
				</section> <!-- todo body -->

			</div> <!-- todo-container -->

		</section> <!-- frame-container -->

			<!-- ======================================== --> 
			<!-- ! To Dos Footer	 	      			  --> 
			<!-- ======================================== -->
	
			<footer class="todo-footer">
				<div class="col">
					<a href="target-calculator" class="todo-back-btn">&laquo; Review Your Plan</a>
				</div> <!-- col -->
	
				<div class="col">
					<a href="#" class="todo-print-btn"><span class="printer-icon"></span>Print</a>
				</div> <!-- col -->
			</footer>


