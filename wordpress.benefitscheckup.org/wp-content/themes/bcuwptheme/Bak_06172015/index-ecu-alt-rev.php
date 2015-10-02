<?php
/*
Template Name: ECU Revised page alternate layout (homepage) 
*/

	get_header("ecu-rev"); ?>
			
			<div id="content">
				<div id="top-content" class="row-fluid">

                <div id="content" class="span12 main-content featured">
                
                                
                <?php // TODO: add in a custom field to enter top content via the editor, then just 
				      // move the content below into the custom field editor  ?>
                      			                
					<h2 class="feature">Am I Making the Most of My Money?</h2>
					<img src="/wp-content/uploads/2013/08/BCU-images_251x217_top.png" title="Women Smiling" alt="Women Smiling" class="alignright moveup">
                    <h3>It&#039;s easy to find out.</h3>
<p>Answer a few simple questions and get a personalized report with tips on how you can better manage your budget, save money, and set financial goals. It&#039;s free, confidential, and from a trusted source—the nonprofit National Council on Aging.</p><div class="spacer"></div>
					<a href="/esi-questions" class="btn-ga" data-gaCategory="economic-checkup" data-gaAction="start-economic-checkup">				<img src="/wp-content/uploads/2014/09/get-started-now.jpg"></a>
                  
                  <?php // end TODO ?>  
                    
<div class="row-fluid" style="clear:both">
	<div class="span4">
		<h4><a href="/protecting-yourself-from-scams-swindles/">Protect Yourself from Scams:</a></h4>
		<p>Discover how to avoid the most common scams targeting seniors</p>
	</div>
	<div class="span4">
		<h4><a href="/money-management-tools/">Manage Your Money:</a></h4>
		<p>Create a budget and see where to cut expenses</p>
	</div>
	<div class="span4">
		<h4><a href="http://www.ncoajobsource.org/" target="_blank">Find Work:</a></h4>
		<p>Define your skills, get training, and land a job</p>
	</div>
</div>
</div>

                        	
                </div>
                
				<div id="inner-content">
<div class="row-fluid">
			
				    <div id="main" class="span9 col-md-8" role="main">

					    <?php if (have_posts()) : while (have_posts()) : the_post(); ?>
					
					    	<?php the_content(); ?>
					
					    <?php endwhile; ?>	
					
					
					    <?php else : ?>
					    
    						<p>Nothing to see here...</p>
					
					    <?php endif; ?>
					
				    </div> <!-- end #main -->
				    
    				<div class="span3 col-md-4">
				   		<?php get_sidebar("connect"); ?>
				    </div>
				   </div> 
				</div> <!-- end #inner-content -->

<div id="horizontal-sidebar">
	<?php get_sidebar("horizontal"); ?>
</div>
    
			</div> <!-- end #content -->

<?php get_footer("ecu-rev"); ?>
