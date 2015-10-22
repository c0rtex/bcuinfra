
		<section class="frame-container" data-nav-section="step-2" data-nav-page="goals-page" data-page-state="action-menu-on">

		<!-- ======================================== --> 
		<!-- ! Money in your pocket gets spent		  --> 
		<!-- ======================================== -->

			<article class="frame make-a-plan" data-nav="Make a Plan">
				<div class="frame-title-container">
					<p class="frame-title">Money in your pocket gets spent</p>
				</div>

				<hgroup class="frame-hgroup">
					<h1 class="frame-h1">To spend less, get the money out of your pocket. And keep it out.</h1>
				</hgroup>


				<!-- !Illustrations -->
	
				<div class="how-illo-group">
	
					<article class="col">
						<div class="how-illo"><img src="" class="how-illo-img"> Illustration</div>
						<h3 class="how-illo-text"><strong>Put the money where it's hard to get</strong> like a 401(k) or pay off credit card debt.</h3>
					</article>
					
					
					<article class="col">
						<div class="how-illo"><img src="" class="how-illo-img"> Illustration</div>
						<h3 class="how-illo-text"><strong>Don't cheat</strong> by running up a credit card balance to replace the money you "save."</h3>
					</article>
				</div> <!-- /.split-2 -->

					<h2 class="frame-h3">This is the key to controlling your spending. <span>Click below to add to your Action Plan</span> &mdash; where you'll find a list of things to help reach your goal.</h2>
				<!-- !Checkbox stage -->

				<div class="checkbox-stage add-todo">

					<!-- Note: Enter Your Info -->
					
					<div id="note-container" class="click-me-note">
						<div class="note-arrow"><span class="right"></span></div>
						<p>Click me!<p>
					</div> <!-- /.note -->

					<span class="checkbox-container">
						
						<?php
							$goal = cys_get_usermeta('cys_monthly_goal');
							$go = 'Take ';
							if ($goal){
								$go .= '<span class="todo-target"><span class="dollar">$</span>'.$goal.'</span>';
							} else {
								$go .= ' money ';
								$goal = 0;
							}
							$go .= ' out of your pocket.';
							echo '<input type="checkbox" name="take-money-out" value="'.strip_tags($go).'" class="checkbox-input" data-action-section="todo-move" data-todo-type="move" data-amount="0"><span><label for="take-money-out" class="checkbox-label todo-type">';
						 	echo $go;
						?>
						</label></td>

				</div> <!-- /.checkbox-stage -->

  			</article> <!-- /.frame make-a-plan -->
  
		</section> 