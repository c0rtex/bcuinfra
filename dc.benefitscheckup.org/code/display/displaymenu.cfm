<cfparam name="attributes.title" type="string" default="Display Text Administration">

<cfoutput>
<cfmodule template="../header.cfm" title="#attributes.title#">

<br>
<table border="0" cellspacing="0" cellpadding="5">
	<tr>
		<td bgcolor="#application.color.display.dark#"><b>site text</b></td>
		<td></td>
		<td bgcolor="#application.color.display.med#"><cf_checkAccessLink level="1" href="displayview.cfm?action=new">new</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="displaylist.cfm">list</cf_checkAccessLink></td>
		<td></td>
		<td></td>
		<td bgcolor="#application.color.displaygroup.dark#"><b>site text group</b></td>
		<td></td>
		<td bgcolor="#application.color.displaygroup.med#"><cf_checkAccessLink level="1" href="displaygroupview.cfm?action=new">new</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="displaygrouplist.cfm">list</cf_checkAccessLink></td>
		<td></td>
		<td></td>
		<td bgcolor="#application.color.language.dark#"><b>languages</b></td>
		<td></td>
		<td bgcolor="#application.color.language.med#"><cf_checkAccessLink level="1" href="languagenew.cfm">new</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="languagelist.cfm">list</cf_checkAccessLink></td>
</table>

<cfif attributes.title eq 'Display Text Administration'>
	<h1>#attributes.title#</h1>
<cfelse>
	<h2>#attributes.title#</h2>
</cfif>
</cfoutput>