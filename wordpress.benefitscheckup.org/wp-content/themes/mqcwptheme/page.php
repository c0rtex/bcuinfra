<?php get_header(); ?>

<div id="page" class="subpage <?php if(isset($_GET['fullWidth'])){echo "layout-noRightCol";} else { echo "layout-default";} ?>"><!-- "page" id should remain on every page, swap or extend the "layout-default" class for alternate layouts (class="subpage layout-noRightCol" or class="forum layout-default" -->

<div id="content">
   			
<div class="col1">
<?php if ( ! is_page( 'Home' ) ) {; ?>
<!-- If page is not home page, show page_wrapper -->
     <div class="page_wrapper">
<?php } ?>
<?php if(have_posts()) : ?>
	<?php while(have_posts()) : the_post(); ?>
		<?php the_content(); ?>	
	<?php endwhile; ?>

<?php endif; ?>

<?php if ( ! is_page( 'Home' )  ) {; ?>
<!-- If page is not home page, show page_wrapper --> 
      </div><!--end page_wrapper -->
<?php } ?>
</div><!--end col1 -->

<?php 
if(!isset($_GET['fullWidth'])){ 
	get_sidebar();
} ?>

</div><!-- end content -->
</div>
<?php get_footer(); ?>