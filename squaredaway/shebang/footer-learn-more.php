    <footer>

    </footer>
  </div> <!-- end of #container -->
	

  
  <!-- scripts concatenated and minified via ant build script-->
<!--  <script src="_js/plugins.js"></script>
  <script src="_js/script.js"></script>-->
  <script type='text/javascript' src='/wp-content/scripts/jquery.fixed-scroll.js'></script> 
  <script type='text/javascript' src='/wp-content/scripts/jquery.tools.min.js'></script> 
  <script type="text/javascript" src="<?php bloginfo( 'stylesheet_directory' ); ?>/js/jquery.scrollTo-min.js"></script>
  <script type="text/javascript" src="<?php bloginfo( 'stylesheet_directory' ); ?>/js/jquery.localscroll.js"></script>
  <script type="text/javascript" src="<?php bloginfo( 'stylesheet_directory' ); ?>/js/tito-base.js"></script>
  <script type="text/javascript" src="<?php bloginfo( 'stylesheet_directory' ); ?>/js/ari.js"></script>
  <?php
  	
	/* Always have wp_footer() just before the closing </body>
	 * tag of your theme, or you will break many plugins, which
	 * generally use this hook to reference JavaScript files.
	 */
	wp_footer();
?>
</body>
</html>