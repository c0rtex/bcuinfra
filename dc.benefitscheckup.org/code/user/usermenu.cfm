<cfparam name="attributes.title" type="string" default="User Administration">

<cfoutput>
<cfmodule template="../header.cfm" title="#attributes.title#">

<br>
<table border="0" cellspacing="0" cellpadding="5">
	<tr>
		<td bgcolor="#application.color.user.dark#"><b>users</b></td>
		<td></td>
	  <cfif session.user_level eq "admin" or session.user_level eq "superuser">
		<td bgcolor="#application.color.user.med#"><a href="userview.cfm?action=new">new</a> | <a href="userlist.cfm">list</a></td>
	  <cfelse>
		<td bgcolor="#application.color.user.med#">new | <a href="userlist.cfm">list</a></td>
	  </cfif>
		<td></td>
		<td></td>
		<td bgcolor="#application.color.usertype.dark#"><b>user types</b></td>
		<td></td>
	  <cfif session.user_level eq "superuser">
		<td bgcolor="#application.color.usertype.med#"><a href="usertypeview.cfm?action=new">new</a> | <a href="usertypelist.cfm">list</a></td>
	  <cfelse>
		<td bgcolor="#application.color.usertype.med#">new | <a href="usertypelist.cfm">list</a></td>
	  </cfif>
</table>

<cfif attributes.title eq 'User Administration'>
	<h1>#attributes.title#</h1>
<cfelse>
	<h2>#attributes.title#</h2>
</cfif>
</cfoutput>