<?php
/*
Template Name: ECU Eversafe with sidebar 
*/

	get_header("eversafe"); ?>
			
			<div id="content">
			
				<div id="inner-content">
					<div class="row-fluid">
			
				    <div id="main" class="span9 col-md-9" role="main">

					    <?php if (have_posts()) : while (have_posts()) : the_post(); ?>
					
					    	<?php the_content(); ?>
					
					    <?php endwhile; ?>	
					
					
					    <?php else : ?>
					    
    						<p>Nothing to see here...</p>
					
					    <?php endif; ?>
					
				    </div> <!-- end #main -->
				    
    				<div class="span3 col-md-3">
				   		<?php get_sidebar("ecu-rev"); ?>
				    </div>

				</div>
				    
				</div> <!-- end #inner-content -->
    
			</div> <!-- end #content -->

<?php get_footer("eversafe"); ?>
