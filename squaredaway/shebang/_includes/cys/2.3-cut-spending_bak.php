<?php 	echo '<script type="text/javascript" src="'.get_bloginfo('template_url').'/js/jquery.numeric.js"></script>' ?>
<?php 	echo '<script type="text/javascript" src="'.get_bloginfo('template_url').'/js/calculators-control-your-spending-where-people-spend-2.js"></script>' ?>

		<!-- ================================= --> 
		<!-- ! Cut Your Spending Module		   --> 
		<!-- ================================= -->


			<article class="frame cut-your-spending-interactive">
	
				<div class="col-1">
			
					<!-- ================================= --> 
					<!-- ! Cut Spending Tabs			   --> 
					<!-- ================================= -->					
	
					<ul id="spending-cat-tabs" class="spending-cat-tabs">
	
						<li class="spending-cat-tab" id="sct-all">
							<a href="#all">
							<input class="radio-btn" type="radio" name="category" value="all" /> 
							<label class="filter-label" for="all">
								All</label></a></li>
						<?php
							$sections = cys_get_spending_sections();
							//print_r($sections);
							foreach($sections as $section){
								echo '<h3 class="spending-cat-tab-label">'.$section->name.'</h3>';
								foreach($section->children as $cat){
									echo '<li class="spending-cat-tab" id="sct-'.$cat->slug.'">';
									echo '<a href="#'.$cat->slug.'">';
									echo '<input class="radio-btn" type="radio" name="category" value="'.$cat->slug.'" />';
									echo '<label class="filter-label" for="'.$cat->slug.'">';
									echo '<img class="spending-cat-tab-icon" src="'.get_bloginfo('stylesheet_directory').'/_images/icon-'.$cat->slug.'-25x25.png" />';
									echo $cat->name.'</label></a></li>';
								}
							}
							
						?>

		
					</ul> <!-- /.spending-cat-tabs -->
				</div> <!-- /.col-1 -->



			<!-- ======================================== --> 
			<!-- ! Cut Spending: Categories/Panes		  --> 
			<!-- ======================================== -->

			<div class="col-2">
			
				<!-- Spending Cats: Categories -->
	
				<div id="spending-cats" class="spending-cats">
					
					<header class="spending-cats-header">
						<div class="spending-cats-table-header">
							<p class="col-1">Action</p>
							<p class="col-2">Monthly savings</p>
						</div> <!-- /.table-header -->
					</header>


					<div id="spending-cat-all" class="pane">


					<!-- ================================= --> 
					<!-- ! Income/Life Stage form		   --> 
					<!-- ================================= -->
			
						<form id="cex-age-income-form">
			
							<div class="col-1">
								<!-- Annual Income Form -->
								<fieldset id="cex-income" class="annual-income-group form-field-med-dollar">
									<label for="annual-income" class="cex-annual-label">Annual Household Income</label>
									<span class="dollar-annual">$</span>
									<input name="annual-income" type="text" data-field="annual_income" id="cex-annual-input" value="70,000" class="ls-value">
								</fieldset>
							</div> <!-- /.col-1 -->
			
							<div class="col-2">

								<!-- Life Stage Form -->
								<fieldset id="cex-life-stage" class="life-stage-group">
									<label for="life-stage" class="cex-life-stage-label">Life Stage</label>
									<select name="life-stage" id="cex-life-stage-select" class="ls-value" data-field="cys-life-stage">
										<option value="young adult">New Worker</option>
										<option value="middle age">Mid-Career</option>
										<option value="approaching retirement" selected="selected">Approaching Retirement</option>
										<option value="retired">Retired</option>
									</select>
								</fieldset>
							</div> <!-- /.col-2 -->
			
							<div class="col-3">
								<p class="cex-form-intro">Enter your own information to get more accurate estimates</p>
							</div> <!-- /.col-3 -->
	
							<!-- !Enter Estimate Note -->
			
							<div id="note-container" class="enter-estimate-note">
								<p>Replace our estimate with your own!</p>
								<div class="note-arrow"><span class="right"></span></div>
							</div> <!-- /.note-1 -->
	
						</form>
						<div id="note-container" class="note-advanced note-cys-cuts"><p>Enter your own amounts for more accurate calulations</p><div class="note-arrow"><span class="right"></span></div></div>
							<!-- ================================= --> 
							<!-- ! Bigs Savings: List			   --> 
							<!-- ================================= -->
							<?php
								$sections = cys_get_spending_sections();
								foreach($sections as $section){
									//print_r($section);
									echo '<hgroup class="spending-cat-hgroup">';
									echo '<h3 class="spending-cat-label">'.$section->name.'</h3>';
									echo '<h4 class="spending-cat-sub">'.$section->description.'</h4>';
									echo '</hgroup> <!-- /.spending-cat-hgroup -->';
									foreach($section->children as $child){
										echo '<!-- Category: '.$child->name.' -->';
										echo '<div class="spending-cat-box small-cat type-style spending-cat-preview" id="sc-'.$child->slug.'">';
										echo '<header class="spending-cat-header"><div class="spending-cat-savings"><h5>Save</h5><div class="spending-cat-number"><span class="dollar">$</span>40-500</div></div> <!-- /.spending-cat-savings -->';
	
										echo '<h3 class="spending-cat-h1"><a href="#'.$child->slug.'" class="more-link">';
										echo '<img class="spending-cat-icon" src="'. get_bloginfo('stylesheet_directory').'/_images/icon-'.$child->slug.'-25x25.png" />'.$child->name.'</a></h3></header>';
										
										echo cys_get_tips($child->term_id);
				
										echo '<a href="#'.$child->slug.'" class="spending-cat-more"><span class="spending-cat-more-text">More</span></a>';
										echo '</div> <!-- /.spending-box -->';
									}
								}
							?>
						
								<?php include('_tips/spending-cats-footer.php'); ?>							
						</div> <!-- /#spending-cat-all -->

				

				<!-- ================================= --> 
				<!-- ! Panes		   	   			   --> 
				<!-- ================================= -->
				
				<?php
					
					$sections = cys_get_spending_sections();
					foreach($sections as $section){
						foreach($section->children as $child){
							echo "<!-- Category: ".$child->name." Pane -->\n";
							echo '<div id="spending-cat-'.$child->slug.'" class="pane">';
		
							echo '<div class="spending-cat-box small-cat type-style spending-cat-preview" id="sc-'.$child->slug.'">';
							echo '<header class="spending-cat-header"><div class="spending-cat-savings"><h5>Save</h5><div class="spending-cat-number"><span class="dollar">$</span>40-500</div></div> <!-- /.spending-cat-savings -->';

							
							echo '<h3 class="spending-cat-h1"><a href="#'.$child->slug.'"><img class="spending-cat-icon" src="'.get_bloginfo('stylesheet_directory').'/_images/icon-'.$child->slug.'-25x25.png" />'.$child->name.'</a></h3></header>';
						
							echo cys_get_tips($child->term_id);
					
							echo '<a href="#all" class="spending-cat-back"><span class="spending-cat-back-text">Back to list</span></a>';
							
							include('_tips/spending-cats-footer.php');					
							
							echo '</div> <!-- /.spending-box --></div> <!-- /#spending-cat-big -->';
					
						}
					}

				?>


				</div> <!-- /.spending-cats -->

				<div class="footnote">
					<p>Potential savings based on the U.S. Department of Labor 2009 Consumer Expenditure Survey and informal estimates.</p>
				</div>

			</div> <!-- /.col-2 -->

		</article> <!-- /.cut your spending interactive -->

		<div id="spending-modal" class="modal">
			<h3 class="modal-header">Nice work!</h3>
			<p class="modal-msg">It looks like you've found enough savings to reach your goal. Now go ahead to your Action Plan &mdash; or keep finding more ways to save.</p>
			<ul class="modal-next-btns">
				<li class="col-1">
					<?php
						echo '<a class="spending-modal-next-btn modal-next-btn" href="'.get_next_slide_link().'">
				Take Action <span class="next-arrow">&rsaquo;</span></a>';
					?>
				</li> <!-- /.col-1 -->
				<li class="col-2"><a class="spending-modal-back-btn  modal-back-btn close-modal">Keep Cutting</a></li>
			</ul>
		</div> <!-- /.cut-spending-modal -->


	</section> <!-- /.frame-container -->