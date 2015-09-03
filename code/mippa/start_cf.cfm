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

<cfset mapWidth = 410>
<cfset mapHeight = 320>
<style type="text/css">
	ul#mippaMenu{
		margin:0;
	}
	#mippaMenu .tabItem{
		float:left;
		list-style:none;
		padding:4px;
		background-color:#666;
		border:1px solid black;
		display:block;
	}
	.columnTitle{
		border:1px solid #519e2d; 
		background-color:#519e2d;
		color:#fff;
		font-weight:bold;
		font-size:14px;
		padding:4px;
		text-align:center;
	}
	.clearBoth{
		clear:both;
		line-height:0;
	}
	.tabContent{
		height:200px;
		padding:4px;
		border:1px dotted #519e2d;
	}
</style>
<script src="js/AC_RunActiveContent.js" type="text/javascript"></script>
<script src="jquery.ui-1.5.2/jquery-1.2.6.js" type="text/javascript"></script>
<script src="jquery.ui-1.5.2/ui/ui.core.js" type="text/javascript"></script>
<script src="jquery.ui-1.5.2/ui/ui.tabs.js" type="text/javascript"></script>
<link href="jquery.ui-1.5.2/themes/flora/flora.tabs.css" rel="stylesheet" type="text/css" />
<div style="padding:4px;">
State: 
<select name="state" id="state">
	<option value="">- select -</option>
	<option value="IL">Illinois</option>
</select>
&nbsp;
Program:
<select name="program" id="program">
	<option value="">- select -</option>
	<option value="extra_help">Extra Help</option>
</select>
&nbsp;
Data:
<select name="data" id="data">
	<option value="">- select -</option>
	<option value="temp_data">Temp Data</option>
</select>
</div>
<table cellpadding="0" cellspacing="4" width="750">
    <tr>
        <td width="120" valign="top">
        	<div>
        		<div class="columnTitle">
                	About Extra Help
                </div>
                <div style="font-size:10px;padding:4px;border-left:1px solid #519e2d;border-right:1px solid #519e2d;border-bottom:1px solid #519e2d;">
                	The LIS helps people with limited incomes and resources pay for their Medicare prescription drug costs. People eligible 
                    for the subsidy pay either no deductible (or a lower deductible of $63 per year in 2010), significantly reduced co-payments 
                    and have no coverage gap or donut hole as it is often called. People eligible for Medicare and either Medicaid, SSI or one 
                    of the Medicare Savings Programs automatically qualify for the LIS, and do not need to apply for it.  Click here for more 
                    information about the Low-Income Subsidy.  
                    <br />
                </div>
                <div class="columnTitle" style="margin-top:4px;">
                	Check if you are eligible and APPLY
                </div>
				<div style="font-size:12px;padding:4px;border-left:1px solid #519e2d;border-right:1px solid #519e2d;border-bottom:1px solid #519e2d;">
                    <!--- <img src="images/bculogo-med-reg-bdcfc8.gif" border="0" width="110" style="margin-top:4px;" /> --->
                    <a href="extrahelp.cfm?subset_id=27&partner_id=70" target="_blank">
                    <img src="podcasts/bcu_logo.jpg" border="0" width="110" style="margin-top:4px;" />
                    <br />Apply Now
                    </a>
                </div>
            </div>
        </td>
        <td width="420" valign="top">
			<div id="jQueryUITabs1">
			  	<ul>
               	  <li><a href="#jQueryUITabs1-1"><span>Maps</span></a></li>
               	  <li><a href="#jQueryUITabs1-2"><span>Trends</span></a></li>
                	<li><a href="#jQueryUITabs1-3"><span>Rankings</span></a></li>
       	  	  	</ul>
				<div id="jQueryUITabs1-1">
					<h3 align="center">LIS Participation Rates</h3>
                    <p>
                  <cfoutput>
                   	  <script type="text/javascript">
						AC_FL_RunContent( 'codebase','https://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab##version=8,0,0,0','width','#mapWidth#','height','#mapHeight#','id','flashMap','align','middle','src','/flash/us_city_map/golden_usa_external?xmlfile1=/us_city_map/usa.xml&show_map=#showmap#','quality','high','wmode','transparent','bgcolor','##ffffff','name','golden_usa_external','allowscriptaccess','sameDomain','pluginspage','https://www.macromedia.com/go/getflashplayer','movie','/flash/us_city_map/golden_usa_external','flashvars','xmlfile1=/us_city_map/usa.xml&show_map=#showmap#' ); //end AC code
						</script>
						
					<noscript><object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="https://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab##version=8,0,0,0"  width="#mapWidth#" height="#mapHeight#" id="flashMap" align="middle">
						<param name="allowScriptAccess" value="sameDomain" />
						<param name="movie" value="/flash/us_city_map/golden_usa_external.swf" />
						<PARAM NAME=FlashVars VALUE="xmlfile1=/us_city_map/usa.xml&show_map=#showmap#">
						<param name="quality" value="high" /><param name="wmode" value="transparent" />
						<param name="bgcolor" value="##ffffff" />
						<embed src="flash/us_city_map/golden_usa_external.swf?xmlfile1=/us_city_map/usa.xml&show_map=#showmap#" quality="high" wmode="transparent" bgcolor="##ffffff" width="#mapWidth#" height="#mapHeight#" name="golden_usa_external" align="middle" allowScriptAccess="sameDomain" type="application/x-shockwave-flash" pluginspage="https://www.macromedia.com/go/getflashplayer" />
				    </object></noscript>
                    </p>
                  </cfoutput>
				</div>
				<div id="jQueryUITabs1-2">
				  <h3 align="center">LIS Participation Rates</h3>
				  <br />
					<p><img src="chart.gif" border="0" alt="temp chart" title="temp chart" /></p>
			  	</div>
				<div id="jQueryUITabs1-3"> 
                	<h3 align="center">LIS Participation Rates</h3>
					<br />
					<p><img src="rankings.gif" border="0" alt="temp rankings" title="temp rankings" /></p>
		  		</div>
		  <script type="text/javascript">
            	jQuery("#jQueryUITabs1 > ul").tabs({ event: "click" });
            
            </script>
      	</td>
        <td width="210" valign="top">
       	  <div>
        		<div class="columnTitle">
                	Find Help.
                </div>
				<div style="font-size:12px;padding:4px;border-left:1px solid #519e2d;border-right:1px solid #519e2d;border-bottom:1px solid #519e2d;">
                  <p> 
               	  <cfif error1 IS NOT 1>
                    	<h3 align="center">State Health Insurance Program (SHIP)</h3>
                      <b>Office on Aging</b><br />
                        Kentucky Cabinet for Health Services<br />
                        275 East Main Street, 5C-D<br />
                        Frankfort, KY 40621<br />
                       <a href="http://chfs.ky.gov/dhss/das/ship.htm" target="_blank">website</a><br />
                        877-293-7447 (In-State Calls only)<br />
                        502-564-6930 (Out-of-State calls)<br />
                        <div style="margin-top:8px;">
                        <img src="temp_map.gif" border="0" alt="temp Map" title="temp Map" />
                        </div>
                      <div style="margin-top:8px;">
                        	<h3 align="center">Other agencies in your area:</h3>
							<a href="##">Green River Area Agency on Aging</a><br />
						  <a href="##">Kentucky Medicaid Agency</a>
                    </div>
					<cfelse>
                        (Once zip code is entered, display the state's SHIP info. Entry Points to be attached. We will add additional language 
                        and entry points here.)
                  </cfif>
                    </p>
                  <p>To find help in your area, please select your state or enter your zip code below.</p>
                </div>
				<div class="columnTitle" style="margin-top:4px;border-bottom:1px solid #519e2d">
       	  	    <p>Enter your City,  Zip Code</p>
                  	<form action="locator.cfm?zipSearch=1" method="post">
                    	<input type="text" height="50" value="<cfif error1 IS NOT 1><cfoutput>#zipCode#</cfoutput></cfif>" style="padding:8px;" name="zipCode" id="zipCode" />
                	</form>
</div>
          </div>
        </td>
    </tr>
</table>


