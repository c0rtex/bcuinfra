<cfparam name="zipCode" default="">
<cfparam name="county_id" default="">
<cfparam name="showmap" default="0">
<cfparam name="showOffices" default="0">
<cfparam name="error1" default="0">
<cfparam name="zipSearch" default="0">



<cfif trim(zipCode) IS NOT "" OR zipSearch IS 1>

	<cf_validateZip zipcode="#zipCode#" var="zipValidation">
	
	<cfif zipValidation IS TRUE>
	
		<cfquery name="findZip" datasource="#application.dbSrc#">
			SELECT state_map_code2 
			FROM zip z
			LEFT JOIN state s ON s.state_id = z.state_id
			WHERE zipcode = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="5" value="#left(zipCode, 5)#">
		</cfquery>
	
		<cfset showmap = findZip.state_map_code2>
	<cfelse>
		<cfset showmap = 0>
		<cfset showmap = 0>
		<cfset error1 = 1>
	</cfif>
	

</cfif>

<cfif showMap IS 0>
	<cfset mapWidth = 730>
	<cfset mapHeight = 500>	
<cfelse>
	<cfset mapWidth = 474>
	<cfset mapHeight = 354>	
</cfif>

<style type="text/css">
#for-further-information {
	font-family:verdana,arial,helvetica,sans-serif;
	font-size:0.8em;
	margin:0 0 12px;
	padding:0;
}

</style>

<script type="text/javascript" src="js/jquery.js"></script>

<script type="text/javascript">

<cfif error1 IS 1>
	alert('Please enter a valid zip code.');
</cfif>

function hideOffices() {
	$("#zipCode").val("");			
	$("#zipCodeError").remove();	
	$("#officeCol").css("background-color", "#FFF");
	$("#officeCol").width(0); 	
	$("#officeCol").css("padding", "0px");	
	$("#offices").css("background-color", "#FFF");
	$("#offices").css("padding", "0px");		
	$("#offices").hide();
	$("#flashMap").width(730).height(500); 		
	$(".introText").css("padding-right", "0px");	
	$('#language_country_map').show();
	$('#language_state_map').hide();
	$('#language_office_map').hide();	
	$("#language_country_map, #locatorTitle").width(730); 		
	$("#locatorTitle").css("text-align", "center");	
}

function showOffices(url) {
	$("#zipCode").val("");			
	$("#flashMap").width(474).height(354); 		
	$('#offices').toggle();
	$("#locatorTitle").css("text-align", "left");		
	$(".introText").css("padding-right", "10px");			
	$("#language_country_map, #locatorTitle").width(474); 		
	$('#language_country_map').hide();
	$('#language_state_map').hide();
	$('#language_office_map').show();	

	$('#offices').replaceWith('<div id="offices" style="padding:8px; width:238px; background-color:#CCCCCC;"><h2 class="snapH2">Loading Office(s)</h2><p class="text1"><img src="img/loading.gif"></p></div>');
	$("#offices").css("width", "238px");		
	
	$("#officeCol").css("background-color", "#CCCCCC");				
	$("#officeCol").css("width", "254px");


	$("#offices").load(url, function() {
	$("#offices").css("background-color", "#CCCCCC");	
	$("#officeCol").css("background-color", "#CCCCCC");			
		
	
		
	});
}

function backClick() {
	$("#zipCode").val("");			
	$('#language_country_map').hide();
	$('#language_state_map').show();
	$('#language_office_map').hide();	

}

function stateText() {
	$("#zipCode").val("");			
	$('#language_country_map').hide();
	$('#language_state_map').show();
	$('#language_office_map').hide();	
	$("#language_state_map").css("width", "730px");		

}

</script>



<cfoutput>
<script src="js/AC_RunActiveContent.js" type="text/javascript"></script>

<div style="margin:5px 10px 10px;">

<table cellpadding="0" cellspacing="0" border="0">
<tr>
<td valign="top" style="width: #mapWidth#px;">

<cfif showmap GT 0>
	<cfset alignHeader = "left">
<cfelse>
	<cfset alignHeader = "center">
</cfif>

<h1 id="locatorTitle" class="locatorH1" style="text-align:#alignHeader#; width:100%; margin-top:0px; padding-top:0px;">National Medicaid Office Locator</h1>

<cf_displayText group="site" code="site_mdcd_locator_intro_language_country_map" var="site_mdcd_locator_intro_language_country_map">
<cf_displayText group="site" code="site_mdcd_locator_intro_language_state_map" var="site_mdcd_locator_intro_language_state_page">
<cf_displayText group="site" code="site_mdcd_locator_intro_language_office_page" var="site_mdcd_locator_intro_language_office_page">


<div class="introText" id="language_country_map" <cfif showmap GT 0>style="display:none;"</cfif>>
	<p class="text1" <cfif showmap GT 0>style="margin-right:24px;" </cfif>>
	#site_mdcd_locator_intro_language_country_map#
	</p>
</div>


<div class="introText" id="language_state_map" style="display:none; width:100%">
	<p class="text1" <cfif showmap GT 0>style="margin-right:24px;" </cfif>>
#site_mdcd_locator_intro_language_state_page#
	</p>
</div>
</p>

<div class="introText" id="language_office_map" <cfif showmap IS 0>style="display:none;"</cfif>>
	<p class="text1" <cfif showmap GT 0>style="margin-right:24px;" </cfif>>
#site_mdcd_locator_intro_language_office_page#
	</p>
</div>
</p>


<script type="text/javascript">
AC_FL_RunContent( 'codebase','https://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab##version=8,0,0,0','width','#mapWidth#','height','#mapHeight#','id','flashMap','align','middle','src','/flash/us_city_map/golden_usa_external?xmlfile1=/us_city_map/usa.xml&show_map=#showmap#','quality','high','wmode','transparent','bgcolor','##ffffff','name','golden_usa_external','allowscriptaccess','sameDomain','pluginspage','https://www.macromedia.com/go/getflashplayer','movie','/flash/us_city_map/golden_usa_external','flashvars','xmlfile1=/us_city_map/usa.xml&show_map=#showmap#' ); //end AC code
</script>

<noscript><object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="https://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab##version=8,0,0,0"  width="#mapWidth#" height="#mapHeight#" id="flashMap" align="middle">
<param name="allowScriptAccess" value="sameDomain" />
<param name="movie" value="/flash/us_city_map/golden_usa_external.swf" />
<PARAM NAME=FlashVars VALUE="xmlfile1=/us_city_map/usa.xml&show_map=#showmap#">
<param name="quality" value="high" />
<param name="wmode" value="transparent" />
<param name="bgcolor" value="##ffffff" />
<embed src="flash/us_city_map/golden_usa_external.swf?xmlfile1=/us_city_map/usa.xml&show_map=#showmap#" quality="high" wmode="transparent" bgcolor="##ffffff" width="#mapWidth#" height="#mapHeight#" name="golden_usa_external" align="middle" allowScriptAccess="sameDomain" type="application/x-shockwave-flash" pluginspage="https://www.macromedia.com/go/getflashplayer" />
</object></noscript>

<div class="search" style="margin-left:8px; margin-right:8px;">
<form action="medicaid_locator.cfm?zipSearch=1" method="post">
<p class="text1" style="margin-top:0px;">
<strong>Enter Your Zip Code:</strong> <input type="text" size="10" maxlength="5" value="<cfif error1 IS NOT 1>#zipCode#</cfif>" name="zipCode" id="zipCode"> <input type="submit" value="Search" />
</p>

</form>
</div></td>

<td  valign="top" id="officeCol" <cfif showMap GT 0> style="padding:8px; width:238px; background-color:##CCCCCC;"</cfif><cfif showOffices IS 1>style="display:none;"</cfif>>

<div id="offices">

<cfif showMap GT 0>
	
	<cfparam name="attributes.zip" default="#left(zipCode, 5)#">
	<cfparam name="attributes.program_id" default="579">
	
	<cf_displayProgramDetailEntrypoints program_id="#attributes.program_id#" mode="screen" source="" zipcode="#attributes.zip#" limit="10" var="outstr" append="false" suppressText="True" suppressOfficesLink="True" google="true">
	
<h2 class="snapH2" style="margin:0px;">Medicaid Office(s):</h2>			
	
	<cfoutput>
	<p class="text1">
	#outstr#
	</p>
	</cfoutput>
<cfelseif county_id IS NOT "">
	
	<cfquery name="findCounty" datasource="#application.dbSrc#">
	SELECT *
	FROM county
	WHERE county_id = <cfqueryparam value="#county_id#">
</cfquery>
	
	<cfparam name="attributes.county_id" default="#county_id#">
	<cfparam name="attributes.program_id" default="579">
	

	
	<cf_displayProgramDetailEntrypoints program_id="#attributes.program_id#" mode="screen" source="" county_id="#attributes.county_id#" limit="10" var="outstr" append="false" suppressText="True" suppressOfficesLink="True" proximityOverride="county" google="true">
	
	
	
	<cfoutput>
	
	<h2 class="snapH2" style="margin:0px;">The following office(s) serves your area:</h2>		
	
	<p class="text1">
	#outstr#
	</p>
	</cfoutput>

</cfif>
</div></td>


</tr>
</table>
</div>
</cfoutput>



