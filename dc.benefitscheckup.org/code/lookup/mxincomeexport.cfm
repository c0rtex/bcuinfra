<cfparam name="format" type="string" default="csv"><cf_exportQuery query="
	select qmb.st, qmb.single_max as qmb_single_max, qmb.single_min as qmb_single_min,
		qmb.couple_max as qmb_couple_max, qmb.couple_min as qmb_couple_min,
		slmb.single_max as slmb_single_max, slmb.single_min as slmb_single_min,
		slmb.couple_max as slmb_couple_max, slmb.couple_min as slmb_couple_min,
		qi1.single_max as qi1_single_max, qi1.single_min as qi1_single_min,
		qi1.couple_max as qi1_couple_max, qi1.couple_min as qi1_couple_min
	from tbl_mx_income qmb, tbl_mx_income slmb, tbl_mx_income qi1
	where qmb.tbl_nm='QMB'
		and qmb.st=slmb.st
		and slmb.tbl_nm='SLMB'
		and slmb.st=qi1.st
		and qi1.tbl_nm='QI1'
	order by qmb.st
" columnList="st,qmb_single_max,qmb_single_min,qmb_couple_max,qmb_couple_min,slmb_single_max,slmb_single_min,slmb_couple_max,slmb_couple_min,qi1_single_max,qi1_single_min,qi1_couple_max,qi1_couple_min" format="#format#">