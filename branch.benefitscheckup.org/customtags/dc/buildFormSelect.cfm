<cfsilent>
<cfparam name="attributes.table" type="string">
<cfparam name="attributes.name" type="string">
<cfparam name="attributes.required" type="boolean" default="false">
<cfparam name="attributes.nullrow" type="boolean" default="true">
<cfparam name="attributes.nullvalue" type="any" default="">
<cfparam name="attributes.nulltext" type="string" default="none">
<cfparam name="attributes.condition" type="string" default="">
<cfparam name="attributes.order" type="string" default="">
<cfparam name="attributes.selected" type="string" default="">
<cfparam name="attributes.multiple" type="boolean" default="false">
<cfparam name="attributes.self" type="string" default="">
<cfparam name="attributes.rows" type="numeric" default="6">
<cfparam name="attributes.chop" type="numeric" default="80">

<cf_tableLoad table="#attributes.table#">
<cfset namex=name>
<cfif attributes.order eq ''>
	<cfset attributes.order = name>
</cfif>

<cfset tablecolumn = ''>
<cfif attributes.self eq ''>
	<cfset attributes.self = false>
<cfelseif attributes.self neq 'true'>
	<cfset tablecolumn = attributes.self>
	<cfset attributes.self = true>
</cfif>

<cfif attributes.self>
	<cfif tablecolumn eq ''>
		<cfset tablecolumn = attributes.name>
	</cfif>
	<cfquery name="getselect" datasource="#application.dbSrc#">
		select #tablecolumn# as #keys#, #tablecolumn#
		from `#attributes.table#` <cfif attributes.condition neq ''>
		where #PreserveSingleQuotes(attributes.condition)#</cfif>
		group by #tablecolumn#
		order by #tablecolumn#
	</cfquery>
<cfelse>
	<cfquery name="getselect" datasource="#application.dbSrc#">
		select #keys#, #namex#
		from `#attributes.table#` <cfif attributes.condition neq ''>
		where #PreserveSingleQuotes(attributes.condition)#</cfif>
		order by #attributes.order#
	</cfquery>
</cfif>
<cfif attributes.multiple>
	<cfif getselect.RecordCount lt 2>
		<cfset attributes.rows = 1>
	<cfelseif getselect.RecordCount lt attributes.rows>
		<cfset attributes.rows = getselect.RecordCount>
	</cfif>
</cfif>

</cfsilent><cfoutput><select name="#attributes.name#"<cfif attributes.multiple> multiple size="#attributes.rows#"</cfif>>
<cfif not attributes.multiple and not attributes.self and attributes.nullrow>
<option value="#attributes.nullvalue#"><cfif attributes.required>-- select one --<cfelse>-- #attributes.nulltext# --</cfif></option>
<cfelseif attributes.multiple and not attributes.required and not attributes.self and attributes.nullrow>
<option value="NULL">[none]</option>
</cfif>
<cfloop query="getselect">
<cf_stripTags text="#Evaluate("#namex#")#" var="outputName">
<cfif attributes.chop gt 0>
	<cfset outputName = Left(outputName, attributes.chop)>
</cfif>
<option value="#Evaluate("#keys#")#"<cfif Evaluate("#keys#") eq attributes.selected> selected</cfif>>#outputName#</option>
</cfloop>
</select></cfoutput>