  
  <footer class="global-ftr section-dark">

		<section class="global-ftr-info col-1">

			<!-- Logo -->
			<h1 class="global-ftr-logo-container"><a href="http://fsp.bc.edu/" target="_blank">
				<img class="global-ftr-logo" src="<?php bloginfo('stylesheet_directory'); ?>/_images/fsp-logo-reverse.png" alt="The Financial Security Project at Boston College" />
			</a></h1>

			<p class="global-ftr-info-txt info-tag">From <a href="http://fsp.bc.edu/" target="_blank">The Financial Security Project</a> at Boston College</p>
			
			<p class="global-ftr-info-txt info-copyright">&copy; 2012 Trustees of Boston College, Center for Retirement Research</p>

		</section> <!-- /.global-ftr-info -->	
		
		<section class="global-ftr-links col-2">

			<!-- Topics -->
			<article class="global-ftr-link-group link-group-topics col-1">
				<h3 class="global-ftr-link-h"><a href="/topics/">Topics</a></h3>
				<?php
					echo shebang_get_footer_menu('topics');
				?>
			</article> <!-- /.global-ftr-link-topics  -->

			<!-- Life Stages -->
			<article class="global-ftr-link-group link-group-life-stages col-2">
				<h3 class="global-ftr-link-h"><a href="/life-stages/">Life Events</a></h3>
				<?php
					echo shebang_get_footer_menu('life-stages');
				?>
			</article> <!-- /.global-ftr-link-life-stages  -->

			<!-- Tools -->
			<article class="global-ftr-link-group link-group-tools col-3">
				<h3 class="global-ftr-link-h"><a href="/tools/">Tools</a></h3>
				<?php
					echo shebang_get_footer_menu('tools');
				?>
			</article> <!-- /.global-ftr-link-tools -->

			<!-- More -->
			<article class="global-ftr-link-group link-group-more col-4">
				<h3 class="global-ftr-link-h"><a href="/about/">More</a></h3>
				<?php
					echo shebang_get_footer_menu('more');
				?>
			</article> <!-- /.global-ftr-link-more  -->		
		
		</section> <!-- /.global-ftr-links -->

    </footer> <!-- /.global-ftr -->
	

  
  <!-- scripts concatenated and minified via ant build script-->
<!--  <script src="_js/plugins.js"></script>
  <script src="_js/script.js"></script>-->
  <script type='text/javascript' src='/wp-content/scripts/jquery.fixed-scroll.js'></script> 
  <script type='text/javascript' src='/wp-content/scripts/jquery.tools.min.js'></script> 

  <script type='text/javascript' src='/wp-content/scripts/jquery.hoverintent.min.js'></script> 
  <script type='text/javascript' src='/wp-content/scripts/jquery-ui-core.min.js'></script>
  <script type="text/javascript" src="<?php bloginfo( 'stylesheet_directory' ); ?>/js/jquery.scrollTo-min.js"></script>
  <script type="text/javascript" src="<?php bloginfo( 'stylesheet_directory' ); ?>/js/jquery.localscroll.js"></script>
  <script type="text/javascript" src="<?php bloginfo( 'stylesheet_directory' ); ?>/js/tito-base.js"></script>
  <script type="text/javascript" src="<?php bloginfo( 'stylesheet_directory' ); ?>/js/ari.js"></script>
  <script type="text/javascript" src="<?php bloginfo( 'stylesheet_directory' ); ?>/js/shebang-site.js"></script>
  <script type="text/javascript" src="/wp-content/scripts/jquery.ui.autocomplete.js"></script>
   
 <?php
 	include('footer-close.php');
 ?>