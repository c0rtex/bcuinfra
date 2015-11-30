<HTML>
<HEAD>
	<TITLE></TITLE>
	<script language="JavaScript" src="ValidationFunctions.js"></script>
	<script language="JavaScript">
	<!--
		function checkLowerFrame(thisForm) {
			if (window.parent.lowerframe.frames.length == 0) {
				if (confirm('WARNING: If you leave this e-Form without having completed it and chosen to "Review and Print" it, any responses you entered here will not be carried over to the next e-Form you access.  Are you sure you want to continue?')) {
					thisForm.submit();
				}
			} else {
				thisForm.submit();
			}
		}
	// -->
	</script>
</HEAD>

	<cfset code = ListGetAt(session.codelist, session.codenum)>
	<cfset codeWord = ListGetAt(code, 1, '-')>
	<cfif codeWord eq 'form'>
		<cfset codeSort = ListGetAt(code, 7, '-')>
		<cfset codeClass = ListGetAt(code, 8, '-')>
		<cfset codeType = ListGetAt(code, 9, '-')>
	</cfif>
	<cfset codeProgram = ListGetAt(code, 2, '-') & '-' & ListGetAt(code, 3, '-') & '-' & ListGetAt(code, 4, '-') & '-' & ListGetAt(code, 5, '-') & '-' & ListGetAt(code, 6, '-')>
	<cfif codeWord eq 'fact'>
		<cfquery name="codeString" datasource="#application.dbSrc#">
			select p.prg_nm
			from tbl_prg_all p
			where p.prg_id = '#codeProgram#'
		</cfquery>
		<cfset formClass = 'Fact Sheet'>
	<cfelse>
		<cfquery name="codeString" datasource="#application.dbSrc#">
			select p.prg_nm, t.tag_name
			from tbl_prg_all p, program_form pf, form f, form_formtype ft, formtag t
			where p.prg_id = '#codeProgram#'
				and p.recid=pf.program_id
				and pf.sort=#codeSort#
				and pf.form_id=f.form_id
				and (f.state_id is null or f.state_id='#session.st#')
				and f.form_id=ft.form_id
				and ft.formtype_id=#codeType#
				and ft.active=1
				and f.formtag_id=t.formtag_id
				and t.formclass_id=#codeClass#
			order by p.prg_id, pf.sort, ft.formtype_id, t.formclass_id
		</cfquery>
		<cfif codeClass eq 1>
			<cfif codeType eq 2>
				<cfset formClass = 'Electronic ' & codeString.tag_name>
			<cfelse>
				<cfset formClass = 'Downloadable ' & codeString.tag_name>
			</cfif>
		<cfelse>
			<cfset formClass = codeString.tag_name>
		</cfif>
	</cfif>
	<cfset progName = codeString.prg_nm>
	<cfif Find(' (', progName) gt 1>
		<cfset progName = Left(progName, Find(' (', progName) - 1)>
	</cfif>
	<cfset progName = Trim(progName)>
	<cfset badStr = '<sup><font size=-1>SM</font></sup>'>
	<cfset bLen = Len(badStr)>
	<cfset pos = Find(badStr, progName)>
	<cfif pos gt 1>
		<cfset progName = Left(progName, pos - 1)>
	</cfif>

<body 
	<cfif True>
		bgcolor="#00594b"
	<cfelseif session.partner_id eq 7>
		bgcolor="#999966"
	<cfelseif IsDefined('session.cobrand_bgcolor') and session.cobrand_bgcolor neq '' and session.cobrand_bgcolor neq 0>
		bgcolor="<cfoutput>#session.cobrand_bgcolor#</cfoutput>"
	<cfelse>
		bgcolor="#00594b"
	</cfif>
>
	<cfoutput>

	<table border="0" cellspacing="0" cellpadding="0" width="100%">
		<tr>
			
			<td valign="top" align="left">

	<table border="0" cellspacing="0" cellpadding="5">
		<tr>
			
			<td valign="top" align="center" width="30%">
			<cfif session.codenum gt 1>
	<cfset pcode = ListGetAt(session.codelist, session.codenum - 1)>
	<cfset pcodeWord = ListGetAt(pcode, 1, '-')>
	<cfif pcodeWord eq 'form'>
		<cfset pcodeSort = ListGetAt(pcode, 7, '-')>
		<cfset pcodeClass = ListGetAt(pcode, 8, '-')>
		<cfset pcodeType = ListGetAt(pcode, 9, '-')>
	</cfif>
	<cfset pcodeProgram = ListGetAt(pcode, 2, '-') & '-' & ListGetAt(pcode, 3, '-') & '-' & ListGetAt(pcode, 4, '-') & '-' & ListGetAt(pcode, 5, '-') & '-' & ListGetAt(pcode, 6, '-')>
	<cfif pcodeWord eq 'fact'>
		<cfquery name="codeString" datasource="#application.dbSrc#">
			select p.prg_nm
			from tbl_prg_all p
			where p.prg_id = '#pcodeProgram#'
		</cfquery>
		<cfset pformClass = 'Fact Sheet'>
	<cfelse>
		<cfquery name="codeString" datasource="#application.dbSrc#">
			select p.prg_nm, t.tag_name
			from tbl_prg_all p, program_form pf, form f, form_formtype ft, formtag t
			where p.prg_id = '#pcodeProgram#'
				and p.recid=pf.program_id
				and pf.sort=#pcodeSort#
				and pf.form_id=f.form_id
				and (f.state_id is null or f.state_id='#session.st#')
				and f.form_id=ft.form_id
				and ft.formtype_id=#pcodeType#
				and ft.active=1
				and f.formtag_id=t.formtag_id
				and t.formclass_id=#pcodeClass#
			order by p.prg_id, pf.sort, ft.formtype_id, t.formclass_id
		</cfquery>
		<cfif pcodeClass eq 1>
			<cfif pcodeType eq 2>
				<cfset pformClass = 'Electronic ' & codeString.tag_name>
			<cfelse>
				<cfset pformClass = 'Downloadable ' & codeString.tag_name>
			</cfif>
		<cfelse>
			<cfset pformClass = codeString.tag_name>
		</cfif>
	</cfif>
	<cfset pprogName = codeString.prg_nm>
	<cfif Find(' (', pprogName) gt 1>
		<cfset pprogName = Left(pprogName, Find(' (', pprogName) - 1)>
	</cfif>
	<cfset ppos = Find(badStr, pprogName)>
	<cfif ppos gt 1>
		<cfset pprogName = Left(pprogName, ppos - 1)>
	</cfif>
	<cfset pprogName = Trim(pprogName)>
			<form action="printforms.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" method="post" target="_parent">
				<input type="hidden" name="codenum" value="#Evaluate("session.codenum - 1")#">
				<cfif codeWord eq 'form' And codeType eq 2>
				<input type="hidden" name="single" value="Previous Item">
				<input type="button" value="Previous Item" onClick="checkLowerFrame(this.form);"><br>
				<cfelse>
				<input type="submit" name="single" value="Previous Item"><br>
				</cfif>
				<img src="images/pixel.gif" width="1" height="3" alt=""><br>
				<textarea name="prevframe" cols="30" rows="3" width="150" height="40" style="width: 150; font-family: Arial, Helvetica, Verdana, sans-serif; font-size: 9pt;" wrap="virtual">Go back to the #pformClass# for #pprogName#.</textarea>
			</form>
			<cfelse>
			<form action="frmEForms.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" method="post" target="_parent">
				<input type="submit" name="prev" value="[at first item]"><br>
				<img src="images/pixel.gif" width="1" height="3" alt=""><br>
				<textarea name="prevframe" cols="30" rows="3" width="150" height="40" style="width: 150; font-family: Arial, Helvetica, Verdana, sans-serif; font-size: 9pt;" wrap="virtual">You are at the first item on your task list.  Click this button to return to the main Application Guide page.</textarea>
			</form>
			</cfif>
			</td>
			
			<td valign="top" align="center" width="30%">
				<form>
				<cfif codeWord eq 'form' And codeType eq 2>
					<input type="button" value="[at e-form]">
				<cfelse>
					<input type="button" value="Print This Item" onClick="parent.lowerframe.focus(); parent.lowerframe.print();"><br>
				</cfif>
				<img src="images/pixel.gif" width="1" height="3" alt=""><br>
				<textarea name="printframe" cols="30" rows="3" width="200" height="40" style="width: 200; font-family: Arial, Helvetica, Verdana, sans-serif; font-size: 10pt;" wrap="virtual">This is the #formClass# for #progName#.</textarea>
			</form>
			</td>
			
			<td valign="top" align="center" width="30%">
			<cfif session.codenum lt ListLen(session.codelist)>
	<cfset ncode = ListGetAt(session.codelist, session.codenum + 1)>
	<cfset ncodeWord = ListGetAt(ncode, 1, '-')>
	<cfif ncodeWord eq 'form'>
		<cfset ncodeSort = ListGetAt(ncode, 7, '-')>
		<cfset ncodeClass = ListGetAt(ncode, 8, '-')>
		<cfset ncodeType = ListGetAt(ncode, 9, '-')>
	</cfif>
	<cfset ncodeProgram = ListGetAt(ncode, 2, '-') & '-' & ListGetAt(ncode, 3, '-') & '-' & ListGetAt(ncode, 4, '-') & '-' & ListGetAt(ncode, 5, '-') & '-' & ListGetAt(ncode, 6, '-')>
	<cfif ncodeWord eq 'fact'>
		<cfquery name="codeString" datasource="#application.dbSrc#">
			select p.prg_nm
			from tbl_prg_all p
			where p.prg_id = '#ncodeProgram#'
		</cfquery>
		<cfset nformClass = 'Fact Sheet'>
	<cfelse>
		<cfquery name="codeString" datasource="#application.dbSrc#">
			select p.prg_nm, t.tag_name
			from tbl_prg_all p, program_form pf, form f, form_formtype ft, formtag t
			where p.prg_id = '#ncodeProgram#'
				and p.recid=pf.program_id
				and pf.sort=#ncodeSort#
				and pf.form_id=f.form_id
				and (f.state_id is null or f.state_id='#session.st#')
				and f.form_id=ft.form_id
				and ft.formtype_id=#ncodeType#
				and ft.active=1
				and f.formtag_id=t.formtag_id
				and t.formclass_id=#ncodeClass#
			order by p.prg_id, pf.sort, ft.formtype_id, t.formclass_id
		</cfquery>
		<cfif ncodeClass eq 1>
			<cfif ncodeType eq 2>
				<cfset nformClass = 'Electronic ' & codeString.tag_name>
			<cfelse>
				<cfset nformClass = 'Downloadable ' & codeString.tag_name>
			</cfif>
		<cfelse>
			<cfset nformClass = codeString.tag_name>
		</cfif>
	</cfif>
	<cfset nprogName = codeString.prg_nm>
	<cfif Find(' (', nprogName) gt 1>
		<cfset nprogName = Left(nprogName, Find(' (', nprogName) - 1)>
	</cfif>
	<cfset npos = Find(badStr, nprogName)>
	<cfif npos gt 1>
		<cfset nprogName = Left(nprogName, npos - 1)>
	</cfif>
	<cfset nprogName = Trim(nprogName)>
			<form action="printforms.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" method="post" target="_parent">
				<input type="hidden" name="codenum" value="#Evaluate("session.codenum + 1")#">
				<cfif codeWord eq 'form' And codeType eq 2>
				<input type="hidden" name="single" value="Next Item">
				<input type="button" value="Next Item" onClick="checkLowerFrame(this.form);"><br>
				<cfelse>
				<input type="submit" name="single" value="Next Item"><br>
				</cfif>
				<img src="images/pixel.gif" width="1" height="3" alt=""><br>
				<textarea name="nextframe" cols="30" rows="3" width="150" height="40" style="width: 150; font-family: Arial, Helvetica, Verdana, sans-serif; font-size: 9pt;" wrap="virtual">Continue to the #nformClass# for #nprogName#.</textarea>
			</form>
			<cfelse>
			<form action="frmEForms.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" method="post" target="_parent">
				<input type="submit" name="prev" value="[at last item]"><br>
				<img src="images/pixel.gif" width="1" height="3" alt=""><br>
				<textarea name="prevframe" cols="30" rows="3" width="150" height="40" style="width: 150; font-family: Arial, Helvetica, Verdana, sans-serif; font-size: 9pt;" wrap="virtual">You are at the last item on your task list.  Click this button to return to the main Application Guide page.</textarea>
			</form>
			</cfif>
			</td>

			<td valign="top" align="left" width="10%">
					<input type="button" name="facthelp" value="Help" onClick="help2('hlpEFormsFrame.cfm')">
			</td>
		</tr>
	</table>
	
			</td>
			<td valign="top" align="right">

	<table border="0" cellspacing="0" cellpadding="5">
		<tr>
		<cfif application.debug And codeWord eq 'form' And codeType eq 2>
			<cfquery name="codeStringer" datasource="#application.dbSrc#">
				select ft.string
				from tbl_prg_all p, program_form pf, form f, form_formtype ft, formtag t
				where p.prg_id = '#codeProgram#'
					and p.recid=pf.program_id
					and pf.sort=#codeSort#
					and pf.form_id=f.form_id
					and (f.state_id is null or f.state_id='#session.st#')
					and f.form_id=ft.form_id
					and ft.formtype_id=2
					and ft.active=1
					and f.formtag_id=t.formtag_id
					and t.formclass_id=#codeClass#
				order by p.prg_id, pf.sort, ft.formtype_id, t.formclass_id
			</cfquery>
			<td valign="top" align="right">
				<form action="xml.cfm" method="post" name="eform" target="_blank">
				<cf_genAssistGuideXML code="#codeStringer.string#" prg_id="#codeProgram#">
				<input type="hidden" name="#codeStringer.string#" value="include">
				<input type="hidden" name="startxml" value="#startAssistGuideXML#">
				<input type="hidden" name="endxml" value="#endAssistGuideXML#">
				<input type="hidden" name="xml" value="">
				<input type="button" value="XML" onClick="document.eform.xml.value = document.eform.startxml.value; for (x = 0; x < document.eform.elements.length; x++) {if (document.eform.elements[x].type == 'hidden' && document.eform.elements[x].value == 'include') {document.eform.xml.value = document.eform.xml.value + '<Form>' + document.eform.elements[x].name + '</Form>\n';}} document.eform.xml.value = document.eform.xml.value + document.eform.endxml.value; document.eform.submit();">
				</form>
			</td>
		</cfif>
			<td valign="top" align="right">
			<form action="frmEForms.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" method="post" target="_parent">
				<cfif codeWord eq 'form' And codeType eq 2>
				<input type="button" value="Application Guide" onClick="checkLowerFrame(this.form);"><br>
				<img src="images/pixel.gif" width="1" height="5" alt=""><br>
				<span style="background: ##ffffff; font-family: Arial, Helvetica, Verdana, sans-serif; font-size: 10pt;">
					<a href="javascript:help2('http://www.assistguide.com/ncoaprivacy')">Privacy&nbsp;Policy</a></span>&nbsp;
				<cfelse>
				<input type="submit" value="Application Guide"><br>
				</cfif>
			</form>
			</td>
		</tr>
	</table>
		
			</td>
			
		</tr>
	</table>

</cfoutput>

</body>
</html>
