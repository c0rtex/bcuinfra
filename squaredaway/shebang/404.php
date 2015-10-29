<?php
/**
 * The template for displaying 404 pages (Not Found).
 *
 * @package WordPress
 * @subpackage Boilerplate
 * @since Boilerplate 1.0
 */

get_header(); ?>
	
<article id="post-0" class="error404 not-found" role="main">
	<h1 class="error404-h"><?php _e( 'Not Found', 'boilerplate' ); ?></h1>
	<p class="error404-sub"><?php _e( 'Apologies, but the page you requested could not be found.', 'boilerplate' ); ?></p>

	<?php //get_search_form(); ?>
<!--
	<script>
		// focus on search field after it has loaded
		document.getElementById('s') && document.getElementById('s').focus();
	</script>
-->
</article> <!-- /.error-404 -->

				
<?php 
	get_sidebar();
	get_footer(); 
?>
