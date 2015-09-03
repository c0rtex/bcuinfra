<cfquery datasource="#application.dbSrc#">
UPDATE wrapper
SET wrapper_additional_css= '<link href="css/header_1024_ssl_noNav_s14.css" media="all" rel="stylesheet" type="text/css" />'
WHERE wrapper_partner_id = 22;
</cfquery>

<cfquery datasource="#application.dbSrc#">
UPDATE wrapper
SET wrapper_top_menu='<div id="pageContainer">	<div id="header">		<div id="satellites">		<ul>			<li id="dotOrg"><a class="current" href="http://www.aarp.org/" target="aarp"><span>AARP.org</span></a></li>			<li id="magazine"><a href="http://www.aarpmagazine.org/" target="aarp"><span>AARP The Magazine</span></a></li>				<li id="bulletin"><a href="http://bulletin.aarp.org/" target="aarp"><span>AARP Bulletin Today</span></a></li>			<li id="segunda"><a href="http://www.aarpsegundajuventud.org/english/index.html" target="aarp"><span>AARP Segunda Juventud</span></a></li>			<li id="tv"><a href="http://www.aarp.org/leisure/entertainment/tv/" target="aarp"><span>AARP TV</span></a></li>			<li id="benefits"><a href="http://products.aarp.org/" target="aarp"><span>Services & Discounts</span></a></li>			<li id="foundation"><a href="http://www.aarp.org/about_aarp/aarp_foundation/" target="aarp"><span>AARP Foundation</span></a></li>				<li id="research"><a href="http://www.aarp.org/research/" target="aarp"><span>AARP Policy and Research</span></a></li>			<li id="dwf"><a href="http://www.aarp.org/issues/dividedwefail/" target="aarp"><span>Divided We Fail</span></a></li>		</ul>	</div><!-- /satellites -->		<div id="logoLockup">		<a href="http://www.aarp.org/" target="aarp"><img src="images/aarp_logo_s10.gif" width="148" height="31" alt="AARP.org" title="AARP.org" /></a>	</div>		</div><!-- /header --></div><!-- /pageContainer -->'
WHERE wrapper_partner_id = 22;
</cfquery>