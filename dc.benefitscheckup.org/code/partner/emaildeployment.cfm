<cfquery name="wrapper" datasource="#application.dbsrc#">
	SELECT *
	FROM wrapper w
	LEFT JOIN tbl_partner t ON t.wrapper_id = w.wrapper_id
	WHERE wrapper_deployment_status = 2
	ORDER BY partner_name
</cfquery>

<cfsavecontent variable="bodytext">

<table cellpadding="3" cellspacing="3" border="1">

<tr>
	<td valign="bottom" colspan="9"><table border="0" cellspacing="0" cellpadding="0" width="100%" style="font-size: 8pt; font-family: Verdana, Arial, Helvetica, sans-serif;">
	<tr>
	<cfoutput>
	<td align="left" valign="middle"><font size="+1"><strong>Private Label Deployment List</strong></font><br />
	<strong>#wrapper.recordcount# private label<cfif wrapper.recordcount GT 1>s</cfif> ready for deployment</strong></td>
	</cfoutput>
	</tr>
	</table></td>
</tr>

<tr>
	<td><b>ID</b></td>
	<td><b>Partner Name</b></td>
	<td><b>Wrapper Code</b></td>
	<td><b>Partner Code</b></td>
	<td><b>Create Folders</b></td>
	<td><b>Upload Files</b></td>
	<td><b>Deployed</b></td>
</tr>

<cfoutput query="wrapper">
<tr>
	<td valign="top">#wrapper_id#</td>
	<td valign="top">#partner_name# (#partner_id#)</td>
	<td valign="top">#wrapper_code#</td>
	<td valign="top">#partner_code#</td>
	<td valign="top"><input type="checkbox" /> /#wrapper_code#<br />
	<input type="checkbox" /> /img/partners/#partner_code#</td>	
	<td valign="top"><input type="checkbox" /> /#wrapper_code#/index.cfm<br />
	<input type="checkbox" /> #wrapper_logo#<br />
	<input type="checkbox" /> #wrapper_cover_image#
	</td>
	<td align="center" valign="top"><input type="checkbox" /></td>
</tr>
</cfoutput>
<tr>
	<td valign="top" colspan="9"><strong>Synchronize tbl_partner and wrapper tables</strong></td>
</tr>

</table>
</cfsavecontent>

<cfmail from="dc@benefitscheckup.org" subject="Private Label Deployment List" to="#to#" type="html">
#bodytext#
</cfmail>

<cflocation url="deploymentlist.cfm?emailSent=y&to=#urlencodedformat(to)#">