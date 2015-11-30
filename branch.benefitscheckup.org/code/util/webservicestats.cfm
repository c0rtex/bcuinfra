
<cfquery name="results" datasource="#application.dbSrc#">
		
update program set legacy_prg_id = 'XXX-XXX-' + cast(program_id as char) +
'-XX-XX' where legacy_prg_id is null or legacy_prg_id = '';
select * from program where legacy_prg_id is null or legacy_prg_id = '';
</cfquery>

<cfquery name="results" datasource="#application.dbSrc#">
select * from screening where source_id = 8 order by START_DATETIME desc limit 0,200

</cfquery>


<cfdump var="#results#">
<cfquery name="results2" datasource="#application.dbSrc#">
		
select * from city_zip where city_id = '005965' 

</cfquery>


<cfdump var="#results2#">
<!---h3>Programs without legacy id</h3>


<!--- Display results  - comment out when executing batch --->



<cfabort --->