<cfparam name="form_id" type="numeric">

<cfparam name="type_id" type="numeric">



<cfquery name="getform" datasource="#application.dbSrc#">

	SELECT form_name

	FROM form

	WHERE form_id=#form_id#

</cfquery>

<cfquery name="gettype" datasource="#application.dbSrc#">

	SELECT type_code, type_name

	FROM formtype

	WHERE formtype_id=#type_id#

</cfquery>



<cfset fname=getform.form_name>

<cfset tcode=gettype.type_code>

<cfset tname=gettype.type_name>



<cf_formmenu title="Add Form Instance (#tcode#)"><cfoutput>



<table border="0" cellpadding="3" cellspacing="3">

<tr>

	<td bgcolor="#application.color.form.dark#"><font size="+1"><b>#fname#</b></font></td>

	<td bgcolor="#application.color.form.med#" valign="top"><a href="formview.cfm?id=#form_id#">view</a></td>

  <cfif session.user_level eq "admin">

	<td bgcolor="#application.color.form.med#" valign="top"><a href="formedit.cfm?id=#form_id#">edit</a></td>

  <cfelse>

    <td bgcolor="#application.color.form.med#" valign="top">edit</td>

  </cfif>

</tr>

</table><br>



<form action="typeadd.cfm" method="post" name="adder">

<table border="0" cellpadding="5" cellspacing="0" bgcolor="#application.color.formtype.med#">

	<tr>

		<td valign="top" colspan="2"><font size="+1"><b>String</b></font></td>

		<td colspan="2"><input type="text" name="string" value="" size="70"></td>

	</tr>

	<tr>

		<td colspan="2"></td>

		<td colspan="2"><font size="-1"><i>#tname#</i></font></td>

	</tr>

	<tr>

		<td valign="top" colspan="2"><font size="+1"><b>Active</b></font></td>

		<td colspan="2"><input type="checkbox" name="active" value="1" checked></td>

	</tr>

	<tr>

		<td valign="top" colspan="2"><font size="+1"><b>Form&nbsp;Rev.&nbsp;Date</b></font></td>

		<td colspan="2"><select name="fd_month"><option value="0"><cfloop index="mo" from="1" to="12"><option value="#mo#">#MonthAsString(mo)#</cfloop></select>

		<select name="fd_day"><option value="0"><cfloop index="dt" from="1" to="31"><option value="#dt#">#dt#</cfloop></select>,

		<select name="fd_year"><option value="0"><cfloop index="yr" from="1990" to="2020"><option value="#yr#">#yr#</cfloop></select>

		&nbsp; <input type="button" value="clear date" onClick="this.form.fd_month.selectedIndex = 0; this.form.fd_day.selectedIndex = 0; this.form.fd_year.selectedIndex = 0;">

		&nbsp; <input type="button" value="clear day only" onClick="this.form.fd_day.selectedIndex = 0;"></td>

	</tr>

	<tr>

		<td valign="top" colspan="2"><font size="+1"><b>Date&nbsp;Updated</b></font></td>

		<td colspan="2"><select name="ed_month"><option value="0"><cfloop index="mo" from="1" to="12"><option value="#mo#">#MonthAsString(mo)#</cfloop></select>

		<select name="ed_day"><option value="0"><cfloop index="dt" from="1" to="31"><option value="#dt#">#dt#</cfloop></select>,

		<select name="ed_year"><option value="0"><cfloop index="yr" from="1990" to="2020"><option value="#yr#">#yr#</cfloop></select>

		&nbsp; <input type="button" value="clear date" onClick="this.form.ed_month.selectedIndex = 0; this.form.ed_day.selectedIndex = 0; this.form.ed_year.selectedIndex = 0;">

		&nbsp; <input type="button" value="set to today" onClick="this.form.ed_month.selectedIndex = #Month(Now())#; this.form.ed_day.selectedIndex = #Day(Now())#; this.form.ed_year.selectedIndex = #Year(Now())# - 1989;"></td>

	</tr>

	<tr>

		<td colspan="2">&nbsp;</td>

		<td><input type="hidden" name="form_id" value="#form_id#"><input type="hidden" name="type_id" value="#type_id#"><input type="button" value="Add instance" onClick="if (this.form.fd_month.selectedIndex == 0 && this.form.fd_year.selectedIndex > 0) alert('Form Rev. Date: You must set a month or clear the entire date'); else if (this.form.fd_month.selectedIndex > 0 && this.form.fd_year.selectedIndex == 0) alert('Form Rev. Date: You must set a year or clear the entire date'); else if (this.form.fd_month.selectedIndex == 0 && this.form.fd_day.selectedIndex > 0 && this.form.fd_year.selectedIndex == 0) alert('Form Rev. Date: You must set a month and year or clear the entire date'); else if ((this.form.fd_day.selectedIndex == 31 && (this.form.fd_month.selectedIndex == 4 || this.form.fd_month.selectedIndex == 6 || this.form.fd_month.selectedIndex == 9 || this.form.fd_month.selectedIndex == 11)) || (this.form.fd_month.selectedIndex == 2 && this.form.fd_day.selectedIndex > 29) || (this.form.fd_month.selectedIndex == 2 && this.form.fd_day.selectedIndex > 28 && this.form.fd_year.selectedIndex != 3 && this.form.fd_year.selectedIndex != 7 && this.form.fd_year.selectedIndex != 11 && this.form.fd_year.selectedIndex != 15 && this.form.fd_year.selectedIndex != 19 && this.form.fd_year.selectedIndex != 23 && this.form.fd_year.selectedIndex != 27 && this.form.fd_year.selectedIndex != 31)) alert('Form Rev. Date: Day value exceeds length of month'); else if ((this.form.ed_month.selectedIndex > 0 || this.form.ed_day.selectedIndex > 0 || this.form.ed_year.selectedIndex > 0) && (this.form.ed_month.selectedIndex == 0 || this.form.ed_day.selectedIndex == 0 || this.form.ed_year.selectedIndex == 0)) alert('Date Entered: You must set a complete date or clear it entirely'); else if ((this.form.ed_day.selectedIndex == 31 && (this.form.ed_month.selectedIndex == 4 || this.form.ed_month.selectedIndex == 6 || this.form.ed_month.selectedIndex == 9 || this.form.ed_month.selectedIndex == 11)) || (this.form.ed_month.selectedIndex == 2 && this.form.ed_day.selectedIndex > 29) || (this.form.ed_month.selectedIndex == 2 && this.form.ed_day.selectedIndex > 28 && this.form.ed_year.selectedIndex != 3 && this.form.ed_year.selectedIndex != 7 && this.form.ed_year.selectedIndex != 11 && this.form.ed_year.selectedIndex != 15 && this.form.ed_year.selectedIndex != 19 && this.form.ed_year.selectedIndex != 23 && this.form.ed_year.selectedIndex != 27 && this.form.ed_year.selectedIndex != 31)) alert('Date Entered: Day value exceeds length of month'); else this.form.submit();"></td>

</form>

<form action="formview.cfm?id=#form_id#" method="post">

		<td align="right"><input type="submit" value="Cancel"></td>

</form>

	</tr>

</table><br>



</cfoutput><cfmodule template="../footer.cfm">