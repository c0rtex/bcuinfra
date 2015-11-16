<cfparam name="by" type="string" default="partner_name">
<cfparam name="dir" type="string" default="asc">
<cfparam name="page" type="numeric" default="1">
<cfparam name="rows" type="numeric" default="50">

<cfif by IS NOT 'partner_name'>
	<cfset by2 = ', partner_name'>
<cfelse>
	<cfset by2 = ''>
</cfif>

<cfquery name="wrapper" datasource="#application.dbsrc#">
	SELECT *
	FROM wrapper w
	LEFT JOIN tbl_partner t ON t.wrapper_id = w.wrapper_id
	WHERE wrapper_type = 1
	ORDER BY #by# #dir# #by2#, w.wrapper_id
</cfquery>

<cf_checkAccess level="5">
<cf_buildPage title="Wrapper Administration" section="partner">

<p><a href="deploymentlist.cfm">View Deployment List</a></p>

<table cellpadding="3" cellspacing="3" border="0">

<tr bgcolor="#22737B">
	<td valign="bottom" colspan="10"><table border="0" cellspacing="0" cellpadding="0" width="100%" style="font-size: 8pt; font-family: Verdana, Arial, Helvetica, sans-serif;">
	<tr>
	<cfoutput>
	<td align="left" valign="middle"><strong>1</strong> to <strong>#wrapper.recordcount#</strong> of <strong>#wrapper.recordcount#</strong></td>
	</cfoutput>
	</tr>
	</table></td>
</tr>

<tr bgcolor="#2E99AF">
	<td><a href="pls.cfm?by=w.wrapper_id&dir=asc"><b>Wrapper ID</b></a></td>
	<td><a href="pls.cfm?by=partner_name&dir=asc"><b>Partner Name</b></a></td>
	<td><a href="pls.cfm?by=wrapper_code&dir=asc"><b>Partner Code</b></a></td>
	<td><a href="pls.cfm?by=wrapper_code&dir=asc"><b>Wrapper Code</b></a></td>
	<td><a href="pls.cfm?by=wrapper_code&dir=asc"><b>Partner ID</b></a></td>
	<td><a href="pls.cfm?by=wrapper_partner_id&dir=asc"><b>Wrapper Partner ID</b></a></td>	
	<td><a href="pls.cfm?by=wrapper_status&dir=asc"><b>Status</b></a></td>
	<td><a href="pls.cfm?by=wrapper_status&dir=asc"><b>Deployment Status</b></a></td>
	<td></td>
	<td></td>	

</tr>

<cfoutput query="wrapper" group="wrapper_id">
<tr bgcolor="##21ADCB">
	<td valign="top">#wrapper_id#</td>
	<td valign="top"><cfset pc = ""><cfoutput><cfif pc IS ""><cfset pc = partner_code><cfelse><cfset pc = "#pc#<br>#partner_code#"></cfif><cf_checkAccessLink level="3" href="pl.cfm?wrapper_id=#wrapper_id#&action=edit">#partner_name# (#partner_id#)</cf_checkAccessLink><br />
	</cfoutput></td>
	<td valign="top">#pc#</td>
	<td valign="top">#wrapper_code#</td>
	<td valign="top"><a href="partnerview.cfm?id=#partner_id#">#partner_id#</a></td>
	<td valign="top"><a href="partnerview.cfm?id=#wrapper_partner_id#">#wrapper_partner_id#</a></td>
	<td valign="top"><cfswitch expression="#val(wrapper_status)#">
	<cfcase value="0">Disabled/Hide</cfcase>
	<cfcase value="1">Active</cfcase>
	</cfswitch>
	</td>	
	<td valign="top"><cfswitch expression="#val(wrapper_deployment_status)#">
	<cfcase value="0">Disabled/Hide</cfcase>
	<cfcase value="1">Pending</cfcase>
	<cfcase value="2">Ready for Deployment</cfcase>
	<cfcase value="3">Live</cfcase>
	</cfswitch>
	</td>
	<td align="center" valign="top"><cf_checkAccessLink level="3" href="pl.cfm?wrapper_id=#wrapper_id#&action=edit">edit</cf_checkAccessLink><!--- &nbsp;|&nbsp;<cf_checkAccessLink level="5" href="pl.cfm?wrapper_id=#wrapper_id#&action=view">view</cf_checkAccessLink> ---></td>
	<td align="center" valign="top"><a href="#application.website_url#/#wrapper_code#" target="#wrapper_code#">preview</a></td>

</tr>
</cfoutput>
</table>