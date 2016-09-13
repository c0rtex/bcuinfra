<cfset id=url.id>



<cfset in=''>

<cfif IsDefined('form.name') And trim(form.name) neq '' And (form.tagnew neq 1 Or trim(form.tagline) neq '')>

	<cfset in=form.name>

	<cfset tagnew=form.tagnew>

	<cfset tag_id=form.tag_id>

	<cfset state_id=form.state_id>

	<cfset tagline=form.tagline>

	<cfset class_id=form.class_id>

	<cfset description=form.description>

	<cfif trim(description) eq ''>

		<cfset description = 'NULL'>

	<cfelse>

		<cfset description = "'" & Replace(trim(description), "'", "''", 'ALL') & "'">

	</cfif>

	<cfif tagnew eq 1>

		<cfset tagline = trim(tagline)>

		<cfinclude template="taginsert.cfm">

	</cfif>

	<cfquery name="put" datasource="#application.dbSrc#">

		update form

		set formtag_id = #tag_id#,

			form_name = '#trim(in)#',

			description = #PreserveSingleQuotes(description)#,

			state_id = #PreserveSingleQuotes(state_id)#

		where form_id=#id#

	</cfquery>

	<cflocation url="formview.cfm?id=#id#">

<cfelse>



<cfquery name="get" datasource="#application.dbSrc#">

	select f.form_name, f.description, f.formtag_id, f.state_id, t.tag_name, t.formclass_id

	from form f, formtag t

	where f.form_id=#id#

		and f.formtag_id=t.formtag_id

	order by f.form_name

</cfquery>



<cfif get.recordcount eq 0>

	<cfset name=''>

	<cfset desc=''>

	<cfset tag_id=''>

	<cfset state_id=''>

	<cfset tag=''>

	<cfset class_id=''>

<cfelse>

	<cfset name=get.form_name>

	<cfset desc=get.description>

	<cfset tag_id=get.formtag_id>

	<cfset state_id=get.state_id>

	<cfset tag=get.tag_name>

	<cfset class_id=get.formclass_id>

</cfif>



<cf_formmenu title="Form Edit"><cfoutput>



<table border="0" cellpadding="3" cellspacing="3">

<tr>

	<td bgcolor="#application.color.form.dark#"><font size="+1"><b>#name#</b></font></td>

	<td bgcolor="#application.color.form.med#" valign="top"><a href="formview.cfm?id=#id#">view</a></td>

</tr>

</table><br>





<cfquery name="tag" datasource="#application.dbSrc#">

	select formtag_id, tag_name

	from formtag

	order by tag_name

</cfquery>

<cfquery name="class" datasource="#application.dbSrc#">

	select formclass_id, class_code

	from formclass

	order by class_name

</cfquery>

<!--- Original Query Removed by MH and replaced with the one below
<cfquery name="state" datasource="#application.dbSrc#">
	select st
	from tbl_st
	order by st
</cfquery>--->

<cfquery name="state" datasource="#application.dbSrc#">
	select state_id as st
	from state
    where statetype_id < 3
	order by state_id
</cfquery>




<form action="formedit.cfm?id=#id#" method="post" name="adder">

<table border="0" cellpadding="5" cellspacing="0" bgcolor="#application.color.form.med#">

	<tr>

		<td valign="top" colspan="2"><font size="+1"><b>Name</b></font></td>

		<td colspan="2"><textarea name="name" rows="3" cols="50">#name#</textarea></td>

	</tr>

	<tr>

		<td valign="bottom"><font size="+1"><b>Tag</b></font></td>

		<td valign="bottom" align="right"><b>existing</b></td>

		<td colspan="2"><input type="radio" name="tagnew" value="0" checked>

		<select name="tag_id">

		<cfloop query="tag">

			<option value="#formtag_id#"<cfif formtag_id eq tag_id> selected</cfif>>#tag_name#

		</cfloop>

		</select></td>

	</tr>

	<tr>

		<td valign="top" align="right" colspan="2"><b>new</b></td>

		<td colspan="2"><input type="radio" name="tagnew" value="1">

		<input type="text" name="tagline" value="" size="40">

		<select name="class_id">

		<cfloop query="class">

			<option value="#formclass_id#">#class_code#

		</cfloop>

		</select></td>

	</tr>

	<tr>

		<td valign="top" colspan="2"><font size="+1"><b>State</b></font></td>

		<td><select name="state_id">

			<option value="NULL">all

		<cfloop query="state">

			<option value="'#st#'"<cfif st eq state_id> selected</cfif>>#st#

		</cfloop>

		</select></td>

	</tr>

	<tr>

		<td valign="top" colspan="2"><font size="+1"><b>Description</b></font></td>

		<td colspan="2"><textarea name="description" rows="6" cols="50">#desc#</textarea></td>

	</tr>

	<tr>

		<td colspan="2">&nbsp;</td>

		<td><input type="submit" value="Modify"></td>

</form>

<form action="formview.cfm?id=#id#" method="post">

		<td align="right"><input type="submit" value="Cancel"></td>

</form>

	</tr>

</table><br>



</cfoutput><cfmodule template="../footer.cfm">



</cfif>