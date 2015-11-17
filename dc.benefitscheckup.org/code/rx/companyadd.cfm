<cfset name="">
<cfif isdefined("form.name")>
	<cfset name=form.name>
</cfif>
<cfif trim(name) eq ''>
	<cflocation url="companynew.cfm">
<cfelse>


<cfinclude template="companyanswerfield.cfm">
<cfinclude template="companyinsert.cfm">


<cflocation url="companyview.cfm?company_id=#id#">

</cfif>