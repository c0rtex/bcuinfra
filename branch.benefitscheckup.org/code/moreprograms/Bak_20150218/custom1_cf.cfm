<cfoutput>

<cfif val(partnerQuery.wrapper_custom_subset)>

<cfif partnerQuery.wrapper_custom_subset eq 1>
	<cfset neededURL = "neededinfo-rx.cfm">
<cfelseif partnerQuery.wrapper_custom_subset eq 12>
	<cfset neededURL = "neededinfo-card.cfm">
<cfelseif partnerQuery.wrapper_custom_subset eq 14>
	<cfset neededURL = "neededinfo-lis.cfm">
<cfelseif partnerQuery.wrapper_custom_subset eq 18 or partnerQuery.wrapper_custom_subset eq 22>
	<cfset neededURL = "neededinfo-aoa.cfm">
<cfelseif partnerQuery.wrapper_custom_subset eq 21>
	<cfset neededURL = "neededinfo-il.cfm">
<cfelseif partnerQuery.wrapper_custom_subset eq 27>
	<cfset neededURL = "neededinfo-27.cfm">
<cfelseif partnerQuery.wrapper_custom_subset eq 34>
	<cfset neededURL = "neededinfo-wom.cfm">
<cfelseif partnerQuery.wrapper_custom_subset eq 35>
	<cfset neededURL = "neededinfo-35.cfm">
<cfelseif partnerQuery.wrapper_custom_subset eq 36>
	<cfset neededURL = "neededinfo-36.cfm">
<cfelseif partnerQuery.wrapper_custom_subset eq 37>
	<cfset neededURL = "neededinfo-37.cfm">
<cfelseif partnerQuery.wrapper_custom_subset eq 38>
	<cfset neededURL = "neededinfo-38.cfm">
<cfelseif partnerQuery.wrapper_custom_subset eq 39>
	<cfset neededURL = "neededinfo-39.cfm">
<cfelseif partnerQuery.wrapper_custom_subset eq 44>
	<cfset neededURL = "neededinfo-44.cfm">
<cfelseif partnerQuery.wrapper_custom_subset eq 49>
	<cfset neededURL = "neededinfo-49.cfm">
<cfelseif partnerQuery.wrapper_custom_subset eq 49>
	<cfset neededURL = "neededinfo-49.cfm">
<cfelseif partnerQuery.wrapper_custom_subset eq 51>
	<cfset neededURL = "neededinfo-51.cfm">
<cfelseif partnerQuery.wrapper_custom_subset eq 54>
	<cfset neededURL = "neededinfo-54.cfm">	
<cfelseif partnerQuery.wrapper_custom_subset eq 56>
	<cfset neededURL = "neededinfo-56.cfm">	
<cfelseif partnerQuery.wrapper_custom_subset eq 57>
	<cfset neededURL = "neededinfo-57.cfm">	
<cfelseif partnerQuery.wrapper_custom_subset eq 78>
	<cfset neededURL = "neededinfo-78.cfm">			
<cfelse>
	<cfif session.partner_id IS "24">
		<cfset neededURL = "neededinfo-24.cfm">
	<cfelse>
		<cfset neededURL = "neededinfo.cfm">
	</cfif>	
</cfif>

<div class="icon"><cf_displayImage code="img_home_tool_off2_gif" height="22" width="19" hspace="0" vspace="0"></div>
<div class="apply2"><div class="h1">#partnerQuery.wrapper_custom_title#:</div>
<p class="text1"><em>Typically takes #partnerQuery.wrapper_custom_time# minutes.</em>  <a href="javascript:help2('<cfoutput>#neededURL#</cfoutput>')">Click here</a> to see if you need to gather any information before you begin.

<cfif val(partnerQuery.wrapper_whatithelps) GT 0>
<a href="javascript:help2('<cfoutput>#application.transferType#://#application.serverPath#/whatithelps.cfm?id=#partnerQuery.wrapper_custom_subset#</cfoutput>')">Click here</a> to see what benefit programs are included in this questionnaire.
</cfif>

</p>


<table cellpadding="0" cellspacing="0" width="100%" border="0">
<tr>
<td valign="top" width="68%"><div class="box">
	<div class="box-outer">
		<div class="box-inner">
			
			<h2 style="margin-bottom:8px;"><div class="box-content">Interactive Questionnaire <cfif SESSION.partner_id NEQ 76>(recommended)</cfif></div></h2>
			<div class="box-content2">
			<cfif SESSION.partner_id EQ 76><p class="text2" style="height:50px;"><cfelse><p class="text1"></cfif>This is the quickest and easiest way to get started. You will only answer questions based on your unique needs, saving you time.</p>
			<cfif SESSION.partner_id EQ 76><p class="text3" style="margin-bottom:0px;"><cfelse><p class="text10" style="margin-bottom:0px;"></cfif><cf_sessionPassVars href="frmwelcome2.cfm?partner_id=#SESSION.partner_id#" subset_id="#partnerQuery.wrapper_custom_subset#" class="linkbutton">Go!</cf_sessionPassVars></p>
			</div>
		</div>
	</div>	
</div></td>
<td width="2%">&nbsp;</td>
<td valign="top" width="30%"<cfif SESSION.partner_id EQ 76> style="padding-right:3px;"</cfif>><div class="box">
	<div class="box-outer">
		<div class="box-inner">
			
			<h2 style="margin-bottom:8px;"><div class="box-content">Printed Questionnaire</div></h2>
			<div class="box-content2">
			<cfif SESSION.partner_id EQ 76><p class="text2" style="height:50px;"><cfelse><p class="text1"></cfif>Get a questionnaire to fill out by hand.</p>
<cfif SESSION.partner_id EQ 76><p class="text3" style="margin-bottom:0px;"><cfelse><p class="text10" style="margin-bottom:0px;"></cfif><cf_sessionPassVars href="printed.cfm?partner_id=#SESSION.partner_id#" subset_id="#partnerQuery.wrapper_custom_subset#" class="linkbutton">Go!</cf_sessionPassVars></p>
			</div>
		</div>
	</div>	
</div></td>
</tr>
</table>

</div>

<p style="clear:both; height:8px; margin: 0px;"></p>
</cfif>

</cfoutput>