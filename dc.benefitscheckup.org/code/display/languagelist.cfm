<cf_checkAccess level="5">
<cfquery name="language" datasource="#application.dbSrc#">
	select l.language_id, substring(dl.display_text, 1, 255) as language_name, l.default_flag, l.active
	from language l, display_language dl, language ll
	where l.display_id=dl.display_id
		and dl.language_id=ll.language_id
		and ll.default_flag=1
	order by l.default_flag desc, l.active desc, language_name, l.language_id
</cfquery>

<cf_buildPage title="Language Administration" section="display"><cfoutput>

<table cellpadding="3" cellspacing="3" border="0">
<tr bgcolor="#application.color.language.med#">
	<td><b>ID</b></td>
	<td><b>Name</b></td>
	<td><b>Default</b></td>
	<td><b>Active</b></td>
	<td colspan="3" align="center"><b>Actions</b></td>
</tr>
<cfloop query="language">
<tr bgcolor="#application.color.language.light#">
	<td valign="top">#language_id#</td>
	<td valign="top">#language_name#</td>
	<td valign="top" align="center"><cfif default_flag><b>X</b></cfif></td>
	<td valign="top" align="center"><cfif active><b>X</b></cfif></td>
	<td valign="top" align="center"><cf_checkAccessLink level="5" href="languageview.cfm?id=#language_id#">view</cf_checkAccessLink></td>
  <cfif Not default_flag>
	<td valign="top" align="center"><cf_checkAccessLink level="1" href="languageview.cfm?id=#language_id#&action=edit">edit</cf_checkAccessLink></td>
	<td valign="top" align="center"><cf_checkAccessLink level="2" href="languageactivate.cfm?language_id=#language_id#&active=#Evaluate('1 - active')#"><cfif active>de</cfif>activate</cf_checkAccessLink></td>
  <cfelse>
    <td valign="top" align="center"><i>edit</i></td>
    <td valign="top" align="center"><i><cfif active>de</cfif>activate</i></td>
  </cfif>
</tr>
</cfloop>
</table>

</cfoutput></cf_buildPage>