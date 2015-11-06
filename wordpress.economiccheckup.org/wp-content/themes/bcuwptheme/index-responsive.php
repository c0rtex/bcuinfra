<?php
/*
Template Name: Responsive Test
*/

	get_header("responsive"); ?>
			
			<div id="content">
			
				<div id="inner-content" class="row">
			
				 

					    <?php if (have_posts()) : while (have_posts()) : the_post(); ?>
					
					    	<?php the_content(); ?>
					
					    <?php endwhile; ?>	
					
					
					    <?php else : ?>
					    
    						<p>Nothing to see here...</p>
					
					    <?php endif; ?>
    
			</div> <!-- end #content -->

<?php get_footer("responsive"); ?>
