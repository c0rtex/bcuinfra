<cfset name="">
<cfif isdefined("form.name")>
	<cfset name=form.name>
</cfif>
<cfif trim(name) eq ''>
	<cflocation url="drugnew.cfm">
<cfelse>


<cfinclude template="druganswerfield.cfm">
<cfinclude template="druginsert.cfm">


<cflocation url="drugview.cfm?brand_id=#id#">

</cfif>