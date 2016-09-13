<cfquery name="missing" datasource="#application.dbSrc#">
	SELECT * 
	FROM county
	WHERE map_id = '' OR map_id IS NULL
	AND state_id NOT IN ('as', 'fm', 'gu', 'mh', 'mp', 'pr', 'pw', 'vi')
	ORDER BY state_id, county_name
</cfquery>

<cfoutput query="missing" group="state_id">
<h1>#state_id#</h1>
<cfoutput>
 #county_name#<br />
</cfoutput>
<hr />
</cfoutput>