<cfquery name="wrapper" datasource="#application.dbsrc#">
	SELECT *
	FROM wrapper w
	LEFT JOIN tbl_partner t ON t.wrapper_id = w.wrapper_id
	WHERE wrapper_deployment_status = 2
	ORDER BY partner_name
</cfquery>

<cf_checkAccess level="5">

<cf_buildPage title="Wrapper Administration" section="partner">


<table cellpadding="3" cellspacing="3" border="0">

<tr bgcolor="#22737B">
	<td valign="bottom" colspan="9"><table border="0" cellspacing="0" cellpadding="0" width="100%" style="font-size: 8pt; font-family: Verdana, Arial, Helvetica, sans-serif;">
	<tr>
	<cfoutput>
	<td align="left" valign="middle"><font size="+1"><strong>Private Label Deployment List</strong></font><br />
	
	<strong>#wrapper.recordcount# private label<cfif wrapper.recordcount GT 1>s</cfif> ready for deployment</strong></td>
	</cfoutput>
	</tr>
	</table></td>
</tr>

<tr bgcolor="#2E99AF">
	<td><b>ID</b></td>
	<td><b>Partner Name</b></td>
	<td><b>Wrapper Code</b></td>
	<td><b>Partner Code</b></td>
	<td><b>Upload Instructions</b></td>
	<td></td>
	<td></td>	
	<td></td>		

</tr>

<cfoutput query="wrapper">
<tr bgcolor="##21ADCB">
	<td valign="top">#wrapper_id#</td>
	<td valign="top">#partner_name# (#partner_id#)</td>
	<td valign="top">#wrapper_code#</td>
	<td valign="top">#partner_code#</td>
	<td valign="top">FOLDERS:<br />
	NEW:<br />
	/BCU/#wrapper_code#<br />
	/BCU/img/partners/#partner_code#
	<p>
	FILES:<br />
	NEW:<br />
	/BCU/#wrapper_code#/index.cfm<br />

	<cfif trim(wrapper_logo) IS NOT "">
		/BCU#wrapper_logo#<br />
	</cfif>

	<cfif trim(wrapper_cover_image) IS NOT "">
		/BCU#wrapper_cover_image#

	</cfif>
	<p>
	DATABASE:<br />
	TABLES:<br />
	Sync wrapper table
	
	
	</td>	

	<td align="center" valign="top"><a href="#website_url#/#wrapper_code#" target="#wrapper_code#">preview</a> </td>
	<td align="center" valign="top"><a href="pl.cfm?wrapper_id=#wrapper_id#&action=edit">edit</a></td>
	<td align="center" valign="top"><a href="deployed.cfm?wrapper_id=#wrapper_id#">site deployed</a></td>
</tr>
</cfoutput>

<tr bgcolor="#21ADCB">
	<td valign="top" colspan="9"><strong>Synchronize tbl_partner and wrapper tables</strong></td>
</tr>

</table>

<cfparam name="emailSent" default="">
<cfparam name="to" default="">
<form action="emaildeployment.cfm" method="post">
<strong>Email Deployment List:</strong><br />
<input type="text" size="50" name="to" /> <input type="submit" value="Send" >
<cfif emailSent IS 'y'><br />
<cfoutput>
<b>Email Sent to #to#</b>
</cfoutput>
</cfif>
</form>