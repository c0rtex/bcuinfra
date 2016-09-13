<cfsilent>

<cfquery name="counties" datasource="#application.dbSrc#">
	SELECT *
	FROM county
	WHERE state_id = '#state#'
	AND map_id > 0
	ORDER BY map_id
</cfquery>

</cfsilent><cfcontent type="text/xml"><map>  
<cfoutput query="counties">
<county>
 <id>#map_id#</id>
 <name>#county_name#</name>
 <URL>javascript:showOffices("liheap_locator_county.cfm?county_id=#county_id#&program_id=150");</URL>
 <popup></popup>
 <cfif SESSION.partner_id EQ 0 OR SESSION.partner_id EQ 77>
  <color1>DAA869</color1>
  <color2>8a6b44</color2>
 <cfelse>	
   <color1>0098BA</color1>
   <color2>366CA3</color2>
 </cfif>
 <image></image>
</county>
</cfoutput>
</map>