<section class="frame-container section" data-nav-section="step-1" data-nav-page="intro-page">

	<!-- ================================= --> 
	<!-- ! Introduction					   --> 
	<!-- ================================= -->
		
		<article class="frame" data-nav="Introduction">

				<ul id="drawdown-intro-list" class="intro-list">
					<li class="col-1 drawdown-intro-item intro-item first">
						<?php echo '<a class="intro-link" href="'.get_next_slide_link().'">';?><img class="intro-img" src="<?php echo get_template_directory_uri(); ?>/_images/_icons/annuities.png"></a>
						<?php
							$pi = get_post_info(3370);
							echo '<h3 class="intro-header">'.get_editable_title($pi->ID).'</h3>';
							echo '<p class="intro-text">'.get_editable_furniture($pi->ID).'</p>';
						?>
					</li>
					<li class="col-2 drawdown-intro-item intro-item">
						<?php echo '<a class="intro-link" href="'.get_next_slide_link().'">'; ?><img class="intro-img" src="<?php echo get_template_directory_uri(); ?>/_images/_icons/target.png"></a>
						<?php
							$pi = get_post_info('determine-what-you-need');
							echo '<h3 class="intro-header">'.get_editable_title($pi->ID).'</h3>';
							echo '<p class="intro-text">'.get_editable_furniture($pi->ID).'</p>';
						?>
					</li>
					<li class="col-3 drawdown-intro-item intro-item last">
						<?php echo '<a class="intro-link" href="'.get_next_slide_link().'">';?><img class="intro-img" src="<?php echo get_template_directory_uri(); ?>/_images/_icons/checklist.png"></a>
						<?php
							$pi = get_post_info('make-a-plan');
							echo '<h3 class="intro-header">'.get_editable_title($pi->ID).'</h3>';
							echo '<p class="intro-text">'.get_editable_furniture($pi->ID).'</p>';
						?>
					</li>
				</ul>
			
		
		</article>
		
	</section>
	
<!-- 

Tito couldn'tsee how to update the thumbnail in WP, 
so he removed this. But just in case we need it later ...

src="'.$pi->thumb_src. 

-->