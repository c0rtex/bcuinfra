<?php /*Template Name: Home Page Eversafe (index-everafe.php*/?> 
<?php get_header(eversafe); ?>

<div id="page" class="subpage <?php if(isset($_GET['fullWidth'])){echo "layout-noRightCol";} else { echo "layout-default";} ?>"><!-- "page" id should remain on every page, swap or extend the "layout-default" class for alternate layouts (class="subpage layout-noRightCol" or class="forum layout-default" -->

   	
<div id="content" class="eversafe-content">
				<div id="top-content" class="row-fluid">

                <div id="content" class="span12 main-content featured">
                
                                
                <?php // TODO: add in a custom field to enter top content via the editor, then just 
				      // move the content below into the custom field editor  ?>
                      			                
					<h2 class="feature">Am I Making the Most of My Money?</h2>
					<img src="/wp-content/uploads/2013/08/BCU-images_251x217_top.png" title="Women Smiling" alt="Women Smiling" class="alignright">
                    <h3>Find out today with an EconomicCheckUp&reg;.</h3>
<p>Whether you’re retired or still working, it pays to be smart about your income. Discover tips and resources in your community to manage your budget, save money, find work, and set financial goals. It’s free, confidential, and from a trusted source—the nonprofit National Council on Aging.</p><div class="spacer"></div>
					<a id="getStartedESIButton" href="#esi_quickcheck" class="btn-ga" data-gaCategory="economic-checkup" data-gaAction="start-economic-checkup" data-toggle="modal" data-backdrop="static">				<img id="getStartedESIButtonImg" src="/wp-content/uploads/2014/09/get-started-now.jpg"></a>


<div id="esi_quickcheck" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="QuickCheck" aria-hidden="true" style="display: none;">
  <div class="modal-body well">
<div id="esiQuickcheckTitle">
<button aria-hidden="true" data-dismiss="modal" class="btn" id="esiQuickcheckClose">Close <i class="icon-remove"></i> </button>
<h2 class="esiQuickcheckTitle">EconomicCheckUp&reg;</h2>
</div>

<?php require_once ($_SERVER["DOCUMENT_ROOT"]."/_custom/questionnairebody_esi_quickcheck.php"); ?>

  </div>


</div>
                  
                  <?php // end TODO ?>  
                    
<div class="row-fluid" style="clear:both">
	<div class="span4">
		<h3><a href="/protecting-yourself-from-scams-swindles-eversafe/">Protect Yourself from Scams:</a></h3>
		<p>Discover how to avoid the most common scams targeting seniors</p>
	</div>
	<div class="span4">
		<h3><a href="/money-management-tips-eversafe/">Money Saving Tips:</a></h3>
		<p>Create a budget and see where to cut expenses</p>
	</div>
	<div class="span4">
		<h3><a href="http://www.ncoajobsource.org/" target="_blank">Find Jobs for Seniors:</a></h3>
		<p>Define your skills, get training, and land a job</p>
	</div>
</div>
</div>

                        	
                </div>
                
				
	<?php //get_sidebar("horizontal"); ?>
</div>
    
			</div> <!-- end #content -->

</div>
</div>
<?php get_footer(eversafe); ?>
