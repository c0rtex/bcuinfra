<cfset name="">
<cfif isdefined("form.gname")>
	<cfset name=form.gname>
</cfif>
<cfif trim(name) eq ''>
	<cflocation url="drugview.cfm?brand_id=#form.brand_id#">
<cfelse>

	<cfinclude template="genericanswerfield.cfm">
	<cfinclude template="genericinsert.cfm">
	<cflocation url="associate.cfm?generic_id=#id#&brand_id=#form.brand_id#&src=d">

</cfif>
