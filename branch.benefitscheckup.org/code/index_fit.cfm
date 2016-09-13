<cfset neededURL = "neededinfo.cfm">
<style type="text/css">
 .titleFix{
 	height:45px;
 }
  .titleFixNew{
 	height:45px;
 }
</style>
<!--[if IE]>
<style type="text/css">
 .titleFix{
 	height:45px;
 }
  .titleFixNew{
 	height:65px;
 }
</style>
<![endif]-->
<cfif wrapper.wrapper_special_link IS NOT "">
	<cfset special_link = evaluate(wrapper.wrapper_special_link)>
	<cfset special_text = replacenocase(wrapper.wrapper_special_text, "[link]", "#application.transferType#://#special_link#", "all")>
<cfelse>
	<cfset special_link = application.serverPathES>
</cfif>
<cfif Left(wrapper.wrapper_cover_image, 1) EQ "/">
	<cfset wrapper.wrapper_cover_image = ReReplaceNoCase(wrapper.wrapper_cover_image,"/","","ONE")>
</cfif>
<cfoutput>
<table cellpadding="0" cellspacing="0" width="100%" border="0" class="boxtable">
<tr>
<td style="padding:0px 16px 16px 16px;"><cfif trim(wrapper.wrapper_cover_image) IS NOT ""><img src="#wrapper.wrapper_cover_image#" alt="#wrapper.wrapper_cover_image_alt_text#" title="#wrapper.wrapper_cover_image_alt_text#" align="right" class="plimage" /></cfif>
<h1 class="indexh1">
	<cfif wrapper.partnertype_id IS 12>
		MIPPA Grantees - Get Started Now!
	<cfelse>
		Get Started Now!
	</cfif>
</h1>
<p class="text1">#wrapper.wrapper_get_started_now#</p>

<div class="clear"></div>

<cfif val(wrapper.wrapper_special) IS 1 and wrapper.partner_id eq 22>

<div class="box">
	<div class="box-outer">
		<div class="box-inner">
			<div class="box-content"><cf_sessionPassVars href="snap.cfm?partner_id=56" partner_id="56" prev_id="0" target="snap" class="indexh2b"><cf_displayImage code="img_food_gif"  border="0" align="right" class="icon2">Need Help Paying for Food?</cf_sessionPassVars></div>
			<div class="box-content2">
		<p class="text3"><cfif wrapper.wrapper_special_text IS NOT "">#wrapper.wrapper_special_text#<cfelse>Find the program in your state, get an application and apply today by clicking <cf_sessionPassVars href="snap.cfm?partner_id=56" partner_id="56" prev_id="0" target="snap">here!</cf_sessionPassVars>


</cfif></p>
			</div>
		</div>
	</div>	
</div>

<div class="divider"></div>

</cfif>

<cfif val(wrapper.wrapper_risk_calculator) IS 1>

<div class="box">
	<div class="box-outer">
		<div class="box-inner">
			<div class="box-content"><a href="http://demo.ltccounselor.org/index.cfm?method=ltcc.doCalculateCosts" target="risk_calculator" class="indexh2b">
			
			
			<cf_displayImage code="img_partners_stimulus_gif"  border="0" align="right" class="icon2">Your Risks and Costs for Long-Term Care</a></div>
			<div class="box-content2">
			<p class="text2">Planning for long-term care requires knowledge of your risk of needing long-term care and the related costs.  Learn the risk you have for using long-term care services and the related costs based on your specific age, health, and level of activity.<a href="http://demo.ltccounselor.org/index.cfm?method=ltcc.doCalculateCosts" target="risk_calculator" class="linkbutton" style="float:right; margin: 8px 0px 0px 8px;">Go!</a>
			</p>


			
			</div>
		</div>
	</div>	
</div>

<div class="divider"></div>

</cfif>

<table cellpadding="0" cellspacing="0" width="100%">
<tr>
<td valign="top" width="32%"><div class="box">
	<div class="box-outer" >
		<div class="box-inner">
			<h2 class="boxheader">
            	<div class="box-content titleFix">
                	<cf_sessionPassVars href="cf/fitapp/index.cfm" prev_id="0" class="indexh2b">
						<cf_displayImage code="img_partners_rxicon_gif"  border="0" class="icon"><cf_displayText code="site_fit_homepage_fit_title" group="site">
                    </cf_sessionPassVars>
                </div>
            </h2>
			<div class="box-content2">
				<p class="text2" style="clear:left;"><cf_displayText code="site_fit_homepage_fit_description" group="site"></p>
				<p class="text3">
					<cf_sessionPassVars href="fitapp/index.cfm" prev_id="0" class="linkbutton">Go!</cf_sessionPassVars><span class="indexh2b" style="font-style:italic;padding-left:4px">Start Here!</span>
                </p>
			</div>
		</div>
	</div>	
</div></td>
<td width="32">&nbsp;</td>

<td valign="top" width="32%"><div class="box">
	<div class="box-outer" >
		<div class="box-inner">
			<h2 class="boxheader">
            	<div class="box-content titleFix">
                	<cf_sessionPassVars href="moreprograms.cfm" prev_id="0" class="indexh2b">
						<cf_displayImage code="img_partners_findbenefitsicon_gif"  border="0" class="icon"><cf_displayText code="site_fit_homepage_bcu_title" group="site">
                    </cf_sessionPassVars>
                </div>
            </h2>
			<div class="box-content2">
				<p class="text2" style="clear:left;"><cf_displayText code="site_fit_homepage_bcu_description" group="site"></p>
				<p class="text3">
					<cf_sessionPassVars href="moreprograms.cfm" prev_id="0" class="linkbutton">Go!</cf_sessionPassVars>
                </p>
			</div>
		</div>
	</div>	
</div></td>
<td width="32">&nbsp;</td>

<!--- <td valign="top" width="32%"><div class="box">
	<div class="box-outer" >
		<div class="box-inner">
			<h2 class="boxheader">
			<div class="box-content">
			<!--- <cfif wrapper.wrapper_lis_link_direct IS 1>
				<cf_sessionPassVars href="lisapp/index.cfm" partner_id="#session.partner_id#"
					org_id="#session.org_id#" user_id="#session.user_id#"
					test_id="#session.test_id#" extralist="skipintro=true" class="indexh2b">
					<cf_displayImage code="img_partners_rxicon_gif"  border="0" class="icon">Medicare<br />Rx Extra Help
				</cf_sessionPassVars>
			<cfelse>
				<cf_sessionPassVars href="extrahelp.cfm" prev_id="0" class="indexh2b"><cf_displayImage code="img_partners_rxicon_gif"  border="0" class="icon">Medicare<br />Rx Extra Help</cf_sessionPassVars>
			</cfif> --->
			</div></h2>
			<div class="box-content2">
			<p class="text2">Apply now for Medicare's Extra Help and also find out if you qualify for other valuable benefit programs.</p>
			<p class="text3">
			<cfif wrapper.wrapper_lis_link_direct IS 1>
				<cf_sessionPassVars href="lisapp/index.cfm" partner_id="#session.partner_id#"
				org_id="#session.org_id#" user_id="#session.user_id#"
				test_id="#session.test_id#" extralist="skipintro=true" class="linkbutton">Go!</cf_sessionPassVars>
			<cfelse>
				<cf_sessionPassVars href="extrahelp.cfm" prev_id="0" class="linkbutton">Go!</cf_sessionPassVars>
			</cfif>
			</p>


			</div>
		</div>
	</div>	
</div></td> 

<td width="32">&nbsp;</td>
--->

<td valign="top" width="32%">
<div class="box">
	<div class="box-outer">
		<div class="box-inner">
			<h2 class="boxheader">
            	<div class="box-content titleFix">
                	<cf_sessionPassVars href="fit_resources.cfm" prev_id="0" class="indexh2b">
                    	<cf_displayImage code="img_partners_applyicon_gif"  border="0" class="icon"><cf_displayText code="site_fit_homepage_resources_title" group="site">
                    </cf_sessionPassVars>
                </div>
            </h2>
			<div class="box-content2">
				<p class="text2"><cf_displayText code="site_fit_homepage_resources_description" group="site"></p>
				<p class="text3"><cf_sessionPassVars href="fit_resources.cfm" prev_id="0" class="linkbutton">Go!</cf_sessionPassVars></p>
			</div>
		</div>
	</div>	
</div>
</td>
</tr>
</table>

</td>
</tr>


<cfif findnocase("[SLOT2]", wrapper.wrapper_optional_box_text) IS 0 AND trim(wrapper.wrapper_optional_box_text) IS NOT "">
<tr>
<td>#wrapper.wrapper_optional_box_text#</td>
</tr>
</cfif>


<cfif val(wrapper.wrapper_special) IS 1 and wrapper.partner_id neq 22>
<tr>
<td style="padding:0px 16px 0px 16px;">
<div class="box">
	<div class="box-outer">
		<div class="box-inner">
			<div class="box-content"><cf_sessionPassVars href="snap.cfm?partner_id=#wrapper.partner_id#" partner_id="#wrapper.partner_id#" prev_id="0"  class="indexh2b"><cf_displayImage code="img_food_gif"  border="0" align="right" class="icon">Need Help Paying for Food?</cf_sessionPassVars></div>
			<div class="box-content2">
				<p class="text3">
				<cfif wrapper.wrapper_special_text IS NOT "">
					#wrapper.wrapper_special_text#
				<cfelse>
					Find the program in your state, get an application and apply today by clicking <cf_sessionPassVars href="snap.cfm?partner_id=#wrapper.partner_id#" partner_id="#wrapper.partner_id#" prev_id="0" >here!</cf_sessionPassVars>
				</cfif>
				</p>
			</div>
		</div>
	</div>	
</div></td>
</tr>
</cfif>

<cfif findnocase("[SLOT2]", wrapper.wrapper_optional_box_text) GT 0>
<tr>
<td style="padding:16px 16px 0px 16px;">
<div class="box">
	<div class="box-outer">
		<div class="box-inner">
			<div class="box-content" style="padding-bottom:0px;"><p class="text3" style="margin-bottom:4px;">#replacenocase(wrapper.wrapper_optional_box_text, "[SLOT2]", "")#</p></div>
			<div class="box-content2"></div>
		</div>
	</div>	
</div>
<div class="divider"></div></td>
</tr>
</cfif>

</table>
<div class="box" style="margin:-5px 15px 5px 18px; width:730px;">
	<div class="box-outer">
		<div class="box-inner">
			
			<h2 class="boxheader">
            	<div class="box-content titleFixNew taxreliefheader">
                	<cf_sessionPassVars href="fit_taxrelief.cfm?partner_id=#SESSION.partner_id#" prev_id="0" class="indexh2b">
						<img width="32" src="images/home.png" border="0" class="index_icon_new" alt="House" title="House">
						<cf_displayText code="site_fit_homepage_tax_insurance_title" group="site">
                    </cf_sessionPassVars>
                </div>
            </h2>
            <div id="starburst">
				<img src="images/starburst_new.png" width="45px">
			</div>
			<div class="box-content2" style="margin-top:-10px">
				
				<p id="taxrelief_text" style="clear:left;" class="text2"><cf_displayText code="site_fit_homepage_tax_insurance_description" group="site"></p>
				<p class="text3" style="margin-top:-25px">
					<cf_sessionPassVars href="fit_taxrelief.cfm?partner_id=#SESSION.partner_id#" prev_id="0" class="linkbutton">Go!</cf_sessionPassVars>
                </p>
			</div>
		</div>
	</div>	
</div>

</cfoutput>
