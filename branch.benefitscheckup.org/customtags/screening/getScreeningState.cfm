<cfsilent>
<cfparam name="attributes.screening_id" type="any">
<cfparam name="attributes.var" type="string" default="">

<cfset outStr = ''>
<cfif IsDefined("request.screeningState#attributes.screening_id#")>
	<cfset outStr = Evaluate("request.screeningState#attributes.screening_id#")>
<cfelseif IsNumeric(attributes.screening_id) and attributes.screening_id gt 0>
	<cfquery name="getState" datasource="#application.dbSrc#">
		select sa.response
		from answerfield a, screening_answerfield sa
		where a.answerfield='st'
			and a.answerfield_id=sa.answerfield_id
			and sa.screening_id=<cfqueryparam maxlength="10" cfsqltype="cf_sql_integer" value="#attributes.screening_id#">
	</cfquery>
	<cfif getState.RecordCount>
		<cfset outStr = getState.response>
	</cfif>
	<cfset "request.screeningState#attributes.screening_id#" = outStr>
</cfif>

</cfsilent><cfif attributes.var eq ''><cfsilent>
	</cfsilent><cfoutput>#outStr#</cfoutput><cfsilent>
</cfsilent><cfelse><cfsilent>
	</cfsilent><cfset "caller.#attributes.var#" = outStr><cfsilent>
</cfsilent></cfif>