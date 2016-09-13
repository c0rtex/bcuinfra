<cfparam name="id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">
<cfparam name="continue" default="">

<cfparam name="error1" default="">
<cfparam name="error2" default="">
<cfparam name="error3" default="">
<cfparam name="error4" default="">
<cfparam name="errors" default="">

<cfif saving IS 1>

	<cfif trim(wrapper_code) IS "">
		<cfset error1 = 1>
		<cfset errors = 1>
	</cfif>

	<cfif trim(wrapper_code) IS NOT trim(wrapper_old_code)>
		<cfif DirectoryExists("#website_path#/#wrapper_code#") IS NOT 0>
			<cfset error2 = 1>
			<cfset errors = 1>
		</cfif>
	</cfif>

	<cfif trim(wrapper_title) IS "">
		<cfset error3 = 1>
		<cfset errors = 1>
	</cfif>
	
	<cfif errors IS "">
		
		<cfif trim(wrapper_code) IS NOT trim(wrapper_old_code)>
			<cffile action="move" source="#website_path#/#wrapper_old_code#/index.cfm" destination="#website_path#/#wrapper_code#/index.cfm">
		</cfif>
		
		<cfquery name="wrapper" datasource="#application.dbsrc#">
			UPDATE wrapper 
			SET 
			wrapper_code = '#wrapper_code#',
			wrapper_description = '#wrapper_description#',
			wrapper_title = '#wrapper_title#',
			wrapper_status = #val(wrapper_status)#,	
			wrapper_deployment_status = #val(wrapper_deployment_status)#
		
			WHERE wrapper_id = #wrapper_id#
		</cfquery>
		
		<cfif continue IS 'Save and Continue to Step 3'>
			<cflocation url="plnew3.cfm?partner_id=#partner_id#&wrapper_id=#wrapper_id#">
		</cfif>
		
	</cfif>

</cfif>

<cfquery name="wrapper" datasource="#application.dbsrc#">
	SELECT *
	FROM wrapper w
	LEFT JOIN tbl_partner t ON t.wrapper_id = w.wrapper_id
	WHERE w.wrapper_id = #wrapper_id#
</cfquery>



<cfif action eq 'view'>
	<cf_checkAccess level="5">
<cfelse>
	<cf_checkAccess level="3">
</cfif>
<cf_buildPage title="Wrapper Administration" section="partner">

<cfoutput query="wrapper">

<cfif errors IS 1>
	<font color="##FF0000">
	<strong>There were errors in the form below:</strong><br>
	<cfif error1 IS 1>
		&##8226; "Website Mapping" may not be left blank<br>
	</cfif>
	
	<cfif error2 IS 1>
		&##8226; New "Website Mapping" is taken.  Please select a different mapping.<br>
	</cfif>

	<cfif error3 IS 1>
		&##8226; "Page Title" may not be left blank<br>
	</cfif>
	</font>
</cfif>

<table border="0" cellpadding="3" cellspacing="3">

<form action="plnew2b.cfm?saving=1&partner_id=#partner_id#" method="post" enctype="multipart/form-data">
<input type="hidden" name="wrapper_id" value="#wrapper_id#">

	<tr bgcolor="##22737B">
		<td colspan="2"><font size="+2"><b>Private Label - Basic Options</b></font></td>
	</tr>

<tr bgcolor="##22737B">
		<td colspan="2"><font size="+2"><b>New Private Label</b></font></td>
	</tr>
	
	<tr bgcolor="##2E99AF">
		<td colspan="2"><strong>Step 2: Basic Information | <a href="#website_url#/#wrapper_code#" target="#wrapper_code#">preview</a></strong></td>
	</tr>

	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Partner Code</b></font><br /><font size="-2"><i>required</i></font></td>
		<td bgcolor="##21ADCB" valign="top">#partner_code#<br />
		<a href="#website_url#/img/partners/#partner_code#" target="#partner_code#">/img/partners/#partner_code#</a></td>
	</tr>
	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Website Mapping</b></font><br /><font size="-2"><i>required</i></font></td>
		<td bgcolor="##21ADCB" valign="top"><input type="text" name="wrapper_code" value="#wrapper_code#" size="80"><cfif trim(wrapper_code) IS NOT ""><br />
		<a href="#website_url#/#wrapper_code#" target="#wrapper_code#">#website_url#/#wrapper_code#</a>
		</cfif></td>
	</tr>
	
	<input type="hidden" name="wrapper_old_code" value="#wrapper_code#" >
	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Page Title</b><br />
		<font size="-2"><i>required</i></font></font></td>
		<td bgcolor="##21ADCB" valign="top"><input type="text" name="wrapper_title" value="#wrapper_title#" size="80"></td>
	</tr>

	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Status</b></font></td>
		<td bgcolor="##21ADCB" valign="top"><input type="radio" name="wrapper_status" value="1" <cfif wrapper_status IS 1>checked</cfif>  />Active <input type="radio" name="wrapper_status" value="0" <cfif wrapper_status IS 0>checked</cfif>  />Inactive/Hide</td>
	</tr>
	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Deployment Status</b></font></td>
		<td bgcolor="##21ADCB" valign="top"><input type="radio" name="wrapper_deployment_status" value="0" <cfif wrapper_deployment_status IS 0>checked</cfif>  />Disabled <input type="radio" name="wrapper_deployment_status" value="1" <cfif wrapper_deployment_status IS 1>checked</cfif>  />Incomplete <input type="radio" name="wrapper_deployment_status" value="2" <cfif wrapper_deployment_status IS 2>checked</cfif>  />Ready for Deployment <input type="radio" name="wrapper_deployment_status" value="3" <cfif wrapper_deployment_status IS 3>checked</cfif>  />Live</td>
	</tr>
	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Internal Notes</b></font></td>
		<td bgcolor="##21ADCB" valign="top"><textarea name="wrapper_description" cols="62" rows="10">#wrapper_description#</textarea></td>
	</tr>

	<tr>
		<td bgcolor="##2E99AF"><input type="hidden" name="saving" value="1"></td>
		<td bgcolor="##21ADCB"><input type="submit" value="Save"> <input name="continue" type="submit" value="Save and Continue to Step 3"></td>
	</tr>
</form>

</table>

</cfoutput>