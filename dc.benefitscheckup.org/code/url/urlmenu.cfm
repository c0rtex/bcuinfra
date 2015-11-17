<cfparam name="attributes.title" type="string" default="URL Administration">

<cfoutput>
<cfmodule template="../header.cfm" title="#attributes.title#">

<br>
<table border="0" cellspacing="0" cellpadding="5">
	<tr>
		<td bgcolor="#application.color.url.dark#"><b>URLs</b></td>
		<td></td>
	  <cfif session.user_level eq "admin">
		<td bgcolor="#application.color.url.med#"><a href="urlnew.cfm">new</a> | <a href="urllist.cfm">list</a></td>
	  <cfelse>
		<td bgcolor="#application.color.url.med#">new | <a href="urllist.cfm">list</a></td>
	  </cfif>
</table>

<cfif attributes.title eq 'URL Administration'>
	<h1>#attributes.title#</h1>
<cfelse>
	<h2>#attributes.title#</h2>
</cfif>
</cfoutput>