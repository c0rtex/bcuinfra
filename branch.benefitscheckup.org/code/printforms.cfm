<cfparam name="codelist" type="string" default="">
<cfparam name="codenum" type="numeric" default="1">
<cfparam name="target" type="string" default="">
<cfparam name="src" type="string" default="">
<cfparam name="sr" type="numeric" default="1">

<!--- Calculate which applications from the previous form get printed --->
<cfif codelist neq ''>
	<cfset session.codelist = codelist>
	<cfloop list="#codelist#" index="code">
		<cfif Find('r-', code) eq 1 And StructKeyExists(form, code) And StructFind(form, code) Neq '0'>
			<cfset session.codelist = ListSetAt(session.codelist, ListFind(session.codelist, code), StructFind(form, code))>
		<cfelseif Not StructKeyExists(form, code) Or StructFind(form, code) eq 0 Or (ListGetAt(code, 1, '-') eq 'fact' And IsDefined('form.merge'))>
			<cfset session.codelist = ListDeleteAt(session.codelist, ListFind(session.codelist, code))>
		<cfelseif Find('form', code) eq 1>
			<cfset session.codelist = ListSetAt(session.codelist, ListFind(session.codelist, code), ListGetAt(session.codelist, ListFind(session.codelist, code)) & '-' & StructFind(form, code))>
		</cfif>
	</cfloop>
	<cfset session.codenum = 1>
<cfelseif codenum gt 0>
	<cfset session.codenum = codenum>
</cfif>

<cfif (Not IsDefined('session.codelist') Or ListLen(session.codelist) Eq 0) And Not IsDefined('form.special') And Not IsDefined ('form.code')>  <!--- IF none v. single v. merged --->

	<cfif IsDefined('form.fact')>
		<cfset thingType = 'Fact Sheets'>
	<cfelse>
		<cfset thingType = 'Application Forms'>
	</cfif>

	<!--- BShunn 2004-09-09  User didn't specify any forms, so show error msg and send him back --->
	<cf_tagHeader refreshurl="frmEForms.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" refreshsec="10">

<cfoutput><table width=100% border="0" align="center" cellpadding="#session.cellpadding#" cellspacing="#session.cellspacing#"></cfoutput>
	<tr>
	<td bgcolor=#FFFFFF colspan=2>
<!--Dynamic Area--><font face="arial" size="4" color="#000000">

<cfoutput><h2>No #thingType# Were Selected</h2>

We're sorry, but no #LCase(thingType)# were selected for printing.  If you are not redirected in 10 seconds, please <a href="frmEForms.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#">click here</a> to go back and choose the #LCase(thingType)# you would like to print.</cfoutput>

</FONT></TD></TR></TABLE>
	
	<cf_tagFooter>

<cfelseif IsDefined('form.single')>  <!--- ELSEIF none v. single v. merged --->
	<cfset frameheight = 100>
	<cfset code = ListGetAt(session.codelist, session.codenum)>
	<cfset codeWord = ListGetAt(code, 1, '-')>
	<cfif codeWord eq 'form'>
		<cfset codeSort = ListGetAt(code, 7, '-')>
		<cfset codeClass = ListGetAt(code, 8, '-')>
		<cfset codeType = ListGetAt(code, 9, '-')>
	</cfif>
	<cfset codeProgram = ListGetAt(code, 2, '-') & '-' & ListGetAt(code, 3, '-') & '-' & ListGetAt(code, 4, '-') & '-' & ListGetAt(code, 5, '-') & '-' & ListGetAt(code, 6, '-')>
	<!---cfquery name="print" datasource="#application.dbSrc#">
		SELECT form_name, form_ext
		FROM tbl_app_forms
		WHERE form_id=#ListGetAt(session.pdfids, session.pdfnum)#
	</cfquery--->
<html>
<head>
<title>BenefitsCheckUp</title>
</head>
<cfoutput>
<frameset frameborder="0" framespacing="0" border="0" rows="#frameheight#,*">
	<frame src="printformcontrol.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#" name="upperframe" marginwidth="0" marginheight="0" scrolling="no" noresize frameborder="0" framespacing="0">
	<cfif codeWord eq 'fact'>
		<frame src="frmDetails.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#&prg_id=#codeProgram#&src=frame" name="lowerframe" marginwidth="0" marginheight="0" scrolling="yes" noresize frameborder="0" framespacing="0">
	<cfelse>
		<cfquery name="codeString" datasource="#application.dbSrc#">
			select p.prg_id, pf.sort, ft.formtype_id, t.formclass_id, ft.string, t.tag_name
			from tbl_prg_all p, program_form pf, form f, form_formtype ft, formtag t
			where p.prg_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#codeProgram#" maxlength="30">
				and p.recid=pf.program_id
				and pf.sort=<cfqueryparam cfsqltype="cf_sql_integer" value="#codeSort#" maxlength="4">
				and pf.form_id=f.form_id
				and (f.state_id is null or f.state_id='#session.st#')
				and f.form_id=ft.form_id
				and ft.formtype_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#codeType#" maxlength="4">
				and ft.active=1
				and f.formtag_id=t.formtag_id
				and t.formclass_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#codeClass#" maxlength="4">
			order by p.prg_id, pf.sort, ft.formtype_id, t.formclass_id
		</cfquery>
		<cfif codeType eq 1>
			<frame src="forms/#codeString.string#" name="lowerframe" marginwidth="0" marginheight="0" scrolling="no" noresize frameborder="0" framespacing="0">
		<cfelse>
			<frame src="printsubmit.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#&code=#codeString.string#&prg_id=#codeProgram#" name="lowerframe" marginwidth="0" marginheight="0" scrolling="yes" noresize frameborder="0" framespacing="0">
		</cfif>
	</cfif>
</frameset>
</cfoutput>
<noframes>
<h3>We're sorry</h3>
</noframes>
</html>
<cfelseif IsDefined('form.fact')>  <!--- ELSEIF none v. single v. merged --->

	<cfset frameheight = 35>
	<cfset factList = ''>
	<cfloop list="#session.codelist#" index="code">
		<cfif Find('fact', code) eq 1>
			<cfset codeProgram = ListGetAt(code, 2, '-') & '-' & ListGetAt(code, 3, '-') & '-' & ListGetAt(code, 4, '-') & '-' & ListGetAt(code, 5, '-') & '-' & ListGetAt(code, 6, '-')>
			<cfset factList = ListAppend(factList, codeProgram)>
		</cfif>
	</cfloop>
	
	
	<cfif ListLen(factList) eq 0> <!--- GENERATE SAFE ERROR PAGE IF NO FACT SHEETS SELECTED --->
	

		<cf_tagHeader refreshurl="frmEForms.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" refreshsec="10">

<cfoutput><table width=100% border="0" align="center" cellpadding="#session.cellpadding#" cellspacing="#session.cellspacing#"></cfoutput>
	<tr>
	<td bgcolor=#FFFFFF colspan=2>
<!--Dynamic Area--><font face="arial" size="4" color="#000000">

<h2>No Fact Sheets Were Selected</h2>

<cfoutput>We're sorry, but no fact sheets were selected for printing.  If you are not redirected in 10 seconds, please <a href="frmEForms.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#">click here</a> to go back and choose the fact sheets you would like to print.</cfoutput>

</FONT></TD></TR></TABLE>
	
		<cf_tagFooter>

	<cfelse>

	<cfset fileout = 'f' & session.cfid & '-' & session.cftoken & '-' & RandRange(100000, 99999999)>
	<cf_screenPrintedReport pdfname="#fileout#" randappend="false" coverpage="false" toc="false" intro="false" addedinfo="false" localprgs="false" pgbreaks="false" prglist="#factList#" orderbyprglist="true">

<html>
<head>
<title>BenefitsCheckUp</title>
</head>
<cfoutput>
<frameset frameborder="0" framespacing="0" border="0" rows="#frameheight#,*">
	<frame src="printfactcontrol.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#" name="upperframe" marginwidth="0" marginheight="0" scrolling="no" noresize frameborder="0" framespacing="0">
	<frame src="pdf/#fileout#.pdf" name="lowerframe" marginwidth="0" marginheight="0" scrolling="no" noresize frameborder="0" framespacing="0">
</frameset>
</cfoutput>
<noframes>
<h3>We're sorry</h3>
</noframes>
</html>

	</cfif>

<cfelseif IsDefined('form.merge')>  <!--- ELSEIF none v. single v. merged --->

	<cfset frameheight = 35>

<html>
<head>
<title>BenefitsCheckUp</title>
</head>
<cfoutput>
<frameset frameborder="0" framespacing="0" border="0" rows="#frameheight#,*">
	<frame src="printmergecontrol.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#" name="upperframe" marginwidth="0" marginheight="0" scrolling="no" noresize frameborder="0" framespacing="0">
	<frame src="printmerge.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#" name="lowerframe" marginwidth="0" marginheight="0" scrolling="no" noresize frameborder="0" framespacing="0">
</frameset>
</cfoutput>
<noframes>
<h3>We're sorry</h3>
</noframes>
</html>

<cfelseif IsDefined('form.special') And IsDefined('form.code')>  <!--- ELSEIF none v. single v. merged --->

<cfset frameheight = 60>
<html>
<head>
<title>BenefitsCheckUp</title>
</head>
<cfoutput>
<frameset frameborder="0" framespacing="0" border="0" rows="#frameheight#,*">
	<frame src="printspecialcontrol.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#&code=#form.code#&target=#target#&src=#src#&sr=#sr#" name="upperframe" marginwidth="0" marginheight="0" scrolling="no" noresize frameborder="0" framespacing="0">
	<frame src="printsubmit.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#&code=#form.code#&includePrgIDs=true" name="lowerframe" marginwidth="0" marginheight="0" scrolling="yes" noresize frameborder="0" framespacing="0">
</frameset>
</cfoutput>
<noframes>
<h3>We're sorry</h3>
</noframes>
</html>

<cfelse>  <!--- ELSE none v. single v. merged --->
<cf_tagHeader refreshurl="printmerge.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" refreshsec="1">
<cfoutput><table width=100% border="0" align="center" cellpadding="#session.cellpadding#" cellspacing="#session.cellspacing#"></cfoutput>
	<tr>
	<td bgcolor=#FFFFFF colspan=2>
<!--Dynamic Area--><font face="arial" size="4" color="#000000">

<h2>Assembling Your Application Forms...</h2>

We are now assembling your selected application forms into one easy-to-print document.  Please wait just a few moments for the form to display.

</FONT></TD></TR></TABLE>

<!--- call footer tag --->
<cf_tagFooter>

</cfif> <!--- END none v. single v. merged --->