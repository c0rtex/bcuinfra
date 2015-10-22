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

	
	<section class="generic-page-body">
        <section class="credits-container">
            <article class="about-testimonials col-1">
            <h1 class="credits-h1">Credits</h1>
                    <h2 class="credits-h2">DIRECTOR, CENTER FOR RETIREMENT RESERCH</h2>
                        <p class="credits-names">Alicia Munnell, <span class="credits-organizations"> Center for Retirement Research at Boston College</span></p>
                    <h2 class="credits-h2">PROGRAM DEVELOPMENT & CONTENT CREATION</h2>
                        <p class="credits-names">Steven Sass, Anek Belbase, Christine Polek, Zackary Kleinbart. <span class="credits-organizations">Center for Retirement Research at Boston College</span></p>
                        <p class="credits-names">Ronn Campisi. <span class="credits-organizations">Ronn Campisi Design</span></p>
                    <h2 class="credits-h2">CRITICAL ADVISORS</h2>
                        <p class="credits-names">David Laibson, Brigitte Madrian. <span class="credits-organizations">Harvard University</span></p>
                        <p class="credits-names">Rick Miller.<span class="credits-organizations">Sensible Financial Planning</span></p> 
                        <p class="credits-names">Kimberly Blanton, Norma Coe, Andrew Eschtruth, Richard Kopcke, Matthew Rutledge, Francis Vitagliano, Anthony Webb, April Wu. 		<span class="credits-organizations">Center for Retirement Research at Boston College</span></p> 
                    <h2 class="credits-h2">FINANCE & ADMINISTRATION</h2>
                        <p class="credits-names">Marina Tsiknis, Ryan Carroll. <span class="credits-organizations">Center for Retirement Research at Boston College</span></p> 
                    <h2 class="credits-h2">WEB DESIGN, DEVELOPMENT & ART DIRECTION</h2>
                        <p class="credits-names">Tito Bottita, Jared Novack, Michael Swartz, Ari Rizzitano. <span class="credits-organizations">Upstatement</span></p> 
                        <p class="credits-names">Adam Sontag, <span class="credits-organizations">Bocoup</span></p> 

            </article>
            
            <article class="about-director col-2">
               		<img class="credits-logo-img" src="/wp-content/themes/shebang/_images/FSPlogo_credits.png"><div class="clear"></div><p class="credits-overview">The Financial Security Project was established in 2009 through a grant from the U.S. Social Security Administration and is an initiative of the Center for Retirement Research at Boston College.  Our mission is to help people make smart decisions throughout their lives so they are financially secure at retirement.
</p>

            </article>
            
        </section>

            
	</section> <!-- /.generic-page-body -->

</section><!-- #post-## -->
				

<?php endwhile; ?>
<?php //get_sidebar(); ?>
<?php get_footer(); ?>