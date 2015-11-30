<cfparam name="org_id" default="">
<cfparam name="session.subset_id" default="">
<cfparam name="session.partner_id" default="">
<cfparam name="session.source_id" default="">
<cfparam name="subset_id" default="#session.subset_id#">
<cfparam name="partner_id" default="#session.partner_id#">
<cfparam name="source_id" default="#session.source_id#">
<cfif val(org_id) IS 0 OR val(org_id) IS 0 OR subset_id IS 41>
		
	<cfif partner_id IS 12>
		<cfif source_id IS 1>
			<cfinclude template="/#approot#/wrappers/bcu.cfm">
		<cfelse>
			<cfinclude template="/#approot#/wrappers/#partnerQuery.wrapper_template#">
		</cfif>
	<cfelse>

		<cfif val(partner_id) IS 19 OR val(partner_id) IS 11 OR val(partner_id) IS 16>
			<cfinclude template="/#approot#/wrappers/bcu.cfm">
		<cfelse>
			<cfinclude template="/#approot#/wrappers/#partnerQuery.wrapper_template#">
		</cfif>
	</cfif>

<cfelse>
	<cfif partner_id IS 1>
			<cfinclude template="/#approot#/wrappers/bcu.cfm">
	<cfelse>
		<cfinclude template="/#approot#/wrappers/#partnerQuery.wrapper_template#">
	</cfif>
</cfif>


