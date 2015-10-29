<?php
/**
 * The template for displaying all pages.
 *
 * This is the template that displays all pages by default.
 * Please note that this is the wordpress construct of pages
 * and that other 'pages' on your wordpress site will use a
 * different template.
 *
 * @package WordPress
 * @subpackage Boilerplate
 * @since Boilerplate 1.0
 */

get_header(); ?>
<?php if ( have_posts() ) while ( have_posts() ) : the_post(); ?>

<section id="post-<?php the_ID(); ?>" <?php post_class(); ?>>

	<header class="page-hdr generic-page-header">
	
		<!-- Breadcrumb -->
		<ul class="article-breadcrumb">
			<li class="article-bc-item"><a href="/">Home</a></li>
			<?php
				$uri = $_SERVER['REQUEST_URI'];
				$pieces = explode("/", $uri);
				for ($i = 1; $i<count($pieces) -1; $i++){
					echo '<li class="article-bc-item"><a href="/'.$pieces[$i].'">'.ucfirst($pieces[$i]).'</a></li>';
				}
			?>
		</ul> <!-- /.article-breadcrumb -->
		
		<hgroup class="page-hgroup generic-page-hgroup">
			<h1 class="page-h generic-page-h">
				<?php the_title(); ?></h1>
		</hgroup>

	</header> <!-- /.page-hdr -->
	
	
	<section class="generic-page-body">
		
		<?php
			$posts =	get_posts(array(
							'numberposts' => 100,
							'orderby' => 'post_title',
							'post_type' => array('calculators', 'learn-more', 'how-to'),
							'post_parent' => 0,
						));
			foreach($posts as $post){	
				$pi = get_post_info($post->ID);
				echo '<li class="search-result">';
				echo '<img class="search-result-img" src="'.$pi->thumb_src.'" />';
				echo '<a class="search-result-h" href="'.$pi->permalink.'">'.$pi->post_title.'</a> <strong>'.$pi->post_name.'</strong>';
				echo '<a class="subheader-tag '.$pi->post_type.'-tag">'.$pi->post_type_info->labels->singular_name.'</a>';
				echo '<p class="search-result-description">';
				echo truncate_simple(strip_tags($pi->post_content), 145);
				if (get_current_user_id() == 1){
					echo ' <a href="/wp-admin/post.php?post='.$pi->ID.'&action=edit">Edit</a> ';
				}
				echo '</p></li>';
	
    
			}
		?>


		<article class="entry-content col-1">
			<?php the_content(); ?>
			<?php wp_link_pages( array( 'before' => '' . __( 'Pages:', 'boilerplate' ), 'after' => '' ) ); ?>
			<?php edit_post_link( __( 'Edit', 'boilerplate' ), '', '' ); ?>
		</article><!-- .entry-content -->
		
		<aside class="generic-page-aside col-2">
			
			
			
		</aside> <!-- /.generic-page-aside -->
	
	</section> <!-- /.generic-page-body -->

</section><!-- #post-## -->
				

<?php endwhile; ?>
<?php get_sidebar(); ?>
<?php get_footer(); ?>