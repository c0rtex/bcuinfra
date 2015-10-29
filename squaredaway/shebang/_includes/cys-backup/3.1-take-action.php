<?php include('_includes/header.php'); ?>

		<section class="frame-container action-frame" data-nav-section="step-3" data-nav-page="action-page">

			<!-- ======================================== --> 
			<!-- ! Action Plan header					  --> 
			<!-- ======================================== -->
	
			<header class="action-header">
				<div class="action-header-group">
					<div class="col">
						<h1 class="action-h1">My Action Plan</h1>
					</div> <!-- /.col -->
					
					<div class="col">
						<div class="action-progress">
							<div class="action-prog-text">
								<div class="col">
									<p class="pct-complete">
										<span class="pct-complete-number">
											<span class="ls-value" data-field="cys_current_pct"></span>
										%</span> complete!
									</p>
								</div>
								<div class="col">
									<p class="next-step">Next step: Set up a reminder</p>
								</div>
							</div> <!-- /.action text -->
							<div class="action-prog-bar">
								<div class="action-prog-bar-leader"></div>
							</div>
						</div> <!-- /.action-progress -->
					</div> <!-- /.col -->
				</div> <!-- /.action-header-group -->
				
				<section class="action-explainer">
					<a class="action-close-btn"><span class="action-close-x"></span><span class="action-close-txt">Close</span></a>
					<h3 class="action-explainer-h1">Congratulations, you've made a plan to control your spending!</h3>
					<p class="action-explainer-h2">This page is a summary of your plan. Use it to help follow through on your goal by setting up e-mail reminders, checking off to dos, and <a class="todo-print-link" href="#">printing out your plan</a> so you can stay on task even when you're not online.</p>
				</section>
			</header> 
			
	
			<!-- ======================================== --> 
			<!-- ! Remind Me							  --> 
			<!-- ======================================== -->
	
			<section class="remind-container">
				<header class="col remind-header">
					<img src="_images/icon-reminder.png" class="remind-icon">
					<hgroup class="imageblock-content">
						<h2 class="action-h2">Remind me</h2>
						<p class="action-h2-sub">Stay on track with an e-mail reminder</p>
					</hgroup> <!-- /.imageblock-content -->
				</header> <!-- /.col -->
				
				<div class="col">
					<form class="remind-form">
						<fieldset class="remind-inputs">
							<div class="col">
								<label for="remind-time" class="remind-time-label">Remind me:</label>
								<select name="life-stage" id="remind-time-select" class="remind-time-select" data-selected="<?php echo cys_get_usermeta('cys_remind_freq');?>">
									
									<option value="daily">Daily</option>
									<option value="weekly" selected="selected">Weekly</option>
									<option value="monthly">Monthly</option>
								</select>
							</div> <!-- /.col 1 -->
							<div class="col">
								<label for="remind-email" class="remind-email-label">Email address:</label>
								<input name="remind-email" id="remind-email-input" class="remind-email-input" placeholder="Enter your email" value="<?php echo cys_get_usermeta('cys_remind_email'); ?>">
							</div> <!-- /.col 2 -->
							<div class="col">
								<a class="remind-button">Remind me!</a>
							</div> <!-- /.col 3 -->
						</fieldset> <!-- reminder-inputs -->
					</form> <!-- /.remind-form -->
					
					<div class="remind-complete-msg">
						<ul class="change-remind-btns">
							<h4 class="change-remind-label">Options</h4>
							<li><a href="#" class="change-remind-btn">Change settings</a></li>
							<li><a href="#" class="change-remind-btn cancel-remind-btn">Cancel reminder</a></li>
						</ul>

						<h4 class="remind-complete-h1">Your reminder is set!</h4>
						<p>We'll send a <a href="#" id="remind-time-output" class="change-remind-link">
							<?php echo cys_get_usermeta('cys_remind_freq'); ?>
						</a> reminder to <a href="#" id="remind-email-output" class="change-remind-link"><?php echo cys_get_usermeta('cys_remind_email'); ?></a> until you finish.</p>

					</div> <!-- /.reminder-complete-msg -->
					
				</div> <!-- /.col -->
			
			</section> <!-- /.remind-container -->
	
	
			<!-- ======================================== --> 
			<!-- ! To Dos								  --> 
			<!-- ======================================== -->
	
			<section class="todo-container">
	
				<header class="todo-header">
					<a href="#" class="todo-print-btn"><span class="printer-icon"></span>Print</a>
					<img src="_images/icon-todo.png" class="todo-icon">
					<hgroup class="imageblock-content">
						<h2 class="todo-h2">To Dos</h2>
						<p class="todo-h2-sub">Follow these steps to control your spending. Check each one off as you finish (or to remove it from your list).</p>
					</hgroup> <!-- imageblock-content -->
				</header> <!-- to do header -->
				
				<div class="todo-body">

					<!-- ======================================== --> 
					<!-- ! To Dos: Goal				  			  --> 
					<!-- ======================================== -->

				
					<article class="todo-goal todo-section">
						<div class="col">
							<h3 class="todo-goal-h1 ls-value" data-field="cys_goal_name"></h3>	
						</div> <!-- col -->

						<div class="col">						
							<a href="/planners/control-your-spending/start-with-a-goal" class="todo-change-goal-btn">Change your goal &raquo;</a>
						</div>
						
					</article>  

	
					<!-- ======================================== --> 
					<!-- ! To Dos: Move Your Money				  --> 
					<!-- ======================================== -->
	
					<article class="todo-move todo-section">
						<hgroup class="todo-hgroup">
							<h3 class="todo-h1">Move your money from spending to saving</h3>
							<a href="#" class="arrow-button-small">Help me do it</a>
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
										<input type="checkbox" name="take-money-out" value="Take $<?php
											echo cys_get_usermeta('cys_monthly_goal', 'money');
										?> out of your pocket" class="checkbox-input"></td>
									<td class="todo-type">
										<label for="take-money-out" class="checkbox-label">
										Take 
										
										<?php
											$ga = cys_get_usermeta('cys_monthly_goal', 'money');
											if ($ga == 'money'){
												echo $ga;
											} else {
												echo '<span class="todo-target"><span class="dollar">$</span>'.$ga.'</span>';
											}
										?> out of your pocket.</label></td>
								</tr>
								</tbody>
							</table> <!-- /.todo table -->
					</article> <!-- /.todo-move -->
	
	
					<!-- ======================================== --> 
					<!-- ! To Dos: Make Targeted Changes		  --> 
					<!-- ======================================== -->
					
					<article class="todo-changes todo-section">
	
						<hgroup class="todo-hgroup">
							<h3 class="todo-h1">Make your targeted changes to save
							<?php
								$ga = cys_get_usermeta('cys_savings', 'money');
								if ($ga == 'money'){
									echo $ga;
								} else {
									echo '<span class="todo-target"><span class="dollar">$</span>'.$ga.'</span>';
								}
							?>
							</h3>
						</hgroup>
	
					<table class="todo-table">
					
						<thead class="todo-table-head one-time-table-head">
							<tr>
								<th class="todo-type" colspan="2">One-time changes</th>
								<th class="todo-savings">Monthly savings</th>
								<th class="todo-link"></th>
							</tr>
						</thead>
	
						<tbody class="todo-table-body">
							
							</tbody>
						</table> <!-- todo table -->
	
					<table class="todo-table">
					
						<thead class="todo-table-head everyday-table-head">
							<tr>
								<th class="todo-type" colspan="2">Action</th>
								<th class="todo-savings">Monthly savings</th>
								<th class="todo-link"></th>
							</tr>
						</thead>
	
						<tbody class="todo-table-body">
							<?php
								$todos = cys_get_todos('everyday');
								$i = 0;
								
								foreach($todos as $td){
									$class = 'unchecked';
									if (strtolower($td->status) == 'checked'){
										$class = 'checked';
									}
									echo '<tr class="checkoff-todo row-'.$i.'">
								<td class="checkbox-container">
									<input type="checkbox" name="todo-'.$td->todo_id.'" id="todo-'.$td->todo_id.'" value="'.$td->name.'" class="checkbox-input" data-tdid="'.$td->todo_id.'"';
									if (strtolower($td->status) == 'checked'){
										echo ' checked ';
									}
									echo '></td>
								<td class="todo-type '.$class.'">
									<label for="todo-'.$td->todo_id.'" class="checkbox-label">
									'.$td->name.'</label></td>
								<td class="todo-savings"><span class="dollar">$</span>'.$td->amount.'</td>
								<td class="todo-link"><a href="#" class="link-text">Help me do it &raquo;</a></td>
							</tr>';
									$i++;
								}
							?>
							
							</tbody>
						</table> <!-- /.todo table -->
	
					</article> <!-- /.todo-changes -->
	
	
	
					<!-- ======================================== --> 
					<!-- ! To Dos: Goal-Related Tips	 	      --> 
					<!-- ======================================== -->
					<?php
						$goal = cys_get_usermeta('cys_goal_name');
						if (trim(strtolower($goal)) == 'goal: prepare for retirement'){
					?>
					<article class="todo-other todo-section">
						<h3 class="todo-h1">Other things to do</h3>
		
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
										Go to <a href="#" class="link-text">"Target Your Retirement"</a></label></td>
									<td class="todo-link">
										<a href="#" class="arrow-button-small">Help me do it</a></td>
								</tr>
								</tbody>
							</table> <!-- todo table -->
					</article> <!-- todo-move -->
					<?php
						}
					?>
				</div> <!-- /.todo body -->

			</section> <!-- todo-container -->

		</section> <!-- frame-container -->

			<!-- ======================================== --> 
			<!-- ! To Dos Footer	 	      			  --> 
			<!-- ======================================== -->
	
			<footer class="todo-footer">
				<div class="col">
					<a href="2.1-goals.php" class="todo-back-btn">&laquo; Review your plan</a>
				</div> <!-- /.col -->
	
				<div class="col">
					<a href="#" class="todo-print-btn"><span class="printer-icon"></span>Print</a>
				</div> <!-- /.col -->
			</footer>



		<!-- ================================= --> 
		<!-- ! Footer Nav					   --> 
		<!-- ================================= -->

		<footer class="footer-nav">
			
			<div class="col">
				<a class="footer-nav-button next" href="index.php">
					Back to dashboard
					<span class="arrow-right-large"></span></a>
			</div> <!-- /.col-1 -->

		</footer>

    </div> <!-- /.main -->

    
<?php include('_includes/footer.php'); ?>