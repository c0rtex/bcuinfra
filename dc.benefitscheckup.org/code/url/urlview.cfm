<cfset id=url.id>

<cfquery name="get" datasource="#application.dbSrc#">
	SELECT u.url_id, u.url_code, p.protocol, u.url, u.link_text, u.target_flag, u.active_flag, u.url_description
	FROM url u LEFT OUTER JOIN protocol p
		ON u.protocol_id=p.protocol_id
	WHERE u.url_id=#id#
</cfquery>
<cfif get.recordcount eq 0>
	<cfset code="">
	<cfset protocol="">
	<cfset link="">
	<cfset text="">
	<cfset target="">
	<cfset active="">
	<cfset description="">
<cfelse>
	<cfset code=get.url_code>
	<cfset protocol=get.protocol>
	<cfset link=get.url>
	<cfset text=get.link_text>
	<cfset target=get.target_flag>
	<cfset active=get.active_flag>
	<cfset description=get.url_description>
</cfif>
<cfif protocol eq ''>
	<cfset fulllink = link>
<cfelse>
	<cfset fulllink = protocol & '://' & link>
</cfif>

<cf_urlmenu title="URL View"><cfoutput>

<table cellpadding="3" cellspacing="3" border="0">
<tr bgcolor="#application.color.url.med#">
	<td><b>ID</b></td>
	<td><b>Code</b></td>
	<td colspan="3" align="center"><b>Actions</b></td>
</tr>
<cfloop query="get">
<cfif active_flag eq 0>
<tr bgcolor="#application.color.url.med#">
<cfelse>
<tr bgcolor="#application.color.url.light#">
</cfif>
	<td valign="top">#url_id#</td>
	<td valign="top">#url_code#</td>
	<td valign="top"><b>view</b></td>
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
</table><br>

<table border="0" cellpadding="3" cellspacing="3">
<tr>
	<td bgcolor="#application.color.url.dark#" valign="top"><font size="+1"><b>Code</b></font></td>
	<td bgcolor="#application.color.url.med#" valign="top"><font size="+1">#code#</font></td>
</tr>
<tr>
	<td bgcolor="#application.color.url.dark#" valign="top"><font size="+1"><b>Protocol</b></font></td>
	<td bgcolor="#application.color.url.med#" valign="top"><font size="+1"><cfif protocol eq ''><i>(local URL)</i><cfelse>#protocol#</cfif></font></td>
</tr>
<tr>
	<td bgcolor="#application.color.url.dark#" valign="top"><font size="+1"><b>URL</b></font></td>
	<td bgcolor="#application.color.url.med#" valign="top"><font size="+1">#fulllink#</font></td>
</tr>
<tr>
	<td bgcolor="#application.color.url.dark#" valign="top"><font size="+1"><b>Link Text</b></font></td>
	<td bgcolor="#application.color.url.med#" valign="top"><font size="+1">#text#</font></td>
</tr>
<tr>
	<td bgcolor="#application.color.url.dark#" valign="top"><font size="+1"><b>Opens in New Broswer?</b></font></td>
	<td bgcolor="#application.color.url.med#" valign="top"><font size="+1"><cfif target eq 1>Yes<cfelse>No</cfif></font></td>
</tr>
<tr>
	<td bgcolor="#application.color.url.dark#" valign="top"><font size="+1"><b>Active?</b></font></td>
	<td bgcolor="#application.color.url.med#" valign="top"><font size="+1"><cfif active eq 1>Yes<cfelse>No</cfif></font></td>
</tr>
<tr>
	<td bgcolor="#application.color.url.dark#" valign="top"><font size="+1"><b>Internal Description</b></font></td>
	<td bgcolor="#application.color.url.med#" valign="top"><font size="+1">#description#</font></td>
</tr>
</table>

<a name="alturl"></a>
<cf_buildList title="Alternate Partner URLs" table="alt_url_partner" code="alturlpartner" condition="aup.url_id=#id#" delete="true" order="partner_id" selflink="true" anchor="alturl" addlink="alturlpartnerview.cfm?new_url_id=#id#&action=new">
	<cf_buildListProperty column="url_id" visible="false">
	<cf_buildListProperty column="partner_id" references="tbl_partner">
	<cf_buildListProperty column="alt_url_id" references="url">
</cf_buildList><br>

</cfoutput><cfmodule template="../footer.cfm">
