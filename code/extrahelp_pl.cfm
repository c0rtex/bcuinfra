<script type="text/javascript">
$(function() {
	$('h1').addClass('indexh1');
	$('p').addClass('text1');
	$('li').addClass('text1');
	$('h3').addClass('h1');
});
</script>

<cfoutput><table cellpadding="20" cellspacing="0" width="100%" border="0">
<tr>
<td><cfif session.partner_id NEQ 74>
	<cfquery name="getText2" datasource="#application.dbSrc#">
SELECT *
FROM display_language
where display_id = 3463 and language_id = 'EN'
</cfquery>
	<!---cf_displayText group="site" code="site_extrahelp_intro"--->
    <cfoutput>#getText2.display_text#</cfoutput>
<cfif session.partner_id neq 76>
    <cfoutput><p>Not sure if you should apply? Answer a few questions to find out. <a href="/cf/frmwelcome2.cfm?subset_id=27&partner_id=#session.partner_id#">Get Started</a></p></cfoutput>
</cfif>
<cfelse>
	<cf_displayText group="site" code="site_extrahelp_intro_ak">
</cfif>
<cfoutput>

<p class="text1" style="margin-top:16px;"><cfif session.partner_id IS 48><a href="##" class="linkbutton">Apply Now</a> <em><cf_displayText group="site" code="site_apply_now_disabled"></em><cfelse>

<cfif session.partner_id eq 55>
	<cfif parameterExists(session.transferTypeCanonicalOverride)>
		<cfset urlType = session.transferTypeCanonicalOverride>
		<cfset lisUrl = "https://#CGI.server_name#/cf">
	<cfelse>
		<cfset urlType = application.transferType>		
		<cfset lisUrl = "">
	</cfif>
	<cf_sessionPassVars href="#lisUrl#/lisapp/index.cfm" target="_blank" partner_id="55" subset_id="41" class="linkbutton"   >Apply Now
	</cf_sessionPassVars>
<cfelseif session.partner_id EQ 74>
	<cfif parameterExists(session.transferTypeCanonicalOverride)>
		<cfset urlType = session.transferTypeCanonicalOverride>
		<cfset lisUrl = "https://#CGI.server_name#/cf">
	<cfelse>
		<cfset urlType = application.transferType>		
		<cfset lisUrl = "">
	</cfif>
	<cf_sessionPassVars href="#lisUrl#/lisapp/index.cfm" target="_blank" partner_id="74" subset_id="41" class="linkbutton"   >Apply Now
	</cf_sessionPassVars>
<cfelse>
	<cf_sessionPassVars  href="start.cfm" subset_id="41" class="linkbutton">Apply Now</cf_sessionPassVars>
</cfif>	

</cfif></p>
</cfoutput></td>
</tr>

<tr>
<td><cf_tagPlText column_name="cms_doc_no"></td>
</tr>

</table>
</cfoutput>