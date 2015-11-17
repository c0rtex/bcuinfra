<cfparam name="id" default="0">

<cfswitch expression="#action#">

<cfcase value="edit,addnew" delimiters=",">

	<cfquery name="get" datasource="#application.dbSrc#">

		SELECT *

		FROM programtext

		where programtext_id = #id#

	</cfquery>

<cfoutput>

<table border="0" cellpadding="5" cellspacing="0" bgcolor="#smed#">

<form action="index.cfm?action=#action#_&id=#id#" method="post">

	<!--- <input type="hidden" name="action" value="#action#_">

	<input type="hidden" name="id" value="#id#"> --->

	<tr>

		<td><font size="+1"><b>ID</b></font></td>

		<td colspan="3">#id#</td>

	</tr>

	<tr>

		<td><font size="+1"><b>Program ID </b></font></td>

		<td colspan="3"><input type="text" name="program_id" value="#get.program_id#"></td>

	</tr>
	<tr>
		<td><font size="+1"><b>Active</b></font></td>
		<td colspan="3"><input type="text" name="active" value="#get.active#"></td>
	</tr>

	<tr>

		<td valign="top"><font size="+1"><b>Type</b></font></td>

		<td colspan="3"><input type="text" name="type" value="#get.type#"></td>

		

	</tr>

	<tr>

		<td valign="top"><font size="+1"><b>Benefit</b></font></td>

		<td><input type="text" name="benefit" value="#get.benefit#"></td>

		

	</tr>

	<tr>

		<td valign="top"><font size="+1"><b>Answerfield</b></font></td>

		<td><input type="text" name="answerfield" value="#get.answerfield#"></td>

		

	</tr>

		<tr>

		<td valign="top"><font size="+1"><b>Template</b></font></td>

		<td><input type="text" name="template" value="#get.template#"></td>

		

	</tr>

	</tr>

		<tr>

		<td valign="top"><font size="+1"><b>Sort Order</b></font></td>

		<td><input type="text" name="sortorder" value="#get.sortorder#"></td>

		

	</tr>

	<tr>

		<td valign="top"><font size="+1"><b>Summary Text <br>

		  </b></font></td>

		<td colspan="3"><textarea name="summary" rows="4" cols="47">#HTMLEditFormat(get.summary)#</textarea></td>

	</tr>

	<tr>

		<td valign="top"><font size="+1"><b>Full Text <br>

		  </b></font></td>

		<td colspan="3"><textarea name="rec" rows="6" cols="47">#HTMLEditFormat(get.rec)#</textarea></td>

	</tr>

	<!--- tr>

		<td valign="top"><font size="+1"><b>Actions <br>

		  </b></font></td>

		<td colspan="3"><textarea name="actions" rows="5" cols="47">#HTMLEditFormat(get.actions)#</textarea></td>

	</tr --->

	<tr>

		<td>&nbsp;</td>

		<td><input type="submit" value="Save"></td>

	</tr>

</form>

</table>

</cfoutput>

</cfcase>

<cfcase value="edit_">

	<cfquery name="put" datasource="#application.dbSrc#">

		update programtext

		set program_id = '#program_id#',

			type = '#type#',

			benefit = '#benefit#',

			answerfield = '#answerfield#',

			template = '#template#',

			sortorder = '#sortorder#',

			rec = '#rec#',

			summary = '#summary#',
			
			active = '#active#'
		
			where programtext_id=#id#

	</cfquery>

	<cflocation url="index.cfm">

</cfcase>

<cfcase value="addnew_">

	<cfquery name="put" datasource="#application.dbSrc#">

		INSERT INTO programtext

		(	program_id,

			type,

			benefit,

			answerfield,

			template,

			sortorder,

			rec,

			summary

		
		      

		) VALUES (

			'#program_id#',

			'#type#',

			'#benefit#',

			'#answerfield#',

			'#template#',

			'#sortorder#',

			'#rec#',

			'#summary#'

	
		)

	</cfquery>

	<cflocation url="index.cfm">

</cfcase>

<cfcase value="delete">

	<cfquery name="del" datasource="#application.dbSrc#">

		DELETE FROM programtext

		where programtext_id=#id#

	</cfquery>

	<cflocation url="index.cfm">

</cfcase>

<cfcase value="export"><br><br>



<a href="testxml.cfm" target="new" >Download Export</a><br><br>



</cfcase>

</cfswitch>