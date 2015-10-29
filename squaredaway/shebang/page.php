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

		<article class="entry-content col-1">
			<?php 
			if (strlen(get_the_content())){
				the_content(); 
			} else {
				include('_includes/coming-soon.php');
			}
			
			?>
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