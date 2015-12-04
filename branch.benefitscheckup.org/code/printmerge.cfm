<cfset mergeList = ''>
<cfloop list="#session.codelist#" index="code">
	<cfset codeWord = ListGetAt(code, 1, '-')>
	<cfif codeWord eq 'form'>
		<cfset codeProgram = ListGetAt(code, 2, '-') & '-' & ListGetAt(code, 3, '-') & '-' & ListGetAt(code, 4, '-') & '-' & ListGetAt(code, 5, '-') & '-' & ListGetAt(code, 6, '-')>
		<cfset codeSort = ListGetAt(code, 7, '-')>
		<cfset codeClass = ListGetAt(code, 8, '-')>
		<cfset codeType = ListGetAt(code, 9, '-')>
		<cfquery name="getstring" datasource="#application.dbSrc#">
			select ft.string
			from tbl_prg_all p, program_form pf, form f, form_formtype ft, formtag t
			where p.prg_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#codeProgram#" maxlength="30">
				and p.recid=pf.program_id
				and pf.sort=<cfqueryparam cfsqltype="cf_sql_integer" value="#codeSort#" maxlength="4">
				and pf.form_id=f.form_id
				and (f.state_id is null or f.state_id='#session.st#')
				and f.form_id=ft.form_id
				and ft.formtype_id=1
				and ft.active=1
				and f.formtag_id=t.formtag_id
				and t.formclass_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#codeClass#" maxlength="4">
		</cfquery>
		<cfif getstring.RecordCount eq 1>
			<cfset mergeList = ListAppend(mergeList, getstring.string)>
		</cfif>
	</cfif>
</cfloop>

<cfset cmd = ''>
<cfloop list="#mergeList#" index="pdf">
	<cfset cmd = cmd & session.strFormPath & pdf & ' '>
</cfloop>

<cfif cmd neq ''>
	<cfset fileout = 'm' & session.cfid & '-' & session.cftoken & '-' & RandRange(100000, 99999999) & '.pdf'>
	<cfset cmd = cmd & 'cat output ' & session.strPDFPath & fileout>
	<CFEXECUTE NAME="#session.pdftkExecutionPath#" arguments="#cmd#" timeout="99999"></CFEXECUTE>
</cfif>

<cf_tagHeader refreshurl="pdf/#fileout#" refreshsec="2">

<cfoutput><table width=100% border="0" align="center" cellpadding="#session.cellpadding#" cellspacing="#session.cellspacing#"></cfoutput>
	<tr>
	<td bgcolor=#FFFFFF colspan=2>
<!--Dynamic Area--><font face="arial" size="4" color="#000000">


<h2>Preparing Your Application Forms to Display...</h2>

<cfoutput>We are now preparing your selected application forms to display.  If the document does not come up automatically within 10 seconds, please <a href="pdf/#fileout#">click here</a>.</cfoutput>


</FONT></TD></TR></TABLE>

<!--- call footer tag --->
<cf_tagFooter>
