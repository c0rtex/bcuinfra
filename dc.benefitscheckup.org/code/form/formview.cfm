<cfset id=url.id>

<cfquery name="get" datasource="#application.dbSrc#">
	select f.form_name, f.description, f.formtag_id, f.state_id, t.tag_name, t.formclass_id, c.class_code
	from form f, formtag t, formclass c
	where f.form_id=#id#
		and f.formtag_id=t.formtag_id
		and t.formclass_id=c.formclass_id
	order by f.form_name
</cfquery>

<cfif get.recordcount eq 0>
	<cfset name=''>
	<cfset desc=''>
	<cfset tag_id=''>
	<cfset state_id=''>
	<cfset tag=''>
	<cfset class_id=''>
	<cfset class=''>
<cfelse>
	<cfset name=get.form_name>
	<cfset desc=get.description>
	<cfset tag_id=get.formtag_id>
	<cfset state_id=get.state_id>
	<cfset tag=get.tag_name>
	<cfset class_id=get.formclass_id>
	<cfset class=get.class_code>
</cfif>

<cf_formmenu title="Form Details">
<cfoutput>

<table border="0" cellpadding="3" cellspacing="3">
<tr>
	<td bgcolor="#application.color.form.dark#"><font size="+1"><b>#name#</b></font></td>
  <cfif session.user_level eq "admin">
	<td bgcolor="#application.color.form.med#" valign="top"><a href="formedit.cfm?id=#id#">edit</a></td>
  <cfelse>
    <td bgcolor="#application.color.form.med#" valign="top">edit</td>
  </cfif>
</tr>
</table><br>
<table border="0" cellpadding="3" cellspacing="3">
<tr>
	<td bgcolor="#application.color.form.med#" align="right" valign="top"><b>class</b></td>
	<td bgcolor="#application.color.form.light#">#class#</td>
</tr>
<tr>
	<td bgcolor="#application.color.form.med#" align="right" valign="top"><b>tag</b></td>
	<td bgcolor="#application.color.form.light#"><a href="formtagview.cfm?id=#tag_id#">#tag#</a></td>
</tr>
<tr>
	<td bgcolor="#application.color.form.med#" align="right" valign="top"><b>state</b></td>
	<td bgcolor="#application.color.form.light#"><cfif state_id eq ''><i>all</i><cfelse>#state_id#</cfif></td>
</tr>
<tr>
	<td bgcolor="#application.color.form.med#" align="right" valign="top"><b>description</b></td>
	<td bgcolor="#application.color.form.light#">#desc#</td>
</tr>
</table><br>



<table border="0" cellpadding="3" cellspacing="3">
<tr bgcolor="#application.color.formtype.dark#">
	<td colspan="7"><font size="+1"><b>Form instances</b></font></td>
</tr>
<cfquery name="type" datasource="#application.dbSrc#">
	select ft.formtype_id, ft.string, ft.active, ft.form_date, ft.form_day_ignore_flag, ft.entry_date, t.type_code
	from form_formtype ft, formtype t
	where form_id=#id#
		and ft.formtype_id=t.formtype_id
	order by ft.formtype_id
</cfquery>
<cfif type.RecordCount gt 0>
	<tr bgcolor="#application.color.formtype.med#">
		<td><b>Type</b></td>
		<td><b>String</b></td>
		<td><b>Status</b></td>
		<td><b>Form&nbsp;Rev.&nbsp;Date</b></td>
		<td><b>Date&nbsp;Entered</b></td>
		<td align="center" colspan="2"><b>Actions</b></td>
	</tr>
<cfloop query="type">
	<tr bgcolor="#application.color.formtype.light#">
		<td>#type_code#</td>
		<td>#string#</td>
		<cfif active eq 1>
		<td>active</td>
		<cfelse>
		<td><i>inactive</i></td>
		</cfif>
		<cfif form_date eq ''>
		<td></td>
		<cfelseif form_day_ignore_flag eq 1>
		<td>#MonthAsString(Month(form_date))# #Year(form_date)#</td>
		<cfelse>
		<td>#MonthAsString(Month(form_date))# #Day(form_date)#, #Year(form_date)#</td>
		</cfif>
		<cfif entry_date eq ''>
		<td></td>
		<cfelse>
		<td>#MonthAsString(Month(entry_date))# #Day(entry_date)#, #Year(entry_date)#</td>
		</cfif>
		<cfif session.user_level eq "admin">
		<td><a href="typeedit.cfm?form_id=#id#&type_id=#formtype_id#">edit&nbsp;instance</a></td>
		<td><a href="typedelete.cfm?form_id=#id#&type_id=#formtype_id#">delete&nbsp;instance</a></td>
		<cfelse>
		<td>edit&nbsp;instance</td>
		<td>delete&nbsp;instance</td>
		</cfif>
	</tr>
</cfloop>
<cfelse>
	<tr bgcolor="#application.color.formtype.light#">
		<td colspan="7"><i>none</i></td>
	</tr>
</cfif>
<cfquery name="availabletype" datasource="#application.dbSrc#">
	SELECT formtype_id, type_code
	FROM formtype
	WHERE formtype_id NOT IN (SELECT formtype_id FROM form_formtype WHERE form_id=#id#)
	ORDER BY formtype_id
</cfquery>
<cfif availabletype.RecordCount gt 0 and session.user_level eq "admin">
	<cfset typecount = 0>
	<form action="typeassociate.cfm" method="post">
	<tr bgcolor="#application.color.formtype.med#">
		<td colspan="7">
			<cfloop query="availabletype">
				<input type="radio" name="type_id" value="#formtype_id#"<cfif typecount eq 0> checked</cfif>> #type_code# &nbsp;
				<cfset typecount = typecount + 1>
			</cfloop>
			<input type="hidden" name="form_id" value="#id#">
			<input type="submit" value="Add instance" style="font-size: 8pt;">
		</td>
	</tr>
	</form>
</cfif>
</table><br>


<cfif session.user_level eq "admin">
<cfquery name="prglist" datasource="#application.dbSrc#">
	SELECT program_id, program_code
	FROM program
	WHERE program_id NOT IN (SELECT program_id FROM program_form WHERE form_id=#id#)
	ORDER BY program_code
</cfquery>
<table border="0" cellpadding="5" cellspacing="0" bgcolor="#application.color.program.med#">
<form action="programassociate.cfm" method="post">
	<tr>
	<td><b>Choose a program from the list:</b></td>
	</tr>
	<tr>
	<td><select name="program_id" width="300">
	<cfloop query="prglist">
		<option value="#program_id#">#HTMLEditFormat(program_code)#</option>
	</cfloop>
	</select></td>
	</tr>
	<tr>
	<td><input type="hidden" name="form_id" value="#id#">
	<input type="submit" value="Associate form with program"></td>
</form>
	</tr>
<table><br>
</cfif>


<table border="0" cellpadding="3" cellspacing="3">
<tr bgcolor="#application.color.program.dark#">
	<td colspan="6"><font size="+1"><b>Associated programs</b></font></td>
</tr>
<cfquery name="mem" datasource="#application.dbSrc#">
	select p.program_id, p.program_code, dl.display_text, p.state_id
	from program_form pf, program p, display_language dl
	where pf.form_id=#id#
		and pf.program_id=p.program_id
		and p.name_display_id=dl.display_id
		and dl.language_id='EN'
	order by p.sort
</cfquery>
<cfif mem.RecordCount gt 0>
	<tr bgcolor="#application.color.program.med#">
		<td><b>ID</b></td>
		<td><b>Code</b></td>
		<td><b>Name</b></td>
		<td><b>State</b></td>
		<td align="center" colspan="2"><b>Actions</b></td>
	</tr>
<cfloop query="mem">
	<tr bgcolor="#application.color.program.light#">
		<td valign="top" align="right">#program_id#</td>
		<td valign="top">#program_code#</td>
		<td valign="top">#display_text#</td>
		<td valign="top">#state_id#</td>
		<td valign="top"><a href="../program/programview.cfm?id=#program_id#">view&nbsp;details</a></td>
	  <cfif session.user_level eq "admin">	
		<td valign="top"><a href="programdelete.cfm?form_id=#id#&program_id=#program_id#">delete&nbsp;association</a></td>
	  <cfelse>
	  	<td valign="top">delete&nbsp;from&nbsp;subset</td>
	  </cfif>
	</tr>
</cfloop>
<cfelse>
	<tr bgcolor="#application.color.program.light#">
		<td colspan="5"><i>none</i></td>
	</tr>
</cfif>
</table>

</cfoutput><cfmodule template="../footer.cfm">