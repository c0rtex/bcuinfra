    <footer>

    </footer>
  </div> <!-- end of #container -->
	<!-- SCRIPT START footer-close.php -->

  
  <!-- scripts concatenated and minified via ant build script-->
<!--  <script src="_js/plugins.js"></script>
	<script src="_js/script.js"></script>-->
	<script type="text/javascript" src="/wp-content/scripts/jquery.css-transform.js"></script>
	<script type="text/javascript" src="/wp-content/scripts/jquery.animatecssrotatescale.js"></script>
	<script type='text/javascript' src='/wp-content/scripts/jquery.quicksand.js'></script> 
	<script type='text/javascript' src='/wp-content/scripts/jquery.total-storage.js'></script> 
	<script type='text/javascript' src='/wp-content/scripts/jquery.auto-complete.min.js'></script> 
	<script type='text/javascript' src='/wp-content/scripts/jquery.fixed-scroll.js'></script> 
	<script type='text/javascript' src='/wp-content/scripts/jquery.alphanumeric.pack.js'></script> 
	<script type='text/javascript' src='/wp-content/scripts/jquery.returnkey.js'></script> 
	<script type='text/javascript' src='/wp-content/scripts/jquery.count-to.js'></script> 
	<script type="text/javascript" src="/wp-content/scripts/jshashtable.js"></script>
	<script type="text/javascript" src="/wp-content/scripts/jquery.tools.min.js"></script>
	<script type="text/javascript" src="/wp-content/scripts/jquery.numberformatter-1.2.1.min.js"></script>
	<script type='text/javascript' src='/wp-content/scripts/jquery.slider-group.js'></script> 
	<script type="text/javascript" src="/wp-content/scripts/jquery.sailTo.js"></script>
	<script type="text/javascript" src="/wp-content/scripts/underscore.min.js"></script>
	<script type="text/javascript" src="/wp-content/scripts/jquery.hoverintent.min.js"></script>
	<script type="text/javascript" src="/wp-content/scripts/jquery.scrollTo-min.js"></script>
	<script type="text/javascript" src="/wp-content/scripts/jquery.simplemodal-1.4.2.js"></script>
	<script type="text/javascript" src="/wp-content/themes/shebang/shebang.js"></script>
	<script type="text/javascript" src="/wp-content/themes/shebang/js/shebang-excel-upload.js"></script>
	<script type="text/javascript" src="/wp-content/themes/shebang/js/shebang-stacked-bar.js"></script>
	<?php 	echo '<script type="text/javascript" src="'.get_bloginfo('template_url').'/js/jquery.numeric.js"></script>' ?>
	<?php 	echo '<script type="text/javascript" src="'.get_bloginfo('template_url').'/js/calculators-control-your-spending.js"></script>' ?>
	<?php 	echo '<script type="text/javascript" src="'.get_bloginfo('template_url').'/js/calculators-control-your-spending-where-people-spend-2.js"></script>' ?>
	
 <!-- WP-Minify JS --> 
  <?php
  	global $wp_query;
  	$pid = $wp_query->queried_object->ID;
  	$pi = get_post_info($pid);
  	if (is_single() || is_page()){
  		$pi = get_post_info($pid);
  		$files = array();
  		if ($pi->post_parent){
  			$parent  = get_post_info($pi->post_parent);
  			$files[] = $pi->post_type.'-'.$parent->post_name.'-'.$pi->post_name.'.js';	
  			$files[] = $pi->post_type.'-'.$parent->post_name.'.js';
  		} else {
  			$files[] = $pi->post_type.'-'.$pi->post_name.'.js';
  		}
  		foreach($files as $file){
			$php_js_path = $_SERVER['DOCUMENT_ROOT'].'/wp-content/themes/shebang/js/'.$file;
			if (file_exists($php_js_path)){
				$path = get_bloginfo( 'stylesheet_directory' ).'/js/'.$file.'?v=2';
				echo '<script type="text/javascript" src="'.$path.'"></script>';
			}
		}
  	}
  	echo shebang_get_js_files();
  	
	/* Always have wp_footer() just before the closing </body>
	 * tag of your theme, or you will break many plugins, which
	 * generally use this hook to reference JavaScript files.
	 */
	wp_footer();
?>
</body><!--./footer-close.php -->
</html>