<cf_formmenu title="Add Form">

<cfoutput>



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

<cfquery name="state" datasource="#application.dbSrc#">

	select state_id as st

	from state
    where statetype_id < 3

	order by state_id

</cfquery>



<form action="formadd.cfm" method="post" name="adder">

<table border="0" cellpadding="5" cellspacing="0" bgcolor="#application.color.form.med#">

	<tr>

		<td valign="top" colspan="2"><font size="+1"><b>Name</b></font></td>

		<td><input type="text" name="name" size="60" value=""></td>

	</tr>

	<tr>

		<td valign="bottom"><font size="+1"><b>Tag</b></font></td>

		<td valign="bottom" align="right"><b>existing</b></td>

		<td><input type="radio" name="tagnew" value="0" checked>

		<select name="tag_id">

		<cfloop query="tag">

			<option value="#formtag_id#">#tag_name#

		</cfloop>

		</select></td>

	</tr>

	<tr>

		<td valign="top" align="right" colspan="2"><b>new</b></td>

		<td><input type="radio" name="tagnew" value="1">

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

			<option value="'#st#'">#st#

		</cfloop>

		</select></td>

	</tr>

	<tr>

		<td valign="top" colspan="2"><font size="+1"><b>Description</b></font></td>

		<td><textarea name="description" rows="6" cols="47"></textarea></td>

	</tr>

	<tr>

		<td colspan="2">&nbsp;</td>

		<td><input type="submit"></td>

	</tr>

</table>

</form>



</cfoutput><cfmodule template="../footer.cfm">

