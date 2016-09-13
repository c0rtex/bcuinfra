<cfcache action="cache" timespan="#CreateTimeSpan(90, 0, 0, 0)#">

<cfparam name="state_id" default="">

<cfparam name="partner_id" default="0">

<cf_cachePartnerQuery query="partnerQuery" partner_id="#partner_id#">

<cf_cacheStatePool action="get" state_id="#state_id#" var="stobj">

<cf_sessionLoadVars>

<cf_handleScreening mode="print">



<cf_buildHTML cellpadding="12" cellspacing="2" width="640" align="left">

<cf_displayButton return_oe="true">



<cfif session.subset_id IS 19 AND trim(partnerQuery.wrapper_pap_custom_name) IS NOT "">

	<cfoutput>

	<h2>A Printable #partnerQuery.wrapper_pap_custom_name# Questionnaire for #stobj.name#</h2>

	</cfoutput>

<cfelseif session.subset_id IS 49 AND trim(partnerQuery.wrapper_custom_title) IS NOT "">

	<cfoutput>

	<h2>A Printable #partnerQuery.wrapper_custom_title# Questionnaire for #stobj.name#</h2>

	</cfoutput>

<cfelse>

	<h2><cf_displayText group="site" code="site_printed_qaire_title"></h2>

</cfif>



<cfif IsNumeric(session.org_id) and session.org_id gt 0>

	<p><cf_displayText group="site" code="site_oe_printed_qaire_intro"></p>



	<table border="0" align="center">

	<tr>

		<td width="50%"><cf_displayAddressBlank style="font-size: 7pt;"></td>

		<td>&nbsp;&nbsp;</td>

		<td width="50%"><cf_displayAddressBlank style="font-size: 7pt;" contact="true"></td>

	</tr>

	<tr>

	<td colspan="3"><br />	

	<p><cf_displayText group="site" code="site_oe_printed_qaire_note"></p>

	<p align="center">

		<b><cf_displayText group="site" code="site_oe_printed_qaire_return"></b><br /><br />

		<cf_displayOrganizationAddress>

	</p>

	</tr>

	</table>

<cfelse>

	<cf_displayText group="site" code="site_printed_qaire_intro"><br />

</cfif>



<cf_buildQuestionnaire width="640">



<cfif IsNumeric(session.org_id) and session.org_id gt 0>

	<br />

	<p align="center">

		<i><cf_displayText group="site" code="site_oe_printed_qaire_thanks"></i><br /><br />

		<b><cf_displayText group="site" code="site_oe_printed_qaire_return"></b><br /><br />

		<cf_displayOrganizationAddress>

	</p>

</cfif>



</cf_buildHTML>