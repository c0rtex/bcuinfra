<?php
/**
 * The Template for displaying all single posts.
 *
 * @package WordPress
 * @subpackage Boilerplate
 * @since Boilerplate 1.0
 */
get_header(); 
get_header('planner'); 
?>

<?php if ( have_posts() ) while ( have_posts() ) : the_post(); ?>
				
				<article id="post-<?php the_ID(); ?>" <?php post_class(); ?>>
					<?php
						$pi = get_post_info(get_the_ID());
						if ($pi->banner){
							echo '<div class="frame-title-container">';
							echo '<p class="frame-title">'.get_editable_custom('banner').'</p>';
							echo '</div>';
						}
						echo '<hgroup class="frame-hgroup">';
						if ($pi->h1){
							echo '<h1 class="frame-h1">'.get_editable_custom('h1').'</h1>';
						}
						if ($pi->h2){
							echo '<h2 class="frame-h2">'.get_editable_custom('h2').'</h2>';
							
						}
						echo '</hgroup>';
						$pp = get_previous_slide();
						if ($pp){
							echo '<a class="sticky-btn-prev" href="'.$pp->permalink.'"></a>';
						}
						$np = get_next_slide();
						if ($np){
							echo '<a class="sticky-btn-next" href="'.$np->permalink.'"></a>';
						}
						if ($pi->include){
							include('_includes/'.$pi->include);
						}
						
						
					?>
					<footer class="planner-entry-utility">
						<?php edit_post_link( __( 'Edit', 'boilerplate' ), '<span class="edit-button">', '</span>' ); ?>
					</footer><!-- .entry-utility -->
				
					<div class="entry-content">
						<?php wp_link_pages( array( 'before' => '' . __( 'Pages:', 'boilerplate' ), 'after' => '' ) ); ?>
					</div><!-- .entry-content -->

					
				</article><!-- #post-## -->
			

<?php //get_sidebar(); 
?>
<?php 
$pi = get_post_info();
if ($pi->post_parent == 0){
	get_footer('planner-front');
} else {
	get_footer('planner');
}
?>
<?php endwhile; // end of the loop. 

?>