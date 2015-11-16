<cfset id=url.id>

<cfif id eq 0>
	<cflocation url="urlview.cfm?id=#id#">
<cfelse>

<cfset in="">
<cfif isdefined('form.code')>
	<cfset in=form.code>
	<cfif Trim(in) neq ''>
		<cfset in = Replace(Trim(in), "'", "''", 'ALL')>
		<cfset link = Replace(Trim(form.link), "'", "''", 'ALL')>
		<cfif Trim(form.text) eq ''>
			<cfset text = 'NULL'>
		<cfelse>
			<cfset text = "'" & Replace(Trim(form.text), "'", "''", 'ALL') & "'">
		</cfif>
		<cfif Trim(form.description) eq ''>
			<cfset description = 'NULL'>
		<cfelse>
			<cfset description = "'" & Replace(Trim(form.description), "'", "''", 'ALL') & "'">
		</cfif>
		<cfquery name="put" datasource="#application.dbSrc#">
			update url
			set url_code = '#PreserveSingleQuotes(in)#',
				protocol_id = #form.pcol#,
				url = '#PreserveSingleQuotes(link)#',
				link_text = #PreserveSingleQuotes(text)#,
				target_flag = #target#,
				url_description = #PreserveSingleQuotes(description)#
			where url_id=#id#
		</cfquery>
		<cflocation url="urlview.cfm?id=#id#">
	<cfelse>
		<cflocation url="urledit.cfm?id=#id#">
	</cfif>
<cfelse>

<cfquery name="get" datasource="#application.dbSrc#">
	SELECT u.url_id, u.url_code, p.protocol_id, u.url, u.link_text, u.target_flag, u.active_flag, u.url_description
	FROM url u LEFT OUTER JOIN protocol p
		ON u.protocol_id=p.protocol_id
	WHERE u.url_id=#id#
</cfquery>
<cfquery name="ptype" datasource="#application.dbSrc#">
	SELECT protocol_id, protocol
	FROM protocol
	ORDER BY protocol_id
</cfquery>

<cfif get.recordcount eq 0>
	<cfset code="">
	<cfset pcol="">
	<cfset link="">
	<cfset text="">
	<cfset target="">
	<cfset description="">
<cfelse>
	<cfset code=get.url_code>
	<cfset pcol=get.protocol_id>
	<cfset link=get.url>
	<cfset text=get.link_text>
	<cfset target=get.target_flag>
	<cfset description=get.url_description>
</cfif>

<cf_urlmenu title="URL Edit"><cfoutput>

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
  <cfif session.user_level eq "admin">
	<td valign="top"><a href="urlview.cfm?id=#url_id#">view</a></td>
  <cfelse>
    <td valign="top">view</td>
  </cfif>
	<td valign="top"><b>edit</b></td>
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

<table border="0" cellpadding="5" cellspacing="0" bgcolor="#application.color.url.med#">
	<tr bgcolor="#application.color.url.dark#">
		<td colspan="4" valign="top"><cfinclude template="urldisclaimer.cfm"></td>
	</tr>
</table><br>

<table border="0" cellpadding="5" cellspacing="0" bgcolor="#application.color.url.med#">
<form action="urledit.cfm?id=#id#" method="post">
	<tr>
		<td><font size="+1"><b>Code</b></font></td>
		<td colspan="3" valign="top"><input type="text" name="code" size="20" value="#HTMLEditFormat(code)#"></td>
	</tr>
	<tr>
		<td valign="top"><font size="+1"><b>URL</b></font></td>
		<td colspan="3" valign="top"><select name="pcol">
		<option value="NULL">(local URL)
		<cfloop query="ptype">
			<option value="#protocol_id#"<cfif protocol_id eq pcol> selected</cfif>>#protocol#://
		</cfloop>
		</select> &nbsp;
		<input type="text" name="link" size="60" value="#HTMLEditFormat(link)#"></td>
	</tr>
	<tr>
		<td valign="top"><font size="+1"><b>Default Link Text<br><i>(optional)</i></b></font></td>
		<td colspan="3" valign="top"><input type="text" name="text" size="75" value="#HTMLEditFormat(text)#"></td>
	</tr>
	<tr>
		<td valign="top"><font size="+1"><b>Open in New Browser?</b></font></td>
		<td colspan="3" valign="top"><select name="target">
			<option value="1"<cfif target eq 1> selected</cfif>>Yes
			<option value="0"<cfif target neq 1> selected</cfif>>No
		</select></td>
	</tr>
	<tr>
		<td valign="top"><font size="+1"><b>Description<br><i>(internal)</i></b></font></td>
		<td colspan="3" valign="top"><textarea name="description" rows="4" cols="47">#HTMLEditFormat(description)#</textarea></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td><input type="submit" value="Modify"></td>
</form>
<form action="urlview.cfm?id=#id#" method="post">
		<td align="right" colspan="2"><input type="submit" value="Cancel"></td>
</form>
	</tr>
</table>

</cfoutput><cfmodule template="../footer.cfm">

</cfif>

</cfif>