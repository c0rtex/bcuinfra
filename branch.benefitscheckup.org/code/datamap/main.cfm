<cfparam name="zipCode" default="">
<cfparam name="county_id" default="">
<cfparam name="showmap" default="0">
<cfparam name="showOffices" default="0">
<cfparam name="error1" default="0">
<cfparam name="zipSearch" default="0">

<cfset mapWidth = 550>
<cfset mapHeight = 448>
<script type="text/javascript">
	mapWidth = 550;
	mapHeight = 448;
</script>
<table cellpadding="0">
    <tr>
    	<td width="152">&nbsp;</td>
        <td>
			<div class="progDataForm">
				<form>
        			<input type="hidden" name="start" id="start" value="false" />
                    <table cellpadding = "0">
        				<tr>
                        	<td align="right">
			                    <cf_displayText code="site_mapping_home_program" group="site">
                    		</td>
                      		<td>&nbsp;</td>
                            <td>
                                <select name="programSel" id="programSel">
        						</select>
                            </td>
                    	</tr>
                        <tr>
                        	<td align="right">
                    			<cf_displayText code="site_mapping_home_data_set" group="site">
                            </td>
                            <td>&nbsp;</td>
                            <td>
                    			<select name="dataSel" id="dataSel">
        						</select>
                          	</td>
                       	</tr>
					</table>
    			</form>
			</div>
      	</td>
   	</tr>
</table>
<table cellpadding="0" cellspacing="4">
    <tr>
    	<td width="170" valign="top">
            <div id="leftCol">
        		<div class="columnTitle">
                	<div class="corner left"><img src="topLeftCorner.gif" alt="left corner" title="left corner" /></div>
                    <div class="corner right"><img src="topRightCorner.gif" alt="right corner" title="right corner"  /></div>
                	About <span id="progName">this Project</span>
                </div>
                <div id="aboutText" class="columnContent">
                	<cf_displayText code="site_mapping_home_about_text" group="site">
                    <br />
                </div>
				<div class="columnTitle eligibility">
                	<div class="corner left"><img src="topLeftCorner.gif" alt="left corner" title="left corner" /></div>
                    <div class="corner right"><img src="topRightCorner.gif" alt="right corner" title="right corner"  /></div>
                    Check Eligibility
                </div>
                <div id="EligibilityText" class="columnContent">
                	<a href="../before_you_start.cfm?subset_id=27" target="_blank">
                    	<img id="bcuStack" src="BCU_Logo.gif" alt="BCU Logo" border="0" title="BCU Logo" />
                    </a>
                    <br />
                </div>
                <div id="xtraHelp" style="display:none;">
                    <div class="columnTitle eligibility">
                        <div class="corner left"><img src="topLeftCorner.gif" alt="left corner" title="left corner" /></div>
                        <div class="corner right"><img src="topRightCorner.gif" alt="right corner" title="right corner"  /></div>
                        <cf_displayText code="site_mapping_apply_for_extra_help" group="site">
                    </div>
                    <div id="EligibilityText" class="columnContent">
                        <a href="../extrahelp.cfm" target="_blank">Apply through BenefitsCheckUp</a><br /><br />
                        <a href="https://secure.ssa.gov/i1020/start" 
target="_blank">Apply through Social Security</a><br />
                        <br />
                    </div>
                </div>
                <!--- NOT SURE IF THIS WILL BE USED STILL 
                <div class="columnTitle secondary">
                	<div class="corner left"><img src="topLeftCorner.gif" alt="left corner" title="left corner" /></div>
                    <div class="corner right"><img src="topRightCorner.gif" alt="right corner" title="right corner"  /></div>
                    <a href="https://secure.ssa.gov/apps6z/i1020/main.html" target="_blank">Apply for Extra Help at SSA</a>
                </div>--->
            </div>
        </td>
        <td width="540" valign="top" align="center">
			<div id="jQueryUITabs1">
			  	<div class="tabTitle" style="width:53px;">&nbsp;</div>
                	<!---
				MH: Bug 5304 removed 'Display:' immediately preceding the tabs
                    <cf_displayText code="site_mapping_home_display" group="site">--->
                <ul>
                   	<li><a href="#jQueryUITabs1-0" onclick="javascript:mippa.clearPage();"><span><cf_displayText code="site_mapping_home_tab_home" group="site"></span></a></li>
               	  	<li><a class="clickTrack" id="tab1" href="#jQueryUITabs1-1" onclick="javascript:mippa.processTabClick(this);"><span><cf_displayText code="site_mapping_home_tab_map" group="site"></span></a></li>
               	  	<li><a class="clickTrack" id="tab2"  href="#jQueryUITabs1-2" onclick="javascript:mippa.processTabClick(this);"><span><cf_displayText code="site_mapping_home_tab_trends" group="site"></span></a></li>
                	<li><a class="clickTrack" id="tab3"  href="#jQueryUITabs1-3" onclick="javascript:mippa.processTabClick(this);"><span><cf_displayText code="site_mapping_home_tab_rankings" group="site"></span></a></li>
                </ul>
                <div id="jQueryUITabs1-0" class="longWider">
                	<div id="homeLongDesc" style="display:none;">
                    	<div style="float:right;" class="noprintLong"><a href="javascript:print();" title="Print program description" style="text-decoration:none;"><img src="printer.gif" border="0" alt="Print Description" title="Print Description" height="20" />&nbsp;Print</a></div>
                       	<div id="longDescTitle" style="text-align:center;"><h2></h2></div> 
                        <div id="longDescTxt"></div>
                    </div>
                	<div id="homeHolder">
                        <div class="mapContainer">
                        <cfoutput>
                            <script type="text/javascript">
                                AC_FL_RunContent( 'codebase','https://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab##version=8,0,0,0','width',mapWidth,'height',mapHeight,'id','flashMap','align','middle','src','us_city_map/golden_usa_external.swf?xmlfile1=us_city_map/static_states.cfm&show_map=#showmap#','quality','high','wmode','transparent','bgcolor','##ffffff','name','golden_usa_external','allowscriptaccess','sameDomain','pluginspage','https://www.macromedia.com/go/getflashplayer','movie','us_city_map/golden_usa_external','flashvars','xmlfile1=us_city_map/static_states.cfm&show_map=#showmap#' ); //end AC code
                            </script>
                            <noscript><object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="https://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab##version=8,0,0,0"  width="#mapWidth#" height="#mapHeight#" id="flashMap" align="middle">
                                <param name="allowScriptAccess" value="sameDomain" />
                                <param name="movie" value="us_city_map/golden_usa_external.swf" />
                                <PARAM NAME=FlashVars VALUE="xmlfile1=us_city_map/static_states.cfm&show_map=#showmap#">
                                <param name="quality" value="high" /><param name="wmode" value="transparent" />
                                <param name="bgcolor" value="##ffffff" />
                                <embed src="us_city_map/golden_usa_external.swf?xmlfile1=/cf/us_city_map/static_states.cfm&show_map=#showmap#" quality="high" wmode="transparent" bgcolor="##ffffff" width="#mapWidth#" height="#mapHeight#" name="golden_usa_external" align="middle" allowScriptAccess="sameDomain" type="application/x-shockwave-flash" pluginspage="https://www.macromedia.com/go/getflashplayer" />
                            </object></noscript>
                        </cfoutput>
                        </div>
                        <div class="instructions">
                            <div class="steps"><cf_displayText code="site_mapping_home_easy_steps_title" group="site"></div>
                            <div style="text-align:left;font-size:16px;"><cf_displayText code="site_mapping_home_easy_steps_text" group="site"></div>
                        </div>
                    </div>
                </div>
				<div id="jQueryUITabs1-1">
                  	<cfoutput>
                    	<div class="dataElTitle" style=""></div>
                        <div class="dataA"></div><br />
                        <div id="flashholder" class="mapContainer">
                    		<div id="flashmap3"></div>
                            <div id="stateTotals" class="stateTotals" style="display:none;">
                            	<b>UNITED STATES</b><bR />
                                <b>Year: </b><span class="stateYear"></span>
                                <div class="stateVal">Number: </div>
                            </div>
                        </div>
                  	</cfoutput>
				</div>
				<div id="jQueryUITabs1-2">
                	<div class="dataElTitle"></div>
                    <div class="dataA"></div><br />
                    <div id="trendsCont"><h1>LOADING</h1></div>
				  	<br />
			  	</div>
				<div id="jQueryUITabs1-3"> 
                	<div class="dataElTitle"></div>
                    <div class="dataA"></div><br />
					<br />
					<div id="rankingsCont"></div>
                    <div id="countyDisc" style="text-align:center; color:#333; display:none;position:relative;top:-30px;">*Note: Counties with no data will not be listed.</div>
                    <div id="rankStateTotals" class="stateTotals" style="display:none;padding-top:0px;">
                        <h3 style="margin:0px;padding:0px;"><span class="ranTotalName">UNITED STATES</span> <span class="strippedStateVal"></span><br /><div style="padding-top:4px;"><b>&nbsp;Year: </b><span class="stateYear"></span></div></h3>     
                    </div>
		  		</div>
                
		  	</div>
            <div id="dataInfo" style="display:none;">
            	<!---<div id="dataA"></div><br />--->
                <div id="dataB"></div><br />
                <!---<div id="dataC"></div><br />--->
                <div id="dataD"></div>
            </div>
      	</td>
        <td width="230" valign="top">
			<div id="rightCol" style="width:230px;">
				<div class="columnTitle">
                	<div class="corner left"><img src="topLeftCorner.gif" alt="left corner" title="left corner" /></div>
                    <div class="corner right"><img src="topRightCorner.gif" alt="right corner" title="right corner"  /></div>
					<cf_displayText code="site_mapping_home_find_help_title" group="site">
				</div>
				<div class="columnContent">
                    <div id="entryPoints"><cf_displayText code="site_mapping_home_find_help_text" group="site"></div>
                    <div id="entryPointsState"></div>
				</div>
				<div class="columnTitle zip">
                	<div class="corner left"><img src="topLeftCorner.gif" alt="left corner" title="left corner" /></div>
                    <div class="corner right"><img src="topRightCorner.gif" alt="right corner" title="right corner"  /></div>
					<cf_displayText code="site_mapping_home_enter_your_zip_code" group="site"><br />
                    <form name="zipform" name="zipForm" onsubmit="mippa.captureZipForm(this);return false;" style="margin-top:8px;">
						<input maxlength="5" size="5" type="text" name="zipCode" id="zipCode" />&nbsp;<input id="zipSubmit" type="submit" name="submit" value="Search" />
                   	</form>
				</div>
                <div style="height:8px; line-height:8px;">&nbsp;</div>
                <div class="columnTitle" id ="whatsNew1">
                	<div class="corner left"><img src="topLeftCorner.gif" alt="left corner" title="left corner" /></div>
                    <div class="corner right"><img src="topRightCorner.gif" alt="right corner" title="right corner"  /></div>
					<cf_displayText code="site_mapping_home_whats_new" group="site">
				</div>
                <div class="columnContent" id="whatsNew2">
                    <div><cf_displayText code="site_mapping_home_whats_new_text" group="site"></div>
                </div>
                <div class="columnTitle" id ="dataUses1">
                	<div class="corner left"><img src="topLeftCorner.gif" alt="left corner" title="left corner" /></div>
                    <div class="corner right"><img src="topRightCorner.gif" alt="right corner" title="right corner"  /></div>
					<cf_displayText code="site_mapping_using_this_data" group="site">
				</div>
                <div class="columnContent" id="dataUses2">
                    <div id="dataUses"></div>
                </div>
			</div>
        </td>
    </tr>
</table>
