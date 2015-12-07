<cfparam name="attributes.name" type="string">
<cfparam name="attributes.date" type="string" default="">
<cfparam name="attributes.day" type="any" default="">
<cfparam name="attributes.month" type="any" default="">
<cfparam name="attributes.year" type="any" default="">
<cfparam name="attributes.required" type="boolean" default="false">
<cfparam name="attributes.search" type="boolean" default="false">

<cfif attributes.date eq ''>
	<cfset bdsDay = ''>
	<cfset bdsMonth = ''>
	<cfset bdsYear = ''>
<cfelseif attributes.date eq '1'>
	<cfset bdsDay = attributes.day>
	<cfset bdsMonth = attributes.month>
	<cfset bdsYear = attributes.year>
<cfelse>
	<cfset bdsDay = Day(attributes.date)>
	<cfset bdsMonth = Month(attributes.date)>
	<cfset bdsYear = Year(attributes.date)>
</cfif>
<cfif attributes.search>
	<cfset prefix = ''>
<cfelse>
	<cfset prefix = 'zzyzx_'>
</cfif>

<cfoutput><select id="#prefix##attributes.name#_day" name="#prefix##attributes.name#_day">
<cfif not attributes.required><option value=""></cfif>
<cfloop from="1" to="31" index="d">
<option value="#d#"<cfif d eq bdsDay> selected</cfif>>#d#
</cfloop>
</select>
<select id="#prefix##attributes.name#_month" name="#prefix##attributes.name#_month">
<cfif not attributes.required><option value=""></cfif>
<cfloop from="1" to="12" index="m">
<option value="#m#"<cfif m eq bdsMonth> selected</cfif>>#MonthAsString(m)#
</cfloop>
</select>
<select id="#prefix##attributes.name#_year" name="#prefix##attributes.name#_year">
<cfif not attributes.required><option value=""></cfif>
<cfloop from="2001" to="2020" index="y">
<option value="#y#"<cfif y eq bdsYear> selected</cfif>>#y#
</cfloop>
</select>
&nbsp; <input type="button" value="today" onClick="document.getElementById('#prefix##attributes.name#_day').value = #Day(Now())#; document.getElementById('#prefix##attributes.name#_month').value = #Month(Now())#; document.getElementById('#prefix##attributes.name#_year').value = #Year(Now())#;" />
<cfif not attributes.required>&nbsp; <input type="button" value="clear" onClick="document.getElementById('#prefix##attributes.name#_day').value = ''; document.getElementById('#prefix##attributes.name#_month').value = ''; document.getElementById('#prefix##attributes.name#_year').value = '';" /></cfif>
<input type="hidden" name="#attributes.name#" value="1" /></cfoutput>