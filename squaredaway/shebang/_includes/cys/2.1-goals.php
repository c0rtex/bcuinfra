<?php 	echo '<script type="text/javascript" src="'.get_bloginfo('template_url').'/js/calculators-control-your-spending.js"></script>' ?>


		<section class="frame-container" data-nav-section="step-2" data-nav-page="goals-page">

			<!-- ======================================== --> 
			<!-- ! Money in your pocket gets spent		  --> 
			<!-- ======================================== -->

			<article class="frame make-a-plan" data-nav="Make a Plan">
				<div class="frame-title-container">
					<p class="frame-title">Make a plan</p>
				</div>
				
				<?php
					$ii = 0;
					if (strlen(shebang_get_user_meta('cys_goal_name', '')) > 2){
						$ii = 1;
					}
				?>
				
				<hgroup class="frame-hgroup">
					<h1 class="frame-h1">How Much Will You Need?</h1>
					<h2 class="frame-h3">Start with a goal to help you stay on track. Then see how much you want to save.  </h2>
				</hgroup>

				<?php
					include($_SERVER['DOCUMENT_ROOT'].'/wp-content/themes/shebang/_includes/calculators/calc-using-savings-content.php');
				?>
			
			</article> <!-- /.make-a-plan -->

		</section> <!-- /.frame-container -->