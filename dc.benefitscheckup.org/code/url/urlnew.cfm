<cfif IsDefined('form.code')>
	<cfset code=Trim(form.code)>
	<cfset pcol=form.pcol>
	<cfset link=Trim(form.link)>
	<cfset text=Trim(form.text)>
	<cfset target=form.target>
	<cfset description=Trim(form.description)>
<cfelse>
	<cfset code=''>
	<cfset pcol=''>
	<cfset link=''>
	<cfset text=''>
	<cfset target=''>
	<cfset description=''>
</cfif>

<cfif IsDefined('form.code') And code neq ''>
	<cfset code = Replace(Trim(code), "'", "''", 'ALL')>
	<cfset link = Replace(Trim(link), "'", "''", 'ALL')>
	<cfif Trim(text) eq ''>
		<cfset text = 'NULL'>
	<cfelse>
		<cfset text = "'" & Replace(Trim(text), "'", "''", 'ALL') & "'">
	</cfif>
	<cfif Trim(description) eq ''>
		<cfset description = 'NULL'>
	<cfelse>
		<cfset description = "'" & Replace(Trim(description), "'", "''", 'ALL') & "'">
	</cfif>
	<cfquery name="put" datasource="#application.dbSrc#">
		INSERT INTO url
			(url_code, protocol_id, url, link_text, target_flag, active_flag, url_description)
		VALUES
			('#PreserveSingleQuotes(code)#', #pcol#, '#PreserveSingleQuotes(link)#', #PreserveSingleQuotes(text)#, #target#, 1, #PreserveSingleQuotes(description)#)
	</cfquery>
	<cfquery name="newid" datasource="#application.dbSrc#">
		select max(url_id) AS maxid
		from url
	</cfquery>
	<cflocation url="urlview.cfm?id=#newid.maxid#">
<cfelse>


<cf_buildPage title="URL Administration" section="url">
<cfoutput>

<cfquery name="ptype" datasource="#application.dbSrc#">
	SELECT protocol_id, protocol
	FROM protocol
	ORDER BY protocol_id
</cfquery>

<table border="0" cellpadding="5" cellspacing="0" bgcolor="#application.color.url.med#">
	<tr bgcolor="#application.color.url.dark#">
		<td colspan="4" valign="top"><cfinclude template="urldisclaimer.cfm"></td>
	</tr>
</table><br>

<table border="0" cellpadding="5" cellspacing="0" bgcolor="#application.color.url.med#">
<form action="urlnew.cfm" method="post">
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
		<td align="right" colspan="2"><cfinclude template="../cancel.cfm"></td>
</form>
	</tr>
</table>

</cfoutput>
</cf_buildPage>


</cfif>