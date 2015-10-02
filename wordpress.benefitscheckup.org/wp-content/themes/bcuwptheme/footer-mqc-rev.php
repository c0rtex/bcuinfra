		</div> <!-- end of container -->
        <div class="container" id="footer">
        	<div class="row">
			
				<!-- this is the footer for MQC; for testing purposes only -->
				
				<div class="span3">
			        <a target="_new" href="http://www.ncoa.org/"><img src="<?php echo get_template_directory_uri(); ?>/images/BCUfooter-ncoa-logo.png" alt="National Council on Aging" title="National Council on Aging"></a>
			    </div>
				
			    <div class="span9">
			        <ul id="footer_links">
			            <li>
			                <a target="_new" href="https://www.mymedicarematters.org/about/">About This Site</a>
			            </li>
			            <li class="footer_divider">|</li>
			            <li>
			                <a target="_new" href="https://www.mymedicarematters.org/privacy-policydisclaimers/">Privacy Policy</a>
			            </li>
			            <li class="footer_divider">|</li>
			            <li>
			                <a target="_new" href="https://www.mymedicarematters.org/get-help/contact-us/">Contact Us</a>
			            </li>
			            <li class="footer_divider">|</li>
			            <li>
			                <a target="_new" href="https://www.mymedicarematters.org/get-help/faq/">FAQs</a>
			            </li>
			            <li class="footer_divider">|</li>
			            <li>
			                <a target="_new" href="https://www.mymedicarematters.org/get-help/glossary/">Glossary</a>
			            </li>
			        </ul>
	
			        <ul id="socialnetwork_links">
			            <li>
			                <a target="_new" href="https://www.facebook.com" id="facebook_link"></a>
			            </li>
			            <li>
			                <a target="_new" href="https://www.twitter.com" id="twitter_link"></a>
			            </li>
			            <li>
			                <a target="_new" href="https://www.pinterest.com" id="pinterest_link"></a>
			            </li>
			            <li>
			                <a target="_new" href="https://www.mysocialnetwork.com" id="socialnetwork_link"></a>
			            </li>
			        </ul>
			    </div>
			
			
			</div>
		
		</div> <!-- end .container -->
				
		<?php wp_footer(); ?>
		
		<script type="text/javascript">
		//this is from the MQC footer
$(function() {
               $(".learnMore").hide();
               $(".contractImage").hide();
                      $(".showMore").click(function() {
                 $showId = "#" + $(this).attr("id") + "_more";
                          $($showId).toggle();
                 $showIdContract = "#" + $(this).attr("id") + "_contractImage";
                 $showIdExpand = "#" + $(this).attr("id") + "_expandImage";
               $($showIdContract).toggle();
               $($showIdExpand).toggle();
                          return false;
                      });        
                  });
		 		  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
		  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new
		Date();a=s.createElement(o),
		 
		m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
		  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
		
var startForm =false;
var endForm = false;
var mqcGA;
var mmmGA;
if(document.location.host=='medicarequickcheck.benefitscheckup.org') {
    // production GA values
    mqcGA = 'UA-2674020-10';
    mmmGA = 'UA-52314337-1';
} else {
    // non-production GA values
    mqcGA = 'UA-2674020-10';
    mmmGA = 'UA-52061175-1';
}
ga('create', mqcGA, 'benefitscheckup.org');
ga('create', mmmGA, 'mymedicarematters.org', {'name': 'mmm' });


		  ga('send', 'pageview');
		
		</script>

	</body>

</html> <!-- end page -->
