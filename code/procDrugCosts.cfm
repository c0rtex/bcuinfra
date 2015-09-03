<cfparam name="shownumber" type="numeric" default="1">
<cfset session.shownumber = #shownumber#>
<cfloop list="#session.selectedDrugs#" index="thisdrug">
	<cfif IsDefined("form.rxcost_#thisdrug#")>
		<cfset "session.rxcost_#thisdrug#" = Evaluate("form.rxcost_#thisdrug#")>
	</cfif>
</cfloop>

<cfif session.subsetOptionalFlag eq 0>
	<cflocation url="frmOptionalQuestions.cfm?shownumber=#session.shownumber#" addtoken="Yes">
<cfelse>
	<cflocation url="proceligibility.cfm" addtoken="Yes">
</cfif>