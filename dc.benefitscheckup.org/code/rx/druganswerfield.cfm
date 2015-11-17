<cfset truncated = LCase(Left(REReplace(name, '[^A-Za-z]', '', 'ALL'), 4))>
<cfset iter = 0>
<cfset taken = true>

<cfloop condition="taken">
	<cfset iter = iter + 1>
	<cfset answerfield = "dn_" & truncated & iter>
	<cfoutput>#answerfield#</cfoutput><br>
	<cfquery name="ansmatch" datasource="#application.dbSrc#">
		select answerfield_id as RecID
		from answerfield
		where lower(answerfield) = lower('#answerfield#')
	</cfquery>
	<cfif ansmatch.RecordCount eq 0>
		<cfset taken="false">
	</cfif>
</cfloop>