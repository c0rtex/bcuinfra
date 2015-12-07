<cfset neededURL = "neededinfo.cfm">
<cfoutput>

<table cellpadding="20" cellspacing="0" width="100%" border="0">
<tr>
<td><img src="img/partners/cvs/store.jpg" alt="#wrapper.wrapper_cover_image_alt_text#" title="#wrapper.wrapper_cover_image_alt_text#" align="right" style="padding-bottom: 16px;" />
<h1 class="indexh1">Get Started Now!</h1>
<p class="text1">Get all the benefits you deserve. BenefitsCheckUp helps you find and enroll in federal, state, local and private programs that help pay for prescription drugs, utility bills, meals, health care and other needs.  In addition, BenefitsCheckUp includes up-to-date information on Medicare Prescription Drug Coverage and includes an online application for the Extra Help.</p>

<div class="clear"></div>

<!--- <div class="divider"></div>

<div class="box">
	<div class="box-outer">
		<div class="box-inner">
			<div class="box-content"><a href="#application.transferType#://#wrapper.wrapper_special_link#" ONCLICK="VSLT('#application.serverPathES#')" target="stimulus2008" class="indexh2b"><img src="img/partners/stimulus.gif" border="0" alt="Get Your Stimulus Payment" class="icon2" />Get Your Stimulus Payment!</a> <span style="font-size:12px;"><em>Brought to you by AARP Tax-Aide and NCOA's BenefitsCheckUp</em></span></div>
			<div class="box-content2">
			<p class="text3"><cfif wrapper.wrapper_special_text IS NOT "">#special_text#<cfelse><a href="#application.transferType#://#application.serverPathES#" ONCLICK="VSLT('#application.serverPathES#')" target="stimulus2008" class="linkbutton" style="float:right; margin: 8px 0px 0px 16px;">Go!</a>To get your Economic Stimulus Payment, you must file a tax return, even if you haven't been required to file in a while. To find out if you need to file, use our quick and simple Stimulus Payment Tool. </cfif></p>
			</div>
		</div>
	</div>	
</div>

<div class="divider" style="padding:8px;"></div> --->



<cf_sessionLoadVars>
<div class="icon"><cf_sessionPassVars href="before_you_start.cfm?partner_id=#SESSION.partner_id#" subset_id="0" partner_id="24"><cf_displayImage code="img_home_tool_off2_gif" height="22" width="19" hspace="0" vspace="0"></cf_sessionPassVars></div>
<div class="apply2"><cf_sessionPassVars href="before_you_start.cfm?partner_id=#SESSION.partner_id#" subset_id="0"  partner_id="24" class="h1link">Comprehensive:</cf_sessionPassVars>
<p class="text1">Find programs that can help you pay for prescription drugs, health care, utilities and more.</p>
<p class="text1"><cf_sessionPassVars href="before_you_start.cfm?partner_id=#SESSION.partner_id#" subset_id="0"  class="linkbutton">Go!</cf_sessionPassVars> &nbsp; <em>Typically takes 20-30 minutes.</em></p>
</div>

<div class="line2"></div>

<div class="icon"><a href="redirect.cfm?partner_id=24&id=16&tgt=1" target="1"><cf_displayImage code="img_home_tool_off2_gif" height="22" width="19" hspace="0" vspace="0"></a></div>
<div class="apply2"><a href="redirect.cfm?partner_id=24&id=16&tgt=1" target="1" class="h1link">Medicare Part D Calculator:</a>
<p class="text1">Find out which Medicare Prescription Drug Plan is right for you and
if you are eligible for Medicare's Extra Help.</p> 
<p class="text1"><a href="redirect.cfm?partner_id=24&id=16&tgt=1" target="1"class="linkbutton">Go!</a> &nbsp; <em>Typically takes 10-15 minutes.</em></p>
</div></td>
</tr>
</table>
</cfoutput>