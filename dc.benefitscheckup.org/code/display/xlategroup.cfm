<cfparam name="displaygroup_id" type="numeric">
<cfparam name="language_id" type="string">

<cf_checkAccess level="5">

<cfquery name="getname" datasource="#application.dbSrc#">
	select displaygroup_name
	from displaygroup
	where displaygroup_id = #displaygroup_id#
</cfquery>
<cfset dgname=getname.displaygroup_name>

<cfquery name="getlang" datasource="#application.dbSrc#">
	select dl.display_text
	from language l, display_language dl
	where l.language_id='#language_id#'
		and l.display_id=dl.display_id
		and dl.language_id='EN'
	order by l.default_flag desc, l.active desc, substring(dl.display_text, 1, 255)
</cfquery>
<cfset lname=getlang.display_text>

<cfquery name="translate" datasource="#application.dbSrc#">
	select d.display_id, d.display_name, dl.display_text, ld.display_text as xlate, ld.update_flag
	from display d inner join display_language dl
			on d.display_id = dl.display_id
		left outer join display_language ld
			on d.display_id = ld.display_id and ld.language_id = '#language_id#'
	where d.displaygroup_id = #displaygroup_id# and dl.language_id = 'EN'
	order by d.display_name
</cfquery>


<cf_buildPage title="Site Text Translation" section="display"><cfoutput>

<h3>Site Text Needing Translation</h3>
<h4>Site Text Group: #dgname#<br>Language: #lname#</h4>

<table cellpadding="3" cellspacing="3" border="0">
	<tr bgcolor="#application.color.display.dark#">
		<td align="left" valign="bottom"><b>String Name</b></td>
		<td align="left" valign="bottom"><b>English Version</b></td>
		<td align="left" valign="bottom"><b>#lname# Translation</b></td>
		<td align="left" valign="bottom"><b>Needs?</b></td>
		<td align="left" valign="bottom"><b>Action</b></td>
	</tr>
	<cfloop query="translate">
	<tr bgcolor="#application.color.display.med#">
		<td align="left" valign="top"><b>#display_name#</b></td>
		<td align="left" valign="top">#display_text#</td>
		<td align="left" valign="top"<cfif update_flag eq 1 or update_flag eq ''> bgcolor="#application.color.display.light#"</cfif>>#xlate#</td>
		<cfif update_flag eq 1 or update_flag eq ''>
		<td align="left" valign="top" bgcolor="#application.color.display.light#">Yes</td>
		<cfelse>
		<td align="left" valign="top">No</td>
		</cfif>
		<td align="left" valign="top"<cfif update_flag eq 1 or update_flag eq ''> bgcolor="#application.color.display.light#"</cfif>><cf_checkAccessLink level="4" href="xlate.cfm?displaygroup_id=#displaygroup_id#&display_id=#display_id#&language_id=#language_id#">edit</cf_checkAccessLink></td>
	</tr>
	</cfloop>
</table>

<br>
</cfoutput></cf_buildPage>