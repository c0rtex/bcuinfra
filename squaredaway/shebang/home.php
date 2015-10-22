<?php
/**
 * The main template file.
 *
 * This is the most generic template file in a WordPress theme
 * and one of the two required files for a theme (the other being style.css).
 * It is used to display a page when nothing more specific matches a query. 
 * E.g., it puts together the home page when no home.php file exists.
 * Learn more: http://codex.wordpress.org/Template_Hierarchy
 *
 * @package WordPress
 * @subpackage Boilerplate
 * @since Boilerplate 1.0
 */

get_header(); ?>



	<section class="hp-up-page">
		
		<section class="hp-billboard-tri-message">
			
			<div class="hp-billboard-slidewrap">
			
				<?php
				/* Run the loop to output the posts.
				 * If you want to overload this in a child theme then include a file
				 * called loop-index.php and that will be used instead.
				 */
				 	echo '<ul class="hp-billboard-nav">';
	
					 	echo '<li class="hp-billboard-nav-item col-1">';
						 	echo '<a class="hp-billboard-nav-link" href="#" data-slide="0">';
						 		//echo '<h3 class="hp-billboard-nav-h">'.get_editable_title(697).'</h3>';
						 		echo '<h3 class="hp-billboard-nav-h">Independent Advice</h3>';
						 		//echo '<p class="hp-billboard-nav-text">'.get_editable_furniture(697).'</p>';
						 		echo '<p class="hp-billboard-nav-text">Tools you can trust from a reliable source</p>';
						 	echo '</a> <!-- /.hp-billboard-nav-link -->';
					 	echo '</li>';
	
					 	echo '<li class="hp-billboard-nav-item col-2">';
						 	echo '<a class="hp-billboard-nav-link" href="#" data-slide="1">';
						 		//echo '<h3 class="hp-billboard-nav-h">'.get_editable_title(699).'</h3>';
						 		echo '<h3 class="hp-billboard-nav-h">Square Away Your Finances</h3>';
						 		//echo '<p class="hp-billboard-nav-text">'.get_editable_furniture(699).'</p>';
						 		echo '<p class="hp-billboard-nav-text">Get a plan & live your life better</p>';
						 	echo '</a> <!-- /.hp-billboard-nav-link -->';
					 	echo '</li>';
	
					 	echo '<li class="hp-billboard-nav-item col-3">';
						 	echo '<a class="hp-billboard-nav-link" href="#" data-slide="2">';	
						 		echo '<h3 class="hp-billboard-nav-h">Deal with an Issue</h3>';
						 		//echo '<h3 class="hp-billboard-nav-h">'.get_editable_title(701).'</h3>';
						 		echo '<p class="hp-billboard-nav-text">Make smart financial decisions</p>';
						 		//echo '<p class="hp-billboard-nav-text">'.get_editable_furniture(701).'</p>';
						 	echo '</a> <!-- /.hp-billboard-nav-link -->';
					 	echo '</li>';
	
				 	echo '</ul> <!-- /.hp-billboard-nav -->';

				?>


					<!-- Slide Active Arrow -->
					<div class="hp-billboard-active-arrow-group">
						<div class="hp-billboard-active-arrow"></div>
					</div>
				
					<!-- Animated Dollar Sign --> 
					<img class="hp-billboard-dollar-img" src="<?php bloginfo('stylesheet_directory') ?>/_images/hp-illo-dollar.png" alt="Dollar Sign" />

	
				 	<section class="hp-billboard-slider">
	
					 	
					 	
					 	<article class="hp-billboard-block slide col-1 advice-slide">
							<!-- Billboard Image -->
							<div class="hp-billboard-img-container col-1">
								<img class="hp-billboard-img" src="<?php bloginfo('stylesheet_directory')?>/_images/hp-illo2.png" alt="Illustration - Tools You Can Trust From Reliable Experts" />
							</div> <!-- hp-billboard-img-container -->
	
							<!-- Billboard Headline -->
						 	<hgroup class="hp-billboard-hgroup col-2">
						 		<h5 class="hp-billboard-lead-overline"><?php
						 			//$ti = get_post_info(699);
						 			//echo $ti->post_title;
						 			echo 'Independent Advice';
						 		?></h5>
						 		<h3 class="hp-billboard-lead-h"><?php
						 			//echo get_editable_title(4355);
						 			echo "Tools you can trust from a reliable source";
						 		?></h3>
						 		<p class="hp-billboard-lead-text"><?php
						 			//echo get_editable_furniture(4355);
						 			echo "Square away your finances or deal with a particular issue with tools and information from the Financial Security Project at Boston College.";
						 		?></p>
                                <a class="button home-slide-link" href="/about">Learn More About Us</a>
						 	</hgroup> <!-- /.hp-billboard-hgroup -->
					 	</article>
					 	
					 	<article class="hp-billboard-block slide col-2 how-slide">
							<!-- Billboard Image -->
							<div class="hp-billboard-img-container col-1">
								<img class="hp-billboard-img" src="<?php bloginfo('stylesheet_directory')?>/_images/hp-illo3.png" alt="Illustration - A Simple Path from Plan to Action" />
							</div> <!-- hp-billboard-img-container -->
	
							<!-- Billboard Headline -->
						 	<hgroup class="hp-billboard-hgroup col-2">
						 		<h5 class="hp-billboard-lead-overline">Square Away Your Finances</h5>
						 		<h3 class="hp-billboard-lead-h">Get a plan & live your life better</h3>
						 		<p class="hp-billboard-lead-text"><?php /*?><?php
						 			echo get_editable_furniture(4340);
						 		?><?php */?>We’ll help you make a list of things to do – it’s often not that long! – then help you knock things down, one at a time.
                                </p>
						 		<a class="button home-slide-link" href="/getting-squared-away">Build a Personal Plan</a>
						 	</hgroup> <!-- /.hp-billboard-hgroup -->
					 	</article>
                        
                        <article class="hp-billboard-block slide col-3 approach-slide">
							<!-- Billboard Image -->						
							<div class="hp-billboard-img-container col-1">
								<img class="hp-billboard-img" src="<?php bloginfo('stylesheet_directory') ?>/_images/hp-illo1.png" alt="Illustration - Make Smarter Financial Decisions & Live Your Life" />
							</div> <!-- hp-billboard-img-container -->
	
							<!-- Billboard Headline -->
						 	<hgroup class="hp-billboard-hgroup col-2">
						 		<h5 class="hp-billboard-lead-overline"><?php
						 			//$ti = get_post_info(697);
						 			//echo $ti->post_title;
						 			echo 'Deal with an issue';
						 		?></h5>
						 		<h3 class="hp-billboard-lead-h"><?php
						 			//echo get_editable_title(4335);
						 			echo 'Make smart financial decisions';
						 		?></h3>
						 		<p class="hp-billboard-lead-text"><?php
						 			//echo get_editable_furniture(4335);
						 			echo 'Money makes your life go around. So learn what you need to know, decide what to do, then do it – so your life will go around better.';
						 		?></p>
                                <a class="button home-slide-link" href="/topics">Explore an Issue</a>
						 	</hgroup> <!-- /.hp-billboard-hgroup -->
					 	</article>
                        
                      
				 	</section> <!-- /.hp-billboard-panes -->
	
				
				<section class="hp-billboard-arrow-group">
					<a href="#" class="hp-billboard-next-btn next">
						<span class="hp-billboard-arrow-text">Next</span>
						<span class="hp-billboard-arrow arrow-right-large"></span>
					</a>
					<a href="#" class="hp-billboard-prev-btn prev">
						<span class="hp-billboard-arrow-text">Prev</span>
						<span class="hp-billboard-arrow arrow-left-large"></span>
					</a>
				</section> <!-- /hp-billboard-arrow-group -->
				
			</div> <!-- /.hp-billboard-slidewrap -->

		</section> <!-- /.hp-billboard-tri-message  -->	

	</section> <!-- /.hp-up-page -->

	
		<section class="hp-downpage">
           
           <div class="search-holder">
           <label for="search">Ask a Question:</label><input id="search" name="search" type="text" class="instant-search ui-autocomplete-input search-large" placeholder="housing" />
           </div>
           
			<div class="width-bracket hp-downpage-width-bracket section-dark">
				<section class="hp-popular-programs col-2">
					<hgroup class="hp-pop-hgroup">
						<a class="hp-pop-h site-section-h" href="/topics">Topics</a>
						<ul class="square-filters hp-square-filters">
							<li class="square-filter-item hp-square-filter-item filter-active"><a class="trigger-qs" data-target="home-sort-everyday-money">Everyday Money</a></li>
							<li class="square-filter-item hp-square-filter-item"><a class="trigger-qs-how-tos trigger-qs" data-target="home-sort-reserves-insurance">Reserves &amp; Insurance</a></li>
							<li class="square-filter-item hp-square-filter-item"><a class="trigger-qs-lear-mores trigger-qs" data-target="home-sort-investments-debt">Investments &amp; Debt</a></li>
							<li class="square-filter-item hp-square-filter-item"><a class="trigger-qs-calculators trigger-qs" data-target="home-sort-housing">Housing &amp; Mortgages</a></li>
							<li class="square-filter-item hp-square-filter-item"><a class="trigger-qs-planners trigger-qs" data-target="home-sort-retirement">Retirement</a></li>							
						</ul>
					</hgroup>
					<section class="hp-square-tease-container">				
						<?php get_template_part( 'loop', 'home' ); ?>
					</section> <!-- /.hp-square-tease-container -->
				</section> <!-- /.hp-popular-programs -->
				
			</div> <!-- /.width-bracket -->

		</section> <!-- /.hp-downpage -->

<?php //get_sidebar(); ?>

<?php get_footer(); ?>
