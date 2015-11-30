<cfsilent>
<cfparam name="attributes.mode" type="string" default="screen">
<cfparam name="attributes.entrypointgroup_id" type="numeric">
<cfparam name="attributes.program_id" type="numeric" default="0">
<cfparam name="attributes.state_id" type="string" default="">
<cfparam name="attributes.var" type="string" default="">
<cfparam name="attributes.append" type="boolean" default="false">

<cfset outstr = ''>
<cfset isPrintMode = Evaluate("attributes.mode eq 'print'")>

<cfif not isPrintMode>

	<cfquery name="epcount" datasource="#application.dbSrc#"> 
		select count(*) c
		from entrypoint_entrypointgroup eg, entrypoint e
		where eg.entrypointgroup_id=<cfqueryparam cfsqltype="cf_sql_numeric" value="#attributes.entrypointgroup_id#" maxlength="6">
			and eg.entrypoint_id=e.entrypoint_id
		and (e.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.state_id#" maxlength="2">
			or (e.state_id is null
				and e.zipcode in (select zipcode from zip where state_id='#attributes.state_id#')
			)
		)
	</cfquery>
	
	<cf_displayText group="site" code="site_ep_all_linktext" param1="#epcount.c#" param2="group_id=#attributes.entrypointgroup_id#,program_id=#attributes.program_id#" param3="#attributes.state_id#" var="linkstr">
	
	<cfset linkstr = ReReplaceNoCase(linkstr, "<a", "<a class='offices_link' ", "ALL")>
	
	<cfset linkstr = ReReplaceNoCase(linkstr, "benefitscheckup.org/offices.cfm", "benefitscheckup.org/cf/offices.cfm", "ALL")>
	<cfset linkstr = ReReplaceNoCase(linkstr, "benefitscheckup%2Eorg%2Foffices%2Ecfm", "benefitscheckup%2Eorg%2Fcf%2Foffices%2Ecfm", "ALL")>
	
	<cfset outstr = outstr & "#linkstr#<br>">

</cfif>

</cfsilent><cfif attributes.var eq ''><cfsilent>
	</cfsilent><cfoutput>#outstr#</cfoutput><cfsilent>
</cfsilent><cfelseif attributes.append><cfsilent>
	<cfset "caller.#attributes.var#" = Evaluate("caller.#attributes.var#") & outstr>
</cfsilent><cfelse><cfsilent>
	<cfset "caller.#attributes.var#" = outstr>
</cfsilent></cfif>