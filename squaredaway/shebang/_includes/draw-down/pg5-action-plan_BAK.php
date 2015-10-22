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
			</div> <!-- /.col-2 -->
		</hgroup>
		
		<article class="action-explainer"> 
			<a class="action-close-btn"><span class="action-close-x"></span><span class="action-close-txt">Close</span></a> 
			<h3 class="action-explainer-h1">Welcome to your Action Plan!</h3> 
			<p class="action-explainer-h2">This page summarizes what you can do to reach your goals. Use it to help follow through by setting up e-mail reminders, checking off to-do items, and <a class="todo-print-link trigger-print" href="#">printing out your plan</a> so you can stay on task even when you're not online.</p> 
		</article> 

	</header> 
	

	<!-- ======================================== --> 
	<!-- ! Remind Me							  --> 
	<!-- ======================================== -->

	<div class="remind-container">
		<header class="col-1 remind-header">
			<img src="<?php echo get_template_directory_uri(); ?>/_images/icon-reminder.png" class="remind-icon">
			<hgroup class="imageblock-content">
				<h2 class="action-h2">Remind Me</h2>
				<p class="action-h2-sub">Stay on track with e-mail reminders</p>
			</hgroup> <!-- imageblock-content -->
		</header> <!-- /.col-1 -->
		
		<div class="col-2">
			<form class="remind-form">
				<fieldset class="remind-inputs">
					<div class="col-1">
						<label for="remind-time" class="remind-time-label">Remind Me:</label>
						<select name="life-stage" id="remind-time-select" class="remind-time-select ls-value instant-save" data-field="email-freq-draw-down">
							<option value="daily">Daily</option>
							<option value="weekly" selected="selected">Weekly</option>
							<option value="monthly">Monthly</option>
						</select>
					</div> <!-- /.col-1 -->
					<div class="col-2">
						<label for="remind-email" class="remind-email-label">E-mail Address:</label>
						<input name="remind-email" id="remind-email-input" class="remind-email-input ls-value instant-save" placeholder="Enter your email" data-field="remind-email-draw-down">
					</div> <!-- /.col-2 -->
					<div class="col-3">
						<a class="remind-button">Remind Me!</a>
					</div> <!-- /.col-3 -->
				</fieldset> <!-- reminder-inputs -->
			</form>

			<div class="remind-complete-msg">
				<hgroup class="remind-complete-hgroup">
					<h4 class="remind-complete-h1">Your reminder is set!</h4>
					<a href="#" class="change-remind-btn">Change settings</a>
				</hgroup>
				<p>We'll send a <a href="#" id="remind-time-output" class="change-remind-link ls-value" data-field="email-freq-draw-down">weekly</a> reminder to <a href="#" id="remind-email-output" class="change-remind-link ls-value" data-field="remind-email-draw-down"></a> until you finish</p>
			</div> <!-- reminder-complete-msg -->
		
		</div> <!-- /.col-2 -->
	
	</div> <!-- action-container -->


	<!-- ======================================== --> 
	<!-- ! To Dos								  --> 
	<!-- ======================================== -->

	<div class="todo-container">

		<header class="todo-header">
			<a href="#" class="todo-print-btn trigger-print"><span class="printer-icon"></span>Print</a>
			<img src="<?php echo get_template_directory_uri(); ?>/_images/icon-todo.png" class="todo-icon">
			<hgroup class="imageblock-content">
				<h2 class="todo-h2">To Dos</h2>
				<!-- <p class="todo-h2-sub">Follow these steps to control your spending. Check each one off as you finish.</p> -->
			</hgroup> <!-- imageblock-content -->
		</header> <!-- to do header -->
		
		<section class="todo-body">
		
		
		<!-- ========================================	--> 
			<!-- ! To Dos: How To Put Into Effect			--> 
			<!-- ========================================	-->

			<article class="todo-cys todo-section your-plan-section">
				<hgroup class="todo-hgroup">
					<h3 class="todo-h1">Your Plan</span></h3>
				</hgroup>

				<table class="todo-table">

					<thead class="todo-table-head">
						<tr>
							<th class="todo-type blank" colspan="2"></th>
							<th class="todo-link blank"></th>
						</tr>
					</thead>
				
					<tbody class="todo-table-body action-plan-your-plan-body">
						<tr class="checkoff-todo action-plan-pct-source">
							<td class="checkbox-container">
								<input type="checkbox" id="spend-less" name="spend-less" value="Plan How You Can Spend Less and Save More" class="checkbox-input"></td>
							<td class="todo-type">
								<label for="spend-less" class="checkbox-label">
								Put <span class="action-pct"></span> toward <span class="action-name"></span></label></td>
							<td class="todo-link">
								</td>
						</tr>
						
						
						
						</tbody>
					</table> <!-- /.todo table -->
			</article> <!-- /.todo-goal -->

		
		<!-- ========================================	--> 
			<!-- ! To Dos: How To Put Into Effect			--> 
			<!-- ========================================	-->

			<article class="todo-cys todo-section">
				<hgroup class="todo-hgroup">
					<h3 class="todo-h1">How to Put It Into Effect</span></h3>
				</hgroup>

				<table class="todo-table">

					<thead class="todo-table-head">
						<tr>
							<th class="todo-type blank" colspan="2"></th>
							<th class="todo-link blank"></th>
						</tr>
					</thead>
				
					<tbody class="todo-table-body">
						<!--var pct = shebangGetValue('drawdown_cut_pct');
		if (pct){
			var tr = $('.action-plan-pct-source').clone();
			tr.removeClass('action-plan-pct-source');
			tr.find('.checkbox-label').text('See how I could cut spending by ' + pct + '% in a pinch.');
			
			// 8% in a pinch
			tr.show();
			$('.action-plan-your-plan-body').append(tr);
		}-->
						<tr class="checkoff-todo row-1 ls-boolean-display" data-field="drawdown_cut_pct">
							<td class="checkbox-container">
								<input type="checkbox" id="spend-less" name="spend-less" value="Plan How You Can Spend Less and Save More" class="checkbox-input"></td>
							<td class="todo-type">
								<label for="spend-less" class="checkbox-label">See how I could cut spending by <span class="ls-value" data-field="drawdown_cut_pct"></span>% in a pinch</label></td>
							<td class="todo-link"><a href="/calculators/control-your-spending/" class="arrow-button-small">Do It &raquo;</a>
								</td>
						</tr>
						
						<tr class="checkoff-todo row-1">
							<td class="checkbox-container">
								<input type="checkbox" id="spend-less" name="spend-less" value="Plan How You Can Spend Less and Save More" class="checkbox-input"></td>
							<td class="todo-type">
								<label for="spend-less" class="checkbox-label">
								<?php echo get_editable_title(4686); ?></label></td>
							<td class="todo-link"><a href="/how-to/manage-your-savings-in-retirement/" class="arrow-button-small">Do It &raquo;</a>
								</td>
						</tr>
						
						<tr class="checkoff-todo row-1">
							<td class="checkbox-container">
								<input type="checkbox" id="spend-less" name="spend-less" value="Plan How You Can Spend Less and Save More" class="checkbox-input"></td>
							<td class="todo-type">
								<label for="spend-less" class="checkbox-label">
								Revisit This Calculator Next Year, as Things Change</label></td>
							<td class="todo-link"><a href="/calculators/savings-as-a-source-of-retirement-income/" class="arrow-button-small">Do It &raquo;</a>
								</td>
						</tr>
						
						
						</tbody>
					</table> <!-- /.todo table -->
			</article> <!-- /.todo-goal -->


			<!-- ========================================	--> 
			<!-- ! To Dos: Options							--> 
			<!-- ========================================	-->

			<article class="todo-cys todo-section" id="options-if-you-dont-have-enough">
				<hgroup class="todo-hgroup">
					<h3 class="todo-h1">Options If You Don't Have Enough</span></h3>
				</hgroup>

				<table class="todo-table">

					<thead class="todo-table-head">
						<tr>
							<th class="todo-type blank" colspan="2"></th>
							<th class="todo-link blank"></th>
						</tr>
					</thead>
				
					<tbody class="todo-table-body">
						<tr class="checkoff-todo row-1">
							<td class="checkbox-container">
								<input type="checkbox" id="spend-less" name="spend-less" value="See how downsizing could help" class="checkbox-input"></td>
							<td class="todo-type">
								<label for="spend-less" class="checkbox-label">
								See how downsizing could help</label></td>
							<td class="todo-link">
								<a href="/calculators/move-or-stay-put/" class="arrow-button-small">Do It &raquo;</a></td>
						</tr>
					
						<tr class="checkoff-todo row-2">
							<td class="checkbox-container">
								<input type="checkbox" id="spend-less" name="spend-less" value="Plan How You Can Spend Less and Save More" class="checkbox-input"></td>
							<td class="todo-type">
								<label for="spend-less" class="checkbox-label">
								Learn more about reverse mortgages</label></td>
							<td class="todo-link">
								<a href="/learn-more/reverse-mortgages/" class="arrow-button-small">Learn More &raquo;</a></td>
						</tr>
						
					

					<tr class="checkoff-todo row-3">
						<td class="checkbox-container">
							<input id="reverse-mortgages" type="checkbox" name="reverse-mortgages" value="Learn More About Reverse Mortgages" class="checkbox-input"></td>
						<td class="todo-type unchecked">
							<label for="reverse-mortgages" class="checkbox-label">
							Plan how you can spend less & save more</label></td>
						<td class="todo-link"><a href="/how-to/how-to-make-ends-meet/" class="arrow-button-small">Do It &raquo;</a></td>
					</tr>

				
						<tr class="checkoff-todo row-4">
							<td class="checkbox-container">
								<input id="employment-options" type="checkbox" name="employment-options" value="Look at Employment Options for Older Workers" class="checkbox-input"></td>
							<td class="todo-type">
								<label for="employment-options" class="checkbox-label">
								Look at Employment Strategies for Older Workers</label></td>
							<td class="todo-link">
								<a href="/learn-more/employment-options-for-older-workers/" class="arrow-button-small">Learn More <span class="arrow-small">&raquo;</span></a></td>
						</tr>
					
						<tr class="checkoff-todo row-5">
							<td class="checkbox-container">
								<input id="employment-options" type="checkbox" name="employment-options" value="Look at Employment Options for Older Workers" class="checkbox-input"></td>
							<td class="todo-type">
								<label for="employment-options" class="checkbox-label">
								Revisit Savings as a Source of Retirement Income</label></td>
							<td class="todo-link">
								<a href="/learn-more/employment-options-for-older-workers/" class="arrow-button-small">Do It <span class="arrow-small">&raquo;</span></a></td>
						</tr>
						
						
						</tbody>
					</table> <!-- /.todo table -->
			</article> <!-- /.todo-goal -->
			
		</section> <!-- /.todo-body -->

	</div> <!-- /.todo-container -->

</section> <!-- /.frame-container -->

	<!-- ======================================== --> 
	<!-- ! To Dos Footer	 	      			  --> 
	<!-- ======================================== -->

	<footer class="todo-footer">
		<div class="col-1">
			<a href="make-a-plan" class="todo-back-btn">&laquo; Review Your Plan</a>
		</div> <!-- /.col-1 -->

		<div class="col-2">
			<a href="#" class="todo-print-btn trigger-print"><span class="printer-icon"></span>Print</a>
		</div> <!-- /.col-2 -->
	</footer>

<script type="text/javascript" src="/wp-content/themes/shebang/js/action-plan.js"></script>
