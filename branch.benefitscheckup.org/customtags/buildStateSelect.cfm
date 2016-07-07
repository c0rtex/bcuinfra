<cfsilent>
<cfparam name="attributes.name" type="string">
<cfparam name="attributes.required" type="boolean" default="false">
<cfparam name="attributes.showID" type="boolean" default="true">
<cfparam name="attributes.showName" type="boolean" default="true">
<cfparam name="attributes.includeTerritories" type="boolean" default="false">
<cfparam name="attributes.sortByType" type="boolean" default="true">
<cfparam name="attributes.default" type="string" default="">
<cfparam name="attributes.style" type="string" default="font-family: verdana, arial, helvetica, sans-serif; font-size: 9pt; color: black;">

<!--- you can't set both showID and showName to false or nothing will display
      in the dropdown rows, so if both are false then we set showID to true --->
<cfif not (attributes.showID or attributes.showName)>
	<cfset attributes.showID = true>
</cfif>

<cfif attributes.style neq ''>
	<cfset attributes.style = " style=""#attributes.style#""">
</cfif>

<cfquery name="states" datasource="#application.dbSrc#">
	SELECT state_id, state_name
	FROM state
	WHERE (statetype_id<cfif attributes.includeTerritories> in (1, 2)<cfelseif isdefined('subset_id') and subset_id eq 59>=1 or state_id eq 'VI'<cfelse>=1</cfif>)
	ORDER BY <cfif attributes.sortByType>statetype_id, </cfif><cfif attributes.showID>state_id<cfelse>state_name</cfif>
</cfquery>

</cfsilent><cfoutput><select name="#attributes.name#" style="">
	<cfif not attributes.required><option value=""></option></cfif>
	<cfloop query="states">
		<option value="#state_id#"<cfif attributes.default eq state_id> selected</cfif>><cfif attributes.showID>#state_id#</cfif><cfif attributes.showID and attributes.showName> - </cfif><cfif attributes.showName>#state_name#</cfif></option>
	</cfloop>
</select></cfoutput>