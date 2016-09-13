
<cfquery name="results" datasource="#application.dbSrc#">
		
update program set legacy_prg_id = 'XXX-XXX-' + cast(program_id as char) +
'-XX-XX' where legacy_prg_id is null or legacy_prg_id = '';
select * from program where legacy_prg_id is null or legacy_prg_id = '';
</cfquery>

<cfquery name="results" datasource="#application.dbSrc#">
select h.help_id, h.help_code, ht.code type_code, h.keyword, dt.display_code title_code, d.display_code text_code
		from `help` h inner join `helptype` ht
				on h.helptype_id=ht.helptype_id
			inner join `display` d
				on h.display_id=d.display_id
			left outer join `display` dt
				on h.title_display_id=dt.display_id
		order by h.help_code
</cfquery>


<cfdump var="#results#">
<cfquery name="results2" datasource="#application.dbSrc#">
		
select * from city_zip where city_id = '005965' 

</cfquery>


<cfdump var="#results2#">
<!---h3>Programs without legacy id</h3>


<!--- Display results  - comment out when executing batch --->



<cfabort --->