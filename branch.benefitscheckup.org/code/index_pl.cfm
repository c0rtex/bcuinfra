<cfset neededURL = "neededinfo.cfm?partner_id=#SESSION.partner_id#">
<style type="text/css">
 .titleFix{
 	height:38px;
 }
</style>
<!--[if IE]>
<style type="text/css">
 .titleFix{
 	height:60px;
 }
</style>
<![endif]-->
<cfset browser = ''>
<CFIF FindNoCase('Chrome','#CGI.HTTP_USER_AGENT#') GREATER THAN 0>
  <CFSET browser = 'Chrome'>
</CFIF>

<cfif wrapper.wrapper_special_link IS NOT "">
	<cfset special_link = evaluate(wrapper.wrapper_special_link)>
	<cfset special_text = replacenocase(wrapper.wrapper_special_text, "[link]", "#application.transferType#://#special_link#", "all")>
<cfelse>
	<cfset special_link = application.serverPathES>
</cfif>
<cfoutput>
<table cellpadding="0" cellspacing="0" width="100%" border="0" class="boxtable">
<tr>
<td style="padding:0px 16px 16px 16px;">
	<cfif trim(wrapper.wrapper_cover_image) IS NOT "">
    	<cfif wrapper.wrapper_id eq 60>
        	<a href="esi_start.cfm?partner_id=77">
        </cfif>
        <cfif Left(wrapper.wrapper_cover_image, 1) EQ "/">
         	<cfset wrapper.wrapper_cover_image = ReReplaceNoCase(wrapper.wrapper_cover_image,"/","","ONE")>
        </cfif>
    	<img src="#wrapper.wrapper_cover_image#" alt="#wrapper.wrapper_cover_image_alt_text#" title="#wrapper.wrapper_cover_image_alt_text#" align="right" class="plimage" style="margin-bottom:0px;" />
    	<cfif wrapper.wrapper_id eq 60>
        	</a>
        </cfif>
    </cfif>
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
			<div class="box-content"><cf_sessionPassVars href="snap.cfm?partner_id=56" partner_id="56" prev_id="0" target="snap" class="indexh2b"><cf_displayImage code="img_food_gif"  border="0" align="right" class="icon2" style="margin-bottom:0px;">Need Help Paying for Food?</cf_sessionPassVars></div>
			<div class="box-content2">
		<p class="text3"><cfif wrapper.wrapper_special_text IS NOT "">#wrapper.wrapper_special_text#<cfelse>Find the program in your state, get an application and apply today by clicking <cf_sessionPassVars href="snap.cfm?partner_id=56" partner_id="56" prev_id="0" target="snap">here!</cf_sessionPassVars>


</cfif></p>
			</div>
		</div>
	</div>	
</div>

<div class="divider"></div>

</cfif>

<!---cfif val(wrapper.wrapper_risk_calculator) IS 1>

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

</cfif--->

<!--- MH: Bug 5589 7/21/10 --->
<cfif wrapper.wrapper_id eq 60>
<div class="box">
	<div class="box-outer">
		<div class="box-inner">
			<div class="box-content"><a href="esi_start.cfm?partner_id=77" class="indexh2b">
				<cf_displayImage code="img_partners_emblem_money_32_gif"  border="0" align="right" class="icon2"><cf_displayText code="site_esi_homepage_title" group="site"></a><font class="text2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="esi_start.cfm?partner_id=77" class="linkbutton" style="margin:8px;">Go!</a></font></div>
			<div class="box-contentesi">
				<p class="text2"><cf_displayText code="site_esi_homepage_description" group="site"></p>
            </div>
		</div>
	</div>	
</div>
<div class="divider"></div>
</cfif><!--- END MH --->

<table cellpadding="0" cellspacing="0" width="100%">
<tr>
<td valign="top" width="32%">
<div class="box">
	<div class="box-outer" >
		<div class="box-inner">
			<h2 class="boxheader">
            	<div class="box-content">
                	<cf_sessionPassVars href="moreprograms.cfm?partner_id=#SESSION.partner_id#" prev_id="0" class="indexh2b">
						<cf_displayImage code="img_partners_findbenefitsicon_gif"  border="0" class="icon">
						<cfif session.partner_id is 77>
                            <cf_displayText group="site" code="site_fit_homepage_bcu_title"><BR />&nbsp;<BR />
                        <cfelse>
                            Find Benefits Programs<cfif session.partner_id neq 55 and browser neq 'Chrome'></br></br></cfif>
                        </cfif>
            		</cf_sessionPassVars>
                </div>
            </h2>
			<div class="box-content2">
				<p class="text2">Find and enroll in programs that can help save you money.</p>
				<p class="text3">
					<cf_sessionPassVars href="/cf/moreprograms.cfm?partner_id=#SESSION.partner_id#" prev_id="0" class="linkbutton">Go!</cf_sessionPassVars>
                </p>
			</div>
		</div>
	</div>	
</div>
</td>
<td width="32">&nbsp;</td>

<td valign="top" width="32%"><div class="box">
	<div class="box-outer" >
		<div class="box-inner">
			<h2 class="boxheader">
			<div class="box-content">
			<cfif wrapper.wrapper_lis_link_direct IS 1>
			<cf_sessionPassVars href="lisapp/index.cfm?partner_id=#SESSION.partner_id#" partner_id="#session.partner_id#"
org_id="#session.org_id#" user_id="#session.user_id#"
test_id="#session.test_id#" extralist="skipintro=true" class="indexh2b"><cf_displayImage code="img_partners_rxicon_gif"  border="0" class="icon">Medicare<br />Rx Extra Help</cf_sessionPassVars>

			<cfelse>
			<cf_sessionPassVars href="extrahelp.cfm?partner_id=#SESSION.partner_id#" prev_id="0" class="indexh2b"><cf_displayImage code="img_partners_rxicon_gif"  border="0" class="icon">Medicare<br />Rx Extra Help</cf_sessionPassVars>
			</cfif>
			
			
			</div></h2>
			<div class="box-content2">
			<p class="text2">Apply now for Medicare's Extra Help and also
find out if you qualify for other valuable benefit programs.</p>
			<p class="text3">
			<cfif wrapper.wrapper_lis_link_direct IS 1>
				<cf_sessionPassVars href="lisapp/index.cfm?partner_id=#SESSION.partner_id#" partner_id="#session.partner_id#"
				org_id="#session.org_id#" user_id="#session.user_id#"
				test_id="#session.test_id#" extralist="skipintro=true" class="linkbutton">Go!</cf_sessionPassVars>
			<cfelse>
				<cf_sessionPassVars href="extrahelp.cfm?partner_id=#SESSION.partner_id#" prev_id="0" class="linkbutton">Go!</cf_sessionPassVars>
			</cfif>
			</p>


			</div>
		</div>
	</div>	
</div></td>



<td width="32">&nbsp;</td>

<td valign="top" width="32%"><div class="box">
	<div class="box-outer">
		<div class="box-inner">
			
			<h2 class="boxheader"><div class="box-content"><cf_sessionPassVars href="apply.cfm?partner_id=#SESSION.partner_id#" prev_id="0" class="indexh2b"><cf_displayImage code="img_partners_applyicon_gif"  border="0" class="icon">Application Forms<br />Center</cf_sessionPassVars></div></h2>
			<div class="box-content2">
			<p class="text2">Get applications and fact sheets for programs that help pay for prescription drugs and health care.</p>
<p class="text3"><cf_sessionPassVars href="apply.cfm?partner_id=#SESSION.partner_id#" prev_id="0" class="linkbutton">Go!</cf_sessionPassVars></p>
			</div>
		</div>
	</div>	
</div>
</td>
</tr>
</table></td>
</tr>


<cfif findnocase("[SLOT2]", wrapper.wrapper_optional_box_text) IS 0 AND trim(wrapper.wrapper_optional_box_text) IS NOT "">
<tr>

#rereplaceNoCase(wrapper.wrapper_optional_box_text, "\[SLOT3\].*", "")#
<td>#wrapper.wrapper_optional_box_text#</td>
</tr>
</cfif>


<cfif val(wrapper.wrapper_special) IS 1 and wrapper.partner_id neq 22> 

<!---<cfif partner_id eq 30 or partner_id eq 117 or partner_id eq 120> ---><!--- Lynna Cekova: Coventry, 30,  Aetna, 117, and HPP, 120  being the only ones with SLOT3 as of Feb 23, 2015 --->


<cfif findnocase("[SLOT3]", wrapper.wrapper_optional_box_text) GT 0>
<tr>

<td style="padding:16px 16px 0px 16px;">
<div class="box">
	<div class="box-outer">
		<div class="box-inner">
			<div class="box-content" style="padding-bottom:0px;"><p class="text3" style="margin-bottom:4px;">#rereplaceNoCase(wrapper.wrapper_optional_box_text, "\[SLOT2\].*\[SLOT3\]", "")#</p></div> 
<!--- Lynna Cekova: regex selects to delete everything between [SLOT2] and [SLOT3], inclusive --->
			<div class="box-content2"></div>
		</div>
	</div>	
</div>
<div class="divider"></div></td>
<!--- <br/> --->
</cfif>
<!---</cfif> --->


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
					<cf_displayText code="site_snap_textbox" group="site"> <cf_sessionPassVars href="snap.cfm?partner_id=#wrapper.partner_id#" partner_id="#wrapper.partner_id#" prev_id="0" >here</cf_sessionPassVars>!
				</cfif>
				</p>
			</div>
		</div>
	</div>	
</div></td>
</tr>
</cfif>

<cfif findnocase("[SLOT2]", wrapper.wrapper_optional_box_text) GT 0>

         	<cfset tempWrapperText = ReReplaceNoCase(wrapper.wrapper_optional_box_text, "\[SLOT2\]", "")>
<cfset wrapper.wrapper_optional_box_text = tempWrapperText>
<cfset wrapper.wrapper_optional_box_text = rereplaceNoCase(wrapper.wrapper_optional_box_text, "\[SLOT3\].*", "")>
<!--- Lynna Cekova: combination of the two regex selects to delete [SLOT2], and [SLOT3] and everything after it --->
<cfif trim(wrapper.wrapper_optional_box_text) IS NOT "">
<tr>
<td style="padding:16px 16px 0px 16px;">
<div class="box">
	<div class="box-outer">
		<div class="box-inner">
			<div class="box-content" style="padding-bottom:0px;"><p class="text3" style="margin-bottom:4px;">#wrapper.wrapper_optional_box_text#</p></div> 

			<div class="box-content2"></div>
		</div>
	</div>	
</div>
<div class="divider"></div></td>
</tr>
</cfif>
</cfif>


</table>


</cfoutput>
