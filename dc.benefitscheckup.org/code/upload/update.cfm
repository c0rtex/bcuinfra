<cfparam name="table" type="string">
<cfparam name="source" type="string" default="#application.dbSrcQA#">
<cfparam name="target" type="string" default="#application.dbSrc#">
<cfparam name="details" type="boolean" default="false">
<cfparam name="nonidentity" type="boolean" default="false">
<cfparam name="group" type="numeric" default="0">
<cfparam name="startID" type="any" default="">
<cfparam name="endID" type="any" default="">
<cfparam name="slicesize" type="numeric" default="10000">

<cf_tableLoad table="#table#">

<cfset colhash=StructNew()>
<cfset colhash.table=table>
<cfset colhash.keys=keys>
<cfif nonidentity>
	<cfset colhash.identity=false>
<cfelse>
	<cfset colhash.identity=identity>
</cfif>
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

<cfset whereClause = ''>
<cfset groupQS = ''>
<cfif group gt 0>
	<cfif colhash.table eq 'display'>
		<cfset whereClause = " where displaygroup_id=#group#">
	<cfelse>
		<cfset whereClause = " where display_id in (select display_id from display where displaygroup_id=#group#)">
	</cfif>
	<cfset groupQS = "&group=#group#">
</cfif>
<cfif startID neq '' and endID neq ''>
	<cf_buildSQLTerm var="loTerm" value="#startID#" type="#Evaluate("colhash.columns.#rangeKey#.type")#" required="1">
	<cf_buildSQLTerm var="hiTerm" value="#endID#" type="#Evaluate("colhash.columns.#rangeKey#.type")#" required="1">
	<cfif whereClause eq ''>
		<cfset whereClause = ' where '>
	<cfelse>
		<cfset whereClause = "#whereClause# and ">
	</cfif>
	<cfset whereClause = "#whereClause##rangeKey# >= #loTerm# and #rangeKey# <= #hiTerm#">
	<cfset rangeLimit = true>
<cfelse>
	<cfset rangeLimit = false>
</cfif>

<cfif view>
	<cfset viewFix = 'view_'>
<cfelse>
	<cfset viewFix = ''>
</cfif>


<cfset localTable=colhash.table>
<cfset keyList=ListChangeDelims(colhash.keys, ', ')>
<cfif colhash.nonkeys eq ''>
	<cfset columnList = keyList>
<cfelse>
	<cfset columnList = ListChangeDelims(ListAppend(colhash.keys, colhash.nonkeys), ', ')>
</cfif>
<!---
<cfoutput>
	localTable: #localTable#<br>
	keyList: #keyList#<br>
	columnList: #columnList#<br>
</cfoutput>
--->

<cfset countQuery = "select count(*) as c from `#viewFix##localTable#` #whereClause#">
<cfquery name="srcCountStart" datasource="#source#">
	#PreserveSingleQuotes(countQuery)#
</cfquery>
<cfset countQuery = "select count(*) as c from `#localTable#` #whereClause#">
<cfquery name="tgtCountStart" datasource="#target#">
	#PreserveSingleQuotes(countQuery)#
</cfquery>
<cfset srcStart = srcCountStart.c>
<cfset tgtStart = tgtCountStart.c>

<cfset selectQuery = "select #columnList# from `#viewFix##localTable#` #whereClause# order by #keyList#">
<cfquery name="srcData" datasource="#source#">
	#PreserveSingleQuotes(selectQuery)#
</cfquery>
<cfset selectQuery = "select #columnList# from `#localTable#` #whereClause# order by #keyList#">
<cfquery name="tgtData" datasource="#target#">
	#PreserveSingleQuotes(selectQuery)#
</cfquery>

<cfif not rangeLimit and (srcStart gt slicesize or tgtStart gt slicesize)>

	<cfset hash = StructNew()>
	<cfloop query="srcData">
		<cfset hashVal = Evaluate(rangeKey)>
		<cfif not StructKeyExists(hash, hashVal)>
			<cfset StructInsert(hash, hashVal, 1)>
		</cfif>
	</cfloop>
	<cfloop query="tgtData">
		<cfset hashVal = Evaluate(rangeKey)>
		<cfif not StructKeyExists(hash, hashVal)>
			<cfset StructInsert(hash, hashVal, 1)>
		</cfif>
	</cfloop>
	
	<cfset rawCount = srcStart + tgtStart>
	<cfset hashCount = StructCount(hash)>
	<cfset rawSlices = Ceiling(rawCount / slicesize)>
	<cfset hashSlice = Ceiling(hashCount / rawSlices)>
	<cfset redone = rawSlices * hashSlice>
	<cfif Evaluate("colhash.columns.#rangeKey#.type") eq 'n'>
		<cfset hashArray = ListToArray(ListSort(StructKeyList(hash), 'Numeric'))>
	<cfelse>
		<cfset hashArray = ListToArray(ListSort(StructKeyList(hash), 'Textnocase'))>
	</cfif>
	
<html>
<head>
	<title>Update Table <cfoutput>#localTable#</cfoutput> by Slice</title>
</head>

<body><cfoutput>

<h1>#table#</h1>
<h2>#columnList#</h2>
<h3>#keyList#</h3>
<cfif whereClause neq ''>
<h4>#whereClause#</h4>
</cfif>

	raw: #rawCount#<br>
	count: #hashCount#<br>
	slices: #rawSlices#<br>
	slice: #hashSlice#<br>
	redone: #redone#<br>
	<br>
	<table border="1" cellpadding="3" cellspacing="2">
	<tr>
		<td valign="bottom" align="center"><b>slice</b></td>
		<td valign="bottom" align="center"><b>loIndex</b></td>
		<td valign="bottom" align="center"><b>hiIndex</b></td>
		<td valign="bottom" align="center"><b>loVal</b></td>
		<td valign="bottom" align="center"><b>hiVal</b></td>
		<td valign="bottom" align="center" colspan="2"><b>action</b></td>
	</tr>
	<cfloop from="1" to="#rawSlices#" index="x">
		<cfset startNo = (hashSlice * (x - 1)) + 1>
		<cfset endNo = hashSlice * x>
		<cfif endNo gt hashCount>
			<cfset endNo = hashCount>
		</cfif>
		<tr>
			<td valign="top" align="right">#x#</td>
			<td valign="top" align="right">#startNo#</td>
			<td valign="top" align="right">#endNo#</td>
		<cfif Evaluate("colhash.columns.#rangeKey#.type") eq 'n'>
			<td valign="top" align="right">#hashArray[startNo]#</td>
			<td valign="top" align="right">#hashArray[endNo]#</td>
		<cfelse>
			<td valign="top" align="left">'#hashArray[startNo]#'</td>
			<td valign="top" align="left">'#hashArray[endNo]#'</td>
		</cfif>
			<td valign="top" align="center"><a href="update.cfm?table=#table#&source=#source#&target=#target#&details=#details##groupQS#&startID=#hashArray[startNo]#&endID=#hashArray[endNo]#" target="_blank">#table#</a></td>
			<td valign="bottom" align="center"><font size="-2"><i><a href="update.cfm?table=#table#&source=#source#&target=#target#&details=#details##groupQS#&startID=#hashArray[startNo]#&endID=#hashArray[endNo]#&nonidentity=true" target="_blank">non-identity</a></i></font></td>
		</tr>
	</cfloop>
	</table>

</cfoutput></body>
</html>	

<cfelse>

<cfset comp=StructNew()>
<cfset srcArr=ArrayNew(2)>
<cfset srcx=0>
<cfset tgtArr=ArrayNew(2)>
<cfset tgtx=0>
<cfset excised=0>
<cfloop query="srcData">
	<cfset qkey=''>
	<cfloop list="#colhash.keys#" index="j">
		<cfif Evaluate("colhash.columns.#j#.type") eq 'n'>
			<cfset qkey=ListAppend(qkey, NumberFormat(Evaluate(j), '000000000000'), '|')>
		<cfelse>
			<cfset qkey=ListAppend(qkey, Evaluate(j), '|')>
		</cfif>
	</cfloop>
	<cfset StructInsert(comp, qkey, 1)>
	<cfset srcx=srcx + 1>
	<cfset srcy=0>
	<cfloop list="#ListAppend(colhash.keys, colhash.nonkeys)#" index="j">
		<cfset srcy=srcy + 1>
		<cfset srcArr[srcx][srcy] = Evaluate(j)>
	</cfloop>
</cfloop>
<cfloop query="tgtData">
	<cfset qkey=''>
	<cfloop list="#colhash.keys#" index="j">
		<cfif Evaluate("colhash.columns.#j#.type") eq 'n'>
			<cfset qkey=ListAppend(qkey, NumberFormat(Evaluate(j), '000000000000'), '|')>
		<cfelse>
			<cfset qkey=ListAppend(qkey, Evaluate(j), '|')>
		</cfif>
	</cfloop>
	<cfset collision = false>
	<cfif StructKeyExists(comp, qkey)>
		<cfset StructUpdate(comp, qkey, StructFind(comp, qkey) + 2)>
		<cfif StructFind(comp, qkey) gt 3>
			<cfset collision = true>
		</cfif>
	<cfelse>
		<cfset StructInsert(comp, qkey, 2)>
	</cfif>
	<cfif collision>
		<cfset qry = "DELETE FROM `#localTable#` WHERE ">
		<cfset loops = 0>
		<cfloop list="#colhash.keys#" index="m">
			<cfif loops>
				<cfset qry = qry & ' AND '>
			</cfif>
			<cf_buildSQLTerm value="#Evaluate(m)#" type="#Evaluate("colhash.columns.#m#.type")#" required="#Evaluate("colhash.columns.#m#.req")#">
			<cfset qry = qry & "#m#=#term#">
			<cfset loops = loops + 1>
		</cfloop>
		<cfset excised = excised + 1>
		<cfquery name="excision" datasource="#target#">
			#PreserveSingleQuotes(qry)#
		</cfquery>
		<!---
		<cfoutput>
		selectQuery: #selectQuery#<br>
		qkey: #qkey#<br>
		StructFind(comp, qkey): #StructFind(comp, qkey)#<br>
		qry: #HTMLEditFormat(qry)#<br>
		</cfoutput>
		--->
		<cfset qry = ''>
		<cfif colhash.identity>
			<cfset qry = qry & "/*SET IDENTITY_INSERT `#localTable#` ON*/">
		</cfif>
		<cfset qry = qry & "INSERT INTO `#localTable#` (#ListChangeDelims(ListAppend(colhash.keys, colhash.nonkeys), ', ')#) VALUES (">
		<cfset loops = 0>
		<cfloop list="#ListAppend(colhash.keys, colhash.nonkeys)#" index="m">
			<cfif loops>
				<cfset qry = qry & ', '>
			</cfif>
			<cf_buildSQLTerm value="#Evaluate(m)#" type="#Evaluate("colhash.columns.#m#.type")#" required="#Evaluate("colhash.columns.#m#.req")#">
			<cfset qry = qry & term>
			<cfset loops = loops + 1>
		</cfloop>
		<cfset qry = qry & ')'>
		<cfif colhash.identity>
			<cfset qry = qry & "/*SET IDENTITY_INSERT [#localTable#] OFF*/">
		</cfif>
		<cfquery name="reinsertion" datasource="#target#">
			#PreserveSingleQuotes(qry)#
		</cfquery>
		<!---
		<cfoutput>
		qry: #HTMLEditFormat(qry)#<br>
		</cfoutput>
		--->
		<cfset StructUpdate(comp, qkey, StructFind(comp, qkey) - 2)>
		<cfset tgtx=tgtx - 1>
	</cfif>
	<cfset tgtx=tgtx + 1>
	<cfset tgty=0>
	<cfloop list="#ListAppend(colhash.keys, colhash.nonkeys)#" index="j">
		<cfset tgty=tgty + 1>
		<cfset tgtArr[tgtx][tgty] = Evaluate(j)>
	</cfloop>
</cfloop>

<html>
<head>
	<title>Update Table <cfoutput>#localTable#</cfoutput></title>
</head>

<body><cfoutput>

<h1>#table#</h1>
<h2>#columnList#</h2>
<h3>#keyList#</h3>
<cfif whereClause neq ''>
<h4>#whereClause#</h4>
</cfif>

<b>Rows on #source#:</b> #srcStart#<br>
<b>Rows on #target#:</b> #tgtStart#<br><br>

<!---<table border="1">
	<tr>
<cfloop list="#ListAppend(colhash.keys, colhash.nonkeys)#" index="j">
		<td><b>#j#</b></td>
</cfloop>
	</tr>
<cfloop from="1" to="#tgtx#" index="x">
	<tr>
	<cfloop from="1" to="#tgty#" index="y">
		<td>#tgtArr[x][y]#</td>
	</cfloop>
	</tr>
</cfloop>
</table><br><br>--->

<cfset srcp=0>
<cfset tgtp=0>
<cfset inserted=0>
<cfset deleted=0>
<cfset updated=0>
<cfset unchanged=0>
<cfif details>
<table border="1">
	<tr>
<cfloop list="#colhash.keys#" index="j">
		<td><b>#j#</b></td>
</cfloop>
		<td><b>#source#</b></td>
		<td><b>#target#</b></td>
	</tr>
</cfif>
<cfloop list="#ListSort(StructKeyList(comp), 'Text')#" index="qkey">
	<cfif details>
	<tr>
	</cfif>
	<cfset hx=0>
	<cfloop list="#colhash.keys#" index="j">
		<cfset hx=hx+1>
		<cfset iv=ListGetAt(qkey, hx, '|')>
		<cfif details>
			<cfif Evaluate("colhash.columns.#j#.type") eq 'n'>
		<td align="right">#NumberFormat(iv, '0')#</td>
			<cfelse>
		<td>#iv#</td>
			</cfif>
		</cfif>	
	</cfloop>
	<cfif details>
		<td align="center"><b><cfif StructFind(comp, qkey) neq 2>X<cfelse>&nbsp;</cfif></b></td>
		<td align="center"><b><cfif StructFind(comp, qkey) neq 1>X<cfelse>&nbsp;</cfif></b></td>
	</tr>
	</cfif>
	<cfif StructFind(comp, qkey) neq 2>
		<cfset srcp=srcp+1>
	</cfif>
	<cfif StructFind(comp, qkey) neq 1>
		<cfset tgtp=tgtp+1>
	</cfif>
	
	<cfset qry=''>
	<cfif StructFind(comp, qkey) eq 1>
		<cfif colhash.identity>
			<cfset qry=qry & "/*SET IDENTITY_INSERT `#localTable#` ON*/">
		</cfif>
		<cfset qry=qry & "INSERT INTO `#colhash.table#` (#columnList#) VALUES (">
		<cfset loops=0>
		<cfloop list="#ListAppend(colhash.keys, colhash.nonkeys)#" index="m">
			<cfif loops>
				<cfset qry=qry & ', '>
			</cfif>
			<cfset loops=loops+1>
			<cf_buildSQLTerm value="#srcArr[srcp][loops]#" type="#Evaluate("colhash.columns.#m#.type")#" required="#Evaluate("colhash.columns.#m#.req")#">
			<cfset qry=qry & term>
		</cfloop>
		<cfif colhash.identity>
			<cfset qry=qry & ")
/*SET IDENTITY_INSERT [#localTable#] OFF*/">
		<cfelse>
			<cfset qry=qry & ')'>
		</cfif>
		<cfset inserted=inserted+1>
	<cfelseif StructFind(comp, qkey) eq 2>
		<cfset qry=qry & "DELETE FROM `#colhash.table#` WHERE ">
		<cfset loops=0>
		<cfloop list="#colhash.keys#" index="m">
			<cfif loops>
				<cfset qry=qry & ' AND '>
			</cfif>
			<cfset loops=loops+1>
			<cf_buildSQLTerm value="#tgtArr[tgtp][loops]#" type="#Evaluate("colhash.columns.#m#.type")#" required="#Evaluate("colhash.columns.#m#.req")#" comparison="True">
			<cfset qry=qry & m & term>
		</cfloop>
		<cfset deleted=deleted+1>
	<cfelseif StructFind(comp, qkey) eq 3 And colhash.nonkeys neq ''>
		<cfset check = ListLen(colhash.keys)>
		<cfset diffStr=''>
		<cfloop list="#colhash.nonkeys#" index="k">
			<cfset check=check+1>
			<cfif srcArr[srcp][check] neq tgtArr[tgtp][check]>
				<cf_buildSQLTerm value="#srcArr[srcp][check]#" type="#Evaluate("colhash.columns.#k#.type")#" required="#Evaluate("colhash.columns.#k#.req")#">
				<cfif diffStr neq ''>
					<cfset diffStr=diffStr & ', '>
				</cfif>
				<cfset diffStr=diffStr & "#k#=#term#">
			</cfif>
		</cfloop>
		<cfif diffStr neq ''>
			<cfset qry = qry & "UPDATE `#colhash.table#` SET #diffStr# WHERE ">
			<cfset loops=0>
			<cfloop list="#colhash.keys#" index="m">
				<cfif loops>
					<cfset qry=qry & ' AND '>
				</cfif>
				<cfset loops=loops+1>
				<cf_buildSQLTerm value="#srcArr[srcp][loops]#" type="#Evaluate("colhash.columns.#m#.type")#" required="#Evaluate("colhash.columns.#m#.req")#" comparison="True">
				<cfset qry=qry & m & term>
			</cfloop>
			<cfset updated=updated+1>
		<cfelse>
			<cfset unchanged=unchanged+1>
		</cfif>
	</cfif>

	<cfif qry neq ''>
		<cfif details>
		</table><br>
		</cfif>
		#HTMLEditFormat(qry)#<br><br>
		<cfquery name="transferQuery" datasource="#target#">
			#PreserveSingleQuotes(qry)#
		</cfquery>
		<cfif details>
<table border="1">
	<tr>
			<cfloop list="#colhash.keys#" index="j">
		<td><b>#j#</b></td>
			</cfloop>
		<td><b>#source#</b></td>
		<td><b>#target#</b></td>
	</tr>
		</cfif>
	</cfif>
	
</cfloop>
<cfif details>
</table><br><br>
</cfif>

<b>Rows inserted:</b> #inserted#<br>
<b>Rows deleted:</b> #deleted#<br>
<b>Rows updated:</b> #updated#<br>
<b>Rows unchanged:</b> #unchanged#<br>
<i><b>Rows excised:</b> #excised#</i><br><br>

<cfset countQuery = "select count(*) as c from `#viewFix##localTable#` #whereClause#">
<cfquery name="srcCountEnd" datasource="#source#">
	#PreserveSingleQuotes(countQuery)#
</cfquery>
<cfset countQuery = "select count(*) as c from `#localTable#` #whereClause#">
<cfquery name="tgtCountEnd" datasource="#target#">
	#PreserveSingleQuotes(countQuery)#
</cfquery>
<cfset srcEnd = srcCountEnd.c>
<cfset tgtEnd = tgtCountEnd.c>
<b>Rows on #source#:</b> #srcEnd#<br>
<b>Rows on #target#:</b> #tgtEnd#<br><br>

<cfif srcEnd eq tgtEnd>
<b style="color: green;">SUCCESS!!!</b>
<cfelse>
<b style="color: red;">ERROR!!!</b>
</cfif>

</cfoutput></body> 
</html>

</cfif>