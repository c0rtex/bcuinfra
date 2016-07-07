<cfparam name="attributes.name" type="string" default="">
<cfparam name="attributes.table" type="string">
<cfparam name="attributes.code" type="string">
<cfparam name="attributes.title" type="string" default="">
<cfparam name="attributes.page" type="numeric" default="-1">
<cfparam name="attributes.rows" type="numeric" default="50">
<cfparam name="attributes.order" type="string" default="">
<cfparam name="attributes.orderlinks" type="boolean" default="true">
<cfparam name="attributes.by" type="string" default="">
<cfparam name="attributes.dir" type="string" default="asc">
<cfparam name="attributes.condition" type="string" default="">
<cfparam name="attributes.view" type="boolean" default="true">
<cfparam name="attributes.viewlevel" type="numeric" default="5">
<cfparam name="attributes.viewlink" type="string" default="">
<cfparam name="attributes.viewcondition" type="string" default="">
<cfparam name="attributes.edit" type="boolean" default="true">
<cfparam name="attributes.editlevel" type="numeric" default="3">
<cfparam name="attributes.editlink" type="string" default="">
<cfparam name="attributes.editcondition" type="string" default="">
<cfparam name="attributes.activate" type="boolean" default="false">
<cfparam name="attributes.activatelevel" type="numeric" default="3">
<cfparam name="attributes.activatelink" type="string" default="">
<cfparam name="attributes.activatecondition" type="string" default="">
<cfparam name="attributes.delete" type="boolean" default="false">
<cfparam name="attributes.deletelevel" type="numeric" default="3">
<cfparam name="attributes.deletelink" type="string" default="">
<cfparam name="attributes.deletecondition" type="string" default="">
<cfparam name="attributes.addlevel" type="numeric" default="3">
<cfparam name="attributes.addlink" type="string" default="">
<cfparam name="attributes.orderlevel" type="numeric" default="3">
<cfparam name="attributes.orderlink" type="string" default="">
<cfparam name="attributes.key" type="string" default="">
<cfparam name="attributes.crosstable" type="string" default="">
<cfparam name="attributes.crosscolumn" type="string" default="">
<cfparam name="attributes.crosslimit" type="numeric" default="64">
<cfparam name="attributes.crossvalue" type="any" default="">
<cfparam name="attributes.crosscondition" type="any" default="">
<cfparam name="attributes.crossorder" type="string" default="">
<cfparam name="attributes.crossadd" type="boolean" default="true">
<cfparam name="attributes.crossaddcondition" type="string" default="">
<cfparam name="attributes.crossaddlink" type="string" default="">
<cfparam name="attributes.crossaddlevel" type="numeric" default="3">
<cfparam name="attributes.crossdelete" type="boolean" default="true">
<cfparam name="attributes.crossdeletelevel" type="numeric" default="3">
<cfparam name="attributes.crossreorderlink" type="string" default="">
<cfparam name="attributes.crossorderlinks" type="boolean" default="false">
<cfparam name="attributes.reverseadd" type="boolean" default="false">
<cfparam name="attributes.reverseaddtable" type="string" default="">
<cfparam name="attributes.reverseaddcolumn" type="string" default="">
<cfparam name="attributes.reverseaddvalue" type="string" default="">
<cfparam name="attributes.reverseaddjoin" type="boolean" default="false">
<cfparam name="attributes.reverseaddcondition" type="string" default="">
<cfparam name="attributes.reverseaddlink" type="string" default="">
<cfparam name="attributes.reverseaddlevel" type="numeric" default="3">
<cfparam name="attributes.servedselectlink" type="string" default="">
<cfparam name="attributes.servedselectstate" type="string" default="">
<cfparam name="attributes.servedselectlevel" type="numeric" default="3">
<cfparam name="attributes.joincolumn" type="string" default="">
<cfparam name="attributes.keycolumn" type="string" default="">
<cfparam name="attributes.linkname" type="string" default="">
<cfparam name="attributes.linksection" type="string" default="">
<cfparam name="attributes.linktable" type="string" default="">
<cfparam name="attributes.linkcolumn" type="string" default="">
<cfparam name="attributes.linkkeycolumn" type="string" default="">
<cfparam name="attributes.linkhassort" type="boolean" default="true">
<cfparam name="attributes.linkextrainsert" type="string" default="">
<cfparam name="attributes.linkid" type="any" default="">
<cfparam name="attributes.linkaction" type="string" default="">
<cfparam name="attributes.selflink" type="boolean" default="false">
<cfparam name="attributes.selflinkid" type="any" default="">
<cfparam name="attributes.message" type="string" default="">

<cfif attributes.name eq ''>
	<cfset anchorname = ''>
	<cfset passanchorname = ''>
<cfelse>
	<cfset anchorname = "###attributes.name#">
	<cfset passanchorname = "&name=#attributes.name#">
</cfif>
<cfif attributes.key eq '' and IsDefined('id')>
	<cfset thiskey = id>
<cfelse>
	<cfset thiskey = attributes.key>
</cfif>
<cfif attributes.crosstable neq '' and attributes.crosscolumn neq '' and attributes.crossvalue neq ''>
	<cfset cross = true>
<cfelse>
	<cfset cross = false>
</cfif>
<cfif attributes.crossaddcondition eq ''>
	<cfset crosswhere = ''>
<cfelse>
	<cfset crosswhere = ' and ' & attributes.crossaddcondition>
</cfif>
<cfif attributes.linksection eq ''>
	<cfset linkpath = ''>
<cfelse>
	<cfset linkpath = "../#attributes.linksection#/">
</cfif>
<cfif attributes.selflink>
	<cfif attributes.selflinkid eq ''>
		<cfset listlink = CGI.SCRIPT_NAME & '?'>
	<cfelse>
		<cfset listlink = CGI.SCRIPT_NAME & "?id=#attributes.selflinkid#&">
	</cfif>
<cfelse>
	<cfset listlink = "#attributes.code#list.cfm?">
</cfif>

<cfif (ThisTag.ExecutionMode eq 'Start' And Not ThisTag.HasEndTag) Or ThisTag.ExecutionMode eq 'End'>

<cfset locallight = Evaluate("application.color.#attributes.code#.light")>
<cfset localmed = Evaluate("application.color.#attributes.code#.med")>
<cfset localdark = Evaluate("application.color.#attributes.code#.dark")>

<cfset actions=0>
<cfloop list="view,edit,activate,delete" index="act">
	<cfif Evaluate("attributes.#act#")>
		<cfset actions = actions + 1>
	</cfif>
</cfloop>
<cfif cross and attributes.crossdelete>
	<cfset actions = actions + 1>
</cfif>

<cf_tableLoad table="#attributes.table#">

<cfset colhash=StructNew()>
<cfset colhash.table=attributes.table>
<cfset colhash.keys=keys>
<cfset colhash.unique=unique>
<cfset colhash.identity=identity>
<cfset colhash.tag=tag>
<cfset colhash.name=name>
<cfset colhash.nonkeys=''>
<cfset colhash.columns=StructNew()>
<cfloop list="#columns#" index="column">
	<cfset colname = ListGetAt(column, 1, '|')>
	<cfset "colhash.columns.#colname#" = StructNew()>
	<cfset "colhash.columns.#colname#.name" = ListGetAt(column, 2, '|')>
	<cfset "colhash.columns.#colname#.type" = ListGetAt(column, 3, '|')>
	<cfset "colhash.columns.#colname#.req" = ListGetAt(column, 4, '|')>
	<cfset "colhash.columns.#colname#.refalias" = ''>
	<cfif ListFind(colhash.keys, colname)>
		<cfset "colhash.columns.#colname#.id" = 1>
	<cfelse>
		<cfset "colhash.columns.#colname#.id" = 0>
		<cfset colhash.nonkeys=ListAppend(colhash.nonkeys, colname)>
	</cfif>
	<cfset "colhash.columns.#colname#.visible" = true>
	<cfset "colhash.columns.#colname#.references" = ''>
	<cfset "colhash.columns.#colname#.display" = ''>
	<cfset "colhash.columns.#colname#.displaygroup_id" = 0>
</cfloop>

<cfif IsDefined('ThisTag.AssocAttribs')>
	<cfloop index="x" from="1" to="#ArrayLen(ThisTag.AssocAttribs)#">
		<cfset temper = ThisTag.AssocAttribs[x].column>
		<cfif StructKeyExists(colhash.columns, temper)>
			<cfloop list="visible,references,display,displaygroup_id" index="attrib">
				<cfset "colhash.columns.#temper#.#attrib#" = Evaluate("ThisTag.AssocAttribs[x].#attrib#")>
			</cfloop>
		</cfif>
	</cfloop>
</cfif>

<cfset localTable=colhash.table>
<cfset keyList=ListChangeDelims(colhash.keys, ', ')>
<cfif colhash.nonkeys eq ''>
	<cfset columnNameList = keyList>
<cfelse>
	<cfset columnNameList = ListAppend(colhash.keys, colhash.nonkeys)>
</cfif>

<cfif attributes.linktable neq '' and attributes.linktable eq attributes.crosstable and attributes.linkid neq '' and (attributes.name eq '' or (attributes.name eq attributes.linkname))>
	<cfif attributes.crossvalue eq ''>
		<cfset saveThisKey = thiskey>
	<cfelse>
		<cfset saveThisKey = attributes.crossvalue>
	</cfif>
	<cfif IsNumeric(attributes.linkid)>
		<cfset saveLinkID = attributes.linkid>
	<cfelse>
		<cfset saveLinkID = "'#Replace(attributes.linkid, "'", "''", 'ALL')#'">
	</cfif>
	<cfif attributes.linkaction eq 'delete'>
		<cfquery name="crossinsert" datasource="#application.dbSrc#">
			delete from `#attributes.linktable#`
			where #attributes.linkcolumn#=#saveThisKey#
				and #attributes.linkkeycolumn#=#PreserveSingleQuotes(saveLinkID)#
		</cfquery>
	<cfelse>
		<cfif attributes.linkhassort>
			<cfquery name="getsort" datasource="#application.dbSrc#">
				select max(sort) + 1 as newsort from `#attributes.linktable#` where #attributes.linkcolumn#=#thiskey#
			</cfquery>
			<cfif getsort.newsort eq ''>
				<cfset newsort = 1>
			<cfelse>
				<cfset newsort = getsort.newsort>
			</cfif>
		</cfif>
		<cfquery name="crossinsert" datasource="#application.dbSrc#">
			insert into `#attributes.linktable#`]
				(#attributes.linkcolumn#, #attributes.linkkeycolumn#<cfif attributes.linkhassort>, sort</cfif><cfloop list="#attributes.linkextrainsert#" index="x">, #ListGetAt(x, 1, '|')#</cfloop>)
			values
				(#saveThisKey#, #PreserveSingleQuotes(saveLinkID)#<cfif attributes.linkhassort>, #newsort#</cfif><cfloop list="#attributes.linkextrainsert#" index="x">, #ListGetAt(x, 2, '|')#</cfloop>)
		</cfquery>
	</cfif>
	<cfif attributes.linkhassort>
		<cf_compressSort table="#attributes.linktable#" limitByColumn="#attributes.linkcolumn#" limitByValue="#saveThisKey#" keyColumn="#attributes.linkkeycolumn#">
	</cfif>
</cfif>

<cfset tagColumnList = ''>
<cfset extraTableList = ''>
<cfif attributes.condition eq ''>
	<cfset extraWhere = ''>
<cfelse>
	<cfset extraWhere = " where #attributes.condition#">
</cfif>
<cfset displayCount = 0>
<cfset searchList = ''>
<cfloop list="#columnNameList#" index="column">
	<cfset tagColumnList = ListAppend(tagColumnList, "#colhash.tag#.#column#")>
	<cfif Evaluate("colhash.columns.#column#.req") eq 1>
		<cfset joinType = 'inner'>
	<cfelse>
		<cfset joinType = 'left outer'>
	</cfif>
	<cfif Evaluate("colhash.columns.#column#.display") eq 'display'>
		<cfset displayCount = displayCount + 1>
		<cfset tagColumnList = ListAppend(tagColumnList, "dl#displayCount#.display_text as #column#_disptext,cast(dl#displayCount#.display_text) as #column#_dispsort" as varchar(255))>
		<cfif joinType eq 'inner'>
			<cfset extraTableList = extraTableList & " #joinType# join `display_language` dl#displayCount# on #colhash.tag#.#column#=dl#displayCount#.display_id inner join `language` l#displayCount# on dl#displayCount#.language_id=l#displayCount#.language_id">
			<cfif extraWhere eq ''>
				<cfset extraWhere = ' where '>
			<cfelse>
				<cfset extraWhere = extraWhere & ' and '>
			</cfif>
			<cfset extraWhere = extraWhere & "l#displayCount#.active=1 and l#displayCount#.default_flag=1">
		<cfelse>
			<cfset extraTableList = extraTableList & " #joinType# join (select dl#displayCount#.display_id, dl#displayCount#.display_text from ">
			<cfif Evaluate("colhash.columns.#column#.displaygroup_id")>
				<cfset extraTableList = extraTableList & "`display` d#displayCount# inner join `display_language` dl#displayCount# on d#displayCount#.displaygroup_id=#Evaluate("colhash.columns.#column#.displaygroup_id")# and d#displayCount#.display_id=dl#displayCount#.display_id">
			<cfelse>
				<cfset extraTableList = extraTableList & "`display_language` dl#displayCount#">
			</cfif>
			<cfset extraTableList = extraTableList & " inner join `language` l#displayCount# on dl#displayCount#.language_id=l#displayCount#.language_id where l#displayCount#.active=1 and l#displayCount#.default_flag=1) dl#displayCount# on #colhash.tag#.#column#=dl#displayCount#.display_id">
		</cfif>
	<cfelseif Evaluate("colhash.columns.#column#.display") eq 'text'>
		<cfset tagColumnList = ListAppend(tagColumnList, "cast(#colhash.tag#.#column#) as #column#_dispsort" as varchar(255))>
	<cfelseif Evaluate("colhash.columns.#column#.references") neq ''>
		<cf_joinForeignKey table="#Evaluate("colhash.columns.#column#.references")#">
		<cfset tagColumnList = ListAppend(tagColumnList, "#refTag#.#refCol# as #column#_alias")>
		<cfset "colhash.columns.#column#.refalias" = "#refTag#.#refCol#">
		<cfset extraTableList = extraTableList & " #joinType# join `#Evaluate("colhash.columns.#column#.references")#` #refTag# on #colhash.tag#.#column#=#refTag#.#refKey#">
	</cfif>
	<cfif Evaluate("colhash.columns.#column#.visible") eq 'searchonly'>
		<cfif IsDefined("caller.dcsrch_#column#") and Trim(Evaluate("caller.dcsrch_#column#")) neq ''>
			<cfset "colhash.columns.#column#.visible" = true>
		<cfelse>
			<cfset "colhash.columns.#column#.visible" = false>
		</cfif>
	</cfif>
	<!---
		Test to see if this is a date field.  There are 3 different possibilities:
			1.  all date fields exist and are filled out (1)
			2.  all date fields exist but are not all filled out (-1)
			3.  date fields do not exist (0)
		We only want to try to evaluate this field in the first case, because otherwise the dummy date
		variable that gets passed along will cause an error, since SQL will try doing a comparison to
		something that is not a date.
	--->
	<cfif IsDefined("caller.dcsrch_#column#_day") and IsDefined("caller.dcsrch_#column#_month") and IsDefined("caller.dcsrch_#column#_year")>
		<cfif Evaluate("caller.dcsrch_#column#_day") neq '' and Evaluate("caller.dcsrch_#column#_month") neq '' and Evaluate("caller.dcsrch_#column#_year") neq ''>
			<cfset dateSearch = 1>
		<cfelse>
			<cfset dateSearch = -1>
		</cfif>
	<cfelse>
		<cfset dateSearch = 0>
	</cfif>
	<cfif (IsDefined("caller.dcsrch_#column#") and Trim(Evaluate("caller.dcsrch_#column#")) neq '' and dateSearch gt -1) or dateSearch eq 1>
		<cfif dateSearch eq 1>
			<cfset "caller.dcsrch_#column#" = "#Evaluate("caller.dcsrch_#column#_month")#/#Evaluate("caller.dcsrch_#column#_day")#/#Evaluate("caller.dcsrch_#column#_year")#">
		</cfif>
		<cfset searchList = ListAppend(searchList, "dcsrch_#column#=#URLEncodedFormat(Evaluate("caller.dcsrch_#column#"))#", '&')>
		<cfset searchList = ListAppend(searchList, "dcsrchop_#column#=#Evaluate("caller.dcsrchop_#column#")#", '&')>
		<cfif extraWhere eq ''>
			<cfset extraWhere = ' where '>
		<cfelse>
			<cfset extraWhere = extraWhere & ' and '>
		</cfif>
		<cfif Evaluate("colhash.columns.#column#.display") eq 'display'>
			<cfset searchColumn = "dl#displayCount#.display_text">
		<cfelse>
			<cfset searchColumn = "#colhash.tag#.#column#">
		</cfif>
		<cfswitch expression="#Evaluate("caller.dcsrchop_#column#")#">
			<cfcase value="1">
				<cfset searchCondition = "=">
			</cfcase>
			<cfcase value="2">
				<cfset searchCondition = "<>">
			</cfcase>
			<cfcase value="3">
				<cfset searchCondition = "<">
			</cfcase>
			<cfcase value="4">
				<cfset searchCondition = "<=">
			</cfcase>
			<cfcase value="5">
				<cfset searchCondition = ">">
			</cfcase>
			<cfcase value="6">
				<cfset searchCondition = ">=">
			</cfcase>
			<cfcase value="7">
				<cfset searchCondition = "like">
			</cfcase>
			<cfcase value="8">
				<cfset searchCondition = "not like">
			</cfcase>
			<cfcase value="9">
				<cfset searchCondition = "in">
			</cfcase>
			<cfcase value="10">
				<cfset searchCondition = "not in">
			</cfcase>
		</cfswitch>
		<cfset searchTerm = Trim(URLDecode(Evaluate("caller.dcsrch_#column#")))>
		<cfif Evaluate("caller.dcsrchop_#column#") eq 9 or Evaluate("caller.dcsrchop_#column#") eq 10>
			<cfset searchListNullIsInverse = false>
			<cfif ListFind(searchTerm, 'NULL')>
				<cfset searchListHasNull = true>
				<cfset searchTerm = ListDeleteAt(searchTerm, ListFind(searchTerm, 'NULL'))>
				<cfif Evaluate("caller.dcsrchop_#column#") eq 9>
					<cfset searchClauseNull = "#searchColumn# is null">
					<cfset searchClauseNullVisible = "is&nbsp;null">
					<cfset searchClauseNullInvisible = "#searchColumn# is&nbsp;null">
				<cfelse>
					<cfset searchClauseNull = "#searchColumn# is not null">
					<cfset searchClauseNullVisible = "is&nbsp;not&nbsp;null">
					<cfset searchClauseNullInvisible = "#searchColumn# is&nbsp;not&nbsp;null">
				</cfif>
			<cfelse>
				<cfset searchListHasNull = false>
			</cfif>
			<cfif ListLen(searchTerm)>
				<cfif Evaluate("colhash.columns.#column#.type") eq 's'>
					<cfset searchTerm = "('#ListChangeDelims(ListSort(searchTerm, 'textnocase'), "', '")#')">
				<cfelse>
					<cfset searchTerm = "(#ListChangeDelims(ListSort(searchTerm, 'numeric'), ', ')#)">
				</cfif>
				<cfset searchClauseList = "#searchColumn# #searchCondition# #searchTerm#">
				<cfset searchClauseListVisible = "#searchCondition#&nbsp;#searchTerm#">
				<cfset searchClauseListInvisible = "#searchColumn# #searchCondition#&nbsp;#searchTerm#">
				<cfif not SearchListHasNull and Evaluate("caller.dcsrchop_#column#") eq 10>
					<cfset searchListHasNull = true>
					<cfset searchListNullIsInverse = true>
					<cfset searchClauseNull = "#searchColumn# is null">
					<cfset searchClauseNullVisible = "is&nbsp;null">
					<cfset searchClauseNullInvisible = "#searchColumn# is&nbsp;null">
				</cfif>
			</cfif>
			<cfif searchListHasNull and ListLen(searchTerm)>
				<cfif Evaluate("caller.dcsrchop_#column#") eq 9 or (searchListNullIsInverse and Evaluate("caller.dcsrchop_#column#") eq 10)>
					<cfset searchClause = "(#searchClauseNull# or #searchClauseList#)">
					<cfset searchClauseVisible = "#searchClauseNullVisible# or #searchClauseListVisible#">
					<cfset searchClauseInvisible = "#searchClauseNullInvisible# or #searchClauseListInvisible#">
				<cfelse>
					<cfset searchClause = "#searchClauseNull# and #searchClauseList#">
					<cfset searchClauseVisible = "#searchClauseNullVisible# and #searchClauseListVisible#">
					<cfset searchClauseInvisible = "#searchClauseNullInvisible# and #searchClauseListInvisible#">
				</cfif>
			<cfelseif searchListHasNull>
				<cfset searchClause = searchClauseNull>
				<cfset searchClauseVisible = searchClauseNullVisible>
				<cfset searchClauseInvisible = searchClauseNullInvisible>
			<cfelseif ListLen(searchTerm)>
				<cfset searchClause = searchClauseList>
				<cfset searchClauseVisible = searchClauseListVisible>
				<cfset searchClauseInvisible = searchClauseListInvisible>
			</cfif>
		<cfelseif Evaluate("colhash.columns.#column#.type") eq 's' or Evaluate("colhash.columns.#column#.display") eq 'display'>
			<cfif Evaluate("caller.dcsrchop_#column#") eq 7 or Evaluate("caller.dcsrchop_#column#") eq 8>
				<cfset searchTerm = Replace(searchTerm, "*", "%", 'ALL')>
				<cfif Left(searchTerm, 1) neq '%'>
					<cfset searchTerm = '%' & searchTerm>
				</cfif>
				<cfif Right(searchTerm, 1) neq '%'>
					<cfset searchTerm = searchTerm & '%'>
				</cfif>
			</cfif>
			<cfset searchTerm = "'#Replace(searchTerm, "'", "''", 'ALL')#'">
			<cfset searchClause = "#searchColumn# #searchCondition# #searchTerm#">
			<cfset searchClauseVisible = "#searchCondition#&nbsp;#searchTerm#">
			<cfset searchClauseInvisible = "#searchColumn# #searchCondition#&nbsp;#searchTerm#">
		<cfelse>
			<cfset searchClause = "#searchColumn# #searchCondition# #searchTerm#">
			<cfset searchClauseVisible = "#searchCondition#&nbsp;#searchTerm#">
			<cfset searchClauseInvisible = "#searchColumn# #searchCondition#&nbsp;#searchTerm#">
		</cfif>
		<cfset searchRow = true>
		<cfif Evaluate("colhash.columns.#column#.visible") eq 'true'>
			<cfset "colhash.columns.#column#.search" = searchClauseVisible>
		<cfelse>
			<cfset searchRowInvisible = true>
			<cfset "colhash.columns.#column#.search" = searchClauseInvisible>
		</cfif>
		<cfset extraWhere = extraWhere & searchClause>
	</cfif>
</cfloop>
<cfif searchList neq ''>
	<cfif IsDefined('caller.dcsrchpop')>
		<cfset searchGoBack = caller.dcsrchpop>
	<cfelse>
		<cfset searchGoBack = 1>
	</cfif>
	<cfset searchList = '&' & ListAppend(searchList, "dcsrchpop=#Evaluate("#searchGoBack# + 1")#", '&')>
</cfif>
<cfset tagOrderByList = ''>
<cfloop list="#colhash.keys#" index="column">
	<cfset tagOrderByList = ListAppend(tagOrderByList, "#colhash.tag#.#column#")>
</cfloop>

<cfset selectList = ListChangeDelims(tagColumnList, ', ')>
<cfset orderByList = ListChangeDelims(tagOrderByList, ', ')>

<cfif attributes.keycolumn eq ''>
	<cfset keycolumn = colhash.keys>
<cfelse>
	<cfset keycolumn = attributes.keycolumn>
</cfif>
<cfif attributes.joincolumn eq ''>
	<cfset joincolumn = keycolumn>
<cfelse>
	<cfset joincolumn = attributes.joincolumn>
</cfif>
<cfif attributes.crosscondition neq ''>
	<cfset attributes.crosscondition = ' and ' & attributes.crosscondition>
</cfif>
<cfquery name="getdata" datasource="#application.dbSrc#">
	select #selectList#
	from <cfif cross>`#attributes.crosstable#` xtbl inner join `#localTable#` #colhash.tag#
			on xtbl.#attributes.crosscolumn#=#PreserveSingleQuotes(attributes.crossvalue)#
				and xtbl.#joincolumn#=#colhash.tag#.#keycolumn##PreserveSingleQuotes(attributes.crosscondition)#<cfelse>`#localTable#` #colhash.tag#</cfif>#extraTableList##PreserveSingleQuotes(extraWhere)#
	order by <cfif cross and not attributes.crossorderlinks and attributes.crossorder neq ''><cfif not Find('.', ListGetAt(attributes.crossorder, 1))>xtbl.</cfif>#attributes.crossorder#<cfelseif attributes.by eq ''><cfif attributes.order eq ''>#orderByList#<cfelse>#colhash.tag#.#attributes.order#</cfif><cfelse><cfif Evaluate("colhash.columns.#attributes.by#.display") eq 'display' or Evaluate("colhash.columns.#attributes.by#.display") eq 'text'>#attributes.by#_dispsort<cfelseif Evaluate("colhash.columns.#attributes.by#.references") neq ''>#Evaluate("colhash.columns.#attributes.by#.refalias")#<cfelse>#colhash.tag#.#attributes.by#</cfif> #attributes.dir#</cfif>
</cfquery>
<cfif attributes.by eq '' and attributes.order neq ''>
	<cfset attributes.by = attributes.order>
</cfif>

<cfoutput>
<cfif cross or attributes.selflink>
<br>
</cfif>
<cfset colspan = actions>
<cfloop list="#columnNameList#" index="column">
	<cfif Evaluate("colhash.columns.#column#.visible") eq 'true'>
		<cfset colspan = colspan + 1>
	</cfif>
</cfloop>
<cfif attributes.name neq ''>
	<a name="#attributes.name#" />
</cfif>
<table cellpadding="3" cellspacing="3" border="0">
<cfif attributes.title neq ''>
	<cfset blockShowTitle = true>
<cfelse>
	<cfset blockShowTitle = false>
</cfif>
<cfif cross and attributes.crossadd and session.level lte attributes.crossaddlevel>
	<cfset blockShowCross = true>
<cfelse>
	<cfset blockShowCross = false>
</cfif>
<cfif attributes.reverseadd and session.level lte attributes.reverseaddlevel>
	<cfset blockShowReverse = true>
<cfelse>
	<cfset blockShowReverse = false>
</cfif>
<cfif attributes.servedselectlink neq '' and session.level lte attributes.servedselectlevel>
	<cfset blockServedSelect = true>
<cfelse>
	<cfset blockServedSelect = false>
</cfif>
<cfif blockShowTitle or blockShowCross or blockShowReverse or blockServedSelect>
	<tr bgcolor="#localdark#">
		<td valign="bottom" colspan="#colspan#" style="<cfif blockShowTitle and not blockShowCross and not blockShowReverse>font-size: 18pt; font-weight: bold;<cfelseif blockShowTitle and (blockShowCross or blockShowReverse)>font-size: 10pt;</cfif>">
	<cfif blockShowTitle and (blockShowCross or blockShowReverse or blockServedSelect)>
		<table cellpadding="0" cellspacing="0" border="0" width="100%">
			<tr bgcolor="#localdark#">
	</cfif>
	<cfif blockShowTitle>
		<cfif blockShowCross or blockShowReverse or blockServedSelect>
			<td valign="bottom" style="font-size: 18pt; font-weight: bold;">#attributes.title#</td>
		<cfelse>
			#attributes.title#
		</cfif>
	</cfif>
	<cfif blockShowTitle and (attributes.addlink neq '' or attributes.orderlink neq '')>
		&nbsp;&nbsp;&nbsp;
	</cfif>
	<cfif attributes.addlink neq ''>
		<cf_checkAccessLink level="#attributes.addlevel#" href="#attributes.addlink#" style="color: white; font-weight: normal; font-size: 12pt;">add</cf_checkAccessLink>
	</cfif>
	<cfif attributes.addlink neq '' and attributes.orderlink neq ''>
		&nbsp;
	</cfif>
	<cfif attributes.orderlink neq ''>
		<cf_checkAccessLink level="#attributes.orderlevel#" href="#attributes.orderlink#" style="color: white; font-weight: normal; font-size: 12pt;">reorder</cf_checkAccessLink>
	</cfif>
	<cfif blockShowTitle and (blockShowCross or blockShowReverse or blockServedSelect)>
		<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
	</cfif>
	<cfif blockShowCross>
		<cfif attributes.joincolumn eq ''>
			<cfset joincolumn = colhash.keys>
		<cfelse>
			<cfset joincolumn = attributes.joincolumn>
		</cfif>
		<cfquery name="getadd" datasource="#application.dbSrc#">
			select #colhash.tag#.#colhash.keys#, #colhash.tag#.#colhash.name#
			from `#attributes.crosstable#` xtbl right outer join `#localTable#` #colhash.tag#
					on xtbl.#attributes.crosscolumn#=#PreserveSingleQuotes(attributes.crossvalue)#
						and xtbl.#joincolumn#=#colhash.tag#.#colhash.keys#
			where xtbl.#joincolumn# is null#PreserveSingleQuotes(crosswhere)#
			order by #colhash.tag#.#colhash.name#
		</cfquery>
		<cfif attributes.crossaddlink eq ''>
		<form action="?id=#thiskey##anchorname#" method="post">
		<cfelse>
		<form action="#attributes.crossaddlink##anchorname#" method="post">
		</cfif>
		<cfif blockShowTitle><td align="right" valign="bottom" style="font-size: 10pt;"></cfif>
			<select name="linkid">
				<option value="" selected>-- choose one --
			<cfloop query="getadd">
				<option value="#Evaluate("#colhash.keys#")#">#Left(HTMLEditFormat(Evaluate("#colhash.name#")), attributes.crosslimit)#
			</cfloop>
			</select>
			<cfif attributes.name neq ''>
			<input type="hidden" name="linkname" value="#attributes.name#" />
			</cfif>
			<input type="hidden" name="linktable" value="#attributes.crosstable#">
			<input type="hidden" name="linkcolumn" value="#attributes.crosscolumn#">
			<input type="hidden" name="linkkeycolumn" value="#colhash.keys#">
			<input type="submit" value="add">
			<cfif attributes.crossreorderlink neq ''>
			<input type="button" value="reorder" onClick="window.location.href = '#attributes.crossreorderlink#';">
			</cfif>
		<cfif blockShowTitle></td></cfif>
		</form>
	<cfelseif blockShowReverse>
		<cf_tableLoad table="#attributes.reverseaddtable#">
		<cfset revhash = StructNew()>
		<cfset revhash.keys = keys>
		<cfset revhash.tag = tag>
		<cfset revhash.name = name>
		<cfif attributes.reverseaddjoin>
			<cfquery name="getadd" datasource="#application.dbSrc#">
				select #revhash.tag#.#revhash.keys#, #revhash.tag#.#revhash.name#
				from `#attributes.reverseaddtable#` #revhash.tag# left outer join `#localTable#` #colhash.tag#
						on #colhash.tag#.#attributes.reverseaddcolumn#=#attributes.reverseaddvalue#
							and #revhash.tag#.#revhash.keys#=#colhash.tag#.#revhash.keys#
				where #colhash.tag#.#revhash.keys# is null
					<cfif attributes.reverseaddcondition neq ''>and #PreserveSingleQuotes(attributes.reverseaddcondition)#</cfif>
				order by #revhash.tag#.#revhash.name#
			</cfquery>
		<cfelse>
			<cfquery name="getadd" datasource="#application.dbSrc#">
				select #revhash.tag#.#revhash.keys#, #revhash.tag#.#revhash.name#
				from `#attributes.reverseaddtable#` #revhash.tag#
				<cfif attributes.reverseaddcondition neq ''>where #PreserveSingleQuotes(attributes.reverseaddcondition)#</cfif>
				order by #revhash.tag#.#revhash.name#
			</cfquery>
		</cfif>
		<form action="#attributes.reverseaddlink#" method="post">
		<cfif blockShowTitle><td align="right" valign="bottom" style="font-size: 10pt;"></cfif>
			<select name="new_#revhash.keys#">
				<option value="" selected>-- choose one --
			<cfloop query="getadd">
				<option value="#Evaluate("#revhash.keys#")#">#Left(HTMLEditFormat(Evaluate("#revhash.name#")), attributes.crosslimit)#
			</cfloop>
			</select>
			<cfif attributes.name neq ''>
			<input type="hidden" name="name" value="#attributes.name#" />
			</cfif>
			<input type="hidden" name="new_#attributes.reverseaddcolumn#" value="#attributes.reverseaddvalue#">
			<input type="submit" value="add">
		<cfif blockShowTitle></td></cfif>
		</form>
	<cfelseif blockServedSelect>
		<cfquery name="getadd" datasource="#application.dbSrc#">
			select state_id
			from state
			order by state_id
		</cfquery>
		<form action="#attributes.servedselectlink#" method="post">
		<cfif blockShowTitle><td align="right" valign="bottom" style="font-size: 10pt;"></cfif>
			<select name="state_id">
			<cfloop query="getadd">
				<option value="#state_id#"<cfif attributes.servedselectstate eq state_id> selected</cfif>>#state_id#</option>
			</cfloop>
			</select>
			<cfif attributes.name neq ''>
			<input type="hidden" name="name" value="#attributes.name#" />
			</cfif>
			<input type="submit" value="edit">
		<cfif blockShowTitle></td></cfif>
		</form>
	</cfif>
	<cfif blockShowTitle and (blockShowCross or blockShowReverse or blockServedSelect)>
		</tr>
		</table>
	</cfif>
		</td>
	</tr>
</cfif>
<cfif attributes.message neq ''>
	<tr bgcolor="#localmed#">
		<td valign="bottom" colspan="#colspan#" style="font-size: 10pt;">
			<em>#attributes.message#</em>
		</td>
	</tr>
</cfif>
<cfset pageCount = int((getdata.RecordCount - 1) / attributes.rows) + 1>
<cfif attributes.page lt 1>
	<cfset startRow = 1>
	<cfset endRow = getdata.RecordCount>
<cfelse>
	<cfif attributes.page gt pageCount>
		<cfset attributes.page = pageCount>
	</cfif>
	<cfset startRow = ((attributes.page - 1) * attributes.rows) + 1>
	<cfset endRow = attributes.page * attributes.rows>
	<cfif endRow gt getdata.RecordCount>
		<cfset endRow = getdata.RecordCount>
	</cfif>
</cfif>
<cfif attributes.page gt -1>
	<tr bgcolor="#localdark#">
		<td valign="bottom" colspan="#colspan#"><table border="0" cellspacing="0" cellpadding="0" width="100%" style="font-size: 8pt; font-family: Verdana, Arial, Helvetica, sans-serif;"><tr><td align="left" valign="middle">
			<cfif getdata.RecordCount eq '0'>
				<strong>no result</strong>
			<cfelse>
				<strong>#startRow#</strong> to <strong>#endRow#</strong> of <strong>#getdata.RecordCount#</strong>
			</cfif>
			<cfif IsDefined('searchGoBack')>
				&nbsp;(<a href="javascript:history.go(-#searchGoBack#)">refine search</a>)
			</cfif>
		</td>
		<cfif attributes.page gt -1 and pageCount gt 1>
			<td>&nbsp;</td>
			<td align="right" valign="middle">
				<cfif attributes.page lt 2>
					&nbsp;&##171;&nbsp; &nbsp;&lt;&nbsp;
				<cfelse>
					<a href="#listlink#by=#attributes.by#&dir=#attributes.dir#&page=1#searchList#">&nbsp;&##171;&nbsp;</a>
					<a href="#listlink#by=#attributes.by#&dir=#attributes.dir#&page=#Evaluate("#attributes.page# - 1")##searchList#">&nbsp;&lt;&nbsp;</a>
				</cfif>
				<cfloop from="1" to="#pageCount#" index="x">
					<cfif x eq attributes.page>
						&nbsp;<strong>#x#</strong>&nbsp;
					<cfelse>
						<a href="#listlink#by=#attributes.by#&dir=#attributes.dir#&page=#x##searchList#">&nbsp;#x#&nbsp;</a>
					</cfif>
				</cfloop>
				<cfif attributes.page eq 0 or attributes.page eq pageCount>
					&nbsp;&gt;&nbsp; &nbsp;&##187;&nbsp;
				<cfelse>
					<a href="#listlink#by=#attributes.by#&dir=#attributes.dir#&page=#Evaluate("#attributes.page# + 1")##searchList#">&nbsp;&gt;&nbsp;</a>
					<a href="#listlink#by=#attributes.by#&dir=#attributes.dir#&page=#pageCount##searchList#">&nbsp;&##187;&nbsp;</a>
				</cfif>
				<cfif attributes.page eq 0>
					&nbsp;<strong>all</strong>&nbsp;
				<cfelse>
					<a href="#listlink#by=#attributes.by#&dir=#attributes.dir#&page=0#searchList#">&nbsp;all&nbsp;</a>
				</cfif>
			</td>
		</cfif>
		</tr></table></td>
	</tr>
</cfif>
<tr bgcolor="#localmed#">
<cfloop list="#columnNameList#" index="column">
	<cfif Evaluate("colhash.columns.#column#.visible") eq 'true'>
	<td valign="bottom"<cfif StructKeyExists(Evaluate("colhash.columns.#column#"), 'search')> bgcolor="#localdark#"</cfif>><cfif (not cross or attributes.crossorderlinks) and attributes.orderlinks><a href="#listlink#by=#column#&dir=<cfif (attributes.by eq '' and column eq colhash.keys) or column eq attributes.by><cfif attributes.dir eq 'asc'>desc<cfelse>asc</cfif><cfelse>asc</cfif><cfif attributes.page eq 0>&page=0</cfif>#searchList##anchorname#"></cfif><b>#Evaluate("colhash.columns.#column#.name")#</b></a><cfif (attributes.by eq '' and column eq colhash.keys) or column eq attributes.by>&nbsp;<b><cfif attributes.dir eq 'desc'>&darr;<cfelse>&uarr;</cfif></b><!---img src="#session.serverpath#/img/order#attributes.dir#.gif" align="baseline" border="0" hspace="0" vspace="0"---></cfif></td>
	</cfif>
</cfloop>
	<td valign="bottom" <cfif IsDefined('searchRowInvisible')>bgcolor="#localdark#" </cfif>colspan="#actions#" align="center"><b>Actions</b></td>
</tr>
<cfif IsDefined('searchRow')>
<tr bgcolor="#localmed#" style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:7pt; font-weight:bold;">
<cfloop list="#columnNameList#" index="column">
	<cfif Evaluate("colhash.columns.#column#.visible") eq 'true'>
	<td <cfif not IsDefined("colhash.columns.#column#.search")>bgcolor="#locallight#" </cfif>valign="bottom"><cfif IsDefined("colhash.columns.#column#.search")>#Evaluate("colhash.columns.#column#.search")#<cfelse>&nbsp;</cfif></td>
	</cfif>
</cfloop>
	<td <cfif not IsDefined('searchRowInvisible')>bgcolor="#locallight#" </cfif>colspan="#actions#" valign="bottom">
	<cfif IsDefined('searchRowInvisible')>
		<span style="font-weight:normal;">columns not shown:</span>
		<cfloop list="#columnNameList#" index="column">
			<cfif Evaluate("colhash.columns.#column#.visible") neq 'true' and IsDefined("colhash.columns.#column#.search")>
				<br /><li>#Evaluate("colhash.columns.#column#.search")#
			</cfif>
		</cfloop>
	<cfelse>
		&nbsp;
	</cfif>
	</td>
</tr>
</cfif>
<cfset rowCount = 0>
<cfloop query="getdata">
	<cfset rowCount = rowCount + 1>
	<cfif rowCount gte startRow and rowCount lte endRow>
		<tr bgcolor="<cfif attributes.activate and active neq 1>#localmed#<cfelse>#locallight#</cfif>">
			<cfloop list="#columnNameList#" index="column">
				<cfif Evaluate("colhash.columns.#column#.visible") eq 'true'>
			<td valign="top"<cfif Evaluate("colhash.columns.#column#.type") eq 'n' and Evaluate("colhash.columns.#column#.display") neq 'display' and Evaluate("colhash.columns.#column#.references") eq '' and Evaluate("colhash.columns.#column#.display") neq 'yesno'> align="right"</cfif>><cfif Evaluate("colhash.columns.#column#.display") eq 'password'>********<cfelseif Evaluate("colhash.columns.#column#.display") eq 'notnull'><cfif Evaluate(column) neq ''><strong>X</strong></cfif><cfelseif Evaluate("colhash.columns.#column#.display") eq 'display'>#Evaluate("#column#_disptext")#<cfelseif Evaluate("colhash.columns.#column#.references") neq ''>#Evaluate("#column#_alias")#<cfelseif Evaluate("colhash.columns.#column#.display") eq 'yesno'><cfif Evaluate("#column#") eq 1>Yes<cfelse>No</cfif><cfelseif Evaluate("colhash.columns.#column#.display") eq 'dollar'>#DollarFormat(Evaluate("#column#"))#<cfelseif Evaluate("colhash.columns.#column#.display") eq 'date'>#DateFormat(Evaluate("#column#"), 'd mmmm yyyy')#<cfelse>#Evaluate("#column#")#</cfif></td>
				</cfif>
			</cfloop>
			<cfif attributes.view>
				<cfif attributes.viewcondition eq '' Or Evaluate("#attributes.viewcondition#")>
					<cfif attributes.viewlink eq ''>
						<cfif ListLen(colhash.keys) gt 1>
							<cfset idFields = ''>
							<cfloop list="#colhash.keys#" index="x">
								<cfset idFields = ListAppend(idFields, "#x#=#Evaluate("#x#")#", '&')>
							</cfloop>
						<cfelse>
							<cfset idFields = "id=#Evaluate("#colhash.keys#")#">
						</cfif>
						<cfset link = "#attributes.code#view_dev.cfm?#idFields##passanchorname#&test=true">
					<cfelse>
						<cfset link = attributes.viewlink>
						<cfif ListLen(colhash.keys) eq 1>
							<cfset link = ReplaceNoCase(link, '[[id]]', Evaluate("#colhash.keys#"), 'ALL')>
						</cfif>
						<cfloop list="#columnNameList#" index="x">
							<cfset link = ReplaceNoCase(link, "[[#x#]]", Evaluate("#x#"), 'ALL')>
						</cfloop>
					</cfif>
					<td align="center" valign="top"><cf_checkAccessLink level="#attributes.viewlevel#" href="#linkpath##link#">view</cf_checkAccessLink></td>
				<cfelse>
					<td align="center" valign="top">view</td>
				</cfif>
			</cfif>
			<cfif attributes.edit>
				<cfif attributes.editcondition eq '' Or Evaluate("#attributes.editcondition#")>
					<cfif attributes.editlink eq ''>
						<cfif ListLen(colhash.keys) gt 1>
							<cfset idFields = ''>
							<cfloop list="#colhash.keys#" index="x">
								<cfset idFields = ListAppend(idFields, "#x#=#Evaluate("#x#")#", '&')>
							</cfloop>
						<cfelse>
							<cfset idFields = "id=#Evaluate("#colhash.keys#")#">
						</cfif>
						<cfset link = "#attributes.code#view.cfm?#idFields#&action=edit#passanchorname#">
					<cfelse>
						<cfset link = attributes.editlink>
						<cfif ListLen(colhash.keys) eq 1>
							<cfset link = ReplaceNoCase(link, '[[id]]', Evaluate("#colhash.keys#"), 'ALL')>
						</cfif>
						<cfloop list="#columnNameList#" index="x">
							<cfset link = ReplaceNoCase(link, "[[#x#]]", Evaluate("#x#"), 'ALL')>
						</cfloop>
					</cfif>
					<td align="center" valign="top"><cf_checkAccessLink level="#attributes.editlevel#" href="#linkpath##link#">edit</cf_checkAccessLink></td>
				<cfelse>
					<td align="center" valign="top">edit</td>
				</cfif>
			</cfif>
			<cfif attributes.activate>
				<cfif attributes.activatecondition eq '' Or Evaluate("#attributes.activatecondition#")>
					<cfif attributes.activatelink eq ''>
						<cfif ListLen(colhash.keys) gt 1>
							<cfset idFields = ''>
							<cfloop list="#colhash.keys#" index="x">
								<cfset idFields = ListAppend(idFields, "#x#=#Evaluate("#x#")#", '&')>
							</cfloop>
						<cfelse>
							<cfset idFields = "id=#Evaluate("#colhash.keys#")#">
						</cfif>
						<cfset link = "#attributes.code#activate.cfm?#idFields##passanchorname#&value=">
					<cfelse>
						<cfset link = attributes.activatelink>
						<cfif ListLen(colhash.keys) eq 1>
							<cfset link = ReplaceNoCase(link, '[[id]]', Evaluate("#colhash.keys#"), 'ALL')>
						</cfif>
						<cfloop list="#columnNameList#" index="x">
							<cfset link = ReplaceNoCase(link, "[[#x#]]", Evaluate("#x#"), 'ALL')>
						</cfloop>
					</cfif>
					<td align="center" valign="top"><cfif active neq 1><cf_checkAccessLink level="2" href="#linkpath##link#1">reactivate</cf_checkAccessLink><cfelse><cf_checkAccessLink level="2" href="#linkpath##link#0">deactivate</cf_checkAccessLink></cfif></td>
				<cfelse>
					<td align="center" valign="top"><cfif active neq 1>reactivate<cfelse>deactivate</cfif></td>
				</cfif>
			</cfif>
			<cfif attributes.delete>
				<cfif attributes.deletecondition eq '' Or Evaluate("#attributes.deletecondition#")>
					<cfif attributes.deletelink eq ''>
						<cfif ListLen(colhash.keys) gt 1>
							<cfset idFields = ''>
							<cfloop list="#colhash.keys#" index="x">
								<cfset idFields = ListAppend(idFields, "#x#=#Evaluate("#x#")#", '&')>
							</cfloop>
						<cfelse>
							<cfset idFields = "id=#Evaluate("#colhash.keys#")#">
						</cfif>
						<cfset link = "#attributes.code#delete.cfm?#idFields##passanchorname#">
					<cfelse>
						<cfset link = attributes.deletelink>
						<cfif ListLen(colhash.keys) eq 1>
							<cfset link = ReplaceNoCase(link, '[[id]]', Evaluate("#colhash.keys#"), 'ALL')>
						</cfif>
						<cfloop list="#columnNameList#" index="x">
							<cfset link = ReplaceNoCase(link, "[[#x#]]", Evaluate("#x#"), 'ALL')>
						</cfloop>
					</cfif>
					<td align="center" valign="top"><cf_checkAccessLink level="#attributes.deletelevel#" href="#linkpath##link#" onClick="if (confirm('Are you sure you want to delete this item?')) return true; else return false;">delete</cf_checkAccessLink></td>
				<cfelse>
					<td align="center" valign="top">delete</td>
				</cfif>
			</cfif>
			<cfif cross and attributes.crossdelete>
				<td align="center" valign="top"><cf_checkAccessLink level="#attributes.crossdeletelevel#" href="?id=#thiskey#&linkname=#attributes.name#&linktable=#attributes.crosstable#&linkcolumn=#attributes.crosscolumn#&linkkeycolumn=#colhash.keys#&linkid=#Evaluate("#colhash.keys#")#&linkaction=delete#anchorname#" onClick="if (confirm('Are you sure you want to delete this association?')) return true; else return false;">dissociate</cf_checkAccessLink></td>
			</cfif>
		</tr>
	</cfif>
</cfloop>
<cfif attributes.page gt -1>
	<tr bgcolor="#localdark#">
		<td valign="bottom" colspan="#colspan#"><table border="0" cellspacing="0" cellpadding="0" width="100%" style="font-size: 8pt; font-family: Verdana, Arial, Helvetica, sans-serif;"><tr><td align="left" valign="middle">
			<cfif getdata.RecordCount eq '0'>
				<strong>no result</strong>
			<cfelse>
				<strong>#startRow#</strong> to <strong>#endRow#</strong> of <strong>#getdata.RecordCount#</strong>
			</cfif>
			<cfif IsDefined('searchGoBack')>
				&nbsp;(<a href="javascript:history.go(-#searchGoBack#)">refine search</a>)
			</cfif>
		</td>
		<cfif attributes.page gt -1 and pageCount gt 1>
			<td>&nbsp;</td>
			<td align="right" valign="middle">
				<cfif attributes.page lt 2>
					&nbsp;&##171;&nbsp; &nbsp;&lt;&nbsp;
				<cfelse>
					<a href="#listlink#by=#attributes.by#&dir=#attributes.dir#&page=1#searchList#">&nbsp;&##171;&nbsp;</a>
					<a href="#listlink#by=#attributes.by#&dir=#attributes.dir#&page=#Evaluate("#attributes.page# - 1")##searchList#">&nbsp;&lt;&nbsp;</a>
				</cfif>
				<cfloop from="1" to="#pageCount#" index="x">
					<cfif x eq attributes.page>
						&nbsp;<strong>#x#</strong>&nbsp;
					<cfelse>
						<a href="#listlink#by=#attributes.by#&dir=#attributes.dir#&page=#x##searchList#">&nbsp;#x#&nbsp;</a>
					</cfif>
				</cfloop>
				<cfif attributes.page eq 0 or attributes.page eq pageCount>
					&nbsp;&gt;&nbsp; &nbsp;&##187;&nbsp;
				<cfelse>
					<a href="#listlink#by=#attributes.by#&dir=#attributes.dir#&page=#Evaluate("#attributes.page# + 1")##searchList#">&nbsp;&gt;&nbsp;</a>
					<a href="#listlink#by=#attributes.by#&dir=#attributes.dir#&page=#pageCount##searchList#">&nbsp;&##187;&nbsp;</a>
				</cfif>
				<cfif attributes.page eq 0>
					&nbsp;<strong>all</strong>&nbsp;
				<cfelse>
					<a href="#listlink#by=#attributes.by#&dir=#attributes.dir#&page=0#searchList#">&nbsp;all&nbsp;</a>
				</cfif>
			</td>
		</cfif>
		</tr></table></td>
	</tr>
</cfif>
</table>

</cfoutput>

</cfif>