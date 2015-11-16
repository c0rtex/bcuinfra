<cfparam name="format" type="string" default="csv"><cf_exportQuery query="
	select tbl_id, proc_id, tbl_nm, st, county, mem1, mem2, mem3, mem4, mem5, mem6, mem7, mem8
	from tbl_inc_new
	order by tbl_nm, st, county
" columnList="tbl_id,proc_id,tbl_nm,st,county,mem1,mem2,mem3,mem4,mem5,mem6,mem7,mem8" format="#format#">