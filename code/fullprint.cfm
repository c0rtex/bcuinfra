<cfcache action="cache" protocol="https://"  timespan="#CreateTimeSpan(90, 0, 0, 0)#">
<cfparam name="state_id" default="#SESSION.state_id#">
<cfparam name="partner_id" default="0">
<cf_cachePartnerQuery query="partnerQuery" partner_id="#partner_id#">
<cf_cacheStatePool action="get" state_id="#state_id#" var="stobj">
<cf_sessionLoadVars>
<cf_handleScreening mode="print">
<cfif SESSION.partner_id EQ 89 OR SESSION.partner_id EQ 90>
	<cfset partner_width = 840>
<cfelse>
	<cfset partner_width = 640>
</cfif>
<cf_buildHTML cellpadding="12" cellspacing="2" width="#partner_width#" align="left" guts="fullprint.cfm">
<cf_displayButton return_oe="true">

<cfif session.subset_id IS 19 AND trim(partnerQuery.wrapper_pap_custom_name) IS NOT "">
	<cfoutput>
	<h2>A Printable #partnerQuery.wrapper_pap_custom_name# Questionnaire for #stobj.name#</h2>
	</cfoutput>
<cfelseif session.subset_id IS 49 AND (
(trim(partnerQuery.wrapper_custom_title) IS NOT "" AND partnerQuery.wrapper_custom_subset IS 49) OR 
(trim(partnerQuery.wrapper_custom_title2) IS NOT "" AND partnerQuery.wrapper_custom_subset2 IS 49)
)>
	<cfoutput>
	<cfif trim(partnerQuery.wrapper_custom_title) IS NOT "" AND partnerQuery.wrapper_custom_subset IS 49>
		<h2>A Printable #partnerQuery.wrapper_custom_title# Questionnaire for #stobj.name#</h2>
	<cfelse>
		<h2>A Printable #partnerQuery.wrapper_custom_title2# Questionnaire for #stobj.name#</h2>
	</cfif>
	</cfoutput>
<cfelseif session.subset_id eq 0 and session.partner_id eq 101>
	<cfoutput>
	<h2>A Printable Comprehensive BenefitsCheckUp Questionnaire for #stobj.name#</h2>
	</cfoutput>
	<cfelseif session.subset_id eq 27 and session.partner_id eq 101>
	<cfoutput>
	<h2>A Printable Extra Help (LIS) Quick Screen BenefitsCheckUp Questionnaire for #stobj.name#</h2>
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
	</table>

	<p><cf_displayText group="site" code="site_oe_printed_qaire_note"></p>

	<p align="center">
		<b><cf_displayText group="site" code="site_oe_printed_qaire_return"></b><br /><br />
		<cf_displayOrganizationAddress>
	</p>
	<br />
<cfelseif session.partner_id eq 101 and session.subset_id eq 0>
Welcome to the BenefitsCheckUp Printed Questionnaire!  To learn about benefits you might be eligible for, please take the following steps:
<ol>
<li>Print and fill out this questionnaire.</li>
<li>Go to the following Web site:
<br><b>http://www.benefitscheckup.org/link/101/0</b></li>
<li>Once there, enter the zip code in the "Enter Printed Questionnaire Information" box in the bottom right hand corner and click "Go!"</li>
<li>Type in the answers to the questions from your printed copy and click on "View Results."</li></ol><br />
<cfelseif session.partner_id eq 101 and session.subset_id eq 27>
Welcome to the BenefitsCheckUp Printed Questionnaire!  To learn about benefits you might be eligible for, please take the following steps:
<ol>
<li>Print and fill out this questionnaire.</li>
<li>Go to the following Web site:
<br><b>http://www.benefitscheckup.org/link/101/27</b></li>
<li>Once there, enter the zip code in the "Enter Printed Questionnaire Information" box in the bottom right hand corner and click "Go!"</li>
<li>Type in the answers to the questions from your printed copy and click on "View Results."</li></ol><br />
<cfelse>
	<cf_displayText group="site" code="site_printed_qaire_intro"><br />
</cfif>

<cf_buildQuestionnaire width="#partner_width#">

<cfif IsNumeric(session.org_id) and session.org_id gt 0>
	<br />
	<p align="center">
		<i><cf_displayText group="site" code="site_oe_printed_qaire_thanks"></i><br /><br />
		<b><cf_displayText group="site" code="site_oe_printed_qaire_return"></b><br /><br />
		<cf_displayOrganizationAddress>
	</p>
</cfif>

</cf_buildHTML>
