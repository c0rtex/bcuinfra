<!--- Set Data layer tracking params --->
<cfset script_partner_id = 0>
<cfset script_partner_name = ''>
<cfset script_subset_id = 0>
<cfset script_state_id = ''>
<cfif isdefined('session.partner_id') and session.partner_id neq ''>
	<cfset script_partner_id = session.partner_id>
<cfelseif isdefined('form.partner_id') and form.partner_id neq ''>
	<cfset script_partner_id = form.partner_id>
<cfelseif isdefined('url.partner_id') and url.partner_id neq ''>
	<cfset script_partner_id = url.partner_id>
</cfif>
<cfif isdefined('session.subset_id') and session.subset_id neq ''>
	<cfset script_subset_id = session.subset_id>
<cfelseif isdefined('form.subset_id') and form.subset_id neq ''>
	<cfset script_subset_id = form.subset_id>
<cfelseif isdefined('url.subset_id') and url.subset_id neq ''>
	<cfset script_subset_id = url.subset_id>
</cfif>
<cfif isdefined('session.state_id') and session.state_id neq ''>
	<cfset script_state_id = session.state_id>
<cfelseif isdefined('form.state_id') and form.state_id neq ''>
	<cfset script_state_id = form.state_id>
<cfelseif isdefined('url.state_id') and url.state_id neq ''>
	<cfset script_state_id = url.state_id>
<cfelseif isdefined('form.state') and form.state neq ''>
	<cfset script_state_id = form.state>
<cfelseif isdefined('url.state') and url.state neq ''>
	<cfset script_state_id = url.state>
</cfif>
<cfif isdefined('session.zip')>
<cfinvoke  component="util" method="getStateDetails" returnVariable="statequery">
                        <cfinvokeargument name="state_zip" value="#session.zip#"/>
                </cfinvoke>
<cfset script_state_id = statequery.state_name>
</cfif>
<cfif script_partner_id gt 0>
<cfset script_partner_name = wrapper.partner_name>
</cfif>
<cfoutput>
<script>
dataLayer = [{
        'partner_id': '#script_partner_id#',
        'partner_name': '#script_partner_name#',
        'subset_id': '#script_subset_id#',
        'state': '#script_state_id#',       
}];
</script>
</cfoutput>