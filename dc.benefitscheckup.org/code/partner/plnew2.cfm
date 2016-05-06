<cfset website_path = "/var/www/web/BCU">

<cfquery name="partner" datasource="#application.dbsrc#">
	SELECT *
	FROM tbl_partner
	WHERE partner_id = #partner_id#
</cfquery>

<cfparam name="id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">
<cfparam name="continue" default="">

<cfparam name="wrapper_code" default="#partner.partner_code#">
<cfparam name="wrapper_description" default="">
<cfparam name="wrapper_title" default="BenefitsCheckUp for [Partner Title] - NCOA's Online Screening Service">
<cfparam name="wrapper_status" default="0">
<cfparam name="wrapper_deployment_status" default="1">
<cfparam name="wrapper_menu" default="1">

<cfparam name="wrapper_partner_category" default="">

<cfparam name="error1" default="">
<cfparam name="error2" default="">
<cfparam name="error3" default="">
<cfparam name="error4" default="">
<cfparam name="errors" default="">


<cfif saving IS 1>
	<cfif findnocase('[Partner Title]', wrapper_title) GT 0>
		<cfset error1 = 1>
		<cfset errors = 1>
	</cfif>
	
<!--- 	<cfif DirectoryExists("#website_path#/#wrapper_code#") IS NOT 0>
		<cfset error4 = 1>
		<cfset errors = 1>
	</cfif> --->
</cfif>

<cfset get_started_now = "There are benefits you may be missing! BenefitsCheckUp helps you find and enroll in public and private benefits programs. You can also find an online application for Medicare's Extra Help. It's simple and free and always includes the most up-to-date information.">
<cfset more_programs = "BenefitsCheckUp quickly finds federal, state and private benefit programs available to help you save money on prescription drugs, utilities, taxes, nutrition, and more. Click below to give us some basic information and view a personal report on the benefits you may qualify for.">

<cfif errors IS "" AND saving IS 1>
	
	<cfquery name="addWrapper" datasource="#application.dbsrc#">
		INSERT INTO wrapper
		(wrapper_partner_id, wrapper_type, wrapper_code, wrapper_description, wrapper_title, wrapper_status, wrapper_deployment_status, wrapper_index, wrapper_template, wrapper_css, wrapper_header, wrapper_footer, wrapper_left_col, wrapper_right_col, wrapper_custom_subset, wrapper_moreprograms_template, wrapper_afc, wrapper_external, wrapper_get_started_now, wrapper_more_programs, wrapper_comprehensive, wrapper_pda, wrapper_rx, wrapper_disaster, wrapper_menu, wrapper_iframe, wrapper_afc_popup, wrapper_show_header, wrapper_show_footer
        ) VALUES (
        #partner_id#, 1, '#wrapper_code#', '#wrapper_description#', '#wrapper_title#', '#wrapper_status#', '#wrapper_deployment_status#', 'index_pl.cfm', 'bcu.cfm', 'pl.css', 'header_pl.cfm', 'footer_pl.cfm', 'N', 'N', 0, 'moreprograms_pl_cf.cfm', 'apply_pl.cfm', 0, <cfqueryparam value="#get_started_now#">, <cfqueryparam value="#more_programs#">, 1, 0, 0, 0, #val(wrapper_menu)#, 0, 1, 1, 1)
	</cfquery>
	
	<cfquery name="wrapper" datasource="#application.dbsrc#">
		SELECT *
		FROM wrapper
		WHERE wrapper_partner_id = #partner_id#
	</cfquery>
	
	<cfquery name="updatePartner" datasource="#application.dbsrc#">
		UPDATE tbl_partner
		SET wrapper_id = #wrapper.wrapper_id#
	 	WHERE partner_id = #partner_id#
	</cfquery>
	
	<!--- <cffile action="write" file="#website_path#/#wrapper_code#/index.cfm" output='<cf_sessionPassVars var="redirectURL" href="/index.cfm" partner_id="#partner_id#" source_id="5">
		<cflocation url="##redirectURL##" AddToken="No">'>
 --->
		<cfif continue IS 'Save and Continue to Step 3'>
			<cflocation url="plnew3.cfm?partner_id=#partner_id#&wrapper_id=#wrapper.wrapper_id#">
		<cfelse>
			<cflocation url="plnew2b.cfm?partner_id=#partner_id#&wrapper_id=#wrapper.wrapper_id#">
		</cfif>
	
</cfif>

<!--- <cfif action eq 'view'>
	<cf_checkAccess level="5">
<cfelse>
	<cf_checkAccess level="3">
</cfif> --->

<cf_buildPage title="Wrapper Administration" section="partner">

<cfoutput query="partner">

<cfif errors IS 1>
	<font color="##FF0000">
	<strong>There were errors in the form below:</strong><br>
	<cfif error1 IS 1>
		&##8226; Please check Page Title<br>
	</cfif>

	<cfif error4 IS 1>
		&##8226; Website Mapping is Taken.  Choose a different Website Mapping.<br>
	</cfif>
	
	</font>
</cfif>
<p>
<table border="0" cellpadding="3" cellspacing="3">

<form action="plnew2.cfm?saving=1" method="post" enctype="multipart/form-data">
<input type="hidden" name="partner_id" value="#partner_id#">

<tr bgcolor="##22737B">
		<td colspan="2"><font size="+2"><b>New Private Label</b></font></td>
	</tr>
	
	<tr bgcolor="##2E99AF">
		<td colspan="2"><strong>Step 2: Basic Information</strong></td>
	</tr>


	<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Partner Name</b></font></td>
		<td bgcolor="##21ADCB" valign="top"><span><font size="+1"><strong>#partner_name# (#partner_id#)</strong></font></span></td>
	</tr>


	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Partner Code</b></font><br /><font size="-2"><i>required</i></font></td>
		<td bgcolor="##21ADCB" valign="top">#partner_code#<br />
		<a href="#application.website_url#/img/partners/#partner_code#" target="#partner_code#">/img/partners/#partner_code#</a></td>
	</tr>
	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Website Mapping</b></font><br /><font size="-2"><i>required</i></font></td>
		<td bgcolor="##21ADCB" valign="top"><input type="text" name="wrapper_code" value="#wrapper_code#" size="80"></td>
	</tr>
	
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
		<td bgcolor="##21ADCB" valign="top"><input type="radio" name="wrapper_deployment_status" value="0" <cfif wrapper_deployment_status IS 0>checked</cfif>  />Disabled/Hide <input type="radio" name="wrapper_deployment_status" value="1" <cfif wrapper_deployment_status IS 1>checked</cfif>  />Incomplete <input type="radio" name="wrapper_deployment_status" value="2" <cfif wrapper_deployment_status IS 2>checked</cfif>  />Pending <input type="radio" name="wrapper_deployment_status" value="3" <cfif wrapper_deployment_status IS 3>checked</cfif>  />Live</td>
	</tr>
	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Internal Notes</b></font></td>
		<td bgcolor="##21ADCB" valign="top"><textarea name="wrapper_description" cols="62" rows="10">#wrapper_description#</textarea></td>
	</tr>
	
	<tr>
		<td bgcolor="##2E99AF"></td>
		<td bgcolor="##21ADCB"><input type="submit" value="Save"> <input name="continue" type="submit" value="Save and Continue to Step 3"></td>
	</tr>
</form>

</table>

</cfoutput>
