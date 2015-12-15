<cfsilent>
<cfparam name="attributes.answerfield_id" type="numeric">
<cfparam name="attributes.name" type="string">
<cfparam name="attributes.option_id" type="any" default="">
<cfparam name="attributes.nulltext" type="any" default="no default">

<cfquery name="getselect" datasource="#application.dbSrc#">
	select o.option_id, o.option_code
	from answerfield_option ao, `option` o
	where ao.answerfield_id=#attributes.answerfield_id#
			and ao.option_id=o.option_id
	order by ao.sort
</cfquery>

</cfsilent><cfoutput><select name="#attributes.name#">
<option value="">-- #attributes.nulltext# --</option>
<cfloop query="getselect">
<option value="#option_id#"<cfif attributes.option_id eq option_id> selected</cfif>>#option_code#</option>
</cfloop>
</select></cfoutput>