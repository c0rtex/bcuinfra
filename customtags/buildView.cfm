<cfparam name="attributes.name" type="string" default="">
<cfparam name="attributes.key" type="string">
<cfparam name="attributes.table" type="string">
<cfparam name="attributes.code" type="string">
<cfparam name="attributes.viewlevel" type="numeric" default="5">
<cfparam name="attributes.viewcondition" type="string" default="">
<cfparam name="attributes.editlevel" type="numeric" default="3">
<cfparam name="attributes.editcondition" type="string" default="">
<cfparam name="attributes.action" type="string" default="view">
<cfparam name="attributes.saving" type="numeric" default="0">
<cfparam name="attributes.title" type="string" default="">
<cfparam name="attributes.actionurl" type="string" default="">
<cfparam name="attributes.viewurl" type="string" default="">
<cfparam name="attributes.editurl" type="string" default="">
<cfparam name="attributes.extraurllist" type="string" default="">
<cfparam name="attributes.extranamelist" type="string" default="">
<cfparam name="attributes.linkallactions" type="boolean" default="false">
<cfparam name="attributes.callonsave" type="string" default="">
<cfparam name="attributes.redirect" type="string" default="">
<cfparam name="attributes.newidvar" type="string" default="id">
<cfparam name="attributes.savedvar" type="string" default="hasSaved">

<cfif attributes.actionurl eq ''>
	<cfset attributes.actionurl = "#attributes.code#view.cfm">
</cfif>
<cfset "caller.#attributes.savedvar#" = false>

<cfif (ThisTag.ExecutionMode eq 'Start' And Not ThisTag.HasEndTag) Or ThisTag.ExecutionMode eq 'End'>

<cfset locallight = Evaluate("application.color.#attributes.code#.light")>
<cfset localmed = Evaluate("application.color.#attributes.code#.med")>
<cfset localdark = Evaluate("application.color.#attributes.code#.dark")>

<cf_tableLoad table="#attributes.table#">

<cfset colhash=StructNew()>
<cfset colhash.table=attributes.table>
<cfset colhash.keys=keys>
<cfset colhash.unique=unique>
<cfset colhash.identity=identity>
<cfset colhash.tag=tag>
<cfset colhash.nonkeys=''>
<cfset colhash.columns=StructNew()>
<cfloop list="#columns#" index="column">
	<cfset colname=ListGetAt(column, 1, '|')>
	<cfset "colhash.columns.#colname#"=StructNew()>
	<cfset "colhash.columns.#colname#.name"=ListGetAt(column, 2, '|')>
	<cfset "colhash.columns.#colname#.type"=ListGetAt(column, 3, '|')>
	<cfset "colhash.columns.#colname#.req"=ListGetAt(column, 4, '|')>
	<cfif ListFind(colhash.keys, colname)>
		<cfset "colhash.columns.#colname#.id"=1>
	<cfelse>
		<cfset "colhash.columns.#colname#.id"=0>
		<cfset colhash.nonkeys=ListAppend(colhash.nonkeys, colname)>
	</cfif>
	<cfset "colhash.columns.#colname#.error" = ''>
	<cfset "colhash.columns.#colname#.group" = ''>
	<cfset "colhash.columns.#colname#.namefrom" = ''>
	<cfset "colhash.columns.#colname#.codefrom" = ''>
	<cfset "colhash.columns.#colname#.increment" = 0>
	<cfset "colhash.columns.#colname#.input" = ''>
	<cfset "colhash.columns.#colname#.bindto" = ''>
	<cfset "colhash.columns.#colname#.bindoptionskey" = ''>
	<cfset "colhash.columns.#colname#.bindid" = ''>
	<cfset "colhash.columns.#colname#.yes" = ''>
	<cfset "colhash.columns.#colname#.no" = ''>
	<cfset "colhash.columns.#colname#.default" = ''>
	<cfset "colhash.columns.#colname#.size" = 50>
	<cfset "colhash.columns.#colname#.limit" = 0>
	<cfset "colhash.columns.#colname#.restriction" = ''>
	<cfset "colhash.columns.#colname#.case" = ''>
	<cfset "colhash.columns.#colname#.cols" = 0>
	<cfset "colhash.columns.#colname#.rows" = 0>
	<cfset "colhash.columns.#colname#.prefix"=''>
	<cfset "colhash.columns.#colname#.references" = ''>
	<cfset "colhash.columns.#colname#.condition" = ''>
	<cfset "colhash.columns.#colname#.selectrequiredwhen" = ''>
	<cfset "colhash.columns.#colname#.order" = ''>
	<cfset "colhash.columns.#colname#.skipon" = ''>
	<cfset "colhash.columns.#colname#.valueonadd" = ''>
	<cfset "colhash.columns.#colname#.nullvalue" = ''>
	<cfset "colhash.columns.#colname#.link" = ''>
	<cfset "colhash.columns.#colname#.addlink" = ''>
	<cfset "colhash.columns.#colname#.addlevel" = 3>
	<cfset "colhash.columns.#colname#.user" = ''>
	<cfset "colhash.columns.#colname#.value" = ''>
	<cfset "colhash.columns.#colname#.valuetovar" = ''>
	<cfset "colhash.columns.#colname#.validateagainst" = ''>
	<cfset "colhash.columns.#colname#.message" = ''>
	<cfset "colhash.columns.#colname#.visible" = true>
</cfloop>

<cfif IsDefined('ThisTag.AssocAttribs')>
	<cfloop index="x" from="1" to="#ArrayLen(ThisTag.AssocAttribs)#">
		<cfset temper = ThisTag.AssocAttribs[x].column>
		<cfif StructKeyExists(colhash.columns, temper)>
			<cfloop list="group,namefrom,codefrom,increment,input,bindto,bindoptionskey,bindid,yes,no,default,size,limit,restriction,case,cols,rows,prefix,references,condition,selectrequiredwhen,order,skipon,valueonadd,nullvalue,link,addlink,addlevel,user,value,valuetovar,validateagainst,message,visible" index="attrib">
				<cfset "colhash.columns.#temper#.#attrib#" = Evaluate("ThisTag.AssocAttribs[x].#attrib#")>
			</cfloop>
		</cfif>
	</cfloop>
</cfif>

<cfif ListLen(colhash.keys) eq 1 and not IsDefined(colhash.keys)>
	<cfset "#colhash.keys#" = attributes.key>
</cfif>

<cfset localTable=colhash.table>
<cfset keyList=ListChangeDelims(colhash.keys, ', ')>
<cfif colhash.nonkeys eq ''>
	<cfset columnNameList = keyList>
<cfelse>
	<cfset columnNameList = ListAppend(colhash.keys, colhash.nonkeys)>
</cfif>

<cfset tagColumnList = ''>
<cfloop list="#columnNameList#" index="column">
	<cfset tagColumnList = ListAppend(tagColumnList, "#colhash.tag#.#column#")>
</cfloop>
<cfset tagOrderByList = ''>
<cfloop list="#colhash.keys#" index="column">
	<cfset tagOrderByList = ListAppend(tagOrderByList, "#colhash.tag#.#column#")>
</cfloop>

<cfset selectList = ListChangeDelims(tagColumnList, ', ')>
<cfset orderByList = ListChangeDelims(tagOrderByList, ', ')>


<cfif colhash.identity>
	<cfset insertList = colhash.nonkeys>
<cfelse>
	<cfset insertList = "#colhash.keys#,#colhash.nonkeys#">
</cfif>
<cfset thisRedirect = ''>
<cfif attributes.action neq 'view' and attributes.saving eq 1>
	<cfset errors = 0>
	<cfloop list="#insertList#" index="column">
		<cfif Evaluate("colhash.columns.#column#.visible") eq 'true' or (attributes.action eq 'new' and Evaluate("colhash.columns.#column#.visible") neq 'false')>
			<cfif IsDefined("form.#column#")>
				<cfset response=Trim(Evaluate("form.#column#"))>
			<cfelse>
				<cfset response=''>
			</cfif>
			<cfif Evaluate("colhash.columns.#column#.validateagainst") neq '' and IsDefined("form.#Evaluate("colhash.columns.#column#.validateagainst")#")>
				<cfset validationresponse = Evaluate("form.#Evaluate("colhash.columns.#column#.validateagainst")#")>
			<cfelse>
				<cfset validationresponse = ''>
			</cfif>
			<cfif Evaluate("colhash.columns.#column#.input") eq 'checkbox'>
				<cfif response neq 1>
					<cfset response = 0>
				</cfif>
			</cfif>
			<cfif Evaluate("colhash.columns.#column#.req") eq 1 and response eq ''>
				<cfset "colhash.columns.#column#.error" = 'This is a required field.  You must provide a response.'>
				<cfset errors = errors + 1>
			<cfelseif Evaluate("colhash.columns.#column#.input") eq 'date'>
				<cfset responseDay = Evaluate("form.zzyzx_#column#_day")>
				<cfset responseMonth = Evaluate("form.zzyzx_#column#_month")>
				<cfset responseYear = Evaluate("form.zzyzx_#column#_year")>
				<cfif Evaluate("colhash.columns.#column#.req") eq 1 and responseDay eq '' and responseMonth eq '' and responseYear eq ''>
					<cfset "colhash.columns.#column#.error" = 'This is a required field.  You must provide a response.'>
					<cfset errors = errors + 1>
				<cfelseif (responseDay neq '' or responseMonth neq '' or responseYear neq '') and (responseDay eq '' or responseMonth eq '' or responseYear eq '')>
					<cfif Evaluate("colhash.columns.#column#.req") eq 1>
						<cfset "colhash.columns.#column#.error" = 'This is a required field.  You must select a day, month, and year.'>
					<cfelse>
						<cfset "colhash.columns.#column#.error" = 'You must either select a day, month, and year, or nothing at all.'>
					</cfif>
					<cfset errors = errors + 1>
				<cfelseif (responseMonth eq 2 and responseDay gt 29) or ((responseMonth eq 4 or responseMonth eq 6 or responseMonth eq 9 or responseMonth eq 11) and responseDay gt 30)>
					<cfset "colhash.columns.#column#.error" = "That exceeds the number of days in #MonthAsString(responseMonth)#.">
					<cfset errors = errors + 1>
				<cfelseif responseMonth eq 2 and responseDay eq 29 and (responseYear / 4 neq int(responseYear / 4))>
					<cfset "colhash.columns.#column#.error" = "#responseYear# is not a leap year.">
					<cfset errors = errors + 1>
				</cfif>
			<cfelseif Evaluate("colhash.columns.#column#.input") eq 'email' and response neq ''>
				<cfif not REFind('@', response)>
					<cfset "colhash.columns.#column#.error" = "An email address must contain the @ symbol.">
					<cfset errors = errors + 1>
				</cfif>
			<cfelseif Evaluate("colhash.columns.#column#.input") eq 'url' and response neq ''>
				<cfif not REFindNoCase('^https?://', response)>
					<cfset "colhash.columns.#column#.error" = "A URL must begin with ""http://"" or ""https://"".">
					<cfset errors = errors + 1>
				</cfif>
			<cfelseif Evaluate("colhash.columns.#column#.input") eq 'zip' and response neq ''>
				<cfif Len(response) neq 5 and REFind('[^0-9]', response)>
					<cfset "colhash.columns.#column#.error" = "Zip codes must be exactly 5 digits long and may not contain non-numeric characters.">
					<cfset errors = errors + 1>
				<cfelseif Len(response) neq 5>
					<cfset "colhash.columns.#column#.error" = "Zip codes must be exactly 5 digits long.">
					<cfset errors = errors + 1>
				<cfelseif REFind('[^0-9]', response)>
					<cfset "colhash.columns.#column#.error" = "Zip codes may not contain non-numeric characters.">
					<cfset errors = errors + 1>
				<cfelse>
					<cfquery name="validatezip" datasource="#application.dbSrc#">
						select valid, state_id
						from zip
						where zipcode='#response#'
					</cfquery>
					<cfif validatezip.RecordCount eq 0>
						<cfset "colhash.columns.#column#.error" = """#response#"" is not a valid zip code.">
						<cfset errors = errors + 1>
					<cfelse>
						<cfif validatezip.valid eq 0>
							<cfif validationresponse neq ''>
								<cfif validationresponse neq validatezip.state_id>
									<cfset "colhash.columns.#column#.error" = """#response#"" used to be a valid zip code for #validatezip.state_id#, not #validationresponse#, but has since become invalid.">
								<cfelse>
									<cfset "colhash.columns.#column#.error" = """#response#"" used to be a valid zip code for #validationresponse# but has since become invalid.">
								</cfif>
							<cfelse>
								<cfset "colhash.columns.#column#.error" = """#response#"" used to be a valid zip code but has since become invalid.">
							</cfif>
							<cfset errors = errors + 1>
						<cfelseif validationresponse neq '' and validationresponse neq validatezip.state_id>
							<cfset "colhash.columns.#column#.error" = """#response#"" is a valid zip code for #validatezip.state_id#, not #validationresponse#.">
							<cfset errors = errors + 1>
						</cfif>
					</cfif>
				</cfif>
			<cfelseif Evaluate("colhash.columns.#column#.input") eq 'plus4' and response neq ''>
				<cfif Len(response) neq 4 and REFind('[^0-9]', response)>
					<cfset "colhash.columns.#column#.error" = "Plus+4 fields must be exactly 4 digits long and may not contain non-numeric characters.">
					<cfset errors = errors + 1>
				<cfelseif Len(response) neq 4>
					<cfset "colhash.columns.#column#.error" = "Plus+4 fields must be exactly 4 digits long.">
					<cfset errors = errors + 1>
				<cfelseif REFind('[^0-9]', response)>
					<cfset "colhash.columns.#column#.error" = "Plus+4 fields may not contain non-numeric characters.">
					<cfset errors = errors + 1>
				</cfif>
			<cfelseif Evaluate("colhash.columns.#column#.type") eq 'n' and response neq '' and not IsNumeric(response) and Evaluate("colhash.columns.#column#.input") neq 'display'>
				<cfset "colhash.columns.#column#.error" = 'This field requires a numeric response.'>
				<cfset errors = errors + 1>
			<cfelseif Evaluate("colhash.columns.#column#.type") eq 'n' and response neq '' and Evaluate("colhash.columns.#column#.input") eq 'dollar' and (response * 100) neq (int(response * 100))>
				<cfset "colhash.columns.#column#.error" = 'This currency field allows no more than two decimal places.'>
				<cfset errors = errors + 1>
			<cfelseif Evaluate("colhash.columns.#column#.type") eq 's' and Evaluate("colhash.columns.#column#.limit") gt 0 and Len(response) gt Evaluate("colhash.columns.#column#.limit")>
				<cfset "colhash.columns.#column#.error" = "This field is limited to <b>#Evaluate("colhash.columns.#column#.limit")#</b> characters, but is now <b>#Len(response)#</b> characters long.">
				<cfset errors = errors + 1>
			<cfelseif Evaluate("colhash.columns.#column#.type") eq 's' and Evaluate("colhash.columns.#column#.restriction") eq 'alphanumeric' and REFind('[^_\d\w]', response)>
				<cfset "colhash.columns.#column#.error" = "This field allows only letters, numerals, and underscore (_) characters.">
				<cfset errors = errors + 1>
			<cfelseif Evaluate("colhash.columns.#column#.type") eq 's' and Evaluate("colhash.columns.#column#.restriction") eq 'alphanumeric' and REFind('^\d', response)>
				<cfset "colhash.columns.#column#.error" = "This field does not allow strings that begin with a numeral.">
				<cfset errors = errors + 1>
			<cfelseif Evaluate("colhash.columns.#column#.type") eq 's' and Evaluate("colhash.columns.#column#.restriction") eq 'alphanumeric' and (REFind('^_', response) or REFind('_$', response))>
				<cfset "colhash.columns.#column#.error" = "This field does not allow strings that begin or end with an underscore.">
				<cfset errors = errors + 1>
			<cfelseif Evaluate("colhash.columns.#column#.case") eq 'upper' and Compare(response, UCase(response)) neq 0>
				<cfset "colhash.columns.#column#.error" = "This field allows upper-case characters only.">
				<cfset response = UCase(response)>
				<cfset errors = errors + 1>
			<cfelseif Evaluate("colhash.columns.#column#.case") eq 'lower' and Compare(response, LCase(response)) neq 0>
				<cfset "colhash.columns.#column#.error" = "This field allows lower-case characters only.">
				<cfset response = LCase(response)>
				<cfset errors = errors + 1>
			<cfelseif ListFindNoCase(colhash.unique, column) gt 0>
				<cf_buildSqlTerm value="#response#" type="#Evaluate("colhash.columns.#column#.type")#" required="1" comparison="true">
				<cfif attributes.action eq 'edit'>
					<cf_buildSQLTerm var="idterm" value="#Evaluate("form.#colhash.keys#")#" type="#Evaluate("colhash.columns.#colhash.keys#.type")#" required="1" comparison="true" negate="true">
				</cfif>
				<cfquery name="checkunique" datasource="#application.dbSrc#">
					select count(*) c
					from `#localTable#`
					where #column##PreserveSingleQuotes(term)#<cfif attributes.action eq 'edit'>
						and #colhash.keys##PreserveSingleQuotes(idterm)#</cfif>
				</cfquery>
				<cfif checkunique.c gt 0>
					<cfset "colhash.columns.#column#.error" = "This field must be unique, and there is already a row in the table with this value.">
					<cfset errors = errors + 1>
				</cfif>
			</cfif>
			<cfset "form.#column#" = response>
		</cfif>
	</cfloop>
	<cfif errors eq 0>
		<cfif attributes.action eq 'edit'>
			<cfset qry = "update `#localTable#` set">
			<cfset reps = 0>
			<cfloop list="#colhash.nonkeys#" index="column">
				<cfif Evaluate("colhash.columns.#column#.visible") eq 'true' or ((Evaluate("colhash.columns.#column#.input") eq 'date' or Evaluate("colhash.columns.#column#.user") eq 'this') and Evaluate("colhash.columns.#column#.visible") neq 'true' and Evaluate("colhash.columns.#column#.skipon") neq 'edit')>
					<cfif reps gt 0>
						<cfset qry = qry & ','>
					</cfif>
					<cfif Evaluate("colhash.columns.#column#.input") eq 'display'>
						<cfif IsDefined("form.#column#_plus")>
							<cfif IsDefined("form.#column#_minor")>
								<cfif Evaluate("form.#column#_minor") eq 1>
									<cfset minor=true>
								<cfelse>
									<cfset minor=false>
								</cfif>
							<cfelse>
								<cfset minor=false>
							</cfif>
							<cf_displaySave action="edit" display_id="#Evaluate("form.#column#_plus")#" value="#Evaluate("form.#column#")#" minor="#minor#">
							<cf_buildSQLTerm value="#Evaluate("form.#column#_plus")#" type="#Evaluate("colhash.columns.#column#.type")#" required="#Evaluate("colhash.columns.#column#.req")#">
						<cfelse>
							<cf_displaySave action="insert" value="#Evaluate("form.#column#")#" group="#Evaluate("colhash.columns.#column#.group")#" name="#Evaluate("form.#Evaluate("colhash.columns.#column#.namefrom")#")#" code="#Evaluate("form.#Evaluate("colhash.columns.#column#.codefrom")#")#">
							<cf_buildSQLTerm value="#display_id#" type="#Evaluate("colhash.columns.#column#.type")#" required="#Evaluate("colhash.columns.#column#.req")#">
						</cfif>
					<cfelseif Evaluate("colhash.columns.#column#.input") eq 'supersort' and Evaluate("form.#column#") eq -1>
						<cfquery name="getmax" datasource="#application.dbSrc#">
							select max(#column#) as m
							from `#localTable#`
						</cfquery>
						<cfif getmax.m eq ''>
							<cfset supersortValue = 1>
						<cfelse>
							<cfset supersortValue = getmax.m + 1>
						</cfif>
						<cf_buildSQLTerm value="#supersortValue#" type="n" required="#Evaluate("colhash.columns.#column#.req")#">
					<cfelseif Evaluate("colhash.columns.#column#.input") eq 'date' and Evaluate("colhash.columns.#column#.visible") neq 'true' and Evaluate("colhash.columns.#column#.skipon") neq 'edit'>
						<cf_buildSQLTerm type="d" required="#Evaluate("colhash.columns.#column#.req")#">
					<cfelseif Evaluate("colhash.columns.#column#.input") eq 'date' and Evaluate("colhash.columns.#column#.visible") eq 'true'>
						<cfif Evaluate("form.zzyzx_#column#_year") eq ''>
							<cf_buildSQLTerm type="d" required="#Evaluate("colhash.columns.#column#.req")#">
						<cfelse>
							<cf_buildSQLTerm value="#Evaluate("form.zzyzx_#column#_year")#/#Evaluate("form.zzyzx_#column#_month")#/#Evaluate("form.zzyzx_#column#_day")#" type="d" required="#Evaluate("colhash.columns.#column#.req")#">
						</cfif>
					<cfelseif Evaluate("colhash.columns.#column#.user") eq 'this' and Evaluate("colhash.columns.#column#.visible") neq 'true' and Evaluate("colhash.columns.#column#.skipon") neq 'edit'>
						<cf_buildSQLTerm value="#session.user_id#" type="n" required="#Evaluate("colhash.columns.#column#.req")#">
					<cfelse>
						<cf_buildSQLTerm value="#Evaluate("form.#column#")#" type="#Evaluate("colhash.columns.#column#.type")#" required="#Evaluate("colhash.columns.#column#.req")#">
					</cfif>
					<cfset qry = qry & " #column#=#term#">
					<cfset reps = reps + 1>
				</cfif>
			</cfloop>
			<cfset qry = qry & " where">
			<cfset reps = 0>
			<cfloop list="#colhash.keys#" index="column">
				<cfif reps gt 0>
					<cfset qry = qry & ' and'>
				</cfif>
				<cf_buildSQLTerm value="#Evaluate("form.#column#")#" type="#Evaluate("colhash.columns.#column#.type")#" required="#Evaluate("colhash.columns.#column#.req")#" comparison="true">
				<cfset qry = qry & " #column##term#">
				<cfset reps = reps + 1>
			</cfloop>
			<cfset thisRedirect = attributes.redirect>
		<cfelse>
			<cfset qry = "insert into `#localTable#` (" & ListChangeDelims(insertList, ', ') & ') values ('>
			<cfset reps = 0>
			<cfloop list="#insertList#" index="column">
				<cfif reps gt 0>
					<cfset qry = qry & ', '>
				</cfif>
				<cfset doBuild = true>
				<cfif Evaluate("colhash.columns.#column#.skipon") eq 'new'>
					<cfset "form.#column#" = ''>
				<cfelseif Evaluate("colhash.columns.#column#.input") eq 'supersort' and Evaluate("form.#column#") eq -1>
					<cfquery name="getmax" datasource="#application.dbSrc#">
						select max(#column#) as m
						from `#localTable#`
					</cfquery>
					<cfif getmax.m eq ''>
						<cfset "form.#column#" = 1>
					<cfelse>
						<cfset "form.#column#" = getmax.m + 1>
					</cfif>
				<cfelseif Evaluate("colhash.columns.#column#.visible") neq 'true' and Evaluate("colhash.columns.#column#.value") neq ''>
					<cfset "form.#column#" = Evaluate("colhash.columns.#column#.value")>
				<cfelseif Evaluate("colhash.columns.#column#.visible") neq 'true' and Evaluate("colhash.columns.#column#.user") eq 'this'>
					<cfset "form.#column#" = session.user_id>
				<cfelseif Evaluate("colhash.columns.#column#.visible") neq 'true' and Evaluate("colhash.columns.#column#.input") eq 'random'>
					<cfif IsDefined('form.state_id') and form.state_id neq ''>
						<cfset newcode = "#LCase(form.state_id)#_">
					<cfelse>
						<cfset newcode = 'null_'>
					</cfif>
					<cfif IsDefined('form.zipcode') and form.zipcode neq ''>
						<cfset newcode = "#newcode##form.zipcode#_">
					<cfelse>
						<cfset newcode = "#newcode#null_">
					</cfif>
					<cfset randomSrc = 'abcdefghijklmnopqrstuvwxyz0123456789'>
					<cfset randomLen = RandRange(7, 13)>
					<cfloop from="1" to="#randomLen#" index="rrindex">
						<cfset randomPos = RandRange(1, Len(randomSrc))>
						<cfset newcode = newcode & Mid(randomSrc, randomPos, 1)>
					</cfloop>
					<cfset "form.#column#" = newcode>
				<cfelseif Evaluate("colhash.columns.#column#.visible") neq 'true' and Evaluate("colhash.columns.#column#.input") eq 'date'>
					<cfset "form.#column#" = ''>
					<cf_buildSQLTerm type="d" required="#Evaluate("colhash.columns.#column#.req")#">
					<cfset doBuild = false>
				<cfelseif Evaluate("colhash.columns.#column#.input") eq 'date'>
					<cfif Evaluate("form.zzyzx_#column#_year") eq ''>
						<cfset "form.#column#" = ''>
						<cf_buildSQLTerm type="d" required="#Evaluate("colhash.columns.#column#.req")#">
					<cfelse>
						<cfset "form.#column#" = "#Evaluate("form.zzyzx_#column#_year")#/#Evaluate("form.zzyzx_#column#_month")#/#Evaluate("form.zzyzx_#column#_day")#">
						<cf_buildSQLTerm value="#Evaluate("form.zzyzx_#column#_year")#/#Evaluate("form.zzyzx_#column#_month")#/#Evaluate("form.zzyzx_#column#_day")#" type="d" required="#Evaluate("colhash.columns.#column#.req")#">
					</cfif>
					<cfset doBuild = false>
				<cfelseif Evaluate("colhash.columns.#column#.visible") neq 'true' and Evaluate("colhash.columns.#column#.increment") gt 0>
					<cfquery name="getmax" datasource="#application.dbSrc#">
						select max(#column#) as m
						from `#localTable#`
					</cfquery>
					<cfif getmax.m eq ''>
						<cfset "form.#column#" = 1>
					<cfelse>
						<cfset "form.#column#" = getmax.m + Evaluate("colhash.columns.#column#.increment")>
					</cfif>
				<cfelseif Evaluate("colhash.columns.#column#.visible") eq 'false'>
					<cfset "form.#column#" = ''>
				<cfelseif Evaluate("colhash.columns.#column#.input") eq 'display'>
					<cf_displaySave action="insert" value="#Evaluate("form.#column#")#" group="#Evaluate("colhash.columns.#column#.group")#" name="#Evaluate("form.#Evaluate("colhash.columns.#column#.namefrom")#")#" code="#Evaluate("form.#Evaluate("colhash.columns.#column#.codefrom")#")#">
					<cfset "form.#column#" = display_id>
				</cfif>
				<cfif doBuild>
					<cf_buildSQLTerm value="#Evaluate("form.#column#")#" type="#Evaluate("colhash.columns.#column#.type")#" required="#Evaluate("colhash.columns.#column#.req")#">
				</cfif>
				<cfset qry = qry & term>
				<cfset reps = reps + 1>
			</cfloop>
			<cfset qry = qry & ')'>
			<cfset thisRedirect = attributes.redirect>
		</cfif>
		<cfquery name="doquery" datasource="#application.dbSrc#">
			#PreserveSingleQuotes(qry)#
		</cfquery>
		<cfif attributes.action eq 'new'>
			<cfif colhash.unique eq '' and ListLen(colhash.keys) eq 1>
				<cfset qry = "select max(#colhash.keys#) as #colhash.keys# from `#localTable#`">
			<cfelseif colhash.unique eq ''>
				<cfset qry = "select #selectList# from `#localTable#` #colhash.tag#">
			<cfelse>
				<cfset qry = "select #selectList# from `#localTable#` #colhash.tag# where ">
				<cfset reps = 0>
				<cfloop list="#colhash.unique#" index="column">
					<cfif reps gt 0>
						<cfset qry = qry & ' and '>
					</cfif>
					<cf_buildSQLTerm value="#Evaluate("form.#column#")#" type="#Evaluate("colhash.columns.#column#.type")#" required="#Evaluate("colhash.columns.#column#.req")#" comparison="true">
					<cfset qry = qry & "#colhash.tag#.#column##term#">
					<cfset reps = reps + 1>
				</cfloop>
			</cfif>
			<cfquery name="doquery" datasource="#application.dbSrc#">
				#PreserveSingleQuotes(qry)#
			</cfquery>
			<cfquery name="generateLegacyID" datasource="#application.dbSrc#">
				update program set legacy_prg_id = concat('XXX-XXX-' , program_id, '-XX-XX') where legacy_prg_id is null or legacy_prg_id = '';
			</cfquery>
			<cfquery name="generateLegacyID" datasource="#application.dbSrc#">
				select * from program where legacy_prg_id is null or legacy_prg_id = '';
			</cfquery>
			<cfset attributes.key = Evaluate("doquery.#ListGetAt(colhash.keys, 1)#")>
			<cfset "caller.#attributes.newidvar#" = attributes.key>
		</cfif>
		<cfif thisRedirect eq ''>
			<cfset attributes.action = 'view'>
		</cfif>
		<cfset "caller.#attributes.savedvar#" = true>
		<cfif attributes.callonsave neq ''>
			<cfswitch expression="#attributes.callonsave#">
				<cfcase value="updateRuleAssociations">
					<cf_updateRuleAssociations rule_id="#attributes.key#">
				</cfcase>
			</cfswitch>
		</cfif>
		<cfset attributes.saving = 0>
	</cfif>
</cfif>

<cfif attributes.action neq 'new' And attributes.saving eq 0>
	<cfif ListLen(colhash.keys) eq 1>
		<cf_buildSQLTerm value="#attributes.key#" type="#Evaluate("colhash.columns.#colhash.keys#.type")#" required="#Evaluate("colhash.columns.#colhash.keys#.req")#" comparison="true">
		<cfset qryWhere = colhash.keys & term>
	<cfelse>
		<cfset termCount = 0>
		<cfloop list="#Evaluate('colhash.keys')#" index="x">
			<cfset termCount = termCount + 1>
			<cf_buildSQLTerm value="#ListGetAt(attributes.key, termCount)#" type="#Evaluate("colhash.columns.#x#.type")#" required="#Evaluate("colhash.columns.#x#.req")#" comparison="true">
			<cfif termCount eq 1>
				<cfset qryWhere = x & term>
			<cfelse>
				<cfset qryWhere = "#qryWhere# and #x##term#">
			</cfif>
		</cfloop>
	</cfif>
	<cfset qry="select #selectList# from `#localTable#` #colhash.tag# where #qryWhere# order by #orderByList#">
	<cfquery name="getdata" datasource="#application.dbSrc#">
		#PreserveSingleQuotes(qry)#
	</cfquery>
</cfif>

<cfif thisRedirect neq ''>
	<cflocation url="#thisRedirect#" addtoken="no">
<cfelse>

<cfoutput>

<table border="0" cellpadding="3" cellspacing="3">
<cfif attributes.action neq 'view'>
	<cfif Find('?', attributes.actionurl)>
		<cfset ligature = '&'>
	<cfelse>
		<cfset ligature = '?'>
	</cfif>
<form action="#attributes.actionurl##ligature#id=#attributes.key#&action=#attributes.action#" method="post">
</cfif>
<cfif attributes.title neq ''>
	<tr bgcolor="#localdark#">
		<td colspan="2"><font size="+2"><b>#attributes.title#</b></font></td>
	</tr>
</cfif>
<!--- DEBUG QUERY VIEW
<cfif IsDefined('qry')>
	<tr bgcolor="#localdark#">
		<td colspan="2">#qry#</td>
	</tr>
</cfif>
--->
<cfif IsDefined('errors') and errors gt 0>
	<tr bgcolor="#localmed#">
		<td colspan="2"><font size="+1"><b>Correct your errors and try again.</b></font></td>

	<cfoutput> colhash.columns.state_snap_id.error</cfoutput>
	<cfoutput> #colhash.columns.state_snap_id.error#</cfoutput>
	<cfoutput> colhash.columns.state_id.error</cfoutput>
	<cfoutput> #colhash.columns.state_id.error#</cfoutput>
	</tr>
</cfif>
<cfif attributes.action neq 'new'>
<tr bgcolor="#localmed#">
	<td colspan="2"><cfloop list="view,edit" index="act"><cfsilent>
		<cfif Evaluate("attributes.#act#url") neq ''>
			<cfset thisActionURL = Evaluate("attributes.#act#url")>
			<cfif ListLen(colhash.keys) eq 1>
				<cfset thisActionURL = ReplaceNoCase(thisActionURL, '[[id]]', Evaluate("#colhash.keys#"), 'ALL')>
			</cfif>
			<cfloop list="#columnNameList#" index="x">
				<cfset thisActionURL = ReplaceNoCase(thisActionURL, "[[#x#]]", Evaluate("getdata.#x#"), 'ALL')>
			</cfloop>
		<cfelse>
			<cfif ListLen(colhash.keys) gt 1>
				<cfset idFields = ''>
				<cfloop list="#colhash.keys#" index="x">
					<cfset idFields = ListAppend(idFields, "#x#=#Evaluate("#x#")#", '&')>
				</cfloop>
			<cfelse>
				<cfset idFields = "id=#attributes.key#">
			</cfif>
			<cfset thisActionURL = "#attributes.code#view.cfm?#idFields#&action=#act#">
		</cfif>
		</cfsilent><cfif act neq 'view'> | </cfif><cfsilent>
		</cfsilent><cfif act eq attributes.action and not attributes.linkallactions><cfsilent>
			</cfsilent><b>#act#</b><cfsilent>
		</cfsilent><cfelse><cfsilent>
			</cfsilent><cfif Evaluate("attributes.#act#condition") eq '' Or Evaluate(Evaluate("attributes.#act#condition"))><cfsilent>
				</cfsilent><cf_checkAccessLink level="#Evaluate("attributes.#act#level")#" href="#thisActionURL#">#act#</cf_checkAccessLink><cfsilent>
			</cfsilent><cfelse><cfsilent>
				</cfsilent>#act#<cfsilent>
			</cfsilent></cfif><cfsilent>
		</cfsilent></cfif><cfsilent>
	</cfsilent></cfloop><cfsilent>
	<cfset extraCount = 0>
	</cfsilent><cfloop list="#attributes.extraurllist#" index="extra"><cfsilent>
		<cfset extraCount = extraCount + 1>
		</cfsilent> | <cfsilent>
		</cfsilent><cfif extra eq 'null'><b><cfelse><a href="#extra#"></cfif><cfsilent>
		</cfsilent>#ListGetAt(attributes.extranamelist, extraCount)#<cfsilent>
		</cfsilent><cfif extra eq 'null'></b><cfelse></a></cfif><cfsilent>
	</cfsilent></cfloop></td>
</tr>
</cfif>
<cfloop list="#columnNameList#" index="column">
	<cfset displayLimitBox = true>
	<cfif (Evaluate("colhash.columns.#column#.visible") eq 'true' or (attributes.action eq 'view' and Evaluate("colhash.columns.#column#.visible") eq 'viewonly') or (Evaluate("colhash.columns.#column#.visible") eq 'disableonedit' and (Evaluate("colhash.columns.#column#.increment") eq 0 or attributes.action neq 'new'))) and (attributes.action neq 'new' Or Not colhash.identity Or ListFindNoCase(colhash.keys, column) eq 0) and (attributes.action neq 'new' Or Evaluate("colhash.columns.#column#.skipon") neq 'new')>
	<tr>
		<td bgcolor="#localmed#" valign="top"><font size="+1"><b>#Evaluate("colhash.columns.#column#.name")#</b></font><cfif attributes.action neq 'view'><cfif Evaluate("colhash.columns.#column#.addlink") neq '' and Evaluate("colhash.columns.#column#.addlevel") gte session.level>&nbsp;&nbsp;&nbsp;<font size="-1"><em><a href="#Evaluate("colhash.columns.#column#.addlink")#?action=new">new</a></em></font></cfif><cfif Evaluate("colhash.columns.#column#.req") and not ListFind(colhash.keys, column) and Evaluate("colhash.columns.#column#.input") neq 'flag' and (attributes.action eq 'new' or Evaluate("colhash.columns.#column#.visible") neq 'disableonedit')><br /><font size="-2"><i>required</i></font></cfif></cfif></td>
		<cfif attributes.action eq 'view' Or (colhash.identity And ListFindNoCase(colhash.keys, column) gt 0)>
			<cfif attributes.saving eq 1>
				<cfset response = Evaluate("form.#column#")>
			<cfelse>
				<cfset response = Evaluate("getdata.#column#")>
			</cfif>
			<td bgcolor="#locallight#" valign="top"><span><font size="+1"><cfif Evaluate("colhash.columns.#column#.input") eq 'default' and Evaluate("colhash.columns.#column#.bindto") neq ''><!--- START input="default" case ---><cfif Evaluate("colhash.columns.#column#.bindid") neq ''><cfquery name="getbindingdata" datasource="#application.dbSrc#">select #Evaluate("colhash.columns.#column#.bindto")#, #Evaluate("colhash.columns.#column#.bindoptionskey")# from answerfield where answerfield_id=#Evaluate("colhash.columns.#column#.bindid")#</cfquery><cfelse><cfset getbindingdata = QueryNew("#Evaluate("colhash.columns.#column#.bindto")#,#Evaluate("colhash.columns.#column#.bindoptionskey")#")><cfset QueryAddRow(getbindingdata)><cfset QuerySetCell(getbindingdata, Evaluate("colhash.columns.#column#.bindto"), Evaluate("getdata.#Evaluate("colhash.columns.#column#.bindto")#"))><cfset QuerySetCell(getbindingdata, Evaluate("colhash.columns.#column#.bindoptionskey"), Evaluate("getdata.#Evaluate("colhash.columns.#column#.bindoptionskey")#"))></cfif><cfswitch expression="#Evaluate("getbindingdata.#Evaluate("colhash.columns.#column#.bindto")#")#"><cfcase value="5,6,7,8,25"><!--- yes/no's, select lists and gender ---><cf_displayOptionText option_id="#response#">#displayOptionText#</cfcase><cfcase value="18,23,24"><!--- checkboxes ---><cfif response eq '0'>unchecked<cfelseif response eq '1'>checked</cfif></cfcase><cfdefaultcase>#response#</cfdefaultcase></cfswitch><!--- END input="default" case ---><cfelseif Evaluate("colhash.columns.#column#.input") eq 'display'><cf_displayView display_id="#response#">#displayText#<cfelseif Evaluate("colhash.columns.#column#.input") eq 'checkbox'><cfif response eq 1>Yes<cfelse>No</cfif><cfelseif Evaluate("colhash.columns.#column#.input") eq 'select' And Evaluate("colhash.columns.#column#.references") neq '' And Evaluate("colhash.columns.#column#.references") neq 'self'><cf_showForeignKeyValue table="#Evaluate("colhash.columns.#column#.references")#" value="#response#" link="#Evaluate("colhash.columns.#column#.link")#"><cfelseif Evaluate("colhash.columns.#column#.input") eq 'password'>********<cfelseif Evaluate("colhash.columns.#column#.input") eq 'dollar'>#DollarFormat(response)#<cfelseif Evaluate("colhash.columns.#column#.input") eq 'flag'><cfif response eq 1>#Evaluate("colhash.columns.#column#.yes")#<cfelse>#Evaluate("colhash.columns.#column#.no")#</cfif><cfelseif Evaluate("colhash.columns.#column#.input") eq 'date'>#DateFormat(response, 'd mmmm yyyy')#<cfelse><cfif response neq '' And Evaluate("colhash.columns.#column#.input") eq 'image'><img src="http://#application.serverPathBCU#/#response#" /><br /></cfif><cfif response neq '' And Evaluate("colhash.columns.#column#.prefix") neq ''>#Evaluate("colhash.columns.#column#.prefix")#</cfif>#response#</cfif></font></span><cfif attributes.action eq 'edit'><input type="hidden" name="#column#" value="#HTMLEditFormat(response)#"></cfif></td>
			<cfif Evaluate("colhash.columns.#column#.message") neq ''>
				<td style="border: dashed; border-color: #localmed#; border-width: 2px; padding: 7px;" valign="top"<span style="font-size: 11pt; color: black;">#Evaluate("colhash.columns.#column#.message")#</span></td>
			</cfif>
		<cfelseif attributes.action eq 'edit' or attributes.action eq 'new'>
			<cfif attributes.saving eq 1>
				<cfset response = Evaluate("form.#column#")>
			<cfelseif attributes.action eq 'edit'>
				<cfset response = Evaluate("getdata.#column#")>
			<cfelse>
				<cfset response = ''>
			</cfif>
			<cfif Evaluate("colhash.columns.#column#.input") eq 'display' and attributes.action eq 'edit'>
				<cfif attributes.saving eq 1>
					<cfset display_id = Evaluate("form.#column#_plus")>
					<cfif IsDefined("form.#column#_minor")>
						<cfset minorFlag = Evaluate("form.#column#_minor")>
					<cfelse>
						<cfset minorFlag = 0>
					</cfif>
				<cfelse>
					<cfset display_id = response>
					<cf_displayView display_id="#display_id#" var="response" edit="true">
					<cfset minorFlag = 0>
				</cfif>
			<cfelse>
				<cfset display_id = ''>
			</cfif>
			<td bgcolor="#locallight#" valign="top"><cfif Evaluate("colhash.columns.#column#.visible") eq 'disableonedit' and attributes.action eq 'edit'><cfif Evaluate("colhash.columns.#column#.input") eq 'select'><b><cf_showForeignKeyValue table="#Evaluate("colhash.columns.#column#.references")#" value="#response#"></b><cfelseif Evaluate("colhash.columns.#column#.input") eq 'flag'><b><cfif response eq 1>Yes<cfelseif response eq 0>No</cfif></b><cfelse><b>#response#</b></cfif><input type="hidden" name="#column#" value="#HTMLEditFormat(response)#"><!--- START input="default" case ---><cfelseif Evaluate("colhash.columns.#column#.input") eq 'default' and Evaluate("colhash.columns.#column#.bindto") neq ''><cfif Evaluate("colhash.columns.#column#.bindid") neq ''><cfquery name="getbindingdata" datasource="#application.dbSrc#">select #Evaluate("colhash.columns.#column#.bindto")#, #Evaluate("colhash.columns.#column#.bindoptionskey")# from answerfield where answerfield_id=#Evaluate("colhash.columns.#column#.bindid")#</cfquery><cfelse><cfset getbindingdata = QueryNew("#Evaluate("colhash.columns.#column#.bindto")#,#Evaluate("colhash.columns.#column#.bindoptionskey")#")><cfset QueryAddRow(getbindingdata)><cfset QuerySetCell(getbindingdata, Evaluate("colhash.columns.#column#.bindto"), Evaluate("getdata.#Evaluate("colhash.columns.#column#.bindto")#"))><cfset QuerySetCell(getbindingdata, Evaluate("colhash.columns.#column#.bindoptionskey"), Evaluate("getdata.#Evaluate("colhash.columns.#column#.bindoptionskey")#"))></cfif><cfif attributes.saving eq 1><cfset boundResponse = Evaluate("form.#Evaluate("colhash.columns.#column#.bindto")#")><cfset boundOptionsKey = Evaluate("form.#Evaluate("colhash.columns.#column#.bindoptionskey")#")><cfelse><cfset boundResponse = Evaluate("getbindingdata.#Evaluate("colhash.columns.#column#.bindto")#")><cfset boundOptionsKey = Evaluate("getbindingdata.#Evaluate("colhash.columns.#column#.bindoptionskey")#")></cfif><cfset displayLimitBox = false><cfswitch expression="#boundResponse#"><cfcase value="5,6,7,18,23,24,25"><!--- yes/no's, checkboxes and gender ---><input type="radio" name="#column#" value=""> no default<cfif boundResponse neq 25> &nbsp; <input type="radio" name="#column#" value="1"<cfif response eq '1'> checked</cfif>> <cfif ListFind('18,23,24', boundResponse)>checked<cfelse>yes</cfif> &nbsp; <input type="radio" name="#column#" value="0"<cfif response eq '0'> checked</cfif>> <cfif ListFind('18,23,24', boundResponse)>unchecked<cfelse>no</cfif><cfif boundResponse eq 6> &nbsp; <input type="radio" name="#column#" value="1474"<cfif response eq '1474'> checked</cfif>> don't know<cfelseif boundResponse eq 7> &nbsp; <input type="radio" name="#column#" value="1462"<cfif response eq '1462'> checked</cfif>> not sure</cfif><cfelse> &nbsp; <input type="radio" name="#column#" value="2"<cfif response eq '2'> checked</cfif>> male &nbsp; <input type="radio" name="#column#" value="3"<cfif response eq '3'> checked</cfif>> female</cfif></cfcase><cfcase value="8"><!--- select list ---><cf_buildOptionSelect answerfield_id="#boundOptionsKey#" name="#column#" option_id="#response#"></cfcase><cfdefaultcase><cfset displayLimitBox = true><input type="text" name="#column#" value="#HTMLEditFormat(response)#" size="#Evaluate(Evaluate("colhash.columns.#column#.size") - Len(Evaluate("colhash.columns.#column#.prefix")))#"<cfif Evaluate("colhash.columns.#column#.limit") gt 0> maxlength="#Evaluate("colhash.columns.#column#.limit")#"<cfif attributes.action eq 'new' or Evaluate("colhash.columns.#column#.visible") neq 'disableonedit'> onKeyUp="this.form.#column#_charcount.value = #Evaluate("colhash.columns.#column#.limit")# - this.form.#column#.value.length;"</cfif></cfif>></cfdefaultcase></cfswitch><!--- END input="default" case ---><cfelseif Evaluate("colhash.columns.#column#.input") eq 'checkbox'><input type="checkbox" name="#column#" value="1"<cfif response eq 1> checked</cfif>><cfelseif Evaluate("colhash.columns.#column#.input") eq 'select' And Evaluate("colhash.columns.#column#.references") neq ''><cfif Evaluate("colhash.columns.#column#.skipon") eq 'edit'><cf_showForeignKeyValue table="#Evaluate("colhash.columns.#column#.references")#" value="#response#" hidden="#column#" link="#Evaluate("colhash.columns.#column#.link")#" valueonadd="#Evaluate("colhash.columns.#column#.valueonadd")#"><cfelse><cfif Evaluate("colhash.columns.#column#.references") eq 'self'><cf_buildFormSelect name="#column#" table="#attributes.table#" self="true" selected="#response#" required="true"><cfelse><cfif Evaluate("colhash.columns.#column#.selectrequiredwhen") neq ''><cfquery name="selectreq" datasource="#application.dbSrc#">#Evaluate("colhash.columns.#column#.selectrequiredwhen")#</cfquery><cfif selectreq.c gt 0><cfset requireThis = true><cfset nullRow = false><cfelse><cfset requireThis = false><cfset nullRow = true></cfif><cfelse><cfset requireThis = Evaluate("colhash.columns.#column#.req")><cfset nullRow = true></cfif><cf_buildFormSelect name="#column#" table="#Evaluate("colhash.columns.#column#.references")#" condition="#Evaluate("colhash.columns.#column#.condition")#" order="#Evaluate("colhash.columns.#column#.order")#" selected="#response#" required="#requireThis#" nullrow="#nullRow#" nullvalue="#Evaluate("colhash.columns.#column#.nullvalue")#"></cfif></cfif><cfelseif Evaluate("colhash.columns.#column#.input") eq 'textarea' or Evaluate("colhash.columns.#column#.input") eq 'rule' or (Evaluate("colhash.columns.#column#.input") eq 'display' and Evaluate("colhash.columns.#column#.rows") neq 1)><textarea name="#column#" rows="#Evaluate("colhash.columns.#column#.rows")#" cols="#Evaluate("colhash.columns.#column#.cols")#" wrap="virtual"<cfif Evaluate("colhash.columns.#column#.limit") gt 0 and (attributes.action eq 'new' or Evaluate("colhash.columns.#column#.visible") neq 'disableonedit')> onKeyUp="var charcount = #Evaluate("colhash.columns.#column#.limit")# - this.form.#column#.value.length; if (charcount < 0) {this.form.#column#.value = this.form.#column#.value.substring(0, #Evaluate("colhash.columns.#column#.limit")#); charcount = 0;} this.form.#column#_charcount.value = charcount;"</cfif>>#HTMLEditFormat(response)#</textarea><cfif Evaluate("colhash.columns.#column#.input") eq 'rule'><cf_buildRuleControls name="#column#"></cfif><cfelseif Evaluate("colhash.columns.#column#.input") eq 'dollar'><b>$</b>&nbsp;<input type="text" name="#column#" value="<cfif Evaluate("colhash.columns.#column#.error") neq ''>#HTMLEditFormat(response)#<cfelse>#HTMLEditFormat(NumberFormat(response, '9.99'))#</cfif>" size="12"><cfelseif Evaluate("colhash.columns.#column#.input") eq 'flag'><select name="#column#"><cfif not Evaluate("colhash.columns.#column#.req")><option value=""></option></cfif><option value="1"<cfif (attributes.action eq 'new' and Evaluate("colhash.columns.#column#.default") eq 'yes') or (attributes.action eq 'edit' and response eq 1)> selected</cfif>>#Evaluate("colhash.columns.#column#.yes")#</option><option value="0"<cfif (attributes.action eq 'new' and Evaluate("colhash.columns.#column#.default") eq 'no') or (attributes.action eq 'edit' and (response eq 0 or response eq ''))> selected</cfif>>#Evaluate("colhash.columns.#column#.no")#</option></select><cfelseif Evaluate("colhash.columns.#column#.input") eq 'date'><cf_buildDateSelect name="#column#" date="#response#" day="#IIf(IsDefined("form.zzyzx_#column#_day"), Evaluate(DE("form.zzyzx_#column#_day")), DE(''))#" month="#IIf(IsDefined("form.zzyzx_#column#_month"), Evaluate(DE("form.zzyzx_#column#_month")), DE(''))#" year="#IIf(IsDefined("form.zzyzx_#column#_year"), Evaluate(DE("form.zzyzx_#column#_year")), DE(''))#" required="#Evaluate("colhash.columns.#column#.req")#"><cfelseif Evaluate("colhash.columns.#column#.input") eq 'zip'><input type="text" name="#column#" value="#HTMLEditFormat(response)#" size="5" maxlength="5"><cfelseif Evaluate("colhash.columns.#column#.input") eq 'plus4'><input type="text" name="#column#" value="#HTMLEditFormat(response)#" size="4" maxlength="4"><cfelseif Evaluate("colhash.columns.#column#.input") eq 'supersort'><select name="#column#"><option value="<cfif response eq ''>-1<cfelse>#response#</cfif>"<cfif response neq ''> selected</cfif>>YES, include in super sort</option><option value=""<cfif response eq ''> selected</cfif>>NO, do not include in super sort</option></select><cfelse><cfif response neq '' And Evaluate("colhash.columns.#column#.input") eq 'image'><img src="http://#application.serverPathBCU#/#response#" /><br /></cfif><cfif Evaluate("colhash.columns.#column#.prefix") neq ''>#Evaluate("colhash.columns.#column#.prefix")#&nbsp;</cfif><input type="<cfif Evaluate("colhash.columns.#column#.input") eq 'image'>text<cfelse>#Evaluate("colhash.columns.#column#.input")#</cfif>" name="#column#" value="#HTMLEditFormat(response)#" size="#Evaluate(Evaluate("colhash.columns.#column#.size") - Len(Evaluate("colhash.columns.#column#.prefix")))#"<cfif Evaluate("colhash.columns.#column#.limit") gt 0> maxlength="#Evaluate("colhash.columns.#column#.limit")#"<cfif attributes.action eq 'new' or Evaluate("colhash.columns.#column#.visible") neq 'disableonedit'> onKeyUp="this.form.#column#_charcount.value = #Evaluate("colhash.columns.#column#.limit")# - this.form.#column#.value.length;"</cfif></cfif>></cfif><cfif display_id neq ''><br><b>Minor edit?</b> <input type="checkbox" name="#column#_minor" value="1"<cfif minorFlag> checked</cfif>><input type="hidden" name="#column#_plus" value="#display_id#"><cfelseif displayLimitBox and Evaluate("colhash.columns.#column#.limit") gt 0 and (attributes.action eq 'new' or Evaluate("colhash.columns.#column#.visible") neq 'disableonedit')><br /><font size="-2"><i>#Evaluate("colhash.columns.#column#.limit")# character limit &nbsp; <input type="text" name="#column#_charcount" size="3" value="#Evaluate("colhash.columns.#column#.limit - Len(HTMLEditFormat(response))")#" disabled style="font-size: 7pt;" /> remaining</i></font></cfif></td>
			<cfif Evaluate("colhash.columns.#column#.error") neq ''>
				<td style="background: #locallight#; border: dashed; border-color: #localdark#; border-width: 2px; padding: 7px;" valign="top"><span style="font-size: 11pt; color: black; font-weight: bold; font-style: italic;">#Evaluate("colhash.columns.#column#.error")#</span></td>
			</cfif>
		</cfif>
	</tr>
	</cfif>
	<cfif Evaluate("colhash.columns.#column#.valuetovar") neq ''>
		<cfif attributes.saving eq 1>
			<cfset response = Evaluate("form.#column#")>
		<cfelseif attributes.action eq 'new'>
			<cfset response = ''>
		<cfelse>
			<cfset response = Evaluate("getdata.#column#")>
		</cfif>
		<cfset "caller.#Evaluate("colhash.columns.#column#.valuetovar")#" = response>
	</cfif>
</cfloop>
<cfif attributes.action neq 'view'>
<tr>
	<td bgcolor="#localmed#"><input type="hidden" name="saving" value="1"><cfif attributes.name neq ''><input type="hidden" name="name" value="#attributes.name#"></cfif></td>
	<td bgcolor="#locallight#"><input type="submit" value="Save"></td>
</tr>
</form>
</cfif>
</table>

</cfoutput>

</cfif>

</cfif>
