<cfparam name="id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">
<cfparam name="external" type="numeric" default="0">
<cfparam name="wrapper_lis_link_direct" type="numeric" default="0">
<cfparam name="wrapper_custom_whatithelps" type="numeric" default="0">
<cfparam name="wrapper_custom_whatithelps2" type="numeric" default="0">
<cfparam name="wrapper_pap_whatithelps" type="numeric" default="0">
<cfparam name="wrapper_pap" type="numeric" default="0">
<cfparam name="wrapper_special" type="numeric" default="0">

<cfparam name="wrapper_comprehensive_whatithelps" type="numeric" default="0">
<cfparam name="wrapper_rx_whatithelps" type="numeric" default="0">

<cfparam name="wrapper_whatithelps" type="numeric" default="0">




<cfif action eq 'view'>
	<cf_checkAccess level="5">
<cfelse>
	<cf_checkAccess level="3">
</cfif>


<cfparam name="error1" default="">
<cfparam name="error2" default="">
<cfparam name="errors" default="">

<cfif saving IS 1>

	<cfif trim(wrapper_more_programs) IS "">
		<cfset error1 = 1>
		<cfset errors = 1>
	</cfif>
	
	<cfif wrapper_comprehensive IS "" AND wrapper_rx IS "" AND wrapper_pda IS "" AND wrapper_disaster IS "">
		<cfset error2 = 1>
		<cfset errors = 1>
	</cfif>
	
	<cfif errors IS "">
		<cfquery name="wrapper" datasource="#application.dbsrc#">
				UPDATE wrapper 
				SET 
				
				wrapper_comprehensive = #val(wrapper_comprehensive)#,
				wrapper_pda = #val(wrapper_pda)#,
				wrapper_rx = #val(wrapper_rx)#,
				wrapper_disaster = #val(wrapper_disaster)#,
				wrapper_pap = #val(wrapper_pap)#,
				wrapper_pap_custom_name = '#wrapper_pap_custom_name#',
				wrapper_get_started_now = '#wrapper_get_started_now#',	
				wrapper_printed_text = '#wrapper_printed_text#',
				wrapper_more_programs = '#wrapper_more_programs#',
				wrapper_custom_subset = #val(wrapper_custom_subset)#,
				wrapper_custom_title = '#wrapper_custom_title#',
				wrapper_custom_time = '#wrapper_custom_time#',	

				wrapper_custom_subset2 = #val(wrapper_custom_subset2)#,
				wrapper_custom_title2 = '#wrapper_custom_title2#',
				wrapper_custom_time2 = '#wrapper_custom_time2#',	


				wrapper_external = #val(external)#,
				wrapper_external_title = '#wrapper_external_title#',	
				wrapper_external_title_graphic = '#wrapper_external_title_graphic#',	
				wrapper_external_text = '#wrapper_external_text#',	
				wrapper_external_time = '#wrapper_external_time#',		
				wrapper_external_link = '#wrapper_external_link#',
				wrapper_special = #val(wrapper_special)#,
				wrapper_special_link = '#wrapper_special_link#',
				wrapper_lis_link_direct = #val(wrapper_lis_link_direct)#,		
				wrapper_special_text = '#wrapper_special_text#',
				wrapper_screening_order = '#wrapper_screening_order#',
				wrapper_whatithelps = #val(wrapper_whatithelps)#
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
		&##8226; "Find Benefits Text" may not be left blank<br>
	</cfif>
	
	<cfif error2 IS 1>
		&##8226; Please select at least one screening<br>
	</cfif>


	
	</font>
</cfif>

<table border="0" cellpadding="3" cellspacing="3">

<form action="pl2.cfm?saving=1&&action=#action#" method="post" enctype="multipart/form-data">
<input type="hidden" name="wrapper_id" value="#wrapper_id#">

	<tr bgcolor="##22737B">
		<td colspan="2"><font size="+2"><b>Private Label - Screenings</b></font></td>
	</tr>

<tr bgcolor="##2E99AF">
	<td colspan="2"><strong><a href="#application.website_url#/#wrapper_code#" target="#wrapper_code#">preview</a> | <a href="pl.cfm?wrapper_id=#wrapper_id#&action=#action#">basic options</a> | <a href="pl3.cfm?wrapper_id=#wrapper_id#&action=#action#">images</a> | <a href="pl4.cfm?wrapper_id=#wrapper_id#&action=#action#">advanced options</a></strong></td>
</tr>

	<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Partner Name</b></font></td>
		<td bgcolor="##21ADCB" valign="top"><span><font size="+1"><strong>#partner_name# (#partner_id#)</strong></font></span></td>
	</tr>
	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Get&nbsp;Started&nbsp;Now&nbsp;Text</b></font></td>
		<td bgcolor="##21ADCB" valign="top"><textarea name="wrapper_get_started_now" cols="62" rows="7">#wrapper_get_started_now#</textarea></td>
	</tr>

	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Find&nbsp;Benefits&nbsp;Text</b></font><br /><font size="-2"><i>required</i></font></td>
		<td bgcolor="##21ADCB" valign="top"><textarea name="wrapper_more_programs" cols="62" rows="7">#wrapper_more_programs#</textarea></td>
	</tr>
	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Printed Questionnaire Text</b></font></td>
		<td bgcolor="##21ADCB" valign="top"><textarea name="wrapper_printed_text" cols="62" rows="7">#wrapper_printed_text#</textarea></td>
	</tr>
	
	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Comprehensive?</b></font></td>
		<td bgcolor="##21ADCB" valign="top"><input type="radio" name="wrapper_comprehensive" value="1" <cfif wrapper_comprehensive IS 1>checked</cfif>  />Yes <input type="radio" name="wrapper_comprehensive" value="0" <cfif wrapper_comprehensive IS 0>checked</cfif>  />No</td>
	</tr>
	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Medicare Rx Extra Help?</b></font><br />
        <font size="-2"><i>LIS Quick Screen</i></font></td>
		<td bgcolor="##21ADCB" valign="top"><input type="radio" name="wrapper_rx" value="1" <cfif wrapper_rx IS 1>checked</cfif>  />Yes <input type="radio" name="wrapper_rx" value="0" <cfif wrapper_rx IS 0>checked</cfif>  />No</td>
	</tr>
	

	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>PDA?</b></font></td>
		<td bgcolor="##21ADCB" valign="top"><input type="radio" name="wrapper_pda" value="1" <cfif wrapper_pda IS 1>checked</cfif>  />Yes <input type="radio" name="wrapper_pda" value="0" <cfif wrapper_pda IS 0>checked</cfif>  />No</td>
	</tr>
	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>PAP?</b></font></td>
		<td bgcolor="##21ADCB" valign="top"><input type="radio" name="wrapper_pap" value="1" <cfif wrapper_pap IS 1>checked</cfif>  />Yes <input type="radio" name="wrapper_pap" value="0" <cfif wrapper_pap IS 0>checked</cfif>  />No</td>
	</tr>

	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Custom&nbsp;PAP&nbsp;Name</b></font><br /><font size="-2"><i>Overrides default display name for PAP</i></font></td>
		<td bgcolor="##21ADCB" valign="top"><input type="text" name="wrapper_pap_custom_name" value="#wrapper_pap_custom_name#" size="80"></td>
	</tr>
	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Disaster?</b></font></td>
		<td bgcolor="##21ADCB" valign="top"><input type="radio" name="wrapper_disaster" value="1" <cfif wrapper_disaster IS 1>checked</cfif>  />Yes <input type="radio" name="wrapper_disaster" value="0" <cfif wrapper_disaster IS 0>checked</cfif>  />No</td>
	</tr>
	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>LIS Direct Link?</b></font><br />
        <font size="-2"><i>Start with first question page when link is clicked</i></font></td>
		<td bgcolor="##21ADCB" valign="top"><input type="radio" name="wrapper_lis_link_direct" value="1" <cfif wrapper_lis_link_direct IS 1>checked</cfif>  />Yes <input type="radio" name="wrapper_lis_link_direct" value="0" <cfif wrapper_lis_link_direct IS 0>checked</cfif>  />No</td>
	</tr>
	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Custom&nbsp;Screening</b></font><br /><font size="-2"><i>Enter subset ID<br />
Appears Before Comprehensive</i></font></td>
		<td bgcolor="##21ADCB" valign="top"><input type="text" name="wrapper_custom_subset" value="#wrapper_custom_subset#" size="50"></td>
	</tr>
	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Custom&nbsp;Title</b></font></td>
		<td bgcolor="##21ADCB" valign="top"><input type="text" name="wrapper_custom_title" value="#wrapper_custom_title#" size="50"></td>
	</tr>
	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Custom&nbsp;Time</b></font></td>
		<td bgcolor="##21ADCB" valign="top"><input type="text" name="wrapper_custom_time" value="#wrapper_custom_time#" size="50"></td>
	</tr>
	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Custom&nbsp;Screening 2</b></font><br /><font size="-2"><i>Enter subset ID<br />
Appears Before Comprehensive</i></font></td>
		<td bgcolor="##21ADCB" valign="top"><input type="text" name="wrapper_custom_subset2" value="#wrapper_custom_subset2#" size="50"></td>
	</tr>
	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Custom&nbsp;Title 2</b></font></td>
		<td bgcolor="##21ADCB" valign="top"><input type="text" name="wrapper_custom_title2" value="#wrapper_custom_title2#" size="50"></td>
	</tr>
	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Custom&nbsp;Time 2</b></font></td>
		<td bgcolor="##21ADCB" valign="top"><input type="text" name="wrapper_custom_time2" value="#wrapper_custom_time2#" size="50"></td>
	</tr>
	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>External Screening?</b></font><br /><font size="-2"><i>Appears After Comprehensive</i></font></td>
		<td bgcolor="##21ADCB" valign="top"><input type="radio" name="external" value="0" <cfif wrapper_external IS 0>checked</cfif>  />No <input type="radio" name="external" value="1" <cfif wrapper_external IS 1>checked</cfif>  />Yes</td>
	</tr>
	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>External&nbsp;Title</b></font></td>
		<td bgcolor="##21ADCB" valign="top"><input type="text" name="wrapper_external_title" value="#wrapper_external_title#" size="50"></td>
	</tr>
	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>External&nbsp;Title&nbsp;Graphic</b></font></td>
		<td bgcolor="##21ADCB" valign="top"><input type="text" name="wrapper_external_title_graphic" value="#wrapper_external_title_graphic#" size="50"></td>
	</tr>

	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>External&nbsp;Time</b></font></td>
		<td bgcolor="##21ADCB" valign="top"><input type="text" name="wrapper_external_time" value="#wrapper_external_time#" size="50"></td>
	</tr>
	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>External&nbsp;Text</b></font></td>
		<td bgcolor="##21ADCB" valign="top"><textarea name="wrapper_external_text" cols="50" rows="5">#wrapper_external_text#</textarea></td>
	</tr>
	

	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>External&nbsp;Link ID</b></font></td>
		<td bgcolor="##21ADCB" valign="top"><input type="text" name="wrapper_external_link" value="#wrapper_external_link#" size="50"></td>
	</tr>
	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Special Box?</b></font></td>
		<td bgcolor="##21ADCB" valign="top"><input type="radio" name="wrapper_special" value="1" <cfif wrapper_special IS 1>checked</cfif>  />Yes <input type="radio" name="wrapper_special" value="0" <cfif wrapper_special IS 0>checked</cfif>  />No</td>
	</tr>
	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Special Text</b></font></td>
		<td bgcolor="##21ADCB" valign="top"><textarea name="wrapper_special_text" cols="62" rows="7">#wrapper_special_text#</textarea></td>
	</tr>


	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Special&nbsp;Link</b></font></td>
		<td bgcolor="##21ADCB" valign="top"><input type="text" name="wrapper_special_link" value="#wrapper_special_link#" size="50"></td>
	</tr>
	

	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Show "What it Helps" Link </b></font></td>
		<td bgcolor="##21ADCB" valign="top"><input type="radio" name="wrapper_whatithelps" value="1" <cfif wrapper_whatithelps IS 1>checked</cfif>  />Yes <input type="radio" name="wrapper_whatithelps" value="0" <cfif wrapper_whatithelps IS 0>checked</cfif>  />No</td>
	</tr>		
	
	
	<tr>
		<td bgcolor="##2E99AF" valign="top"><font size="+1"><b>Screening Order</b></font></td>
		<td bgcolor="##21ADCB" valign="top"><textarea name="wrapper_screening_order" cols="62" rows="4">#wrapper_screening_order#</textarea></td>
	</tr>	
	
	<tr>
		<td bgcolor="##2E99AF"><input type="hidden" name="saving" value="1"></td>
		<td bgcolor="##21ADCB"><input type="submit" value="Save"></td>
	</tr>
</form>

</table>

</cfoutput>
