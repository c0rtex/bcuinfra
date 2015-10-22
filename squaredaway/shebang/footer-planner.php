<?php
	include('_includes/planner-explanation.php');
?>
	
	</section> <!-- frame-container -->


		<!-- ================================= --> 
		<!-- ! Footer Nav					   --> 
		<!-- ================================= -->

		<footer class="footer-nav">
			<div class="col-1">
				<?php
					$np = get_next_slide();
					if ($np){
						//echo '<a class="footer-nav-button next" href="'.$np->permalink.'">'.$np->post_title.'<span class="arrow-right-large"></span></a>';
						echo '<a class="footer-nav-button next" href="'.$np->permalink.'">Next<span class="arrow-right-large"></span></a>';
					}
				?>
				
			</div> <!-- col-1 -->

			<div class="col-2">
				<?php
					$pp = get_previous_slide();
					if ($pp){
						//echo '<a class="footer-nav-button prev" href="'.$pp->permalink.'"><span class="arrow-left-large"></span>'.$pp->post_title.'</a>';
						echo '<a class="footer-nav-button prev" href="'.$pp->permalink.'"><span class="arrow-left-large"></span>Back</a>';
					}
				?>
			</div> <!-- col-2 -->

			<div class="footer-page-count">
				<span class="page-count-current"><?php echo get_slide_position(); ?></span> of <span class="page-count-total"><?php echo get_slide_count(); ?></span>
			</div>
			
		</footer>
			
	</div> <!-- main -->

<?php //get_footer('close');
include('footer.php');
?>