<!-- ================================= --> 

<!-- ! Article Container & Body		   --> 

<!-- ================================= -->

<section class="article-container">
	
	<section class="article-body">
		
		<div >

                    <div class="span12">
			<!-- Column 1: Article Navigation -->			
			<div class="span2">
				<article >
					<ul class="article-body-nav">
						<?php 
						/* --------------- Menu Parent Loop ---------------- */
						
						$link_args = array('showposts' => 20, 'post_parent' => get_the_ID(), 'post_type' => $pi->post_type, 'orderby' => 'menu_order', 'order' => 'ASC');
						$link_query = new WP_Query($link_args);
						$linknum = 1;
						while ($link_query->have_posts()) : $link_query->the_post(); ?>
						<li id="<?php echo 'article-body-nav-item-'.$linknum; ?>" class="article-body-nav-item <?php if ($linknum==1) {echo 'item-active';} ?>">
							<!--<a href="#block-<?php //echo get_the_ID(); ?>"><?php //echo get_the_title(); ?></a></li> -->
							<?php $linknum++; ?>
<!--NOTE: the titles include subtitles in themselves -->
						<?php 
						endwhile;
						wp_reset_postdata();
						?>
						
					</ul> <!-- /.article-body-nav -->		 		
					
					<article id="article-addthis" class="article-body-nav-share">  
						<?php include('_includes/share-tools.php'); ?>
					</article>
				
				</article> <!-- /.fixed-article-body-nav -->
				
			</div> <!-- now span2, formerly /.col-1 /.article-body-nav-col -->


			<!-- Column 2: Article Content -->
			<div class="span10">
				
			<?php
			/* --------------- Parent Loop ---------------- */
			
			$parent_args = array('showposts' => 20, 'post_parent' => get_the_ID(), 'orderby' => 'menu_order', 'order' => 'ASC', 'post_type' => $pi->post_type);
			$parent_query = new WP_Query($parent_args);
			$linknum = 1;
			if(!$parent_query->post_count){
				echo '<article id="post-0" class="construction-group not-found" role="main">';
				echo '<h1 class="construction-h">'.get_editable_title(1265).'</h1>';
				echo '<p class="construction-sub">'.get_editable_furniture(1265).'</p>';
				echo '</article>';
			}
			$i = 0;
			while ($parent_query->have_posts()) : $parent_query->the_post(); 
				$child = get_post_info();
				?>
				
				<!-- Article Block -->
				<article class="ui-article-block" id="block-<?php echo get_the_ID(); ?>">
					<?php 
					if ($child->h1){
						update_post_meta($child->ID, 'big-heading', $child->h1);
					}
					if ($child->h2){
						update_post_meta($child->ID, 'small-heading', $child->h2);
					}
					$bigheading = get_post_meta(get_the_ID(), 'big-heading', true);
					if ($bigheading != '') {
						echo '<h2 class="article-h1">'.get_editable_custom('big-heading').'</h2>';
					}
					$smallheading = get_post_meta(get_the_ID(), 'small-heading', true);
					if ($smallheading != '') {
						echo '<h3 class="article-h2">'.get_editable_custom('small-heading').'</h3>';
					}
					?>
					<div class="article-text"><?php 
						$has_media = shebang_display_slide_media(get_the_ID());
						if (!$has_media){
							the_content();
							shebang_edit_link(0, 'Edit Slide', 'button');
						}
					?></div>

					
					<?php
					/* --------------- Child Loop ---------------- */
					
					$child_args = array('showposts' => 20, 'post_parent' => get_the_ID(), 'orderby' => 'menu_order', 'order' => 'ASC', 'post_type' => 'any');
					$child_query = new WP_Query($child_args);
					$linknum = 1;
					//print_r($child_query);
					while ($child_query->have_posts()) : $child_query->the_post();
						$img = getPostImageSrc(get_the_ID());
						
						$video = get_post_meta(get_the_ID(), 'video-url', true);
						$displaystyle = get_post_meta(get_the_ID(), 'img-display-style', true);
						$vidid = '';
						if ($video != '') {
							$pos = strpos($video, 'youtube');
							if ($pos !== false) {
								$vidid = substr($video, 31, 11);
							}
						}
						if ($vidid != '') { ?>
							<!-- UI Pattern: Art Caption -->
							<div class="ui-pattern-art-caption">					
								<div class="article-large-art-container col-1">
									<div class="article-large-img">
										<iframe width="400" height="205" src="http://www.youtube.com/embed/<?php echo $vidid; ?>" frameborder="0"></iframe>
									</div>
								</div> <!-- /.article-small-art-container -->
								
								<div class="article-caption-col col-2">
									<p><strong><?php echo get_editable_title(); ?></strong></p>
									<?php
										$pi = get_post_info();
									?>
									<?php the_content(); ?>
									<?php shebang_edit_link(0, 'Edit Slide', 'button'); ?>
								</div> <!-- /.article-text /.col-2-->
	
							</div> <!-- /.ui-pattern-art-caption -->
						<?php } else if ($img != '') { ?>
							<?php if ($displaystyle == 'Large Image') { ?>
								<!-- UI Pattern: Art Caption -->
								<div class="ui-pattern-art-caption">					
									<div class="article-large-art-container col-1">
										<?php
											$img_src = get_post_thumbnail(get_the_ID(), 255);
										?>
										<img class="article-large-img" src="<?php echo $img_src; ?>"/>
									</div> <!-- /.article-small-art-container -->
									
									<div class="article-caption-col col-2">
										<p><strong><?php echo get_editable_title(); ?></strong></p>
										<?php the_content(); ?>
										<?php shebang_edit_link(0, 'Edit Slide', 'button'); ?>
									</div> <!-- /.article-text /.col-2-->
		
								</div> <!-- /.ui-pattern-art-caption -->
							<?php } else { ?>
								<!-- UI Pattern: Small Art -->
								<div class="ui-pattern-small-art">					
									<div class="article-small-art-container col-1">
										<?php
											$img_src = get_post_thumbnail(get_the_ID(), 255);
										?>
										<img class="article-small-img" src="<?php echo $img_src; ?>" />
									</div> <!-- /.article-small-art-container -->
									
									<div class="article-text col-2">
										<h4 class="article-h3"><?php echo get_editable_title(); ?></h4>
										<?php the_content(); ?>
										<?php shebang_edit_link(0, 'Edit Slide', 'button'); ?>
									</div> <!-- /.article-text /.col-2-->
		
								</div> <!-- /.ui-pattern-small-img -->
							<?php } ?>
						<?php } else { ?>
							<!-- UI Pattern: Simple Text -->
							<div class="ui-pattern-simple-text">					
								<h4 class="article-h3"><?php echo get_editable_title(); ?></h4>
								<?php the_content(); ?>
								<?php shebang_edit_link(0, 'Edit Slide', 'button'); ?>
							</div> <!-- /.ui-pattern-simple-text -->
						<?php } 
					endwhile;
					wp_reset_postdata();
					$i++;
					if ($i == $parent_query->post_count && $pi->post_type != 'calculators'){
						echo '<a href="#" class="print-btn article-body-print-btn trigger-print" style="margin-bottom: 50px" ><span class="print-btn-icon"></span>Print</a>';
					}
					
					?>
					
				</article> <!-- /.ui-article-block -->
				
			<?php endwhile;
			wp_reset_postdata();
			?>
				<?php
					if ($pi->post_type != 'calculators'){
						
					}
				?>

			</div> <!-- /.article-content-col -->
	</div> <!-- span 5 -->	
		</div> <!-- /formerly .article-body-col-group, now row-fluid -->
	
	</section> <!-- article-body -->
	
</section> <!-- article-container -->
