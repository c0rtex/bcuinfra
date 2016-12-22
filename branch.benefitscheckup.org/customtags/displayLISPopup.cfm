<cfsilent>
<cfparam name="attributes.hspace" type="any" default="">
<cfparam name="attributes.vspace" type="any" default="">
<cfparam name="attributes.align" type="any" default="">

<cfif parameterExists(session.transferTypeCanonicalOverride)>
	<cfset urlType = session.transferTypeCanonicalOverride>
	<cfset lisUrl = application.serverPathCanonical>
<cfelse>
	<cfset urlType = application.transferType>		
	<cfset lisUrl = application.serverPathCanonical>
</cfif>	

<cfif attributes.hspace neq ''>
	<cfset attributes.hspace = " hspace=""#attributes.hspace#""">
</cfif>
<cfif attributes.vspace neq ''>
	<cfset attributes.vspace = " vspace=""#attributes.vspace#""">
</cfif>
<cfif attributes.align neq ''>
	<cfset attributes.align = " align=""#attributes.align#""">
</cfif>

<cfif session.partner_id neq 14>
<cfset buttonImg = "<img id='applynow_button' src=""images/button_apply-now.gif"" width=""130"" height=""28"" border=""0"" alt=""Apply Now"" title=""Apply Now""#attributes.hspace##attributes.vspace##attributes.align#>">
<cfelse>
<cfset buttonImg = "">
</cfif>

</cfsilent>

<cfif application.enableLIS>
<cfsilent>
	<cf_displayText group="site" code="site_lis_apply_popup" var="lisappPopupText">
</cfsilent>
<cfif isdefined('session.partner_id') and session.partner_id eq 55>
	<cf_sessionPassVars href="#lisUrl#/lisapp/index.cfm" target="_blank" partner_id="#session.partner_id#" subset_id="41"   test_id="#session.test_id#" confirm="#lisappPopupText#"><cfoutput>#buttonImg#</cfoutput></cf_sessionPassVars>
<cfelseif isdefined('session.partner_id') and (session.partner_id eq 89 or session.partner_id eq 90)>
	<cf_sessionPassVars href="https://secure.ssa.gov/i1020/start" partner_id="#session.partner_id#" subset_id="41"   test_id="#session.test_id#" confirm="#lisappPopupText#"><cfoutput>#buttonImg#</cfoutput></cf_sessionPassVars>
<cfelse>
	<cf_sessionPassVars href="start.cfm" subset_id="41" confirm="#lisappPopupText#"><cfoutput>#buttonImg#</cfoutput></cf_sessionPassVars>
</cfif>
<cfsilent></cfsilent>
<cfelse>
<cfsilent>
	<cf_displayText group="site" code="site_turboapp_not_available_popup" jsEscape="true" var="lisappPopupText">
</cfsilent>
<cfoutput>
<a href="javascript:void();" onClick="alert(#lisappPopupText#);">#buttonImg#</a>
</cfoutput>
<cfsilent></cfsilent>
</cfif>
