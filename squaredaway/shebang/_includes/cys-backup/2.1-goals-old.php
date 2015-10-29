<?php
	include('2.1-goals-slide-test.php');
	return;
?>

<?php include('_includes/header.php'); ?>

		<section class="frame-container" data-nav-section="step-2" data-nav-page="goals-page">

			<!-- ======================================== --> 
			<!-- ! Money in your pocket gets spent		  --> 
			<!-- ======================================== -->

			<article class="frame make-a-plan" data-nav="Make a Plan">
				<div class="frame-title-container">
					<p class="frame-title">Make a plan</p>
				</div>
				
				<div class="scrollable goals-scrollable">
				<div class="items">

					<!-- ======================================== --> 
					<!-- ! Choose a Goal						  --> 
					<!-- ======================================== -->

					<div class="scrollable-item">
				
						<hgroup class="frame-hgroup">
							<h1 class="frame-h1">Start with a goal</h1>
							<h2 class="frame-h3">Why do you want to control your spending ...</h2>
						</hgroup>
	
							<article class="choose-goal-container">
			
								<ul class="choose-goal">
			
									<li class="col">
										<div class="goal-box" id="goal-debt" data-target="enter-goal-solid" data-prompt="Goal: Get out of debt">
											<img class="goal-image" src="#">
											<h3 class="goal-title">Get out of debt</h3>
										</div> <!-- goal-box -->
									</li> <!-- ./col -->
									<li class="col">
										<div class="goal-box" id="goal-retirement" data-target="enter-goal-solid" data-prompt="Goal: Prepare for retirement">
											<img class="goal-image" src="#">
											<h3 class="goal-title">Prepare for retirement</h3>
										</div> <!-- goal-box -->
									</li> <!-- ./col -->
									<li class="col">
										<div class="goal-box" id="goal-big" data-target="enter-goal-select">
											<img class="goal-image" src="#">
											<h3 class="goal-title">Get a big ticket item</h3>
										</div> <!-- goal-box -->
									</li> <!-- ./col -->
									<li class="col">
										<div class="goal-box" id="goal-reserve" data-target="enter-goal-solid" data-prompt="Goal: Build a reserve">
											<img class="goal-image" src="#">
											<h3 class="goal-title">Build a reserve</h3>
										</div> <!-- goal-box -->
									</li> <!-- ./col -->
									<li class="col">
										<div class="goal-box" id="goal-education" data-target="enter-goal-solid" data-prompt="Goal: Save for college">
											<img class="goal-image" src="#">
											<h3 class="goal-title">Save for college</h3>
										</div> <!-- goal-box -->
									</li> <!-- ./col -->
									<li class="col">
										<div class="goal-box" id="goal-trip" data-target="enter-goal-solid" data-prompt="Goal: Take a trip">
											<img class="goal-image" src="#">
											<h3 class="goal-title">Take a trip</h3>
										</div> <!-- goal-box -->
									</li> <!-- ./col -->
									<li class="col">
										<div class="goal-box" id="goal-lifestyle" data-target="enter-goal-solid" data-prompt="Goal: Live a sustainable lifestyle">
											<img class="goal-image" src="#">
											<h3 class="goal-title">Live a sustainable lifestyle</h3>
										</div> <!-- goal-box -->
									</li> <!-- ./col -->
									<li class="col">
										<div class="goal-box" id="goal-home" data-target="enter-goal-solid" data-prompt="Goal: Buy a home">
											<img class="goal-image" src="#">
											<h3 class="goal-title">Buy a home</h3>
										</div> <!-- goal-box -->
									</li> <!-- ./col -->
									<li class="col">
										<div class="goal-box" id="goal-custom" data-target="enter-goal-custom">
											<img class="goal-image" src="#">
											<h3 class="goal-title">Custom goal</h3>
										</div> <!-- goal-box -->
									</li> <!-- ./col -->
				
								</ul> <!-- choose-goal -->
							</article> <!-- choose-goal-container -->
						</div> <!-- scrollable-item -->
		
		
						<!-- ======================================== --> 
						<!-- ! Enter a Goal				 			  --> 
						<!-- ======================================== -->
						
						<div class="scrollable-item">

							<hgroup class="frame-hgroup">
								<h1 class="frame-h1">How much will you need?</h1>
							</hgroup>
		
							<article class="enter-goal-container">
	
								<!-- Enter Goal: Header -->
	
								<header class="enter-goal-header">
									<div class="col">
										<h3 class="enter-goal-h1" data-goal="For Your Retirement" id="enter-goal-solid">Goal:</h3>
										<h3 class="enter-goal-h1" data-goal="For Your Big Ticket Item" id="enter-goal-select">
											<form id="big-ticket-form">
												<label for="Big ticket select" class="big-ticket-label-prefix" >
													Goal: </label>
													<select name="Big ticket select" id="big-ticket-select" class="finish-month-year-select">
														<option value="Default" selected="selected">Get a Big Ticket Item</option>
														<option value="House">Buy a House</option>
														<option value="Car">Buy a Car</option>
														<option value="Trip">Take a Trip</option>
														<option value="Home improvement">Improve Home</option>
														<option value="custom">Enter Your Own</option>
													</select> <!-- big-ticket-select -->
											</form>
											</h3>
											
										<h3 class="enter-goal-h1" data-goal="Big Ticket Item" id="enter-goal-custom">
											<form id="custom-goal-form">
												<label for="Big ticket input" class="big-ticket-label-prefix">
												Goal: </label>
												<input id="big-ticket-input" name="Big ticket input" type="text" placeholder="Enter goal" value="<?php echo cys_get_usermeta('cys_custom_goal', ''); ?>">
											</form>
											</h3>
			
										<h3 class="enter-goal-h1" data-goal="custom">
											<form id="custom-goal-form">
												<label for="custom goal input" class="custom-label-prefix">
												Goal: </label>
												<input id="custom-goal-input" name="custom goal input" type="text" placeholder="Enter your goal" value="<?php echo cys_get_usermeta('cys_custom_goal', ''); ?>">
											</form>
											</h3>
										</div> <!-- ./col -->
										
									<div class="col">
										<a class="change-goal-link">Change goal &raquo;</a>
									</div> <!-- /.col -->
			
								</header>
								
								<div class="enter-goal-body">
	
									<!-- Enter Goal: Bar --> 
									
									<div class="enter-goal-bar-stage">
										<div class="enter-goal-bar-text">
											<div class="col">
												<h3 class="enter-goal-bar-title">How much less you'll spend:</h3>
											</div> <!-- ./col -->
											<div class="enter-goal-bar-saved col">
												<span class="enter-goal-number">
													<span class="dollar">$</span><span class="value saved"><?php
														echo cys_get_usermeta('cys_monthly_goal', 0);
													?></span>
												</span> <!-- money-number -->
												<span class="enter-goal-bar-month"> / month</span>
											</div> <!-- enter-goal-bar-saved -->
										</div> <!-- enter-goal-bar-text -->
								
												<div class="enter-goal-bar tip-trigger">
														<div class="enter-goal-bar-leader"></div>
												<div class="tooltip">In a moment, we'll help you find ways to cut your spending. As you find ways to save, this bar will move closer to your goal.</div>
												</div> <!-- enter-goal-bar -->
							
									</div> <!-- enter-goal-bar-stage -->
	
									<!-- Enter Goal: Form -->
									
									<form id="enter-goal-form" class="enter-goal-form">
										
										<!-- Save by date -->
										<div class="col">
										
											<fieldset id="save-by-date" class="active">
												<h3 class="date-label">By a specific date:</h3>
	
												<div class="form-field">
													<label class="finish-label" for="finish-month-year">
														When would you like to finish?</label>
													<select name="finish-month-year" id="finish-month-select" class="finish-month-year-select">
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
													</select> <!-- finish-month -->
				
													<select name="finish-month-year" id="finish-year-select" class="finish-month-year-select">
														<option value="Default" selected="selected">Year</option>
														<option value="2011">2011</option>
														<option value="2012">2012</option>
														<option value="2013">2013</option>
														<option value="2014">2014</option>
														<option value="2015">2015</option>
														<option value="2016">2016</option>
														<option value="2017">2017</option>
														<option value="2018">2018</option>
														<option value="2019">2019</option>
														<option value="2020">2020</option>
														<option value="2021">2021</option>
														<option value="2022">2022</option>
														<option value="2023">2023</option>
														<option value="2024">2024</option>
														<option value="2025">2025</option>
														<option value="2026">2026</option>
														<option value="2027">2027</option>
														<option value="2028">2028</option>
														<option value="2029">2029</option>
														<option value="2030">2030</option>
													</select> <!-- finish-month -->
												</div> <!-- form-field -->
	
												<div class="form-field">
													<label class="overall-savings-label" for="overall-savings-input">
														How much to save overall:</label>
													<span class="dollar-overall">$</span>
													<input id="overall-savings-input" name="overall-savings-input" type="text" placeholder="0">
												</div> <!-- form-field -->
			
											</fieldset>
										</div> <!-- ./col -->
			
										<!-- Save by month -->
										<div class="col">
											
											<fieldset id="save-by-month">
												<h3 class="date-label">By month:</h3>
	
												<div class="form-field">
													<div class="tip-trigger">
														<label class="monthly-savings-label">
															How much to save each month:</label>
														<div class="tooltip">If your monthly goal feels too high, change it to something more manageable &mdash; just remember that it will take you longer to reach your goal.</div>
													</div> <!-- tip-trigger -->
													<span class="dollar-overall">$</span>
													<input id="monthly-savings-input" type="text" placeholder="0" value="<?php echo cys_get_usermeta('cys_monthly_goal', ''); ?>">
												</div> <!-- form-field -->
											</fieldset>
											
										</div> <!-- ./col -->
										
									</form> <!-- enter-goal-form -->

									<footer class="enter-goal-footer">
										<div class="col">
											<a class="enter-goal-btn" href="2.2-how.php">
												Finished
											<span class="arrow-right-large"></span></a>
										</div> <!-- /.col -->
									</footer> <!-- /.enter-goal-footer -->									
									
									<!-- Enter Goal: Tips -->
									
	<!--
									<article class="goal-tips-group">
										<h3 class="goal-tips-h1">Tips</h3>						
										<p class="goal-tips-text">A note or something about retirement planning and perhaps a suggestion on where to find out more or we'll tell people, "We can help you plan more thoroughly later, but for now, let's get the money out." Or something. Or whatever. OK?</p>
									</article>
	-->
			
								
								</div> <!-- /.choose-goal-body -->
			
							</article> <!-- /.choose-goal-container -->
						</div> <!-- / .scrollable-item -->
				</div><!-- /.items -->
			</div><!-- /.scrollable -->
		</article> <!-- /.make a plan -->

		</section> <!-- /.frame-container -->


		<!-- ================================= --> 
		<!-- ! Footer Nav					   --> 
		<!-- ================================= -->

		<footer class="footer-nav">
			
			<div class="col-1">
				<a class="footer-nav-button next" href="2.2-how.php">
					How to do it
					<span class="arrow-right-large"></span></a>
			</div> <!-- /.col-1 -->

			<div class="col-2">
				<a class="footer-nav-button prev" href="1.1-spending.php">
					<span class="arrow-left-large"></span>
					Where the money goes</a>
			</div> <!-- /.col-2 -->

			<div class="footer-page-count">
				<span class="page-count-current">4</span> of <span class="page-count-total">6</span>
			</div>

		</footer>

		<a href="2.2-how.php" class="footer-next-msg">Next, we'll show you how to follow through and reach your goal</a>
		
	</div> <!-- /.main -->

<?php include('_includes/footer.php'); ?>