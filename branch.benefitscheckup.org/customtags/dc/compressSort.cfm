<cfsilent>
<cfparam name="attributes.table" type="string">
<cfparam name="attributes.limitByColumn" type="string" default="">
<cfparam name="attributes.limitByValue" type="any" default="">
<cfparam name="attributes.keyColumn" type="string">
<cfparam name="attributes.sortColumn" type="string" default="sort">
<cfparam name="attributes.datasource" type="string" default="#application.dbSrc#">

<cfquery name="getSort" datasource="#attributes.datasource#">
	select #attributes.limitByColumn#, #attributes.keyColumn#, #attributes.sortColumn#
	from #attributes.table#
	where #attributes.limitByColumn#=#attributes.limitByValue#
	order by #attributes.sortColumn#
</cfquery>

<cfset newSortValue = 0>
<cfloop query="getSort">
	<cfset newSortValue = newSortValue + 1>
	<cfset saveKeyValue = Evaluate("#attributes.keyColumn#")>
	<cfset saveSortValue = Evaluate("#attributes.sortColumn#")>
	<cfif newSortValue neq saveSortValue>
		<cfquery name="getSort" datasource="#attributes.datasource#">
			update #attributes.table#
			set #attributes.sortColumn#=#newSortValue#
			where #attributes.limitByColumn#=#attributes.limitByValue#
				and #attributes.keyColumn#=#saveKeyValue#
		</cfquery>
		<cfoutput><h3>For key #saveKeyValue#, updated sort value to #newSortValue#</h3></cfoutput>
	</cfif>
</cfloop>
</cfsilent>