<cfquery name="getprogram" datasource="#application.dbSrc#">
	select prg_id, prg_nm, st
	from tbl_prg_all
	where recid='#program_id#'
</cfquery>
<cfset prg_id=getprogram.prg_id>
<cfset pname=getprogram.prg_nm>
<cfset pstate=getprogram.st>