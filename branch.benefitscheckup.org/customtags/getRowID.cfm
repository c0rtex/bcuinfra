<cfparam name="attributes.table" type="string">
<cfparam name="attributes.value" type="string">
<cfparam name="attributes.var" type="string" default="">
<cfparam name="attributes.datasource" type="string" default="">

<cf_tableLoad table="#attributes.table#">
<cfif attributes.var eq ''>
	<cfset attributes.var = keys>
</cfif>
<cfif attributes.datasource eq ''>
	<cfset attributes.datasource = application.dbSrc>
</cfif>

<cfset idHash=StructNew()>
<cfloop list="#columns#" index="column">
	<cfset colname=ListGetAt(column, 1, '|')>
	<cfset "idHash.#colname#"=StructNew()>
	<cfset "idHash.#colname#.type"=ListGetAt(column, 3, '|')>
	<cfset "idHash.#colname#.req"=ListGetAt(column, 4, '|')>
</cfloop>
<cf_buildSQLTerm value="#attributes.value#" type="#Evaluate("idHash.#unique#.type")#" required="#Evaluate("idHash.#unique#.req")#" comparison="true">

<cfset qry="select #keys# from `#attributes.table#` where #unique##term#">
<cfquery name="id" datasource="#attributes.datasource#">
	#PreserveSingleQuotes(qry)#
</cfquery>

<cfif id.RecordCount eq 1>
	<cfset "caller.#attributes.var#" = Evaluate("id.#keys#")>
<cfelse>
	<cfset "caller.#attributes.var#" = ''>
</cfif>