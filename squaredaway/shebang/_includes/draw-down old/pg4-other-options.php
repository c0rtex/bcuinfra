<!-- ================================= --> 
<!-- ! Introduction					   --> 
<!-- ================================= -->
	
	<article class="frame" data-nav="Introduction">
	

		<ul id="drawdown-options-list" class="intro-list">
			<li class="col-1 drawdown-option-item first">
				<?php
					$pi = get_post_info('use-your-house-3');
					echo '<img src="'.$pi->thumb_src.'">';
					echo '<h3 class="intro-header">'.get_editable_title($pi->ID).'</h3>';
					echo '<p class="intro-text">'.get_editable_furniture($pi->ID).'</p>';
				?>
			</li>
			<li class="col-2 drawdown-option-item">
				<?php
					$pi = get_post_info('tighten-your-belt');
					echo '<img src="'.$pi->thumb_src.'">';
					echo '<h3 class="intro-header">'.get_editable_title($pi->ID).'</h3>';
					echo '<p class="intro-text">'.get_editable_furniture($pi->ID).'</p>';
				?>
			</li>
			<li class="col-3 drawdown-option-item last">
				<?php
					$pi = get_post_info('return-to-work');
					echo '<img src="'.$pi->thumb_src.'">';
					echo '<h3 class="intro-header">'.get_editable_title($pi->ID).'</h3>';
					echo '<p class="intro-text">'.get_editable_furniture($pi->ID).'</p>';
				?>
			</li>
		</ul>
		
	
	</article>

