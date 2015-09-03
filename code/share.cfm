<cfparam name="first_name" type="string" default="">
<cfparam name="last_name" type="string" default="">
<cfparam name="city" type="string" default="">
<cfparam name="st" type="string" default="">
<cfparam name="phone" type="string" default="">
<cfparam name="email" type="string" default="">
<cfparam name="learn" type="string" default="">
<cfparam name="submit" type="string" default="">
<cfparam name="src" type="string" default="e">

<cfset errors = 0>
<cfset first_name_error = 0>
<cfset last_name_error = 0>
<cfset city_error = 0>
<cfset contact_error = 0>

<cfif submit eq ''>
	<cfset st = session.st>
<cfelse>
	<cfif first_name eq ''>
		<cfset errors = 1>
		<cfset first_name_error = 1>
	</cfif>
	<cfif last_name eq ''>
		<cfset errors = 1>
		<cfset last_name_error = 1>
	</cfif>
	<cfif city eq ''>
		<cfset errors = 1>
		<cfset city_error = 1>
	</cfif>
	<cfif phone eq '' and email eq ''>
		<cfset errors = 1>
		<cfset contact_error = 1>
	</cfif>
</cfif>

<cfif submit neq '' and errors eq 0>
	<cfquery name="ins_survey" datasource="#application.dbSrc#">
		insert into survey
			(screening_id, first_name, last_name, city, state_id, phone, email, learn)
		values
			(#session.screening_id#, 
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#first_name#" maxlength="50">, 
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#last_name#" maxlength="50">, 
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#city#" maxlength="100">, 
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#st#" maxlength="2">, 
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#phone#" maxlength="50">, 
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#email#" maxlength="50">, 
			<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#learn#" maxlength="500">)
	</cfquery>
	<cfif src eq 'r'>
		<cflocation url="frmRecommend.cfm?aft=1" addtoken="Yes">
	<cfelse>
		<cflocation url="frmeligibility.cfm?aft=1" addtoken="Yes">
	</cfif>
<cfelse>

<cf_tagHeader show_title="yes" guts="frmeligibility.cfm" popupwarning="1">

<cfif first_name_error or last_name_error or city_error><p style="background-color: pink;">We're sorry, but you are required to enter a first name, last name, and city in order to complete this form.</p></cfif>

<cfif contact_error><p style="background-color: #ffcc66;"><cfif first_name_error or last_name_error or city_error>Additionally, y<cfelse>Y</cfif>ou are required to enter either a phone number or an email address so we can contact you.</p></cfif>

<p>Please enter in the following information.  It's important that you provide
either a Phone Number or E-mail address so we can get in touch with you to hear
your story.</p>

<cfoutput>
<form action="share.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#" method="post">

<table width="750">
	<tr>
		<td align="right" width="230"<cfif first_name_error> bgcolor="pink"</cfif>><strong>First name:</strong></td>
		<td rowspan="8" width="10">&nbsp;</td>
		<td width="510"><input type="text" name="first_name" value="#HTMLEditFormat(first_name)#" size="40" maxsize="255"></td>
	</tr>
	<tr>
		<td align="right"<cfif last_name_error> bgcolor="pink"</cfif>><strong>Last name:</strong></td>
		<td><input type="text" name="last_name" value="#HTMLEditFormat(last_name)#" size="40" maxsize="255"></td>
	</tr>
	<tr>
		<td align="right"<cfif city_error> bgcolor="pink"</cfif>><strong>City:</strong></td>
		<td><input type="text" name="city" value="#HTMLEditFormat(city)#" size="30" maxsize="255"></td>
	</tr>
	<tr>
		<td align="right"><strong>State:</strong></td>
		<td><cf_tagStateDropDown selected="#st#"></td>
	</tr>
	<tr>
		<td align="right"<cfif contact_error> bgcolor="##ffcc66"</cfif>><strong>Phone number:</strong></td>
		<td><input type="text" name="phone" value="#HTMLEditFormat(phone)#" size="15" maxsize="255"></td>
	</tr>
	<tr>
		<td align="right"<cfif contact_error> bgcolor="##ffcc66"</cfif>><strong>E-mail address:</strong></td>
		<td><input type="text" name="email" value="#HTMLEditFormat(email)#" size="40" maxsize="255"></td>
	</tr>
	<tr>
		<td align="right" valign="top"><strong>How did you learn about BenefitsCheckUp?</strong></td>
		<td><textarea name="learn" cols="50" rows="5">#HTMLEditFormat(learn)#</textarea></td>
	</tr>
	<tr>
		<td colspan="2"><input type="hidden" name="src" value="#src#"></td>
		<td><input type="submit" name="submit" value=" Submit "> <input type="reset" value=" Reset "></td>
	</tr>
</table>

</form>
</cfoutput>

<p>Thank you for taking the time to fill out your contact information.</p>

<p><strong>Please note:</strong>&nbsp; We will do our best to contact as many people as possible.  If we do not contact you, and you would like to get in touch with us, please send an email to: <a href="mailto:support@benefitscheckup.org">support@benefitscheckup.org</a>.</p>

<cf_tagFooter>

</cfif>