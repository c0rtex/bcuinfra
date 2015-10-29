<?php
/**
 * The template for displaying all pages.
 *
 * This is the template that displays all pages by default.
 * Please note that this is the wordpress construct of pages
 * and that other 'pages' on your wordpress site will use a
 * different template.
 *
 * @package WordPress
 * @subpackage Boilerplate
 * @since Boilerplate 1.0
 */

get_header(); ?>
<?php if ( have_posts() ) while ( have_posts() ) : the_post(); ?>

<section id="post-<?php the_ID(); ?>" <?php post_class(); ?>>

	<div class="frame-title-container">
		<p class="frame-title">My Squared Away</p>
        
        </div>
		
		<div class="gsa-title">
			<h1 class="page-h generic-page-h gsa-h1">
				<?php the_title(); ?></h1>
		<h2 class="gsa-intro"><?php the_content(); ?></h2>
</div>
	</header> <!-- /.page-hdr -->
	
	
	<section class="generic-page-body">
        <section class="gsa-selection-container ">
        	<div class="gsa-selections">
            <article class="gsa-selection" id="gsa-picker-age">
            <img src="wp-content/themes/shebang/_images/cake.png" width="46"/>
<h3>Age</h3>
                <p class="gsa-selection-description">Knowing your age range helps us know what information applies to you.</p>
                    <ul>
                    	<?php
                    		$ages = get_terms('ages');
                    		foreach($ages as $age){
                    			$term = get_term_info($age->term_id);
                    			$lss = unserialize($term->life_stages);
                    			$tids = array();
                    			foreach($lss as $ls){
                    				$stage = get_term_info($ls);
                    				$tids[] = $stage->term_id;
                    			}
                    			echo '<li class="gsa-selection-item"><a href="#" class="trigger-age" data-valid-life-stages="'.implode(',',$tids).'">'.$age->name.'</a></li>';
                    		}
                    	?>
                    </ul>
            </article>
            
               <article class="gsa-selection" id="gsa-picker-life-stage">
               <img src="wp-content/themes/shebang/_images/lifeevent.png" width="46"/>
                <h3>Where Are You In Life?</h3>
                <p class="gsa-selection-description">What big events have happend (or about to) in your life?</p>
                    <ul class="gsa-selection-life-stages">
                    	<?php
                    		$stages = get_terms('life-stages');
                    		foreach($stages as $stage){
                    			echo '<li class="gsa-selection-item" data-life-stage-id="'.$stage->term_id.'"><a href="#" class="trigger-life-stage" data-life-stage-slug="'.$stage->slug.'" data-life-stage-id="'.$stage->term_id.'">'.$stage->name.'</a></li>';
                    		}
                    	?>
                    </ul>
            </article>
            
               <article class="gsa-selection"  id="gsa-picker-issue">
               <img src="wp-content/themes/shebang/_images/focus.png" width="49" />
                <h3>Issue</h3>
                <p class="gsa-selection-description">Let us know what topic is on your mind so we can focus on that.</p>
                    <ul>
                    	<?php
                    		$issues = get_terms('post_tag');
                    		foreach($issues as $issue){
                    			echo '<li class="gsa-selection-item"><a href="#" class="trigger-issue" data-issue-slug="'.$issue->slug.'">'.$issue->name.'</a></li>';
                    		}
                    	?>
                        
                    </ul>
            </article>
            </div>
        </section>
        
        	
<section id="gsa-before-finished" class="gsa-before-finished">
<img src="/wp-content/themes/shebang/_images/notepad.png" />
<h2 class="gsa-before-finished-h">Your Personalized Financial Plan will Appear Here</h2>
</section>

<!-- if no results -->

            
            	<?php
            		$steps = get_tax('steps');
            		osort($steps, 'weight');
            		$j = 1;
            		$queue = get_option('queue');
            		foreach($steps as $step){
            			echo '<section class="gsa-results-container">';
            			echo '<article class="gsa-results-description col-1">';
            			echo '<h3>Step '.$j.'</h3>';
            			echo '<h2>'.$step->name.'</h2>';
            			echo '<p>'.$step->description.'</p>';
            			echo '<a href="#" class="gsa-results-description-link trigger-see-more trigger-see-more-or-less">See More</a>';
            			echo '</article>';
            			
            			$terms = get_terms('life-stages');
            			foreach($terms as $term){
            				echo '<article class="listing-square-group col-2" data-life-stage-slug="'.$term->slug.'">';
            				$squares = $queue['ls-'.$term->term_id]['step-'.$step->term_id];
            				if (count($squares)){
								foreach($squares as $square){
									$pi = get_post_info($square);
									include('template-types.php');
								}
 							} else {
 								echo '<section class="gsa-no-results-container"><h2 class="gsa-no-results">';
 								echo 'There are no Solutions for this Section';
 								echo '</h2></section>';
 							}
            				echo '</article>';
            			}
            			
            			echo '</section>';
            			$j++;
            		}
            	?>
                
                
            
		<section class="gsa-bottom-container">
			<div class="gsa-button-container">
				<a class="footer-nav-button print trigger-print" href="#">Print this Page as a Checklist</a>
			
			
				<a class="footer-nav-button bookmark next trigger-bookmark" href="#">Bookmark this Page for Later</a>
			</div>
		</section>
	</section> <!-- /.generic-page-body -->

</section><!-- #post-## -->
				

<?php endwhile; ?>
<?php //get_sidebar(); ?>
<?php get_footer(); ?>