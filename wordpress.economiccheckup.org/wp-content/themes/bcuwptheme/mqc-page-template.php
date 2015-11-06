<?php
/*
Template Name: MedicareQuickCheck  default
*/
?>
<?php get_header(mqc); ?>

<div id="page" class="subpage <?php if(isset($_GET['fullWidth'])){echo "layout-noRightCol";} else { echo "layout-default";} ?>"><!-- "page" id should remain on every page, swap or extend the "layout-default" class for alternate layouts (class="subpage layout-noRightCol" or class="forum layout-default" -->

<div id="content">

<?php if(have_posts()) : ?>
	<?php while(have_posts()) : the_post(); ?>
		<?php the_content(); ?>	
	<?php endwhile; ?>

<?php endif; ?>
<?php get_sidebar(mqc); ?>

</div><!-- end content -->
</div></div></div></div></div>
<?php get_footer(mqc); ?>