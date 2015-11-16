<cfparam name="id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">

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
			<cffile action="move" source="#website_path##path_slash##wrapper_old_code##path_slash#index.cfm" destination="#website_path##path_slash##wrapper_code##path_slash#index.cfm">
		</cfif>

		<cfquery name="wrapper" datasource="#application.dbsrc#">
			UPDATE wrapper 
			SET 
			wrapper_code = '#wrapper_code#',
			wrapper_description = '#wrapper_description#',
			wrapper_title = '#wrapper_title#',
			wrapper_status = #val(wrapper_status)#,	
			wrapper_deployment_status = #val(wrapper_deployment_status)#,
			wrapper_menu = #val(wrapper_menu)#
		
			WHERE wrapper_id = #wrapper_id#
		</cfquery>
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

<form action="pl.cfm?saving=1&action=#action#" method="post" enctype="multipart/form-data">
<input type="hidden" name="wrapper_id" value="#wrapper_id#">

	<tr bgcolor="##22737B">
		<td colspan="2"><font size="+2"><b>Private Label - Basic Options</b></font></td>
	</tr>

<tr bgcolor="##2E99AF">
	<td colspan="2"><strong><a href="#application.website_url#/#wrapper_code#" target="#wrapper_code#">preview</a> | <a href="pl2.cfm?wrapper_id=#wrapper_id#&action=#action#">screenings</a> | <a href="pl3.cfm?wrapper_id=#wrapper_id#&action=#action#">images</a> | <a href="pl4.cfm?wrapper_id=#wrapper_id#&action=#action#">advanced options</a></strong></td>
</tr>

<tr>
	<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Partner Name</b></font></td>
		<td bgcolor="##21ADCB" valign="top"><span><font size="+1"><strong>#partner_name# (#partner_id#)</strong></font></span></td>
	</tr>


	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Partnet Category/Subcategory</b><br />
		<font size="-2"><i>required</i></font></font></td>
		<td bgcolor="##21ADCB" valign="top"><select name="wrapper_category">
        <option value="1:1" <cfif wrapper_partner_category IS 1 AND wrapper_partner_category IS 1>SELECTED</cfif>>Sponsor: Foundations</option>
        <option value="1:2" <cfif wrapper_partner_category IS 1 AND wrapper_partner_category IS 2>SELECTED</cfif>>Sponsor: Retail Pharmacies</option>
        <option value="1:3" <cfif wrapper_partner_category IS 1 AND wrapper_partner_category IS 3>SELECTED</cfif>>Sponsor: Health Care Organizations</option>
        <option value="1:4" <cfif wrapper_partner_category IS 1 AND wrapper_partner_category IS 4>SELECTED</cfif>>Sponsor: Pharmaceutical Companies</option>
        <option value="2:0" <cfif wrapper_partner_category IS 2>SELECTED</cfif>>Government Partners</option>
        <option value="3:0" <cfif wrapper_partner_category IS 3>SELECTED</cfif>>Service Partners</option>        
		</select></td>
	</tr>

	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Partner Code</b></font><br /><font size="-2"><i>required</i></font></td>
		<td bgcolor="##21ADCB" valign="top">#partner_code#<br />
		<a href="#application.website_url#/img/partners/#partner_code#" target="#partner_code#">/img/partners/#partner_code#</a></td>
	</tr>
	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Website Mapping</b></font><br /><font size="-2"><i>required</i></font></td>
		<td bgcolor="##21ADCB" valign="top"><input type="text" name="wrapper_code" value="#wrapper_code#" size="80"><cfif trim(wrapper_code) IS NOT ""><br />
		<a href="#application.website_url#/#wrapper_code#" target="#wrapper_code#">#application.website_url#/#wrapper_code#</a>
		</cfif></td>
	</tr>
	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Folders</b></font><br /><font size="-2"><i>required</i></font></td>
		<td bgcolor="##21ADCB" valign="top"><cfif trim(wrapper_code) IS NOT "">
		/#wrapper_code#<br />
		/img/partners/#wrapper_code#
		</cfif></td>
	</tr>	
	
	<input type="hidden" name="wrapper_old_code" value="#wrapper_code#" >
	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Page Title</b><br />
		<font size="-2"><i>required</i></font></font></td>
		<td bgcolor="##21ADCB" valign="top"><input type="text" name="wrapper_title" value="#wrapper_title#" size="80"></td>
	</tr>
	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Show Menu</b></font></td>
		<td bgcolor="##21ADCB" valign="top"><input type="radio" name="wrapper_menu" value="1" <cfif wrapper_menu IS 1>checked</cfif>  />Yes <input type="radio" name="wrapper_menu" value="0" <cfif wrapper_menu IS 0>checked</cfif>  />No/Hide</td>
	</tr>

	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Status</b></font></td>
		<td bgcolor="##21ADCB" valign="top"><input type="radio" name="wrapper_status" value="1" <cfif wrapper_status IS 1>checked</cfif>  />Active <input type="radio" name="wrapper_status" value="0" <cfif wrapper_status IS 0>checked</cfif>  />Disabled/Hide</td>
	</tr>
	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Deployment Status</b></font></td>
		<td bgcolor="##21ADCB" valign="top"><input type="radio" name="wrapper_deployment_status" value="0" <cfif wrapper_deployment_status IS 0>checked</cfif>  />Disabled/Hide <input type="radio" name="wrapper_deployment_status" value="1" <cfif wrapper_deployment_status IS 1>checked</cfif>  />Pending <input type="radio" name="wrapper_deployment_status" value="2" <cfif wrapper_deployment_status IS 2>checked</cfif>  />Ready for Deployment <input type="radio" name="wrapper_deployment_status" value="3" <cfif wrapper_deployment_status IS 3>checked</cfif>  />Live</td>
	</tr>
	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Internal Notes</b></font></td>
		<td bgcolor="##21ADCB" valign="top"><textarea name="wrapper_description" cols="62" rows="10">#wrapper_description#</textarea></td>
	</tr>

	<tr>
		<td bgcolor="##2E99AF"><input type="hidden" name="saving" value="1"></td>
		<td bgcolor="##21ADCB"><input type="submit" value="Save"></td>
	</tr>
</form>

</table>

</cfoutput>