<?php
/*
Template Name: MQC Revised
*/

	get_header("mqc-rev"); ?>
			
			<div id="content">
			
				<div id="inner-content" class="row-fluid">
			
				    <div id="main" class="span12 col-md-8" role="main">
                       <?php // we need to add a fluid row because the content contains built in responsive code ?>
                       <div class="row-fluid">
                    

					    <?php if (have_posts()) : while (have_posts()) : the_post(); ?>
					
					    	<?php the_content(); ?>
					
					    <?php endwhile; ?>	
					
					
					    <?php else : ?>
					    
    						<p>Nothing to see here...</p>
					
					    <?php endif; ?>
						</div>
				    </div> <!-- end #main -->
				    
    				<!--<div class="col-md-3">
				   		<?php // create a new template with this sidebar - get_sidebar("responsive"); ?>
				    </div>-->
				    
				</div> <!-- end #inner-content -->
    
			</div> <!-- end #content -->

<?php get_footer("mqc-rev"); ?>
