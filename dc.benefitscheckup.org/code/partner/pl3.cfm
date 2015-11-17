<cfparam name="id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">

<cfparam name="error1" default="">
<cfparam name="errors" default="">

<cfif action eq 'view'>
	<cf_checkAccess level="5">
<cfelse>
	<cf_checkAccess level="3">
</cfif>

<cfquery name="wrapper0" datasource="#application.dbsrc#">
	SELECT *
	FROM wrapper w
	LEFT JOIN tbl_partner t ON t.wrapper_id = w.wrapper_id
	WHERE w.wrapper_id = #wrapper_id#
</cfquery>

<cfif saving IS 1>

	<cfif wrapper_bcu_logo IS NOT "">
		<cffile filefield="wrapper_bcu_logo" action="upload" destination="#website_path##path_slash#img#path_slash#partners#path_slash##wrapper0.partner_code#" nameconflict="overwrite" accept="image/gif">
		
	
	<cfquery name="updateLogo" datasource="#application.dbsrc#">
			UPDATE wrapper 
			SET 
			wrapper_bcu_logo = '/img/partners/#wrapper0.partner_code#/#serverfile#'
			WHERE wrapper_id = #wrapper_id#
		</cfquery>
	</cfif>

	<cfif wrapper_logo IS NOT "">
		<cffile filefield="wrapper_logo" action="upload" destination="#website_path##path_slash#img#path_slash#partners#path_slash##wrapper0.partner_code#" nameconflict="overwrite">
		
		<cffile action="rename" source="#website_path##path_slash#img#path_slash#partners#path_slash##wrapper0.partner_code##path_slash##serverfile#" destination="#website_path##path_slash#img#path_slash#partners#path_slash##wrapper0.partner_code##path_slash#logo.gif">
		
		<cfquery name="updateLogo" datasource="#application.dbsrc#">
			UPDATE wrapper 
			SET 
			wrapper_logo = '/img/partners/#wrapper0.partner_code#/logo.gif'
			WHERE wrapper_id = #wrapper_id#
		</cfquery>
	</cfif>
	
	<cfif wrapper_cover_image IS NOT "">
		<cffile filefield="wrapper_cover_image" action="upload" destination="#website_path##path_slash#img#path_slash#partners#path_slash##wrapper0.partner_code#" nameconflict="overwrite">
		
		<cfquery name="updateCover" datasource="#application.dbsrc#">
			UPDATE wrapper 
			SET 
			wrapper_cover_image = '/img/partners/#wrapper0.partner_code#/#serverfile#'
			WHERE wrapper_id = #wrapper_id#
		</cfquery>
	</cfif>
	

	<cfif trim(wrapper_logo_alt_text) IS "">
		<cfset error1 = 1>
		<cfset errors = 1>
	</cfif>
	
	<cfif errors IS "">
		<cfquery name="updateWrapper" datasource="#application.dbsrc#">
			UPDATE wrapper 
			SET 
			wrapper_logo_alt_text = '#wrapper_logo_alt_text#',
			wrapper_bcu_logo_alt_text = '#wrapper_bcu_logo_alt_text#',
			wrapper_logo_link = '#wrapper_logo_link#',
			wrapper_link = '#wrapper_link#',
			wrapper_logo_margin_top = #val(wrapper_logo_margin_top)#,
			wrapper_logo_margin_right = #val(wrapper_logo_margin_right)#,
			wrapper_partner_category = #val(wrapper_partner_category)#,
			wrapper_cover_image_alt_text = '#wrapper_cover_image_alt_text#'
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



<cf_buildPage title="Wrapper Administration" section="partner">

<cfoutput query="wrapper">

<cfif errors IS 1>
	<font color="##FF0000">
	<strong>There were errors in the form below:</strong><br>
	<cfif error1 IS 1>
		&##8226; "Logo Alt Text" may not be left blank<br>
	</cfif>
	</font>
</cfif>

<table border="0" cellpadding="3" cellspacing="3">

<form action="pl3.cfm?action=#action#" method="post" enctype="multipart/form-data">
<input type="hidden" name="wrapper_id" value="#wrapper_id#">

	<tr bgcolor="##22737B">
		<td colspan="2"><font size="+2"><b>Private Label - Images</b></font></td>
	</tr>

<tr bgcolor="##2E99AF">
	<td colspan="2"><strong><a href="#application.website_url#/#wrapper_code#" target="#wrapper_code#">preview</a> | <a href="pl.cfm?wrapper_id=#wrapper_id#&action=#action#">basic options</a> | <a href="pl2.cfm?wrapper_id=#wrapper_id#&action=#action#">screenings</a> | <a href="pl4.cfm?wrapper_id=#wrapper_id#&action=#action#">advanced options</a></strong></td>
</tr>

	<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Partner Name</b></font></td>
		<td bgcolor="##21ADCB" valign="top"><span><font size="+1"><strong>#partner_name# (#partner_id#)</strong></font></span></td>
	</tr>
	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Partner Code</b></font></td>
		<td bgcolor="##21ADCB" valign="top">#partner_code#<br />
		<a href="#application.website_url#/img/partners/#partner_code#" target="#partner_code#">/img/partners/#partner_code#</a></td>
	</tr>
	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Left&nbsp;Logo</b></font><br /><font size="-2"><i>required<br />360px x 90px<br />
white background</i></font></td>
		<td bgcolor="##FFFFFF" valign="top"><input type="file" name="wrapper_bcu_logo" value="" size="80" accept="image/gif"><br /><cfif wrapper_bcu_logo IS NOT "">
		#wrapper_bcu_logo#
		<p>
			<cfif wrapper_bcu_link IS "">
				<img src="#application.website_url#/#wrapper_bcu_logo#" alt="#wrapper_logo_alt_text#" border="1" />
			<cfelse>
				<a href="#wrapper_bcu_link#" target="#wrapper_bcu_link#"><img src="#application.website_url#/#wrapper_bcu_logo#" alt="#wrapper_bcu_logo_alt_text#" border="1" /></a>
			</cfif><br />
				<a href="deletebculogo.cfm?wrapper_id=#wrapper_id#&partner_id=#wrapper.partner_id#&return=pl3">Delete  Image (Use Default)</a>
		<cfelse>
		/img/bculogo.gif (default)
		<p>
		<img src="#application.website_url#/img/bculogo.gif" alt="BenefitsCheckUp" border="1">
		</cfif>
		
		</td>
	</tr>
	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Left&nbsp;Logo&nbsp;Margin</b></td>
		<td bgcolor="##21ADCB" valign="top">Top <input type="text" name="wrapper_partner_category" value="#wrapper_partner_category#" size="2">px</td>
	</tr>	
	

	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Left&nbsp;Logo&nbsp;Alt&nbsp;Text</b><br />
		<font size="-2"><i>required</i></font></font></td>
		<td bgcolor="##21ADCB" valign="top"><input type="text" name="wrapper_bcu_logo_alt_text" value="#wrapper_bcu_logo_alt_text#" size="80"></td>
	</tr>
	

	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Left&nbsp;Logo&nbsp;Link</b><br />
		<font size="-2"><i>required</i></font></font></td>
		<td bgcolor="##21ADCB" valign="top"><input type="text" name="wrapper_logo_link" value="#wrapper_logo_link#" size="80"></td>
	</tr>
	
	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Logo</b></font><br /><font size="-2"><i>required<br />360px x 95px<br />
white background</i></font></td>
		<td bgcolor="##FFFFFF" valign="top"><input type="file" name="wrapper_logo" value="" size="80" accept="image/gif"><br /><cfif wrapper_logo IS NOT "">
		#wrapper_logo#
		<p>
			<cfif wrapper_link IS "">
				<img src="#application.website_url#/#wrapper_logo#" alt="#wrapper_logo_alt_text#" border="1" />
			<cfelse>
				<a href="#wrapper_link#" target="#wrapper_link#"><img src="#application.website_url#/#wrapper_logo#" alt="#wrapper_logo_alt_text#" border="1" /></a>
				</cfif>
		</cfif><br />
		
		<a href="deletelogo.cfm?wrapper_id=#wrapper_id#&partner_id=#wrapper.partner_id#&return=pl3">Delete  Image (Use Default)</a>
		
		</td>
	</tr>

	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Logo&nbsp;Alt&nbsp;Text</b><br />
		<font size="-2"><i>required</i></font></font></td>
		<td bgcolor="##21ADCB" valign="top"><input type="text" name="wrapper_logo_alt_text" value="#wrapper_logo_alt_text#" size="80"></td>
	</tr>
	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Logo&nbsp;Margin</b><br />
		<font size="-2"><i>required</i></font></font></td>
		<td bgcolor="##21ADCB" valign="top">Top <input type="text" name="wrapper_logo_margin_top" value="#wrapper_logo_margin_top#" size="2">px &nbsp; Right <input type="text" name="wrapper_logo_margin_right" value="#wrapper_logo_margin_right#" size="2">px (15 default)</td>
	</tr>


	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Logo Link</b></font></td>
		<td bgcolor="##21ADCB" valign="top"><input type="text" name="wrapper_link" value="#wrapper_link#" size="80"></td>
	</tr>
	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Cover&nbsp;Image</b></font><br /><font size="-2"><i>250px x 170px</i></font></td>
		<td bgcolor="##FFFFFF" valign="top"><input type="file" name="wrapper_cover_image" value="" size="80" accept="image/gif"><br />
		<cfif wrapper_cover_image IS NOT "">
		#wrapper_cover_image#
		<p>
		<a href="#application.website_url#/#wrapper_cover_image#" target="#application.website_url##wrapper_cover_image#"><img src="#wrapper_cover_image#" alt="" /></a> <a href="#wrapper_cover_image#" target="#application.website_url#/#wrapper_cover_image#">Local File</a> <br />
		<a href="deletecoverimage.cfm?wrapper_id=#wrapper_id#&partner_id=#wrapper.partner_id#&return=pl3">Delete Cover Image</a>
		</cfif></td>
	</tr>
	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Cover&nbsp;Image&nbsp;Alt&nbsp;Text</b><br />
		<font size="-2"><i>required</i></font></font></td>
		<td bgcolor="##21ADCB" valign="top"><input type="text" name="wrapper_cover_image_alt_text" value="#wrapper_cover_image_alt_text#" size="80"></td>
	</tr>
	
	<tr>
		<td bgcolor="##2E99AF"><input type="hidden" name="saving" value="1"></td>
		<td bgcolor="##21ADCB"><input type="submit" value="Save"></td>
	</tr>
</form>

</table>

</cfoutput>