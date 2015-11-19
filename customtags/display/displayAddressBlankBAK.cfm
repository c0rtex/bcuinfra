<cfsilent>
<cfparam name="attributes.contact" type="boolean" default="false">
<cfparam name="attributes.style" type="string" default="">
<cfparam name="attributes.var" type="string" default="">

<cfset outstr = ''>
<cfif attributes.style eq ''>
	<cfset style = ''>
<cfelse>
	<cfset style = " style=""#attributes.style#""">
</cfif>
<cf_displayText group="site" code="site_form_label_name" var="name">
<cf_displayText group="site" code="site_form_label_address" var="add">
<cf_displayText group="site" code="site_form_label_city" var="city">
<cf_displayText group="site" code="site_form_label_state" var="st">
<cf_displayText group="site" code="site_form_label_zip" var="zip">
<cf_displayText group="site" code="site_form_label_phone" var="ph">
<cf_displayText group="site" code="site_form_label_alternate_contact" var="alt">
<cf_displayText group="site" code="site_form_label_relationship" var="rel">

<cfset outstr = outstr & "<table align=""center"" border=""0"" width=""100%"">
	<tr>
		<td#style#>
		">
<cfif attributes.contact>
	<cfset outstr = outstr & "<b>#alt#:</b> _______________________________">
<cfelse>
	<cfset outstr = outstr & "<b>#name#:</b> _________________________________________">
</cfif>
<cfset outstr = outstr & "<br /><br />
		</td>
	</tr>
	<tr>
		<td#style#>
		">
<cfif attributes.contact>
	<cfset outstr = outstr & "#rel#: ____________________________________">
<cfelse>
	<cfset outstr = outstr & "#add#: _______________________________________">
</cfif>
<cfset outstr = outstr & "<br /><br />
		</td>
	</tr>
	<tr>
		<td#style#>
		">
<cfif attributes.contact>
	<cfset outstr = outstr & "#add#: _______________________________________">
<cfelse>
	<cfset outstr = outstr & "_______________________________________________">
</cfif>
<cfset outstr = outstr & "<br /><br />
		</td>
	</tr>
	<tr>
		<td#style#>
		#city#: _______________  &nbsp; #st#: _____ &nbsp; #zip#: __________<br /><br />
		</td>
	</tr>
	<tr>
		<td#style#>
		#ph#: __________________________________<br />
		</td>
	</tr>
</table>">

</cfsilent><cfif attributes.var eq ''><cfsilent>
	</cfsilent><cfoutput>#outstr#</cfoutput><cfsilent>
</cfsilent><cfelse><cfsilent>
	<cfset "caller.#attributes.var#" = outstr>
</cfsilent></cfif>