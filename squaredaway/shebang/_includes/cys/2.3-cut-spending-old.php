<?php 
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
					<h2 class="frame-h2">Check off items to add them to your plan. When you think you&rsquo;re set, <a href="3.1-take-action.php">move ahead to your action plan</a>.</h2>
				</hgroup>
			
			</article>


		<!-- ================================= --> 
		<!-- ! Cut Your Spending Module		   --> 
		<!-- ================================= -->


		<article class="frame cut-your-spending-interactive">
				
				<form class="spending-filters">
					<fieldset>
						<ul id="spending-cat-filters" class="spending-cat-filters">
							<li class="spending-cat-filter show">
								<div class="form-label">Show:</div>
								</li>

							<li class="spending-cat-filter active">
								<input class="radio-btn" type="radio" name="category" value="all" /> 
								<label class="filter-label" for="all">
								All</label></li>

							<li class="spending-cat-filter">
								<input class="radio-btn" type="radio" name="category" value="cats" /> 
								<label class="filter-label" for="big">
								<span class="spending-key-small"></span> Categories</label></li>
							
							<li class="spending-cat-filter">
								<input class="radio-btn" type="radio" name="category" value="style" />
								<label class="filter-label" for="lifestyle">
								<span class="spending-key-style"></span> Lifestyles</label></li>

						</ul> <!-- spending-filters -->
					</fieldset>

					<fieldset>
						<ul id="spending-cat-filter-grid" class="spending-cat-filters">

							<li class="spending-cat-filter">
								<input class="radio-btn" type="radio" name="category" value="popular" /> 
								<label class="filter-label" for="big">
								<span class="spending-key-small"></span> Most Popular</label></li>

							<li class="spending-cat-filter">
								<input class="radio-btn" type="radio" name="category" value="retro" /> 
								<label class="filter-label" for="lifestyle">
								<span class="spending-key-style"></span> Retro</label></li>
							
							<li class="spending-cat-filter">
								<input class="radio-btn" type="radio" name="category" value="transportation" />
								<label class="filter-label" for="big">
								<span class="spending-key-small"></span> Transport</label></li>
								
								<li class="spending-cat-filter">
								<input class="radio-btn" type="radio" name="category" value="healthy-habits" />
								<label class="filter-label" for="lifestyle">
								<span class="spending-key-style"></span> Healthy Habits</label></li>
								
								<li class="spending-cat-filter">
								<input class="radio-btn" type="radio" name="category" value="entertainment" />
								<label class="filter-label" for="big">
								<span class="spending-key-small"></span> Entertainment</label></li>
								
								<li class="spending-cat-filter">
								<input class="radio-btn" type="radio" name="category" value="do-it-yourself" />
								<label class="filter-label" for="lifestyle">
								<span class="spending-key-style"></span> DIY</label></li>
								
								<li class="spending-cat-filter">
								<input class="radio-btn" type="radio" name="category" value="utils" />
								<label class="filter-label" for="big">
								<span class="spending-key-small"></span> Utilities</label></li>
								
								<li class="spending-cat-filter">
								<input class="radio-btn" type="radio" name="category" value="hyper-tech" />
								<label class="filter-label" for="lifestyle">
								<span class="spending-key-style"></span> Hyper-Tech</label></li>
								
								<li class="spending-cat-filter">
								<input class="radio-btn" type="radio" name="category" value="clothing" />
								<label class="filter-label" for="big">
								<span class="spending-key-small"></span> Clothing</label></li>
								
								<li class="spending-cat-filter">
								<input class="radio-btn" type="radio" name="category" value="smart-spender" />
								<label class="filter-label" for="lifestyle">
								<span class="spending-key-style"></span> Smart Spender</label></li>
								
								<li class="spending-cat-filter">
								<input class="radio-btn" type="radio" name="category" value="green-living" />
								<label class="filter-label" for="lifestyle">
								<span class="spending-key-style"></span> Green</label></li>
								
								<li class="spending-cat-filter">
								<input class="radio-btn" type="radio" name="category" value="big" />
								<label class="filter-label" for="big">
								<span class="spending-key-small"></span> Big</label></li>
								
								<li class="spending-cat-filter">
								<input class="radio-btn" type="radio" name="category" value="groceries" />
								<label class="filter-label" for="big">
								<span class="spending-key-small"></span> Groceries</label></li>
								
								<li class="spending-cat-filter">
								<input class="radio-btn" type="radio" name="category" value="parent" />
								<label class="filter-label" for="lifestyle">
								<span class="spending-key-style"></span> Parent</label></li>

						</ul>
					</fieldset>

				<div id="note-container" class="note-1">
					<p>Enter your own estimates to fit your situation</p>
					<div class="note-arrow"><span class="right-down"></span></div>
				</div> <!-- note-1 -->

				<div id="spending-cats" class="spending-cats">

						<!-- Category: Most Popular-->
	
						<div class="spending-cat-box small-cat type-cats" id="sc-popular">
							<header class="spending-cat-header">
									<div class="spending-cat-savings">
										<h5>Save</h5>
										<div class="spending-cat-number"><span class="dollar">$</span>1-150</div>									</div> <!-- spending-cat-savings -->
									
									<h3 class="spending-cat-h1">
										<img class="spending-cat-icon" src="_images/icon-popular-25x25.png" />
										Most Popular</h3>
							</header>
							
							<?php include('_includes/spending-table.php'); ?>							
							
							<footer class="spending-cat-footer">
								<a class="spending-cat-more">
									<span class="spending-cat-more-text">More</span></a>
							</footer>
						</div> <!-- spending-box -->


						<!-- Category: Big -->
	
						<div class="spending-cat-box small-cat type-cats" id="sc-big">
							<header class="spending-cat-header">
									<div class="spending-cat-savings">
										<h5>Save</h5>
										<div class="spending-cat-number"><span class="dollar">$</span>40-500</div>
									</div> <!-- spending-cat-savings -->
	
									<h3 class="spending-cat-h1">
										<img class="spending-cat-icon" src="_images/icon-big-25x25.png" />
										Big Savings</h3>
							</header>
							
							<?php include('_includes/_tips/big.php'); ?>							

							<footer class="spending-cat-footer">
								<a class="spending-cat-more">
									<span class="spending-cat-more-text">More</span></a>
							</footer>
						</div> <!-- spending-box -->						


						<!-- Category: Green Living -->
						
						<div class="spending-cat-box style-cat type-style" id="sc-green-living">
							<header class="spending-cat-header">
									<div class="spending-cat-savings">
										<h5>Save</h5>
										<div class="spending-cat-number"><span class="dollar">$</span>5-800</div>
									</div> <!-- spending-cat-savings -->
	
									<h3 class="spending-cat-h1">
										<img class="spending-cat-icon" src="_images/icon-green-25x25.png" />
										Green Living</h3>
							</header>
							
							<?php include('_includes/_tips/green.php'); ?>							
							
							<footer class="spending-cat-footer">
								<a class="spending-cat-more">
									<span class="spending-cat-more-text">More</span></a>
							</footer>
						</div> <!-- spending-box -->						
						

						<!-- Category: Entertainment/Eating Out -->
						
						<div class="spending-cat-box small-cat type-cats" id="sc-entertainment">
							<header class="spending-cat-header">
									<div class="spending-cat-savings">
										<h5>Save</h5>
										<div class="spending-cat-number"><span class="dollar">$</span>5-40</div>
									</div> <!-- spending-cat-savings -->
	
									<h3 class="spending-cat-h1">
										<img class="spending-cat-icon" src="_images/icon-eating-25x25.png" />
										Entertainment &amp; Eating Out</h3>
							</header>
							
							<?php include('_includes/_tips/entertainment.php'); ?>							
							
							<footer class="spending-cat-footer">
								<a class="spending-cat-more">
									<span class="spending-cat-more-text">More</span></a>
							</footer>
						</div> <!-- spending-box -->
													

						<!-- Category: Retro -->
	
						<div class="spending-cat-box style-cat type-style" id="sc-retro">
							<header class="spending-cat-header">
									<div class="spending-cat-savings">
										<h5>Save</h5>
										<div class="spending-cat-number"><span class="dollar">$</span>10-225</div>
									</div> <!-- spending-cat-savings -->
									
									<h3 class="spending-cat-h1">
										<img class="spending-cat-icon" src="_images/icon-retro-25x25.png" />
										Retro</h3>
							</header>
							
							<?php include('_includes/_tips/retro.php'); ?>							
							
							<footer class="spending-cat-footer">
								<a class="spending-cat-more">
									<span class="spending-cat-more-text">More</span></a>
							</footer>
						</div> <!-- spending-box -->


						<!-- Category: Transportation -->
	
						<div class="spending-cat-box small-cat type-cats" id="sc-transportation">
							<header class="spending-cat-header">
									<div class="spending-cat-savings">
										<h5>Save</h5>
										<div class="spending-cat-number"><span class="dollar">$</span>5-800</div>									</div> <!-- spending-cat-savings -->
									
									<h3 class="spending-cat-h1">
										<img class="spending-cat-icon" src="_images/icon-transport-25x25.png" />
										Transportation</h3>
							</header>
							
							<?php include('_includes/_tips/transportation.php'); ?>							
							
							<footer class="spending-cat-footer">
								<a class="spending-cat-more">
									<span class="spending-cat-more-text">More</span></a>
							</footer>
						</div> <!-- spending-box -->
						

						<!-- Category: Healthy Habits-->
						
						<div class="spending-cat-box style-cat type-style" id="sc-healthy-habits">
							<header class="spending-cat-header">
									<div class="spending-cat-savings">
										<h5>Save</h5>
										<div class="spending-cat-number"><span class="dollar">$</span>5-175</div>									</div> <!-- spending-cat-savings -->
	
									<h3 class="spending-cat-h1">
										<img class="spending-cat-icon" src="_images/icon-healthy-25x25.png" />
										Healthy Habits</h3>
							</header>
							
							<?php include('_includes/_tips/healthy-habits.php'); ?>							
							
							<footer class="spending-cat-footer">
								<a class="spending-cat-more">
									<span class="spending-cat-more-text">More</span></a>
							</footer>
						</div> <!-- spending-box -->


						<!-- Category: Do It Yourself -->
	
						<div class="spending-cat-box style-cat type-style" id="sc-do-it-yourself">
							<header class="spending-cat-header">
									<div class="spending-cat-savings">
										<h5>Save</h5>
										<div class="spending-cat-number"><span class="dollar">$</span>1-170</div>
									</div> <!-- spending-cat-savings -->
									
									<h3 class="spending-cat-h1">
										<img class="spending-cat-icon" src="_images/icon-diy-25x25.png" />
										Do It Yourself</h3>
							</header>
							
							<?php include('_includes/_tips/diy.php'); ?>							
							
							<footer class="spending-cat-footer">
								<a class="spending-cat-more">
									<span class="spending-cat-more-text">More</span></a>
							</footer>
						</div> <!-- spending-box -->



						<!-- Category: Utilities/Phone-->
						
						<div class="spending-cat-box small-cat type-cats" id="sc-utils">
							<header class="spending-cat-header">
									<div class="spending-cat-savings">
										<h5>Save</h5>
										<div class="spending-cat-number"><span class="dollar">$</span>5-125</div>
									</div> <!-- spending-cat-savings -->
	
									<h3 class="spending-cat-h1">
										<img class="spending-cat-icon" src="_images/icon-utilities-25x25.png" />
										Utilities / Telecom</h3>
							</header>
							
							<?php include('_includes/_tips/utilities.php'); ?>							
							
							<footer class="spending-cat-footer">
								<a class="spending-cat-more">
									<span class="spending-cat-more-text">More</span></a>
							</footer>
						</div> <!-- spending-box -->
						

						<!-- Category: Hyper-Tech -->
	
						<div class="spending-cat-box style-cat type-style" id="sc-hyper-tech">
							<header class="spending-cat-header">
									<div class="spending-cat-savings">
										<h5>Save</h5>
										<div class="spending-cat-number"><span class="dollar">$</span>5-225</div>
									</div> <!-- spending-cat-savings -->
									
									<h3 class="spending-cat-h1">
										<img class="spending-cat-icon" src="_images/icon-tech-25x25.png" />
										Hyper-Tech</h3>
							</header>
							
							<?php include('_includes/_tips/tech.php'); ?>							
							
							<footer class="spending-cat-footer">
								<a class="spending-cat-more">
									<span class="spending-cat-more-text">More</span></a>
							</footer>
						</div> <!-- spending-box -->


						<!-- Category: Clothing/Furniture -->
						
						<div class="spending-cat-box small-cat type-cats" id="sc-clothing">
							<header class="spending-cat-header">
									<div class="spending-cat-savings">
										<h5>Save</h5>
										<div class="spending-cat-number"><span class="dollar">$</span>5-110</div>									</div> <!-- spending-cat-savings -->
	
									<h3 class="spending-cat-h1">
										<img class="spending-cat-icon" src="_images/icon-apparel-25x25.png" />
										Clothing / Furniture</h3>
							</header>
							
							<?php include('_includes/_tips/clothing-furniture.php'); ?>							
							
							<footer class="spending-cat-footer">
								<a class="spending-cat-more">
									<span class="spending-cat-more-text">More</span></a>
							</footer>
						</div> <!-- spending-box -->


						<!-- Category: Smart Spender -->
	
						<div class="spending-cat-box style-cat type-style" id="sc-smart-spender">
							<header class="spending-cat-header">
									<div class="spending-cat-savings">
										<h5>Save</h5>
										<div class="spending-cat-number"><span class="dollar">$</span>10-250</div>
									</div> <!-- spending-cat-savings -->
									
									<h3 class="spending-cat-h1">
										<img class="spending-cat-icon" src="_images/icon-smart-25x25.png" />
										Smart Spender</h3>
							</header>
							
							<?php include('_includes/_tips/smart-spender.php'); ?>							
							
							<footer class="spending-cat-footer">
								<a class="spending-cat-more">
									<span class="spending-cat-more-text">More</span></a>
							</footer>
						</div> <!-- spending-box -->
	
					

						<!-- Category: Groceries-->
						
						<div class="spending-cat-box small-cat type-cats" id="sc-groceries">
							<header class="spending-cat-header">
									<div class="spending-cat-savings">
										<h5>Save</h5>
										<div class="spending-cat-number"><span class="dollar">$</span>5-150</div>
									</div> <!-- spending-cat-savings -->
	
									<h3 class="spending-cat-h1">
										<img class="spending-cat-icon" src="_images/icon-groceries-25x25.png" />
										Groceries</h3>
							</header>
							
							<?php include('_includes/_tips/groceries.php'); ?>							
							
							<footer class="spending-cat-footer">
								<a class="spending-cat-more">
									<span class="spending-cat-more-text">More</span></a>
							</footer>
						</div> <!-- spending-box -->
						

						<!-- Category: Practical Parent -->
	
						<div class="spending-cat-box style-cat type-style" id="sc-parent">
							<header class="spending-cat-header">
									<div class="spending-cat-savings">
										<h5>Save</h5>
										<div class="spending-cat-number"><span class="dollar">$</span>5-150</div>									</div> <!-- spending-cat-savings -->
									
									<h3 class="spending-cat-h1">
										Practical Parent</h3>
							</header>
							
							<?php include('_includes/_tips/practical-parent.php'); ?>							
							
							<footer class="spending-cat-footer">
								<a class="spending-cat-more">
									<span class="spending-cat-more-text">More</span></a>
							</footer>
						</div> <!-- spending-box -->


				</div> <!-- spending-cats -->

				<div class="footnote">
					<p>Potential savings based on the U.S. Department of Labor 2009 Consumer Expenditure Survey and informal estimates.</p>
				</div>

			</article> <!-- cut your spending interactive -->

		</section> <!-- frame-container -->



		<!-- ================================= --> 
		<!-- ! Footer Nav					   --> 
		<!-- ================================= -->

		<footer class="footer-nav">
			
			<div class="col-1">
				<a class="footer-nav-button next" href="3.1-take-action.php">
					Action Plan
					<span class="arrow-right-large"></span></a>
			</div> <!-- col-1 -->

			<div class="col-2">
				<a class="footer-nav-button prev" href="2.2-how.php">
					<span class="arrow-left-large"></span>
					Get the money out</a>
			</div> <!-- col-2 -->

			
		</footer>

    </div> <!-- main -->
