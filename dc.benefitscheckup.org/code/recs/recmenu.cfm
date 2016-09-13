<cfparam name="attributes.title" type="string" default="Recommendation Administration">

<cfset sdark="##ff9900">
<cfset smed="##ffcc66">
<cfset slight="##ffe099">
<cfset mdark="##B48866">
<cfset mmed="##DDB89A">
<cfset mlight="##F0D0B7">
<cfset ddark="##ffaaaa">
<cfset dmed="##ffcccc">
<cfset dlight="##ffe2e2">
<cfset gdark="##aaffaa">
<cfset gmed="##ccffcc">
<cfset glight="##e2ffe2">
<cfset pdark="##aaaaff">
<cfset pmed="##ccccff">
<cfset plight="##e2e2ff">
<cfset cdark="##ff66ff">
<cfset cmed="##ff99ff">
<cfset clight="##ffccff">
<cfset rdark="##ffff00">
<cfset rmed="##ffff99">
<cfset rlight="##ffffcc">
<cfset pagecolor="##ffffff">
<cfset homecolor="##dddddd">

<cfoutput>
<!--- <cfmodule template="../header.cfm" pagecolor="#pagecolor#"> --->

<br>
<table border="0" cellspacing="0" cellpadding="5">
	<tr>
		<td bgcolor="#sdark#"><b>Recommendations</b></td>
	  <cfif session.user_level eq "admin">
		<td bgcolor="#smed#"><a href="index.cfm?action=list">List</a></td>
		<td bgcolor="#smed#"><a href="index.cfm?action=addnew">New</a></td>
		<td bgcolor="#smed#"><a href="index.cfm?action=export">Export</a></td>
	  <cfelse>
		<td bgcolor="#smed#">&nbsp;</td>
	  </cfif>

  </table>


</cfoutput>

<cfset caller.sdark=sdark>
<cfset caller.smed=smed>
<cfset caller.slight=slight>
<cfset caller.mdark=mdark>
<cfset caller.mmed=mmed>
<cfset caller.mlight=mlight>
<cfset caller.ddark=ddark>
<cfset caller.dmed=dmed>
<cfset caller.dlight=dlight>
<cfset caller.gdark=gdark>
<cfset caller.gmed=gmed>
<cfset caller.glight=glight>
<cfset caller.pdark=pdark>
<cfset caller.pmed=pmed>
<cfset caller.plight=plight>
<cfset caller.cdark=cdark>
<cfset caller.cmed=cmed>
<cfset caller.clight=clight>
<cfset caller.rdark=rdark>
<cfset caller.rmed=rmed>
<cfset caller.rlight=rlight>
<cfset caller.pagecolor=pagecolor>
<cfset caller.homecolor=homecolor>
