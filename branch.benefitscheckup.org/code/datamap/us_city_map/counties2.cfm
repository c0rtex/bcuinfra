<cfsilent>

<cfquery name="counties" datasource="#application.dbSrc#">
	SELECT *
	FROM county
	WHERE state_id = '#state#'
	AND map_id > 0
	ORDER BY map_id
</cfquery>

</cfsilent><map>  
<cfoutput query="counties">
<county>
 <id>#map_id#</id>
 <name>#county_name#</name>
 <URL></URL>
 <popup></popup>
 <color1>012056</color1>
 <color2>366CA3</color2>
 <image></image>
</county>
</cfoutput>
</map>