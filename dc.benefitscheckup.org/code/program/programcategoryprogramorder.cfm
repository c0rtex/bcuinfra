<cfparam name="id" type="numeric">
<cfparam name="minimum" type="numeric" default="1">
<cfparam name="saving" type="numeric" default="0">

<cf_checkAccess level="3">

<cfif not saving>
	<!--- If not saving the reordered values, then this particular application
	      needs to pre-reorder the programs to group the program before doing
		  the internal category reorder --->
	<cfquery name="preorder" datasource="#application.dbSrc#">
		select p.program_id
		from program p, programcategory pc
		where p.programcategory_id=pc.programcategory_id
		order by pc.sort, p.sort
	</cfquery>
	<cfset itemplace = 1>
	<cfloop query="preorder">
		<cfquery name="reorder" datasource="#application.dbSrc#">
			update program
			set sort=#itemplace#
			where program_id=#program_id#
		</cfquery>
		<cfset itemplace = itemplace + 1>
	</cfloop>
</cfif>

<cf_buildPage title="Program Order in Category" section="program" js="order"><cfoutput>

<cf_buildOrder title="Program Order in Category" table="program" code="programcategory" selflink="true" startatminimum="true" minimum="#minimum#" condition="programcategory_id=#id#" asteriskcolumn="supersort" redirect="programcategoryview.cfm?id=#id#" saving="#saving#" message="* marks programs included in supersort,<br />&nbsp; which overrides this ordering">

</cfoutput></cf_buildPage>