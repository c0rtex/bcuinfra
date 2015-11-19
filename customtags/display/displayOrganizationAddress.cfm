<cfsilent>
<cfparam name="attributes.org_id" type="numeric" default="0">
<cfparam name="attributes.var" type="string" default="">

<cfif attributes.org_id eq 0>
	<cfset attributes.org_id = session.org_id>
</cfif>

<cfset outstr = ''>
<cfif IsNumeric(attributes.org_id) and attributes.org_id gt 0>
	<cf_cacheOrganizationPool action="get" org_id="#attributes.org_id#" var="org">
	<cfif org.name neq ''>
		<cfif outstr neq ''>
			<cfset outstr = outstr & "<br />">
		</cfif>
		<cfset outstr = outstr & "#org.name#">
	</cfif>
	<cfif org.address1 neq ''>
		<cfif outstr neq ''>
			<cfset outstr = outstr & "<br />">
		</cfif>
		<cfset outstr = outstr & "#org.address1#">
	</cfif>
	<cfif org.address2 neq ''>
		<cfif outstr neq ''>
			<cfset outstr = outstr & "<br />">
		</cfif>
		<cfset outstr = outstr & "#org.address2#">
	</cfif>
	<cfif org.city neq '' and org.state neq '' and org.zip neq ''>
		<cfif outstr neq ''>
			<cfset outstr = outstr & "<br />">
		</cfif>
		<cfset outstr = outstr & "#org.city#, #org.state# #org.zip#">
	</cfif>
</cfif>

</cfsilent><cfif attributes.var eq ''><cfsilent>
	</cfsilent><cfoutput>#outstr#</cfoutput><cfsilent>
</cfsilent><cfelse><cfsilent>
	<cfset "caller.#attributes.var#" = outstr>
</cfsilent></cfif>