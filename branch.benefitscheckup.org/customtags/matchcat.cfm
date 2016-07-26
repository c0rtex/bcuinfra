<!-- find category is session program list --->
<cfparam name="attributes.category_id" type="numeric"> 
<cfparam name="attributes.prg_list" default="">
<cfparam name="attributes.program_id" default="0">

<cfquery name="matchCat" datasource="#session.datasrc#">
select  program_id from program p  
where p.programcategory_id = #attributes.category_id#
</cfquery>
<cfset caller.matched_prg_id = "">
<cfset caller.matchcat="false">
<cfloop query=matchCat >
<cfset checkID  = 'XXX-XXX-' & matchCat.program_id & '-XX-XX' >
<cfif #listcontainsnocase(attributes.prg_list,checkID)#>
	<cfset caller.matchcat="true">
	<cfset caller.matched_prg_id = checkID>

</cfif>
</cfloop>



