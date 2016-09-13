<cfparam name="displaygroup_id" type="numeric">
<cfparam name="display_id" type="numeric">
<cfparam name="language_id" type="string">

<cfparam name="translation" type="string" default="">
<cfparam name="incomplete" type="numeric" default="0">
<cfparam name="saving" type="numeric" default="0">

<cf_checkAccess level="4">

<cfset xlateError = ''>
<cfset errors = 0>
<cfif saving eq 1>

	<cfset translation=Trim(translation)>
	<cfif translation eq '' and incomplete eq 0>
		<cfset xlateError = 'You cannot save a blank translation without marking the "Incomplete?" checkbox.'>
		<cfset errors = errors + 1>
	</cfif>
	
	<cfif errors eq 0>
		<cfquery name="savestring" datasource="#application.dbSrc#">
			update display_language
			set display_text='#translation#',
				update_flag=#incomplete#
			where display_id=#display_id# and language_id='#language_id#'
		</cfquery>
		<cflocation url="programxlategroup.cfm?displaygroup_id=#displaygroup_id#&language_id=#language_id#">
		<cfabort>
	</cfif>

</cfif>

<cfquery name="getname" datasource="#application.dbSrc#">
	select displaygroup_name
	from displaygroup
	where displaygroup_id=#displaygroup_id#
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
			on d.display_id=dl.display_id
		left outer join display_language ld
			on d.display_id=ld.display_id and ld.language_id='#language_id#'
	where d.display_id=#display_id#
		and d.displaygroup_id=#displaygroup_id#
		and dl.language_id='EN'
</cfquery>

<cfif saving eq 1>
	<cfset xlatestring = translation>
<cfelse>
	<cfset xlatestring = translate.xlate>
</cfif>


<cf_buildPage title="Program Text Translation" section="program"><cfoutput>

<h3>Program Text Translation</h3>
<h4>Program Text Group: <cf_checkAccessLink level="5" href="programxlategroup.cfm?displaygroup_id=#displaygroup_id#&language_id=#language_id#">#dgname#</cf_checkAccessLink><br>Language: #lname#<br>String Name: "#translate.display_name#"</h4>

<!--- If entry doesn't exist, create it before editing --->
<cfif translate.update_flag eq ''>
	<cfquery name="getlang" datasource="#application.dbSrc#">
		insert into display_language
			(display_id, language_id, display_text, update_flag)
		values
			(#display_id#, '#language_id#', '', 1)
	</cfquery>
</cfif>

<table cellpadding="3" cellspacing="3" border="0">
	<form action="programxlate.cfm?displaygroup_id=#displaygroup_id#&display_id=#display_id#&language_id=#language_id#" method="post">
	<tr bgcolor="#application.color.program.dark#">
		<td align="left" colspan="2" valign="top"><font size="-1"><b><i>The English version of the text string is provided below only for your convenience while translating,<br>in case you need to copy and paste HTML code into the #lname# translation.  Changes made to the<br>English version here will have no effect.  Only your #lname# translation will be saved.</i></b></font></td>
	</tr>
	<tr bgcolor="#application.color.program.med#">
		<td align="left" valign="top"><b>English Version</b></td>
		<td align="left" valign="top" bgcolor="#application.color.program.light#"><textarea name="garbage" rows="6" cols="66" wrap="virtual">#HTMLEditFormat(translate.display_text)#</textarea></td>
	</tr>
	<tr bgcolor="#application.color.program.med#">
		<td align="left" valign="top"><b>#lname# Translation</b></td>
		<td align="left" valign="top" bgcolor="#application.color.program.light#"><textarea name="translation" rows="6" cols="66" wrap="virtual">#HTMLEditFormat(xlatestring)#</textarea></td>
		<cfif xlateError neq ''>
		<td align="left" valign="top" bgcolor="#application.color.program.dark#"><span style="color: #application.color.program.light#;"><i>#xlateError#</i></span></td>
		</cfif>
	</tr>
	<tr bgcolor="#application.color.program.med#">
		<td align="left" valign="top"><b>Incomplete?</b></td>
		<td align="left" valign="top" bgcolor="#application.color.program.light#"><input type="checkbox" name="incomplete" value="1"<cfif incomplete> checked</cfif>>&nbsp;&nbsp;<font size="-1"><i>Please check this box if you want to save your translation while it's not yet finished.</i></font></td>
	</tr>
	<tr bgcolor="#application.color.program.med#">
		<td align="left" valign="top">&nbsp;</td>
		<td align="left" valign="top" bgcolor="#application.color.program.light#"><input type="submit" value="Save Translation"> &nbsp; <input type="reset" value="Reset"> &nbsp; <input type="hidden" name="saving" value="1"></td>
	</tr>
	</form>
</table>

<br>
</cfoutput></cf_buildPage>