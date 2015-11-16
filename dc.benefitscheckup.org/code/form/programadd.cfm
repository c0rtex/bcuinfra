<cfquery name="findprogramsort" datasource="#application.dbSrc#">
	SELECT max(sort) maxsort
	FROM program_form
	WHERE program_id=#program_id#
</cfquery>
<cfif findprogramsort.RecordCount eq 0 Or findprogramsort.maxsort eq ''>
	<cfset sort=1>
<cfelse>
	<cfset sort = findprogramsort.maxsort + 1>
</cfif>
<cfinclude template="programinsert.cfm">