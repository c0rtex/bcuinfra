<cfset name="">
<cfif isdefined("form.name")>
	<cfset name=form.name>
</cfif>
<cfif trim(name) eq ''>
	<cflocation url="genericnew.cfm">
<cfelse>


<cfinclude template="genericanswerfield.cfm">
<cfinclude template="genericinsert.cfm">


<cflocation url="genericview.cfm?generic_id=#id#">

</cfif>