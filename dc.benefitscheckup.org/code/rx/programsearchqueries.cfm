<cfquery name="getname" datasource="#application.dbSrc#">
	select p.recid, p.prg_id, p.prg_nm, ifnull(sp.prg_id, 0) AS rx_only
	from tbl_prg_all p left outer join view_program_rx sp
		on p.prg_id=sp.prg_id
	where p.prg_nm like '%#name#%'
	order by p.prg_nm
</cfquery>
<cfquery name="getsound" datasource="#application.dbSrc#">
	select p.recid, p.prg_id, p.prg_nm, ifnull(sp.prg_id, 0) AS rx_only
	from tbl_prg_all p left outer join view_program_rx sp
		on p.prg_id=sp.prg_id
	where p.prg_nm not like '%#name#%'
		and DIFFERENCE(p.prg_nm, '#name#') = 4
	order by p.prg_nm
</cfquery>