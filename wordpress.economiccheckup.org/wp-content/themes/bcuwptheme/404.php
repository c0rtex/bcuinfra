<?php get_header(); ?>
<style>
#breadcrumbs
{
	display: none;
}
</style>

<div id="page" class="subpage layout-noRightCol">
    <!-- "page" id should remain on every page, swap or extend the "layout-default" class for alternate layouts (class="subpage layout-noRightCol" or class="forum layout-default" -->

<?php $request_url="http://".$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI']; ?>

    <div id="content" class="find-help">
      <div class="col1">
      	<h1>Page Not Found</h1>
        <div id="intro-row" align="center">
          <h2>We're sorry, but the page you are looking for cannot be found.</h2>
				<ul style="width:400px; list-style:disc; text-align:left;">
					<li>Please send us an <a href="mailto:support@benefitscheckup.org?Subject=Page Not Found (<?php echo $request_url; ?>)">email</a> to let us know you received this page.  If you reached this page by clicking from another website, please provide us with the original website you clicked from to get here.</li>
					<li>To get help finding benefits, go to <a href="/index.php">BenefitsCheckUp</a> now.</li>
				</ul>

        </div><!--end intro-row -->
      </div><!--end col1 -->

      <div class="clear"></div>
    </div><!--end content -->
  </div><!--end page -->


<!--?php get_sidebar(); ?-->	
<?php get_footer(); ?>