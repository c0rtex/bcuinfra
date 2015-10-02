<?php
/*
Template Name: ECU Revised full width - no sidebar 
*/

	get_header("ecu-rev"); ?>
			
			<div id="content">
			
				<div id="inner-content" >
					<div class="row-fluid">
			
				    <div id="main" class="span12" role="main">

					    <?php if (have_posts()) : while (have_posts()) : the_post(); ?>
					
					    	<?php the_content(); ?>
					
					    <?php endwhile; ?>	
					
					
					    <?php else : ?>
					    
    						<p>Nothing to see here...</p>
					
					    <?php endif; ?>
					
				    </div> <!-- end #main -->
				</div>
				    
				</div> <!-- end #inner-content -->
    
			<?php get_footer("ecu-rev"); ?>

