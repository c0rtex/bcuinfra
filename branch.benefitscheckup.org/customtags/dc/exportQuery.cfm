<cfsilent>
<cfparam name="attributes.query" type="string" default="">
<cfparam name="attributes.table" type="string" default="">
<cfparam name="attributes.preloadkey" type="any" default="">
<cfparam name="attributes.preload" type="string" default="">
<cfparam name="attributes.format" type="string" default="html">
<cfparam name="attributes.datasource" type="string" default="#application.dbSrc#">
<cfparam name="attributes.columnList" type="string" default="">

<cfset preloadName = StructNew()>

<cfloop list="#attributes.preload#" index="pre" delimiters="^">
	<cfset eqname = ListGetAt(pre, 1, '|')>
	<cfset eqquery = ListGetAt(pre, 2, '|')>
	<cfset eqvalue = ListGetAt(pre, 3, '|')>
	<cfset "preloadName.#eqname#" = 1>
	<cfquery name="loader" datasource="#attributes.datasource#">
		#PreserveSingleQuotes(eqquery)#
	</cfquery>
	<cfset "#eqname#Struct" = StructNew()>
	<cfloop query="loader">
		<cfset k = Evaluate(attributes.preloadkey)>
		<cfset v = Evaluate(eqvalue)>
		<cfif StructKeyExists(Evaluate("#eqname#Struct"), k)>
			<cfset StructUpdate(Evaluate("#eqname#Struct"), k, StructFind(Evaluate("#eqname#Struct"), k) & ', ' & v)>
		<cfelse>
			<cfset StructInsert(Evaluate("#eqname#Struct"), k, v)>
		</cfif>
	</cfloop>
</cfloop>

</cfsilent><cfif attributes.query neq '' or attributes.table neq ''><cfsilent>
	<cfif attributes.query eq ''>
		<cfset attributes.query = "select * from #attributes.table#">
	</cfif>
	<cfquery name="query" datasource="#attributes.datasource#">
		#PreserveSingleQuotes(attributes.query)#
	</cfquery>
	<cfif attributes.columnList eq ''>
		<cfset attributes.columnList = LCase(query.ColumnList)>
	</cfif>

	</cfsilent><cfswitch expression="#attributes.format#">
		<cfcase value="html"><cfcontent type="text/html"><cfsilent>
</cfsilent><cfoutput><table border="1">
	<tr><cfloop list="#attributes.columnList#" index="x">
		<td valign="bottom" align="left"><strong>#x#</strong></td></cfloop>
	</tr><cfloop query="query">
	<tr><cfloop list="#attributes.columnList#" index="x">
		<td valign="top" align="left"><cfif StructKeyExists(preloadName, x)><cfset k = Evaluate(attributes.preloadkey)><cfif StructKeyExists(Evaluate("#x#Struct"), k)>#StructFind(Evaluate("#x#Struct"), k)#</cfif><cfelse>#Evaluate(x)#</cfif></td></cfloop>
	</tr></cfloop>
</table></cfoutput><cfsilent>
		</cfsilent></cfcase>
		<cfcase value="csv"><cfcontent type="text/csv"><cfsilent>
</cfsilent><cfoutput>#attributes.columnList#<cfloop query="query"><cfset row = ''><cfloop list="#attributes.columnList#" index="x"><cfif StructKeyExists(preloadName, x)><cfset k = Evaluate(attributes.preloadkey)><cfif StructKeyExists(Evaluate("#x#Struct"), k)><cfset w = StructFind(Evaluate("#x#Struct"), k)><cfelse><cfset w = ''></cfif><cfelse><cfset w = Evaluate(x)></cfif><cfset row = ListAppend(row, """#Replace(w, '"', '""', 'ALL')#""")></cfloop>#Chr(13)##Chr(10)##row#</cfloop>
</cfoutput><cfsilent>
		</cfsilent></cfcase>
	</cfswitch><cfsilent>

</cfsilent></cfif>