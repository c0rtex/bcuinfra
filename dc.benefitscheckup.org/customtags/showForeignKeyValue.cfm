<cfparam name="attributes.table" type="string">
<cfparam name="attributes.value" type="string" default="">
<cfparam name="attributes.link" type="string" default="">
<cfparam name="attributes.hidden" type="string" default="">
<cfparam name="attributes.valueonadd" type="string" default="">
<cf_tableLoad table="#attributes.table#">
<cfset thisHash = StructNew()>
<cfloop list="#columns#" index="thisCol">
	<cfset colname=ListGetAt(thisCol, 1, '|')>
	<cfset "thisHash.#colname#"=StructNew()>
	<cfset "thisHash.#colname#.type"=ListGetAt(thisCol, 3, '|')>
	<cfset "thisHash.#colname#.req"=ListGetAt(thisCol, 4, '|')>
</cfloop>
<cfoutput>
<cfif attributes.value eq '' and attributes.valueonadd eq ''>
	<i>none</i>
<cfelse>
	<cfif attributes.valueonadd neq ''>
		<cfset thisvalue = attributes.valueonadd>
	<cfelse>
		<cfset thisvalue = attributes.value>
	</cfif>
	<cfset whereAccum = ''>
	<cfloop list="#keys#" index="thisKey">
		<cfif whereAccum eq ''>
			<cfset whereAccum = ' where '>
		<cfelse>
			<cfset whereAccum = whereAccum & ' and '>
		</cfif>
		<cf_buildSQLTerm value="#thisvalue#" type="#Evaluate("thisHash.#thisKey#.type")#" required="#Evaluate("thisHash.#thisKey#.req")#" comparison="true">
		<cfset whereAccum = whereAccum & "#thisKey##term#">
	</cfloop>
	<cfset keyQuery = "select #name# from `#attributes.table#` #whereAccum#">
	<cfquery name="getkeyvalue" datasource="#application.dbSrc#">
		#PreserveSingleQuotes(keyQuery)#
	</cfquery>
	<cfif getkeyvalue.RecordCount eq 0><i>none</i><cfelse><cfset result = Evaluate("getkeyvalue.#name#")><cfif attributes.link eq ''>#result#<cfelse><cfset attributes.link = Replace(attributes.link, '[[result]]', result, 'ALL')><cfset attributes.link = Replace(attributes.link, '[[id]]', thisvalue, 'ALL')><a href="#attributes.link#">#result#</a></cfif></cfif>
	<cfif attributes.hidden neq ''><input type="hidden" name="#attributes.hidden#" value="#thisvalue#"></cfif>
</cfif>
</cfoutput>