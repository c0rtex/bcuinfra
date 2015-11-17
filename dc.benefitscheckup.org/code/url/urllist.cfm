<cfquery name="urls" datasource="#application.dbSrc#">
	SELECT u.url_id, u.url_code, p.protocol, u.url, u.link_text, u.target_flag, u.active_flag, u.url_description
	FROM url u LEFT OUTER JOIN protocol p
		ON u.protocol_id=p.protocol_id
	ORDER BY u.url, p.protocol, u.url_code, u.link_text
</cfquery>

<cf_urlmenu><cfoutput>

<table cellpadding="3" cellspacing="3" border="0">
<tr bgcolor="#application.color.url.med#">
	<td><b>ID</b></td>
	<td><b>Code</b></td>
	<td><b>Protocol</b></td>
	<td><b>URL</b></td>
	<td><b>Link Text</b></td>
	<td><b>New Browser?</b></td>
	<td><b>Active?</b></td>
	<td><b>Description</b></td>
	<td colspan="3" align="center"><b>Actions</b></td>
</tr>
<cfloop query="urls">
<cfif active_flag eq 0>
<tr bgcolor="#application.color.url.med#">
<cfelse>
<tr bgcolor="#application.color.url.light#">
</cfif>
	<td valign="top">#url_id#</td>
	<td valign="top">#url_code#</td>
	<td valign="top"><cfif protocol eq ''><i>(local)</i><cfelse>#protocol#</cfif></td>
	<td valign="top">#url#</td>
	<td valign="top">#link_text#</td>
	<td valign="top" align="center"><cfif target_flag eq 1>Yes</cfif></td>
	<td valign="top" align="center"><cfif active_flag eq 1>Yes</cfif></td>
	<td valign="top">#url_description#</td>
	<td valign="top"><a href="urlview.cfm?id=#url_id#">view</a></td>
  <cfif session.user_level eq "admin">
	<td valign="top"><a href="urledit.cfm?id=#url_id#">edit</a></td>
  <cfelse>
    <td valign="top">edit</td>
  </cfif>
  <cfif active_flag eq 0>
	<cfif session.user_level neq 'admin'>
		<td valign="top"><font color="#application.color.url.med#"><i>reactivate</i></font></td>
	<cfelse>
		<td valign="top"><a href="urlactivate.cfm?url_id=#url_id#"><i>reactivate</i></a></td>
	</cfif>
  <cfelse>
	<cfif session.user_level neq 'admin'>
		<td valign="top"><font color="#application.color.url.light#">deactivate</font></td>
	<cfelse>
		<td valign="top"><a href="urldelete.cfm?id=#url_id#">deactivate</a></td>
	</cfif>
  </cfif>
</tr>
</cfloop>
</table>

</cfoutput><cfmodule template="../footer.cfm">
