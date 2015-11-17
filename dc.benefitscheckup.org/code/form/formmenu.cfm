<cfparam name="attributes.title" type="string" default="Form Administration">
<cfset dir = ''>

<cfoutput>
<cfmodule template="../header.cfm" title="#attributes.title#">

<br>
<table border="0" cellspacing="0" cellpadding="5">
	<tr>
		<td bgcolor="#application.color.form.dark#"><b>forms</b></td>
		<td></td>
		<td bgcolor="#application.color.form.med#"><cf_checkAccessLink level="3" href="#dir#formnew.cfm">new</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#formlist.cfm">list</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#formsearch.cfm">search</cf_checkAccessLink> | <cf_checkAccessLink level="2" href="#dir#formdeactivateall.cfm">deactivate all eforms</cf_checkAccessLink></td>
		<td></td>
		<td></td>
		<td bgcolor="#application.color.formtag.dark#"><b>form tags</b></td>
		<td></td>
		<td bgcolor="#application.color.formtag.med#"><cf_checkAccessLink level="3" href="#dir#formtagview.cfm?action=new">new</cf_checkAccessLink> | <cf_checkAccessLink level="3" href="#dir#formtaglist.cfm">list</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#formtagsearch.cfm">search</cf_checkAccessLink></td>
	</tr>
</table>

<cfif attributes.title eq 'Form Administration'>
	<h1>#attributes.title#</h1>
<cfelse>
	<h2>#attributes.title#</h2>
</cfif>
</cfoutput>