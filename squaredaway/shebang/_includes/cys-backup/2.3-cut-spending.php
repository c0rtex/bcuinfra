<?php include('_includes/header.php'); 
		include('_includes/load-todos.php'); 
?>
		
		<section class="frame-container section" data-nav-section="step-2" data-nav-page="cut-spending-page" data-page-state="action-menu-on">

		<!-- ================================= --> 
		<!-- ! Cut Your Spending			   --> 
		<!-- ================================= -->

			<article class="frame cut-your-spending-text" data-nav="Cut Your Spending">
				<div class="frame-title-container">
					<p class="frame-title">Find savings</p>
				</div>

				<hgroup class="frame-hgroup">
					<h1 class="frame-h1">Here are some things you could cut</h1>
					<h2 class="frame-h3">Check off items to add them to your plan. When you think you&rsquo;re set, <a href="3.1-take-action.php">move ahead to your Action Plan</a>.</h2>
				</hgroup>
			
			</article>


		<!-- ================================= --> 
		<!-- ! Cut Your Spending Module		   --> 
		<!-- ================================= -->


		<article class="frame cut-your-spending-interactive">

			<div class="col">
		
				<!-- ================================= --> 
				<!-- ! Cut Spending Tabs			   --> 
				<!-- ================================= -->					

				<ul id="spending-cat-tabs" class="spending-cat-tabs">

					<h3 class="spending-cat-tab-label">Filters</h3>
	
					<li class="spending-cat-tab" id="sct-all">
						<a href="#all">
						<input class="radio-btn" type="radio" name="category" value="all" /> 
						<label class="filter-label" for="all">
							All</label></a></li>

					<li class="spending-cat-tab" id="sct-popular">
						<a href="#popular">
						<input class="radio-btn" type="radio" name="category" value="popular" /> 
						<label class="filter-label" for="big">
						<img class="spending-cat-tab-icon" src="_images/icon-popular-25x25.png" />
							Most Popular</label></a></li>

					<li class="spending-cat-tab" id="sct-big">
						<a href="#big">
						<input class="radio-btn" type="radio" name="category" value="big" />
						<label class="filter-label" for="big">
						<img class="spending-cat-tab-icon" src="_images/icon-big-25x25.png" />
							Big Savings</label></a></li>


					<h3 class="spending-cat-tab-label">Categories</h3>

					<li class="spending-cat-tab" id="sct-clothing">
						<a href="#clothing">
						<input class="radio-btn" type="radio" name="category" value="clothing" />
						<label class="filter-label" for="big">
						<img class="spending-cat-tab-icon" src="_images/icon-apparel-25x25.png" />	
							Clothing</label></a></li>

					<li class="spending-cat-tab" id="sct-entertainment">
						<a href="#entertainment">
						<input class="radio-btn" type="radio" name="category" value="entertainment" />
						<label class="filter-label" for="entertainment">
						<img class="spending-cat-tab-icon" src="_images/icon-entertainment-25x25.png" />
							Entertainment</label></a></li>

					<li class="spending-cat-tab" id="sct-groceries">
						<a href="#groceries">
						<input class="radio-btn" type="radio" name="category" value="groceries" />
						<label class="filter-label" for="groceries">
						<img class="spending-cat-tab-icon" src="_images/icon-groceries-25x25.png" />
							Groceries</label></a></li>

					<li class="spending-cat-tab" id="sct-health-care">
						<a href="#health-care">
						<input class="radio-btn" type="radio" name="category" value="health-care" />
						<label class="filter-label" for="health-care">
						<img class="spending-cat-tab-icon" src="_images/icon-health-care-25x25.png" />
							Health Care</label></a></li>
					
					<li class="spending-cat-tab" id="sct-transportation">
						<a href="#transportation">
						<input class="radio-btn" type="radio" name="category" value="transportation" />
						<label class="filter-label" for="transportation">
						<img class="spending-cat-tab-icon" src="_images/icon-transport-25x25.png" />
							Transportation</label></a></li>
	
					<li class="spending-cat-tab" id="sct-utilities">
						<a href="#utilities">
						<input class="radio-btn" type="radio" name="category" value="utilities" />
						<label class="filter-label" for="utilities">
						<img class="spending-cat-tab-icon" src="_images/icon-utilities-25x25.png" /> 
							Utilities</label></a></li>

					<h3 class="spending-cat-tab-label">Lifestyles</h3>

					<li class="spending-cat-tab" id="sct-diy">
						<a href="#diy">
						<input class="radio-btn" type="radio" name="category" value="do-it-yourself" />
						<label class="filter-label" for="do-it-yourself">
						<img class="spending-cat-tab-icon" src="_images/icon-diy-25x25.png" />
							Do It Yourself</label></a></li>
	
					<li class="spending-cat-tab" id="sct-green">
						<a href="#green">
						<input class="radio-btn" type="radio" name="category" value="green-living" />
						<label class="filter-label" for="green">
						<img class="spending-cat-tab-icon" src="_images/icon-green-25x25.png" />	
							Green</label></a></li>
						
					<li class="spending-cat-tab" id="sct-healthy-habits">
						<a href="#healthy-habits">
						<input class="radio-btn" type="radio" name="category" value="healthy-habits" />
						<label class="filter-label" for="healthy-habits">
						<img class="spending-cat-tab-icon" src="_images/icon-healthy-25x25.png" />
							Healthy Habits</label></a></li>
							
					<li class="spending-cat-tab" id="sct-tech">
						<a href="#tech">
						<input class="radio-btn" type="radio" name="category" value="hyper-tech" />
						<label class="filter-label" for="tech">
						<img class="spending-cat-tab-icon" src="_images/icon-tech-25x25.png" />
							Hyper-Tech</label></a></li>
														
					<li class="spending-cat-tab" id="sct-retro">
						<a href="#retro">
						<input class="radio-btn" type="radio" name="category" value="retro" /> 
						<label class="filter-label" for="lifestyle">
						<img class="spending-cat-tab-icon" src="_images/icon-retro-25x25.png" />
							Retro</label></a></li>
						
					<li class="spending-cat-tab" id="sct-smart">
						<a href="smart">
						<input class="radio-btn" type="radio" name="category" value="smart-spender" />
						<label class="filter-label" for="lifestyle">
						<img class="spending-cat-tab-icon" src="_images/icon-smart-25x25.png" />
							Smart Spender</label></a></li>
	
				</ul> <!-- /.spending-cat-tabs -->
			</div> <!-- /.col-1 -->



			<!-- ======================================== --> 
			<!-- ! Cut Spending: Categories/Panes		  --> 
			<!-- ======================================== -->

			<div class="col">
			
				<!-- Spending Cats: Categories -->
	
				<div id="spending-cats" class="spending-cats">
					
					<header class="spending-cats-header">
						<div class="spending-cats-table-header">
							<p class="col">Action</p>
							<p class="col">Monthly savings</p>
						</div> <!-- /.table-header -->

					<!-- !Enter Estimate Note -->
	
					<div id="note-container" class="enter-estimate-note">
						<p>Enter your own estimates</p>
						<div class="note-arrow"><span class="left-down"></span></div>
					</div> <!-- /.note-1 -->

					</header>

					<div id="spending-cat-all" class="pane">

						<h3 class="spending-cat-label">Filters</h3>
					
						<!-- Category: Most Popular-->
	
						<div class="spending-cat-box small-cat type-style spending-cat-preview" id="sc-popular">
							<header class="spending-cat-header">
								<div class="spending-cat-savings">
									<h5>Save</h5>
									<div class="spending-cat-number"><span class="dollar">$</span>1-150</div>
								</div> <!-- /.spending-cat-savings -->
									
								<h3 class="spending-cat-h1">
									<a href="#popular">
									<img class="spending-cat-icon" src="_images/icon-popular-25x25.png" />
									Most Popular</a></h3>
							</header>
							
							<?php include('_includes/_tips/popular.php'); ?>
							<a href="#popular" class="spending-cat-more">
								<span class="spending-cat-more-text">More</span></a>
						</div> <!-- /.spending-box -->


						<!-- Category: Big -->
	
						<div class="spending-cat-box small-cat type-style spending-cat-preview" id="sc-big">
							<header class="spending-cat-header">
								<div class="spending-cat-savings">
									<h5>Save</h5>
									<div class="spending-cat-number"><span class="dollar">$</span>40-500</div>
								</div> <!-- /.spending-cat-savings -->

								<h3 class="spending-cat-h1">
									<a href="#big">
									<img class="spending-cat-icon" src="_images/icon-big-25x25.png" />
									Big Savings</a></h3>
							</header>
							
							<?php include('_includes/_tips/big.php'); ?>
							<a href="#big" class="spending-cat-more">
								<span class="spending-cat-more-text">More</span></a>
							
						</div> <!-- /.spending-box -->
	
	
						<h3 class="spending-cat-label">Categories</h3>

						<!-- Category: Clothing/Furniture -->
						
						<div class="spending-cat-box small-cat type-style spending-cat-preview" id="sc-clothing">
							<header class="spending-cat-header">
									<div class="spending-cat-savings">
										<h5>Save</h5>
										<div class="spending-cat-number"><span class="dollar">$</span>5-110</div>
									</div> <!-- /.spending-cat-savings -->
	
									<h3 class="spending-cat-h1">
										<a href="#clothing">
										<img class="spending-cat-icon" src="_images/icon-apparel-25x25.png" />
										Clothing / Furniture</a></h3>
							</header>
							
							<?php include('_includes/_tips/clothing-furniture.php'); ?>
							<a href="#clothing" class="spending-cat-more">
								<span class="spending-cat-more-text">More</span></a>
							
						</div> <!-- /.spending-box -->
	
	
						<!-- Category: Entertainment/Eating Out -->
						
						<div class="spending-cat-box small-cat type-style spending-cat-preview" id="sc-entertainment">
							<header class="spending-cat-header">
								<div class="spending-cat-savings">
									<h5>Save</h5>
									<div class="spending-cat-number"><span class="dollar">$</span>5-40</div>
								</div> <!-- .spending-cat-savings -->

								<h3 class="spending-cat-h1">
									<a href="#entertainment">
									<img class="spending-cat-icon" src="_images/icon-eating-25x25.png" />
									Entertainment &amp; Eating Out</a></h3>
							</header>
							
							<?php include('_includes/_tips/entertainment.php'); ?>
							<a href="#entertainment" class="spending-cat-more">
								<span class="spending-cat-more-text">More</span></a>
							
						</div> <!-- /.spending-box -->


						<!-- Category: Groceries-->
						
						<div class="spending-cat-box small-cat type-style spending-cat-preview" id="sc-groceries">
							<header class="spending-cat-header">
								<div class="spending-cat-savings">
									<h5>Save</h5>
									<div class="spending-cat-number"><span class="dollar">$</span>5-150</div>
								</div> <!-- /.spending-cat-savings -->

								<h3 class="spending-cat-h1">
									<a href="#groceries">
										<img class="spending-cat-icon" src="_images/icon-groceries-25x25.png" />
										Groceries</a></h3>
							</header>
							
							<?php include('_includes/_tips/groceries.php'); ?>
							<a href="#groceries" class="spending-cat-more">
								<span class="spending-cat-more-text">More</span></a>
							
						</div> <!-- /.spending-box -->
						
	
						<!-- Category: Health Care -->
	
						<div class="spending-cat-box style-cat type-style spending-cat-preview" id="sc-health-care">
							<header class="spending-cat-header">
								<div class="spending-cat-savings">
									<h5>Save</h5>
									<div class="spending-cat-number"><span class="dollar">$</span>5-150</div>
								</div> <!-- /.spending-cat-savings -->
									
								<h3 class="spending-cat-h1">
									<a href="#health-care">
									<img class="spending-cat-icon" src="_images/icon-health-care-25x25.png" />
									Health Care</a></h3>
							</header>
							
							<?php include('_includes/_tips/health-care.php'); ?>
							<a href="#health-care" class="spending-cat-more">
								<span class="spending-cat-more-text">More</span></a>
								
						</div> <!-- /.spending-box -->
						

						<!-- Category: Transportation -->
	
						<div class="spending-cat-box small-cat type-style spending-cat-preview" id="sc-transportation">
							<header class="spending-cat-header">
								<div class="spending-cat-savings">
									<h5>Save</h5>
									<div class="spending-cat-number"><span class="dollar">$</span>5-800</div>
								</div> <!-- /.spending-cat-savings -->
									
								<h3 class="spending-cat-h1">
									<a href="#transportation">
									<img class="spending-cat-icon" src="_images/icon-transport-25x25.png" />
									Transportation</a></h3>
							</header>
							
							<?php include('_includes/_tips/transportation.php'); ?>
							<a href="#transportation" class="spending-cat-more">
								<span class="spending-cat-more-text">More</span></a>
														
						</div> <!-- /.spending-box -->
	
	
						<!-- Category: Utilities/Phone-->
						
						<div class="spending-cat-box small-cat type-style spending-cat-preview" id="sc-utils">
							<header class="spending-cat-header">
								<div class="spending-cat-savings">
									<h5>Save</h5>
									<div class="spending-cat-number"><span class="dollar">$</span>5-125</div>
								</div> <!-- /.spending-cat-savings -->

								<h3 class="spending-cat-h1">
									<a href="#utilities">
									<img class="spending-cat-icon" src="_images/icon-utilities-25x25.png" />
									Utilities / Telecom</a></h3>
							</header>
							
							<?php include('_includes/_tips/utilities.php'); ?>
							<a href="#utilities" class="spending-cat-more">
								<span class="spending-cat-more-text">More</span></a>
														
						</div> <!-- /.spending-box -->



						<h3 class="spending-cat-label">Lifestyles</h3>
	
						<!-- Category: Do It Yourself -->
	
						<div class="spending-cat-box style-cat type-style spending-cat-preview" id="sc-do-it-yourself">
							<header class="spending-cat-header">
								<div class="spending-cat-savings">
									<h5>Save</h5>
									<div class="spending-cat-number"><span class="dollar">$</span>1-170</div>
								</div> <!-- /.spending-cat-savings -->
								
								<h3 class="spending-cat-h1">
									<a href="#diy">
										<img class="spending-cat-icon" src="_images/icon-diy-25x25.png" />
										Do It Yourself</a></h3>
							</header>
							
							<?php include('_includes/_tips/diy.php'); ?>
							<a href="#diy" class="spending-cat-more">
								<span class="spending-cat-more-text">More</span></a>
							
						</div> <!-- /.spending-box -->
						
	
						<!-- Category: Green Living -->
						
						<div class="spending-cat-box style-cat type-style spending-cat-preview" id="sc-green-living">
							<header class="spending-cat-header">
								<div class="spending-cat-savings">
									<h5>Save</h5>
									<div class="spending-cat-number"><span class="dollar">$</span>5-800</div>
								</div> <!-- /.spending-cat-savings -->

								<h3 class="spending-cat-h1">
									<a href="#green">
									<img class="spending-cat-icon" src="_images/icon-green-25x25.png" />
									Green Living</a></h3>
							</header>
							
							<?php include('_includes/_tips/green.php'); ?>
							<a href="#green" class="spending-cat-more">
								<span class="spending-cat-more-text">More</span></a>
							
						</div> <!-- /.spending-box -->
							

						<!-- Category: Healthy Habits-->
						
						<div class="spending-cat-box style-cat type-style spending-cat-preview" id="sc-healthy-habits">
							<header class="spending-cat-header">
								<div class="spending-cat-savings">
									<h5>Save</h5>
									<div class="spending-cat-number"><span class="dollar">$</span>5-175</div>
								</div> <!-- /.spending-cat-savings -->

								<h3 class="spending-cat-h1">
									<a href="#healthy">
									<img class="spending-cat-icon" src="_images/icon-healthy-25x25.png" />
									Healthy Habits</a></h3>
							</header>
							
							<?php include('_includes/_tips/healthy-habits.php'); ?>
							<a href="#healthy-habits" class="spending-cat-more">
								<span class="spending-cat-more-text">More</span></a>
							
						</div> <!-- /.spending-box -->
	
	
						<!-- Category: Hyper-Tech -->
	
						<div class="spending-cat-box style-cat type-style spending-cat-preview" id="sc-hyper-tech">
							<header class="spending-cat-header">
								<div class="spending-cat-savings">
									<h5>Save</h5>
									<div class="spending-cat-number"><span class="dollar">$</span>5-225</div>
								</div> <!-- /.spending-cat-savings -->
								
								<h3 class="spending-cat-h1">
									<a href="#tech">
									<img class="spending-cat-icon" src="_images/icon-tech-25x25.png" />
									Hyper-Tech</a></h3>
							</header>
							
							<?php include('_includes/_tips/tech.php'); ?>
							<a href="#tech" class="spending-cat-more">
								<span class="spending-cat-more-text">More</span></a>
							
						</div> <!-- /.spending-box -->
						
	
						<!-- Category: Retro -->
	
						<div class="spending-cat-box style-cat type-style spending-cat-preview" id="sc-retro">

							<header class="spending-cat-header">
								<div class="spending-cat-savings">
									<h5>Save</h5>
									<div class="spending-cat-number"><span class="dollar">$</span>10-225</div>
								</div> <!-- /.spending-cat-savings -->
								
								<h3 class="spending-cat-h1">
									<a href="#retro">
									<img class="spending-cat-icon" src="_images/icon-retro-25x25.png" />
									Retro</a></h3>
							</header>
							
							<?php include('_includes/_tips/retro.php'); ?>
							<a href="#retro" class="spending-cat-more">
								<span class="spending-cat-more-text">More</span></a>
														
						</div> <!-- /.spending-box -->
	
	
						<!-- Category: Smart Spender -->
	
						<div class="spending-cat-box style-cat type-style spending-cat-preview" id="sc-smart-spender">
							<header class="spending-cat-header">
								<div class="spending-cat-savings">
									<h5>Save</h5>
									<div class="spending-cat-number"><span class="dollar">$</span>10-250</div>
								</div> <!-- /.spending-cat-savings -->
								
								<h3 class="spending-cat-h1">
									<a href="#smart">
									<img class="spending-cat-icon" src="_images/icon-smart-25x25.png" />
									Smart Spender</a></h3>
							</header>
							
							<?php include('_includes/_tips/smart-spender.php'); ?>
							<a href="smart" class="spending-cat-more">
								<span class="spending-cat-more-text">More</span></a>
							
						</div> <!-- /.spending-box -->
	
							<?php include('_includes/_tips/spending-cats-footer.php'); ?>							
					</div> <!-- /#spending-cat-all -->

					
	
					<!-- Category: Most Popular-->
	
					<div id="spending-cat-popular" class="pane">

						<div class="spending-cat-box small-cat type-style" id="sc-popular">
							<header class="spending-cat-header">
									<div class="spending-cat-savings">
										<h5>Save</h5>
										<div class="spending-cat-number"><span class="dollar">$</span>1-150</div>									</div> <!-- /.spending-cat-savings -->
									
									<h3 class="spending-cat-h1">
										<a href="#popular">
										<img class="spending-cat-icon" src="_images/icon-popular-25x25.png" />
										Most Popular</a></h3>
							</header>
							
							<?php include('_includes/spending-table.php'); ?>

							<a href="#all" class="spending-cat-back">
								<span class="spending-cat-back-text">Back to list</span></a>
							
							<?php include('_includes/_tips/spending-cats-footer.php'); ?>							
	
						</div> <!-- /.spending-box -->

					</div> <!-- /#spending-cat-popular -->


					<!-- Category: Big -->

					<div id="spending-cat-big" class="pane">

						<div class="spending-cat-box small-cat type-style spending-cat-preview" id="sc-big">
							<header class="spending-cat-header">
								<div class="spending-cat-savings">
									<h5>Save</h5>
									<div class="spending-cat-number"><span class="dollar">$</span>40-500</div>
								</div> <!-- /.spending-cat-savings -->

								<h3 class="spending-cat-h1">
									<a href="#big">
									<img class="spending-cat-icon" src="_images/icon-big-25x25.png" />
									Big Savings</a></h3>
							</header>
							
							<?php include('_includes/_tips/big.php'); ?>

							<a href="#all" class="spending-cat-back">
								<span class="spending-cat-back-text">Back to list</span></a>

							<?php include('_includes/_tips/spending-cats-footer.php'); ?>						
							
						</div> <!-- /.spending-box -->

					</div> <!-- /#spending-cat-big -->


					<!-- Category: Clothing/Furniture -->

					<div id="spending-cat-clothing" class="pane">

						<div class="spending-cat-box small-cat type-style spending-cat-preview" id="sc-clothing">
							<header class="spending-cat-header">
									<div class="spending-cat-savings">
										<h5>Save</h5>
										<div class="spending-cat-number"><span class="dollar">$</span>5-110</div>
									</div> <!-- /.spending-cat-savings -->
	
									<h3 class="spending-cat-h1">
										<a href="#clothing">
										<img class="spending-cat-icon" src="_images/icon-apparel-25x25.png" />
										Clothing / Furniture</a></h3>
							</header>
							
							<?php include('_includes/_tips/clothing-furniture.php'); ?>

							<a href="#all" class="spending-cat-back">
								<span class="spending-cat-back-text">Back to list</span></a>

							<?php include('_includes/_tips/spending-cats-footer.php'); ?>						
							
						</div> <!-- /.spending-box -->

					</div> <!-- /#spending-cat-clothing -->


					<!-- Category: Entertainment/Eating Out -->

					<div id="spending-cat-entertainment" class="pane">

						<div class="spending-cat-box small-cat type-style spending-cat-preview" id="sc-entertainment">
							<header class="spending-cat-header">
								<div class="spending-cat-savings">
									<h5>Save</h5>
									<div class="spending-cat-number"><span class="dollar">$</span>5-40</div>
								</div> <!-- /.spending-cat-savings -->

								<h3 class="spending-cat-h1">
									<a href="#entertainment">
									<img class="spending-cat-icon" src="_images/icon-eating-25x25.png" />
									Entertainment &amp; Eating Out</a></h3>
							</header>
							
							<?php include('_includes/_tips/entertainment.php'); ?>
							
							<a href="#all" class="spending-cat-back">
								<span class="spending-cat-back-text">Back to list</span></a>

							<?php include('_includes/_tips/spending-cats-footer.php'); ?>						
							
						</div> <!-- /.spending-box -->

					</div> <!-- /#spending-cat-entertainment -->


					<!-- Category: Groceries-->

					<div id="spending-cat-groceries" class="pane">

						<div class="spending-cat-box small-cat type-style spending-cat-preview" id="sc-groceries">
							<header class="spending-cat-header">
								<div class="spending-cat-savings">
									<h5>Save</h5>
									<div class="spending-cat-number"><span class="dollar">$</span>5-150</div>
								</div> <!-- /.spending-cat-savings -->

								<h3 class="spending-cat-h1">
									<a href="#groceries">
										<img class="spending-cat-icon" src="_images/icon-groceries-25x25.png" />
										Groceries</a></h3>
							</header>
							
							<?php include('_includes/_tips/groceries.php'); ?>

							<a href="#all" class="spending-cat-back">
								<span class="spending-cat-back-text">Back to list</span></a>

							<?php include('_includes/_tips/spending-cats-footer.php'); ?>						
							
						</div> <!-- /.spending-box -->

					</div> <!-- /#spending-cat-groceries -->


					<!-- Category: Health Care -->

					<div id="spending-cat-health" class="pane">

						<div class="spending-cat-box style-cat type-style spending-cat-preview" id="sc-health-care">
							<header class="spending-cat-header">
								<div class="spending-cat-savings">
									<h5>Save</h5>
									<div class="spending-cat-number"><span class="dollar">$</span>5-150</div>
								</div> <!-- /.spending-cat-savings -->
									
								<h3 class="spending-cat-h1">
									<a href="#health-care">
									<img class="spending-cat-icon" src="_images/icon-health-care-25x25.png" />
									Health Care</a></h3>
							</header>
							
							<?php include('_includes/_tips/health-care.php'); ?>

							<a href="#all" class="spending-cat-back">
								<span class="spending-cat-back-text">Back to list</span></a>

							<?php include('_includes/_tips/spending-cats-footer.php'); ?>						
								
						</div> <!-- /.spending-box -->

					</div> <!-- /#spending-cat-health -->


					<!-- Category: Transportation -->

					<div id="spending-cat-transportation" class="pane">
	
						<div class="spending-cat-box small-cat type-style spending-cat-preview" id="sc-transportation">
							<header class="spending-cat-header">
								<div class="spending-cat-savings">
									<h5>Save</h5>
									<div class="spending-cat-number"><span class="dollar">$</span>5-800</div>
								</div> <!-- /.spending-cat-savings -->
									
								<h3 class="spending-cat-h1">
									<a href="#transportation">
									<img class="spending-cat-icon" src="_images/icon-transport-25x25.png" />
									Transportation</a></h3>
							</header>
							
							<?php include('_includes/_tips/transportation.php'); ?>

							<a href="#all" class="spending-cat-back">
								<span class="spending-cat-back-text">Back to list</span></a>

							<?php include('_includes/_tips/spending-cats-footer.php'); ?>						
														
						</div> <!-- /.spending-box -->

					</div> <!-- /#spending-cat-transportation -->
					

					<!-- Category: Utilities/Phone-->

					<div id="spending-cat-utilities" class="pane">

						<div class="spending-cat-box small-cat type-style spending-cat-preview" id="sc-utils">
							<header class="spending-cat-header">
								<div class="spending-cat-savings">
									<h5>Save</h5>
									<div class="spending-cat-number"><span class="dollar">$</span>5-125</div>
								</div> <!-- /.spending-cat-savings -->

								<h3 class="spending-cat-h1">
									<a href="#utilities">
									<img class="spending-cat-icon" src="_images/icon-utilities-25x25.png" />
									Utilities / Telecom</a></h3>
							</header>
							
							<?php include('_includes/_tips/utilities.php'); ?>

							<a href="#all" class="spending-cat-back">
								<span class="spending-cat-back-text">Back to list</span></a>

							<?php include('_includes/_tips/spending-cats-footer.php'); ?>						
														
						</div> <!-- /.spending-box -->
						
					</div> <!-- /#spending-cat-utilities -->
										

					<!-- Category: Do It Yourself -->

					<div id="spending-cat-diy" class="pane">

						<div class="spending-cat-box style-cat type-style spending-cat-preview" id="sc-do-it-yourself">
							<header class="spending-cat-header">
								<div class="spending-cat-savings">
									<h5>Save</h5>
									<div class="spending-cat-number"><span class="dollar">$</span>1-170</div>
								</div> <!-- /.spending-cat-savings -->
								
								<h3 class="spending-cat-h1">
									<a href="#diy">
										<img class="spending-cat-icon" src="_images/icon-diy-25x25.png" />
										Do It Yourself</a></h3>
							</header>
							
							<?php include('_includes/_tips/diy.php'); ?>
							
							<a href="#all" class="spending-cat-back">
								<span class="spending-cat-back-text">Back to list</span></a>

							<?php include('_includes/_tips/spending-cats-footer.php'); ?>						
							
						</div> <!-- /.spending-box -->

					</div> <!-- /#spending-cat-diy -->


					<!-- Category: Green Living -->

					<div id="spending-cat-green" class="pane">

						<div class="spending-cat-box style-cat type-style spending-cat-preview" id="sc-green-living">
							<header class="spending-cat-header">
								<div class="spending-cat-savings">
									<h5>Save</h5>
									<div class="spending-cat-number"><span class="dollar">$</span>5-800</div>
								</div> <!-- /.spending-cat-savings -->

								<h3 class="spending-cat-h1">
									<a href="#green">
									<img class="spending-cat-icon" src="_images/icon-green-25x25.png" />
									Green Living</a></h3>
							</header>
							
							<?php include('_includes/_tips/green.php'); ?>

							<a href="#all" class="spending-cat-back">
								<span class="spending-cat-back-text">Back to list</span></a>

							<?php include('_includes/_tips/spending-cats-footer.php'); ?>						
							
						</div> <!-- /.spending-box -->	

					</div> <!-- /#spending-cat-green -->


					<!-- Category: Healthy Habits-->

					<div id="spending-cat-healthy-habits" class="pane">

						<div class="spending-cat-box style-cat type-style spending-cat-preview" id="sc-healthy-habits">
							<header class="spending-cat-header">
								<div class="spending-cat-savings">
									<h5>Save</h5>
									<div class="spending-cat-number"><span class="dollar">$</span>5-175</div>
								</div> <!-- /.spending-cat-savings -->

								<h3 class="spending-cat-h1">
									<a href="#healthy">
									<img class="spending-cat-icon" src="_images/icon-healthy-25x25.png" />
									Healthy Habits</a></h3>
							</header>
							
							<?php include('_includes/_tips/healthy-habits.php'); ?>

							<a href="#all" class="spending-cat-back">
								<span class="spending-cat-back-text">Back to list</span></a>

							<?php include('_includes/_tips/spending-cats-footer.php'); ?>						
							
						</div> <!-- /.spending-box -->

					</div> <!-- /#spending-cat-healthy-habits -->


					<!-- Category: Hyper-Tech -->

					<div id="spending-cat-tech" class="pane">

						<div class="spending-cat-box style-cat type-style spending-cat-preview" id="sc-hyper-tech">
							<header class="spending-cat-header">
								<div class="spending-cat-savings">
									<h5>Save</h5>
									<div class="spending-cat-number"><span class="dollar">$</span>5-225</div>
								</div> <!-- /.spending-cat-savings -->
								
								<h3 class="spending-cat-h1">
									<a href="#tech">
									<img class="spending-cat-icon" src="_images/icon-tech-25x25.png" />
									Hyper-Tech</a></h3>
							</header>
							
							<?php include('_includes/_tips/tech.php'); ?>

							<a href="#all" class="spending-cat-back">
								<span class="spending-cat-back-text">Back to list</span></a>

							<?php include('_includes/_tips/spending-cats-footer.php'); ?>						
							
						</div> <!-- /.spending-box -->

					</div> <!-- /#spending-cat-tech -->


					<!-- Category: Retro -->

					<div id="spending-cat-retro" class="pane">
	
						<div class="spending-cat-box style-cat type-style spending-cat-preview" id="sc-retro">

							<header class="spending-cat-header">
								<div class="spending-cat-savings">
									<h5>Save</h5>
									<div class="spending-cat-number"><span class="dollar">$</span>10-225</div>
								</div> <!-- /.spending-cat-savings -->
								
								<h3 class="spending-cat-h1">
									<a href="#retro">
									<img class="spending-cat-icon" src="_images/icon-retro-25x25.png" />
									Retro</a></h3>
							</header>
							
							<?php include('_includes/_tips/retro.php'); ?>

							<a href="#all" class="spending-cat-back">
								<span class="spending-cat-back-text">Back to list</span></a>

							<?php include('_includes/_tips/spending-cats-footer.php'); ?>						
														
						</div> <!-- /.spending-box -->

					</div> <!-- /#spending-cat-retro -->


					<!-- Category: Smart Spender -->

					<div id="spending-cat-smart" class="pane">

						<div class="spending-cat-box style-cat type-style spending-cat-preview" id="sc-smart-spender">
							<header class="spending-cat-header">
								<div class="spending-cat-savings">
									<h5>Save</h5>
									<div class="spending-cat-number"><span class="dollar">$</span>10-250</div>
								</div> <!-- /.spending-cat-savings -->
								
								<h3 class="spending-cat-h1">
									<a href="#smart">
									<img class="spending-cat-icon" src="_images/icon-smart-25x25.png" />
									Smart Spender</a></h3>
							</header>
							
							<?php include('_includes/_tips/smart-spender.php'); ?>

							<a href="#all" class="spending-cat-back">
								<span class="spending-cat-back-text">Back to list</span></a>

							<?php include('_includes/_tips/spending-cats-footer.php'); ?>						
							
						</div> <!-- /.spending-box -->

					</div> <!-- /#spending-cat-smart -->

				</div> <!-- /.spending-cats -->

				<div class="footnote">
					<p>Potential savings based on the U.S. Department of Labor 2009 Consumer Expenditure Survey and informal estimates.</p>
				</div>

			</div> <!-- /.col-2 -->

		</article> <!-- /.cut your spending interactive -->

		<div id="spending-modal" class="modal">
			<p class="spending-modal-msg">Nice work! It looks like you've found enough savings to reach your goal. Now go ahead to your Action Plan &mdash; or keep finding more ways to save.</p>
			<ul class="spending-modal-btns">
				<li class="col"><a class="spending-modal-next-btn" href="3.1-take-action.php">
				Take Action</a></li>
				<li class="col"><a class="spending-modal-back-btn close-modal">Keep cutting</a></li>
			</ul>
		</div> <!-- /.cut-spending-modal -->


	</section> <!-- /.frame-container -->