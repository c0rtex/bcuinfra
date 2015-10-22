	<section class="frame-container action-frame" data-nav-section="step-3" data-nav-page="action-page">

			<!-- ======================================== --> 
			<!-- ! Action Plan header					  --> 
			<!-- ======================================== -->
	
			<header class="action-header">
				<hgroup class="action-header-group">
					<div class="col-1">
						<h1 class="action-h1">My Action Plan</h1>
					</div> <!-- /.col-1 -->
					
					<div class="col-2">
						<div class="action-progress">
							<div class="action-prog-text">
								<div class="col-1">
								<p class="pct-complete">
									<span class="pct-complete-number">
										<span class="ls-value" data-field="cys_current_pct">20</span>
									%</span> complete!</p></div>
								<div class="col-2">
								<p class="next-step"><span class="next-step-label">Next Step:</span> 
								<?php
									$nextStep = 'Make a Plan';
									$td = cys_get_todos('everyday');
									if (count($td)){
										$nextStep = 'Set Up a Reminder';
									}
									echo $nextStep;
								?></p></div>
							</div> <!-- /.action text -->
							<div class="action-prog-bar">
								<div class="action-prog-bar-leader"></div>
							</div>
						</div> <!-- /.action-progress -->
					</div> <!-- /.col-2 -->
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
	
			<section class="remind-container">
				<header class="col-1 remind-header">
					<img src="/wp-content/themes/shebang/_images/icon-reminder.png" class="remind-icon">
					<hgroup class="imageblock-content">
						<h2 class="action-h2">Remind Me</h2>
						<p class="action-h2-sub">Stay on track with e-mail reminders</p>
					</hgroup> <!-- /.imageblock-content -->
				</header> <!-- /.col-1 -->
				
				<div class="col-2">
					<form class="remind-form">
						<fieldset class="remind-inputs">
							<div class="col-1">
								<label for="remind-time" class="remind-time-label">Remind Me:</label>
								<select name="life-stage" id="remind-time-select" class="remind-time-select ls-value" data-field="cys_remind_freq">
									<option value="daily">Daily</option>
									<option value="weekly" selected="selected">Weekly</option>
									<option value="monthly">Monthly</option>
								</select>
							</div> <!-- /.col-1 -->
							<div class="col-2">
								<label for="remind-email" class="remind-email-label">E-mail Address:</label>
								<input name="remind-email" id="remind-email-input" class="remind-email-input ls-value" placeholder="Enter your e-mail" value="" data-field="cys_remind_email">
							</div> <!-- /.col-2 -->
							<div class="col-3">
								<a class="remind-button">Remind Me!</a>
							</div> <!-- /.col-3 -->
						</fieldset> <!-- reminder-inputs -->
					</form> <!-- /.remind-form -->
					
					<div class="remind-complete-msg">
						<hgroup class="remind-complete-hgroup">
							<h4 class="remind-complete-h1">Your Reminder is Set!</h4>
							<a href="#" class="change-remind-btn">Change Settings</a>
						</hgroup>

						<p>We'll send a 
							<a href="#" id="remind-time-output" class="change-remind-link ls-value" data-field="cys_remind_freq"></a> 
							reminder to <a href="#" id="remind-email-output" class="change-remind-link ls-value" data-field="cys_remind_email"></a> until you finish.</p>

					</div> <!-- /.reminder-complete-msg -->
					
				</div> <!-- /.col-2 -->
			
			</section> <!-- /.remind-container -->
	
			<!-- ======================================== --> 
			<!-- ! To Dos								  --> 
			<!-- ======================================== -->
	
			<section class="todo-container">
	
				<header class="todo-header">
					<a href="#" class="todo-print-btn"><span class="printer-icon"></span>Print</a>
					<img src="/wp-content/themes/shebang/_images/icon-todo.png" class="todo-icon">
					<hgroup class="imageblock-content">
						<h2 class="todo-h2">To Dos</h2>
						<p class="todo-h2-sub">Follow these steps to control your spending. Check each one off as you finish.</p>
					</hgroup> <!-- imageblock-content -->
				</header> <!-- to do header -->
				
				<section class="todo-body">

					<!-- ======================================== --> 
					<!-- ! To Dos: Goal				  			  --> 
					<!-- ======================================== -->

					<div class="ls-boolean-display" data-field="cys_goal_name">
						<article class="todo-goal todo-section">
							<div class="col-1">
								<h3 class="todo-goal-h1 ls-value" data-field="cys_goal_name"></h3>
								<span class="ls-boolean-display todo-goal-h1-sub" data-field="finish-year-select">
									by <span class="ls-value ls-boolean-display ls-format" data-format="num-to-month" data-field="finish-month-select"></span> <span class="ls-value no-commas" data-field="finish-year-select"></span>
								</span>	
							</div> <!-- /.col-1 -->

							<div class="col-2">						
								<a href="/planners/control-your-spending/start-with-a-goal/" class="todo-change-goal-btn">Change your goal &raquo;</a>
							</div> <!-- /.col-2 -->
						
						</article>
					</div>
					
					<!-- ======================================== --> 
					<!-- ! To Dos: Make Targeted Changes		  --> 
					<!-- ======================================== -->
					
					<article class="todo-links todo-section">
	
						<hgroup class="todo-hgroup">
							<h3 class="todo-h1">
								Put money aside for savings
							</h3>
						</hgroup>
	
						<table class="todo-table">
					
							<thead class="todo-table-head one-time-table-head">
								<tr>
									<th class="todo-type" colspan="2"></th>
									<th class="todo-link"></th>
								</tr>
							</thead>
	
							<tbody class="todo-table-body">
								<tr class="checkoff-todo row-0">
									<td class="checkbox-container">
										<input type="checkbox" name="todo-3167" id="todo-3167" value="Buy generic drugs" class="checkbox-input" data-id="3167" data-tdid="t8513"></td>
									<td class="todo-type unchecked">
										<label for="todo-3167" class="checkbox-label">Move Money from Spending to Savings</label>
										<p>Money in your pocket gets spent! So get what you want to save out of your pocket and into savings.</p>
									</td>
									<td class="todo-link">
										<!--<a href="#" class="link-text">Help me do it »</a>-->
									</td>
								</tr>
							</tbody>
						</table> <!-- /.todo table -->
	
						
					</article> <!-- /.todo-changes -->


					<!-- ======================================== --> 
					<!-- ! To Dos: Make Targeted Changes		  --> 
					<!-- ======================================== -->
					
					<article class="todo-changes todo-section">
	
						<hgroup class="todo-hgroup">
							<h3 class="todo-h1">Make your targeted changes to save
								<span class="dollar">$</span>
								<span class="ls-value" data-field="cys_savings">money</span>
							</h3>
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
							
								</tbody>
						</table> <!-- /.todo table -->
	
						<table class="todo-table">
					
							<thead class="todo-table-head everyday-table-head">
								<tr>
									<th class="todo-type" colspan="2">Action</th>
									<th class="todo-savings">Monthly savings</th>
									<th class="todo-link"></th>
								</tr>
							</thead>
	
							<tbody class="todo-table-body" id="cys-action-items">
						
							</tbody>
						</table> <!-- /.todo table -->
	
					</article> <!-- /.todo-changes -->
	
					
				</section> <!-- /.todo-body -->

			</section> <!-- /.todo-container -->

			<!-- ======================================== --> 
			<!-- ! To Dos Footer	 	      			  --> 
			<!-- ======================================== -->
	
			<footer class="todo-footer">
				<div class="col-1">
					<a href="/planners/control-your-spending/start-with-a-goal/" class="todo-back-btn">&laquo; Review Your Plan</a>
				</div> <!-- /.col-1 -->
	
				<div class="col-2">
					<a href="#" class="todo-print-btn"><span class="printer-icon"></span>Print</a>
				</div> <!-- /.col-2 -->
			</footer>

		</section> <!-- /.frame-container -->

    </div> <!-- /.main -->