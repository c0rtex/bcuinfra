
<cfquery name="results" datasource="#application.dbSrc#">
		


update program set legacy_prg_id = 'XXX-XXX-' + cast(program_id as char) +
'-XX-XX' where legacy_prg_id is null or legacy_prg_id = '';

select * from program where legacy_prg_id is null or legacy_prg_id = '';



</cfquery>


<h3>Programs without legacy id</h3>
<cfdump var="#results#">



<!--- Display results  - comment out when executing batch --->



<cfabort >