<cfparam name="id" type="numeric">
<cfparam name="confirm" type="boolean" default="false">
<cfparam name="name" type="string" default="">

<cfif name eq ''>
	<cfset anchorname = ''>
	<cfset passanchorname = ''>
<cfelse>
	<cfset anchorname = "###name#">
	<cfset passanchorname = "&name=#name#">
</cfif>

<cf_checkAccess level="3">

<cfquery name="prg" datasource="#application.dbSrc#">
	select p.program_id
	from programvalue v, program p
	where v.programvalue_id=#id#
    	and v.program_id=p.program_id
</cfquery>


<cfif not confirm>

	<cf_buildPage title="Program Value Administration" section="program">
	<cfoutput>
	Are you sure you want to delete that program value?<br /><br />
	<a href="?id=#id#&program_id=#prg.program_id#&confirm=true#passanchorname#">YES</a> &nbsp; &nbsp; <a href="programview.cfm?id=#prg.program_id##anchorname#">NO</a>
	</cfoutput>
	</cf_buildpage>

<cfelse>

	<cfquery name="delete" datasource="#application.dbSrc#">
		delete from programvalue
		where programvalue_id=#id#
	</cfquery>
	<cflocation url="programview.cfm?id=#prg.program_id##anchorname#" addtoken="no">

</cfif>