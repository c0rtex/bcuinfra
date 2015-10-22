<?php
	include('_includes/planner-explanation.php');
?>
	
	</section> <!-- frame-container -->


		<!-- ================================= --> 
		<!-- ! Footer Nav (Front Page)		   --> 
		<!-- ================================= -->

		<footer class="footer-nav-front">
				<?php
					$np = get_next_slide();
					if ($np){
						echo '<a class="ftr-front-btn" href="'.$np->permalink.'">Get Started<span class="arrow-right-large"></span></a>';
					}
				?>
		</footer>
			
	</div> <!-- main -->

<?php //get_footer('close');
include('footer.php');
?>