<cfsilent>

<cfquery name="counties" datasource="#application.dbSrc#">
	SELECT *
	FROM county
	WHERE state_id = '#state#'
	ORDER BY county_name
</cfquery>

</cfsilent><cfcontent type="text/xml"><map>  
<cfoutput query="counties">
<county>
 <id>#map_id#</id>
 <name>#county_name#</name>
 <URL>javascript:showOffices("locator_county.cfm?county_id=#county_id#&program_id=579");</URL>
 <popup></popup>
 <color1>0098BA</color1>
 <color2>366CA3</color2>
 <image></image>
</county>
</cfoutput>
</map>