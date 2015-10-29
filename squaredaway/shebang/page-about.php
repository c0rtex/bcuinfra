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

	<div class="about-header-container">
        <article class="about-header-image col-1">
            <img class="about-header-img" src="/wp-content/themes/shebang/_images/aboutimage.png" />
        </article>
    
        <article class="about-header-description col-2">
            <h1 class="page-h generic-page-h about-h1">About Squared Away</h1>
            <p class="about-header-intro"><img class="about-fsplogo-img" src="/wp-content/themes/shebang/_images/FSPlogo_about.png">Squared Away was created by the Center for Retirement Research at Boston College and funded by a grant from the U.S. Social Security Administration, to provide clear and engaging financial guidance, without any spin or slant, based on the best academic research.</p>
            
        </article>
    </div>
		
	</header> <!-- /.page-hdr -->
	
	
	<section class="generic-page-body">
        <section class="about-first-container ">
            <article class="about-testimonials col-1">
            	<div class="about-testimonial">
                    <h3>"It is an excellent resource and I like that you come away with a plan to execute."</h3>
                        <p>– Jane Smith</p>
                </div>
                <div class="about-testimonial">
                    <h3>"… a comprehensive site with a lot of inspiring tips on looking deeper for information elsewhere."</h3>
                        <p>– John Smith</p>
                </div>
            </article>
            
            <article class="about-director col-2">
               <h2 class="about-director-h3">Director's Message</h2>
               		<img class="about-director-img" src="http://squaredaway.bc.edu/wp-content/themes/shebang/_images/about-alicia.jpg"><p>Welcome to Squared Away brought to you by the  Financial Security Project at Boston College. I understand the compelling need to help individuals make better financial decisions, because I've made my own share of missteps.</p>
<p>And, especially in today's economic climate, it's not easy to know what to do. But we can help by offering clear and engaging guidance without any spin or slant. Come explore what we have to offer... and please let us know what you think.</p>
<img class="about-director-sig" src="wp-content/themes/shebang/_images/sig.png"><div class="clearfix"></div>
<p>Alicia Munnell</p>
            </article>
            
        </section>

            <section class="about-second-container">
                <article class="about-experience col-1">
                <img class="about-experience-img" src="/wp-content/themes/shebang/_images/bulb.png" />
                <h3>Years of Experience</h3>
                <p>Squared Away relies on the contributions of experts in economics and finance as well as writers and designers skilled in creating successful learning environments to provide clear, engaging and reliable advice tailored to you needs.</p>
                </article>
             
          
            
                <article class="about-experience col-2">
                <img class="about-experience-img" src="/wp-content/themes/shebang/_images/helpdesk.png" />
                <h3>How we Help</h3>
                <p>This site is designed to get you straight to the information you need to make ends meet, plan for the unexpected, or secure a better future for you and your family. You can search for something specific, explore an issue, or build a personal plan.</p>
                </article>
             
           
                <article class="about-experience col-3">
                <img class="about-experience-img" src="/wp-content/themes/shebang/_images/money.png" />
                <h3>Nothing to Sell</h3>
                <p>Get unbiased financial guidance without sales pitches or advertisements. We don't push any commercial products or services, nor do we sell or transfer any personal information you provide to those who want to sell you a product or service.</p>
                </article>
             
            </section>
            
            <section class="about-bottom-container">
            
                <div class="about-button-mask">
                    <a class="btn-dark-big about-plan-button" href="/getting-squared-away/">Build a Personalized Financial Plan</a>
                </div>
                    <p>Or you can browse content by <a class="link-underline" href="">Topic</a> or use the search bar at the top of the page to find what you are looking for.</p>
                    
            </section>
            
            		<div class="about-partners-header-container">
                    	
                    </div>
                    
                    <section class="about-partners-container">
                    
                    <article class="about partners col-1"><h2 class="about-partners-header">Learn More About Us</h2></article>
                         <article class="about-partners col-2">
                        
                            <p><a href="/about/credits" class="about-partners-names">Who We Are</a></p>
                        </article>
                        
                        <article class="about-partners col-3">
                        	
                            <p><a href="/about/partners" class="about-partners-names">Partners</a></p>
                        </article>
                        
                  <article class="about-partners col-4">
                        	
                            <p><a href="/about/contact-us" class="about-partners-names">Contact Us</a></p>
                        </article>
                        
                    </section>
	</section> <!-- /.generic-page-body -->

</section><!-- #post-## -->
				

<?php endwhile; ?>
<?php //get_sidebar(); ?>
<?php get_footer(); ?>