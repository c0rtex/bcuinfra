<cfset name="">
<cfif isdefined("form.dname")>
	<cfset name=form.dname>
</cfif>
<cfif trim(name) eq ''>
	<cflocation url="genericview.cfm?generic_id=#form.generic_id#">
<cfelse>

	<cfinclude template="druganswerfield.cfm">
	<cfinclude template="druginsert.cfm">
	<cflocation url="associate.cfm?generic_id=#form.generic_id#&brand_id=#id#&src=g">

</cfif>
