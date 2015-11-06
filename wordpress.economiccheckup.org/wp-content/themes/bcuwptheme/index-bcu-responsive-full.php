<?php
/*
Template Name: BCU Responsive - Full Width
*/

	get_header("bcu-responsive"); ?>
			
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
    
			<?php get_footer("bcu-responsive"); ?>