﻿</div> <!-- end of container -->
		</div> <!-- end .container -->

<?php
//add the eversafe_id, if it exists, to the session so that it can be added to the links
if (isset($_GET["eversafe_id"])) {
    if (!isset($_SESSION["eversafe_id"])) {
        $_SESSION["eversafe_id"] = $_GET["eversafe_id"];
    }
}
//echo "Eversafe header SESSION ID<br/>";
//echo $_SESSION["eversafe_id"];

?>

<center>
<div class="footer-powered">

EconomicCheckUp&reg; is powered by the National Council on Aging.
<br>
&copy;2017 National Council on Aging. All Rights Reserved.
<br>

<a href="/eversafe-privacy-policy/">EconomicCheckUp® Privacy Policy </a>
| 
<a href="/eversafe-terms-of-use/">EconomicCheckUp® Terms of Use</a>

<br>
<br>
</div>
</center>

<div id="footer">

		<div class="footer-container">
			<div class="row">
				<div class="col-md-4 logos">
					<a target="blank" title="Elderscan, LLC, Information Technology Services, Columbia, MD" href="https://www.bbb.org/greater-maryland/business-reviews/information-technology-services/elderscan-in-columbia-md-90239055#bbbseal"><img src="https://www.eversafe.com/images/logos/bbbreg.png" alt="Elderscan, LLC, Information Technology Services, Columbia, MD"> </a>
					<a target="blank" href="https://trustsealinfo.websecurity.norton.com/splash?form_file=fdf/splash.fdf&dn=www.eversafe.com&lang=en">	<img src="https://www.eversafe.com/images/logos/norton.png" alt="norton"></a>
					<a target="blank" href="http://privacy.truste.com/privacy-seal/Elderscan,-LLC/validation?rid=348e0b2a-51cc-48f4-a855-8d591cf833ce">	<img src="https://www.eversafe.com/images/logos/trust.png" alt="truste"></a>
				</div>
				<div class="col-md-6 menu">
					<ul>
						<li>
		          			<a href="https://www.eversafe.com/terms.html<?php if (isset($_SESSION["eversafe_id"])){echo '?eversafe_id='.$_SESSION["eversafe_id"]; }?>">Terms of Use</a>
		        		</li>
		      			<li>
		          			<a href="https://www.eversafe.com/security.html<?php if (isset($_SESSION["eversafe_id"])){echo '?eversafe_id='.$_SESSION["eversafe_id"]; }?>">Security</a>
		        		</li>
		        		<li>
		        			<a href="https://www.eversafe.com/privacy.html<?php if (isset($_SESSION["eversafe_id"])){echo '?eversafe_id='.$_SESSION["eversafe_id"]; }?>">Privacy</a>
		        		</li>
		        		<li>
		          			<a href="http://www.eversafe.com/blog/<?php if (isset($_SESSION["eversafe_id"])){echo '?eversafe_id='.$_SESSION["eversafe_id"]; }?>">Blog</a>
		        		</li>
						<li>
		          			<a href="https://www.eversafe.com/contact-us.html<?php if (isset($_SESSION["eversafe_id"])){echo '?eversafe_id='.$_SESSION["eversafe_id"]; }?>">Contact Us</a>
		        		</li>
	      			</ul>
				</div>
				<div class="col-md-2 social">
					<a href="https://twitter.com/EverSafeSeniors" target="blank">
						<img src="https://www.eversafe.com/images/social/social-tw.png" alt="twitter" />
					</a>
					<a href="https://www.facebook.com/EverSafeSeniors" target="blank">
						<img src="https://www.eversafe.com/images/social/fbt.png" alt="facebook" />
					</a>					
				</div>
			</div>
			<div class="row credits">
				<div class="col-md-12">
					
					Copyright &#0169; 2017 Elderscan, LLC (d/b/a EverSafe) - All Rights Reserved 
				</div>
			</div>
		</div>
	</div>

	
	<!-- Google Code for Remarketing Tag -->
	<script type="text/javascript">
		/* <![CDATA[ */
		var google_conversion_id = 964546803;
		var google_custom_params = window.google_tag_params;
		var google_remarketing_only = true;
		/* ]]> */
	</script>
	
	<script type="text/javascript" src="//www.googleadservices.com/pagead/conversion.js">
	</script>
	<noscript>
		<div style="display:inline;">
			<img height="1" width="1" style="border-style:none;" alt="" src="//googleads.g.doubleclick.net/pagead/viewthroughconversion/964546803/?value=0&amp;guid=ON&amp;script=0"/>
		</div>
	</noscript>
	
	<script type="text/javascript">
		setTimeout(function(){var a=document.createElement("script");
		var b=document.getElementsByTagName("script")[0];
		a.src=document.location.protocol+"//script.crazyegg.com/pages/scripts/0042/5201.js?"+Math.floor(new Date().getTime()/3600000);
		a.async=true;a.type="text/javascript";b.parentNode.insertBefore(a,b)}, 1);
	</script>
<?php require('eversafe_tracking.htm'); ?>
</body>
</html>
