<cfparam name="format" type="string" default="csv"><cf_exportQuery query="
	select qmb.st, qmb.single as qmb_single, qmb.couple as qmb_couple,
		slmb.single as slmb_single, slmb.couple as slmb_couple,
		qi1.single as qi1_single, qi1.couple as qi1_couple,
		qi2.single as qi2_single, qi2.couple as qi2_couple
	from tbl_mx_asset qmb, tbl_mx_asset slmb, tbl_mx_asset qi1, tbl_mx_asset qi2
	where qmb.tbl_nm='QMB'
		and qmb.st=slmb.st
		and slmb.tbl_nm='SLMB'
		and slmb.st=qi1.st
		and qi1.tbl_nm='QI1'
		and qi1.st=qi2.st
		and qi2.tbl_nm='QI2'
	order by qmb.st
" columnList="st,qmb_single,qmb_couple,slmb_single,slmb_couple,qi1_single,qi1_couple,qi2_single,qi2_couple" format="#format#">