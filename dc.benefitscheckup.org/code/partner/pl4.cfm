<cfparam name="id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">

<cfparam name="error1" default="">
<cfparam name="error2" default="">
<cfparam name="error3" default="">
<cfparam name="error4" default="">
<cfparam name="error5" default="">
<cfparam name="error6" default="">
<cfparam name="error7" default="">
<cfparam name="errors" default="">

<cfif saving IS 1>

	<cfif trim(wrapper_index) IS "">
		<cfset error1 = 1>
		<cfset errors = 1>
	</cfif>
	
	<cfif trim(wrapper_template) IS "">
		<cfset error2 = 1>
		<cfset errors = 1>
	</cfif>
	
	<cfif trim(wrapper_css) IS "">
		<cfset error3 = 1>
		<cfset errors = 1>
	</cfif>
		
	<cfif trim(wrapper_header) IS "">
		<cfset error4 = 1>
		<cfset errors = 1>
	</cfif>
		
	<cfif trim(wrapper_footer) IS "">
		<cfset error5 = 1>
		<cfset errors = 1>
	</cfif>
		
	<cfif trim(wrapper_moreprograms_template) IS "">
		<cfset error6 = 1>
		<cfset errors = 1>
	</cfif>

	<cfif trim(wrapper_afc) IS "">
		<cfset error7 = 1>
		<cfset errors = 1>
	</cfif>
		

	<cfif errors IS NOT 1>
		<cfquery name="updateWrapper" datasource="#application.dbsrc#">
			UPDATE wrapper 
			SET 
			wrapper_index = '#wrapper_index#',
			wrapper_template = '#wrapper_template#',
			wrapper_css = '#wrapper_css#',
			wrapper_menu_css = '#wrapper_menu_css#',
			wrapper_menu_ie_css = '#wrapper_menu_ie_css#',
			wrapper_header = '#wrapper_header#',
			wrapper_footer = '#wrapper_footer#',
			wrapper_optional_box_text = '#wrapper_optional_box_text#',
 			wrapper_moreprograms_template = '#wrapper_moreprograms_template#',
			wrapper_top_menu = '#wrapper_top_menu#',
			wrapper_footer_custom = '#wrapper_footer_custom#',
			wrapper_additional_css = '#wrapper_additional_css#',
			wrapper_tag1 = '#wrapper_tag1#',
			wrapper_tag2 = '#wrapper_tag2#',
			wrapper_tag3 = '#wrapper_tag3#',
			wrapper_custom_js = '#wrapper_custom_js#'			
				
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
		&##8226; Please enter wrapper index<br>
	</cfif>

	<cfif error2 IS 1>
		&##8226; Please enter wrapper template<br>
	</cfif>
	
	<cfif error3 IS 1>
		&##8226; Please enter wrapper css<br>
	</cfif>

	<cfif error4 IS 1>
		&##8226; Please enter wrapper header<br>
	</cfif>
	
	<cfif error5 IS 1>
		&##8226; Please enter wrapper footer<br>
	</cfif>
	
	<cfif error6 IS 1>
		&##8226; Please enter more programs template<br>
	</cfif>
	
	<cfif error7 IS 1>
		&##8226; Please enter wrapper afc<br>
	</cfif>
	
	</font>
</cfif>

<form action="pl4.cfm?saving=1&action=#action#" method="post">
<input type="hidden" name="wrapper_id" value="#wrapper_id#">

<table border="0" cellpadding="3" cellspacing="3">

	<tr bgcolor="##22737B">
		<td colspan="2"><font size="+2"><b>Private Label - Advanced Options</b></font></td>
	</tr>

<tr bgcolor="##2E99AF">
	<td colspan="2"><strong><a href="#application.website_url#/#wrapper_code#" target="#wrapper_code#">preview</a> | <a href="pl.cfm?wrapper_id=#wrapper_id#&action=#action#">basic options</a> | <a href="pl2.cfm?wrapper_id=#wrapper_id#&action=#action#">screenings</a> | <a href="pl3.cfm?wrapper_id=#wrapper_id#&action=#action#">images</a></strong></td>
</tr>

	<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Partner Name</b></font></td>
		<td bgcolor="##21ADCB" valign="top"><span><font size="+1"><strong>#partner_name# (#partner_id#)</strong></font></span></td>
	</tr>
	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Index</b></font><br /><font size="-2"><i>required (index_pl.cfm)</i></font></td>
		<td bgcolor="##21ADCB" valign="top"><input type="text" name="wrapper_index" value="#wrapper_index#" size="50"></td>
	</tr>
	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Template</b></font><br /><font size="-2"><i>required (bcu.cfm)</i></font></td>
		<td bgcolor="##21ADCB" valign="top"><input type="text" name="wrapper_template" value="#wrapper_template#" size="50"></td>
	</tr>
	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Style&nbsp;Sheet</b></font><br /><font size="-2"><i>required (pl.css)</i></font></td>
		<td bgcolor="##21ADCB" valign="top"><input type="text" name="wrapper_css" value="#wrapper_css#" size="50"></td>
	</tr>
	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Menu&nbsp;Style&nbsp;Sheet</b></font><br /><font size="-2"><i>required (menu.css)</i></font></td>
		<td bgcolor="##21ADCB" valign="top"><input type="text" name="wrapper_menu_css" value="#wrapper_menu_css#" size="50"></td>
	</tr>
	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Menu&nbsp;Style&nbsp;Sheet (IE)</b></font><br /><font size="-2"><i>required (menu.css)</i></font></td>
		<td bgcolor="##21ADCB" valign="top"><input type="text" name="wrapper_menu_ie_css" value="#wrapper_menu_ie_css#" size="50"></td>
	</tr>	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Header</b></font><br /><font size="-2"><i>required (header_pl.cfm)</i></font></td>
		<td bgcolor="##21ADCB" valign="top"><input type="text" name="wrapper_header" value="#wrapper_header#" size="50"></td>
	</tr>
	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Footer</b></font><br /><font size="-2"><i>required (footer_pl.cfm)</i></font></td>
		<td bgcolor="##21ADCB" valign="top"><input type="text" name="wrapper_footer" value="#wrapper_footer#" size="50"></td>
	</tr>

	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>More&nbsp;Template</b></font><br /><font size="-2"><i>required (moreprograms_pl_cf.cfm)</i></font></td>
		<td bgcolor="##21ADCB" valign="top"><input type="text" name="wrapper_moreprograms_template" value="#wrapper_moreprograms_template#" size="50"></td>
	</tr>
	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>AFC</b></font><br /><font size="-2"><i>required (apply_pl.cfm)</i></font></td>
		<td bgcolor="##21ADCB" valign="top"><input type="text" name="wrapper_afc" value="#wrapper_afc#" size="50"></td>
	</tr>
	
	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Optional&nbsp;Index&nbsp;Text</b></font><br /><font size="-2"><i>displays on bottom of index page<br />
Use class text3 for paragraphs</i></font></td>
		<td bgcolor="##21ADCB" valign="top"><textarea name="wrapper_optional_box_text" cols="50" rows="10">#wrapper_optional_box_text#</textarea></td>
	</tr>
	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Optional&nbsp;Top&nbsp;Menu</b></font><br /><font size="-2"><i>displays above the logos</i></font></td>
		<td bgcolor="##21ADCB" valign="top"><textarea name="wrapper_top_menu" cols="50" rows="10">#wrapper_top_menu#</textarea></td>
	</tr>

	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Custom Footer</b></font><br /><font size="-2"><i>replaces standard footer</i></font></td>
		<td bgcolor="##21ADCB" valign="top"><textarea name="wrapper_footer_custom" cols="50" rows="10">#wrapper_footer_custom#</textarea></td>
	</tr>

	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Additional CSS</b></font><br /><font size="-2"><i>Loads after standard CSS</i></font></td>
		<td bgcolor="##21ADCB" valign="top"><textarea name="wrapper_additional_css" cols="50" rows="10">#wrapper_additional_css#</textarea></td>
	</tr>
	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Tag 1</b></font><br /><font size="-2"><i>Custom Tracking Tag 1</i></font></td>
		<td bgcolor="##21ADCB" valign="top"><textarea name="wrapper_tag1" cols="50" rows="10">#wrapper_tag1#</textarea></td>
	</tr>

	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Tag 2</b></font><br /><font size="-2"><i>Custom Tracking Tag 2</i></font></td>
		<td bgcolor="##21ADCB" valign="top"><textarea name="wrapper_tag2" cols="50" rows="10">#wrapper_tag2#</textarea></td>
	</tr>
	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Tag 3</b></font><br /><font size="-2"><i>Custom Tracking Tag 3</i></font></td>
		<td bgcolor="##21ADCB" valign="top"><textarea name="wrapper_tag3" cols="50" rows="10">#wrapper_tag3#</textarea></td>
	</tr>
	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Custom Javascript</b></font><br /><font size="-2"><i>Custom  Javascript</i></font></td>
		<td bgcolor="##21ADCB" valign="top"><textarea name="wrapper_custom_js" cols="50" rows="10">#wrapper_custom_js#</textarea></td>
	</tr>

<tr>
	<td bgcolor="##2E99AF"><input type="hidden" name="saving" value="1"></td>
	<td bgcolor="##21ADCB"><input type="submit" value="Save"></td>
</tr>
</table>
</form>
</cfoutput>