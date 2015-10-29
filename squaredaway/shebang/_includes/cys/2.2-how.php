
		<section class="frame-container" data-nav-section="step-2" data-nav-page="goals-page" data-page-state="action-menu-on">

		<!-- ======================================== --> 
		<!-- ! Money in your pocket gets spent		  --> 
		<!-- ======================================== -->

			<article class="frame make-a-plan" data-nav="Make a Plan">
				<div class="frame-title-container">
					<p class="frame-title">Money in your pocket gets spent</p>
				</div>

				<hgroup class="frame-hgroup">
					<h1 class="frame-h1">To Spend Less, 
						<?php
							$goal = shebang_get_user_meta('cys_monthly_goal', 0);
							$go = 'Take ';
							if ($goal){
								$go .= '<span class="big-money todo-target"><span class="dollar">$</span>'.$goal.'</span>';
							} else {
								$go .= ' the Money ';
								$goal = 0;
							}
							$go .= ' Out of Your Pocket.';
							
						 	echo $go;
						?>
					<br />And Keep It Out.</h1>
				</hgroup>


				<!-- !Illustrations -->
	
				<div class="how-illo-group">
	
					<article class="col-1">
						<div class="how-illo"><img src="<?php echo get_template_directory_uri(); ?>/_images/money-safe.png" class="how-illo-img"></div>
						<h3 class="how-illo-text"><strong>Put the money where it's hard to get</strong> like a 401(k) or pay off credit card debt.</h3>
					</article> <!-- /.col-1 -->
					
					
					<article class="col-2">
						<div class="how-illo"><img src="<?php echo get_template_directory_uri(); ?>/_images/money-cc-stack.png" class="how-illo-img"></div>
						<h3 class="how-illo-text"><strong>Don't cheat</strong> by running up a credit card balance to replace the money you "save."</h3>
					</article> <!-- /.col-2 -->
				</div> <!-- /.how-illo-group -->


  			</article> <!-- /.frame make-a-plan -->
  
		</section> 


	