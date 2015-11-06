<?php
/*
Template Name: BCU Responsive - Homepage 
*/

	get_header("bcu-responsive"); ?>
			
			<div id="content">
				
                
				<div id="inner-content" class="row-fluid">
			
					    <div id="main" class="span9 col-md-8" role="main">
	
						    <?php if (have_posts()) : while (have_posts()) : the_post(); ?>
						
						    	<?php the_content(); ?>
						
						    <?php endwhile; ?>	
						
						
						    <?php else : ?>
						    
	    						<p>Nothing to see here...</p>
						
						    <?php endif; ?>
						
					    </div> <!-- end #main -->
					    
	    				<div class="span3 col-md-4">
					   		<?php get_sidebar("bcu-responsive"); ?>
					    </div>
				</div> <!-- end #inner-content -->
    
			</div> <!-- end #content -->

<?php get_footer("bcu-responsive"); ?>
