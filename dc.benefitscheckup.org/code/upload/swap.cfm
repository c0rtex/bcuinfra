<cfparam name="table" type="string" default="">
<cfparam name="key1" type="any" default="">
<cfparam name="key2" type="any" default="">

<cfif table neq ''>

<cf_tableLoad table="#table#">

<cfset colhash=StructNew()>
<cfset colhash.table=table>
<cfset colhash.keys=keys>
<cfset colhash.nonkeys=''>
<cfset colhash.columns=StructNew()>
<cfloop list="#columns#" index="column">
	<cfset colname=ListGetAt(column, 1, '|')>
	<cfset "colhash.columns.#colname#"=StructNew()>
	<cfset "colhash.columns.#colname#.type"=ListGetAt(column, 3, '|')>
	<cfset "colhash.columns.#colname#.req"=ListGetAt(column, 4, '|')>
	<cfif ListFind(colhash.keys, colname)>
		<cfset "colhash.columns.#colname#.id"=1>
	<cfelse>
		<cfset "colhash.columns.#colname#.id"=0>
		<cfset colhash.nonkeys=ListAppend(colhash.nonkeys, colname)>
	</cfif>
</cfloop>
<cfset rangeKey = ListGetAt(keys, 1)>



<cfset localTable=colhash.table>
<cfset keyList=ListChangeDelims(colhash.keys, ', ')>
<cfif colhash.nonkeys eq ''>
	<cfset columnList = keyList>
<cfelse>
	<cfset columnList = ListChangeDelims(ListAppend(colhash.keys, colhash.nonkeys), ', ')>
</cfif>

</cfif>


<html>
<head>
	<title>Swap Table <cfoutput>#table#</cfoutput> Rows</title>
</head>

<body><cfoutput>


<form action="swap.cfm" method="post">
	Table:  <input type="text" name="table" value="#table#"><br>
	Key 1:  <input type="text" name="key1" value="#key1#"><br>
	Key 2:  <input type="text" name="key2" value="#key2#"><br>
	<br>
	<input type="submit"><br>
</form>

<cfif table neq ''>

<h1>#table#</h1>
<h2>#columnList#</h2>
<h3>#keyList#</h3>

<cf_buildSQLTerm value="#key1#" type="#Evaluate("colhash.columns.#keyList#.type")#" required="#Evaluate("colhash.columns.#keyList#.req")#" comparison="True" var="term1">
<cfset selectQuery1 = "select #columnList# from `#localTable#` where #keyList##term1#">
<cfset deleteQuery1 = "delete from `#localTable#` where #keyList##term1#">
<cfquery name="row1" datasource="#application.dbSrc#">
	#PreserveSingleQuotes(selectQuery1)#
</cfquery>
<cf_buildSQLTerm value="#key2#" type="#Evaluate("colhash.columns.#keyList#.type")#" required="#Evaluate("colhash.columns.#keyList#.req")#" comparison="True" var="term2">
<cfset selectQuery2 = "select #columnList# from `#localTable#` where #keyList##term2#">
<cfset deleteQuery2 = "delete from `#localTable#` where #keyList##term2#">
<cfquery name="row2" datasource="#application.dbSrc#">
	#PreserveSingleQuotes(selectQuery2)#
</cfquery>

#selectQuery1#<br><br>
#selectQuery2#<br><br>
#deleteQuery1#<br><br>
#deleteQuery2#<br><br>

	<cfquery name="delQuery1" datasource="#application.dbSrc#">
		#PreserveSingleQuotes(deleteQuery1)#
	</cfquery>
	<cfquery name="delQuery2" datasource="#application.dbSrc#">
		#PreserveSingleQuotes(deleteQuery2)#
	</cfquery>



<cfset insertQuery1=''>
<cfset insertQuery2=''>

<cfset insertQuery1=insertQuery1 & "/*SET IDENTITY_INSERT `#localTable#` ON*/">
<cfset insertQuery1=insertQuery1 & "INSERT INTO `#colhash.table#` (#columnList#) VALUES (">
<cf_buildSQLTerm value="#Evaluate("row1.#keyList#")#" type="#Evaluate("colhash.columns.#keyList#.type")#" required="#Evaluate("colhash.columns.#keyList#.req")#">
<cfset insertQuery1=insertQuery1 & term>
<cfloop list="#colhash.nonkeys#" index="m">
	<cf_buildSQLTerm value="#Evaluate("row2.#m#")#" type="#Evaluate("colhash.columns.#m#.type")#" required="#Evaluate("colhash.columns.#m#.req")#">
	<cfset insertQuery1=insertQuery1 & ', ' & term>
</cfloop>
<cfset insertQuery1=insertQuery1 & ")
/*SET IDENTITY_INSERT [#localTable#] OFF*/">

<cfif insertQuery1 neq ''>
	#HTMLEditFormat(insertQuery1)#<br><br>
	<cfquery name="transferQuery1" datasource="#application.dbSrc#">
		#PreserveSingleQuotes(insertQuery1)#
	</cfquery>
</cfif>


<cfset insertQuery2=insertQuery2 & "/*SET IDENTITY_INSERT #localTable#] ON*/">
<cfset insertQuery2=insertQuery2 & "INSERT INTO `#colhash.table#` (#columnList#) VALUES (">
<cf_buildSQLTerm value="#Evaluate("row2.#keyList#")#" type="#Evaluate("colhash.columns.#keyList#.type")#" required="#Evaluate("colhash.columns.#keyList#.req")#">
<cfset insertQuery2=insertQuery2 & term>
<cfloop list="#colhash.nonkeys#" index="m">
	<cf_buildSQLTerm value="#Evaluate("row1.#m#")#" type="#Evaluate("colhash.columns.#m#.type")#" required="#Evaluate("colhash.columns.#m#.req")#">
	<cfset insertQuery2=insertQuery2 & ', ' & term>
</cfloop>
<cfset insertQuery2=insertQuery2 & ")
/*SET IDENTITY_INSERT [#localTable#] OFF*/">

<cfif insertQuery2 neq ''>
	#HTMLEditFormat(insertQuery2)#<br><br>
	<cfquery name="transferQuery2" datasource="#application.dbSrc#">
		#PreserveSingleQuotes(insertQuery2)#
	</cfquery>
</cfif>


</cfif>
</cfoutput></body> 
</html>