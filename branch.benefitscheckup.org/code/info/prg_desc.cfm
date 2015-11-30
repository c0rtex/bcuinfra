<CFQUERY NAME="prog" DATASOURCE = "#session.datasrc#">
	SELECT prg_id, st, prg_nm, prg_desc
	FROM tbl_prg_all
	ORDER BY st, prg_nm
</cfquery>

<b>Program Descriptions</b><br>

<cfoutput query="prog">
--------------------------------------------------<br>
#st#<br>
#prg_id#<br>
#prg_nm#<br>
#prg_desc#<br>
</cfoutput>