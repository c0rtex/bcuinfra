<cfquery name="programtext" datasource="#application.dbSrc#">

SELECT     *

FROM         programtext

</cfquery>



<cfoutput>

<table cellpadding="3" cellspacing="3" border="0">

<tr bgcolor="#smed#">

	<td><b>ID</b></td>

	<td><b>Summary</b></td>

	<td><b>Recommendation</b></td>

	<td><b>Program ID</b></td>

	<td><b>Type</b></td>

	<td><b>Benefit</b></td>

	<td><b>Anwerfield</b></td>

	<td><b>Template</b></td>

	<!--- td><b>Rec Act</b></td --->
	<td><b>Active</b></td>
<td colspan="4" align="center"><b>Actions</b></td>

</tr>

<cfloop query="programtext">

<tr bgcolor="#slight#">

	<td valign="top">#programtext_id#</td>

	<td valign="top">#Summary#</td>

	<td valign="top">#rec#</td>

	<td valign="top">#program_id#</td>

	<td valign="top">#type#</td>

	<td valign="top">#benefit#</td>

	<td valign="top">#answerfield#</td>

	<td valign="top">#template#</td>

	<!--- td valign="top">#actions#</td --->
	<td valign="top">#active#</td>
  <cfif session.user_level eq "admin">

	<td valign="top"><a href="index.cfm?action=edit&id=#programtext_id#">modify</a></td>

	<td valign="top"><!--- a href="index.cfm?action=delete&id=#programtext_id#" --->delete<!--- /a ---></td>

  <cfelse>

    <td valign="top">modify</td>

	<td valign="top">delete</td>

  </cfif>

	

</tr>

</cfloop>

</table>

</cfoutput>



