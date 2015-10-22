<!-- ================================= --> 
	<!-- ! Start #main div container	   --> 
	<!-- ================================= -->

    <div id="main">
    	<header id="frame-menu">
			
			<div class="col-1">
				<div id="action-menu" class="action-menu">
	
					<!-- Dropdown Trigger: Activates Menu --> 
					<a class="action-dropdown dropdown-button dropdown-trigger clearfix"> 
						<h3 class="action-menu-action-h1">Action Plan <span class="action-item">&nbsp;</span></h3>
						<span class="circle-down-arrow-white"></span>
					</a> 
					
					<!-- Action Plan: Dropdown -->
					<ul class="action-list">
						<div class="y-scroll">
							<?php include('_includes/cys/action-menu-todos.php'); ?>	
						</div> <!-- y-scroll -->
					</ul> <!-- action-list -->
						
				</div> <!-- action-menu -->
			</div> <!-- /.col-1 -->
			

			<!-- Action Plan: Goal Menu -->

			<div class="col-2">
				<div id="savings-menu" class="savings-menu">

					<div class="savings-menu-text">
						<div class="col-1">
							<h3 class="action-menu-goal-h1" data-field="cys_monthly_goal">Goal</h3>
						</div> <!-- /.col-1 -->
						<div class="money-saved col-2">
							<span class="money-number">
								<span class="dollar">$</span><span class="value saved ls-value" data-field="cys_savings">0</span>
								
								<span class="ls-boolean-display" data-field="cys_monthly_goal">
									<span class="slash"> / </span>
									<span class="dollar">$</span>
									<span class="value goal ls-value round-to-1" data-field="cys_monthly_goal">0</span>
								</span>
								
							</span> <!-- money-number -->
						</div> <!-- /.col-2 money-saved -->
					</div> <!-- savings-menu-text -->
					
					<div class="money-bar">
						<div class="money-bar-leader"></div>
					</div> <!-- money-bar -->
				
				</div> <!-- savings-menu -->
			</div> <!-- /.col-2 -->
				
    	</header> <!-- frame-menu -->


		<!-- ================================= --> 
		<!-- ! Optimized Modal	   			   --> 
		<!-- ================================= -->
	
		<?php include('_includes/optimized-modal.php'); ?>	


    	<section id="session-data">
    		
    		<input type="hidden" id="uid" value="<?php echo $_COOKIE['uid'];?>" />
    	</section>
    	
    	<section class="frame-container section">
    	
    	<?php
    		echo shebang_get_json_payload('shebang_defaults');
    	?>