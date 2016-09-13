<cfquery name="qryStateReceive" datasource="#application.dbSrc#">
	SELECT a.answerfield, p.prg_id, p.order_num
	FROM tbl_prg_all p, program_answerfield pa, answerfield a
	WHERE p.st =<cfqueryparam 
					value="#session.st#" 
					cfsqltype="cf_sql_varchar"
 					maxlength="2">
			and p.RecID=pa.program_id
			and pa.answerfield_id=a.answerfield_id
			and a.answerfield like 'rec_#session.st#%'
	order by p.order_num desc,a.answerfield desc, p.prg_id
</cfquery>
<cfif isdefined('url.showquery')>
	<cfdump var="#qryStateReceive#">
</cfif>
<cfset stateReceive_prg_id = "">
<cfset stateType = 'eligible'>
<cfset stateReceive = "No">
<cfloop query="qryStateReceive">
<cfset strReceive = "session." & "#answerfield#">
<cfif isdefined('#strReceive#') and evaluate('#strReceive#') eq 'Y'>
	<cfset stateType = 'receiving'>
	<cfset stateReceive = '#answerfield#'>
	<cfif  isdefined('session.rec_vt_vpharm1') and isdefined('session.rec_vt_vhap') and session.rec_vt_vpharm1 eq 'y' and session.rec_vt_vhap eq 'y'  >
		<cfset stateReceive_prg_id = "XXX-311-2719-VT-ST">
	</cfif>
	<cfif  isdefined('session.rec_vt_vpharm1') and isdefined('session.rec_vt_vscript') and session.rec_vt_vpharm1 eq 'y' and session.rec_vt_vscript eq 'y'  >
		<cfset stateReceive_prg_id = "XXX-311-2719-VT-ST">
	</cfif>
	<cfif  isdefined('session.rec_vt_vpharm1') and isdefined('session.rec_vt_vscriptexp') and session.rec_vt_vpharm1 eq 'y' and session.rec_vt_vscriptexp eq 'y'  >
		<cfset stateReceive_prg_id = "XXX-311-2719-VT-ST">
	</cfif>
	<cfif  isdefined('session.rec_vt_vpharm2') and isdefined('session.rec_vt_vhap') and session.rec_vt_vpharm2 eq 'y' and session.rec_vt_vhap eq 'y'  >
		<cfset stateReceive_prg_id = "XXX-311-2720-VT-ST">
	</cfif>
	<cfif  isdefined('session.rec_vt_vpharm2') and isdefined('session.rec_vt_vscript') and session.rec_vt_vpharm2 eq 'y' and session.rec_vt_vscript eq 'y'  >
		<cfset stateReceive_prg_id = "XXX-311-2720-VT-ST">
	</cfif>
	<cfif  isdefined('session.rec_vt_vpharm2') and isdefined('session.rec_vt_vscriptexp') and session.rec_vt_vpharm2 eq 'y' and session.rec_vt_vscriptexp eq 'y'  >
		<cfset stateReceive_prg_id = "XXX-311-2720-VT-ST">
	</cfif>
	<cfif  isdefined('session.rec_vt_vpharm3') and isdefined('session.rec_vt_vhap') and session.rec_vt_vpharm3 eq 'y' and session.rec_vt_vhap eq 'y'  >
		<cfset stateReceive_prg_id = "XXX-311-2721-VT-ST">
	</cfif>
	<cfif  isdefined('session.rec_vt_vpharm3') and isdefined('session.rec_vt_vscript') and session.rec_vt_vpharm3 eq 'y' and session.rec_vt_vscript eq 'y'  >
		<cfset stateReceive_prg_id = "XXX-311-2721-VT-ST">
	</cfif>
	<cfif  isdefined('session.rec_vt_vpharm3') and isdefined('session.rec_vt_vscriptexp') and session.rec_vt_vpharm3 eq 'y' and session.rec_vt_vscriptexp eq 'y'  >
		<cfset stateReceive_prg_id = "XXX-311-2721-VT-ST">
	</cfif>
	<cfif  isdefined('session.rec_il_caresrx') and isdefined('session.rec_il_circuitbreaker') and session.rec_il_caresrx eq 'y' and session.rec_il_circuitbreaker eq 'y'  >
		<cfset stateReceive_prg_id = "XXX-311-2716-IL-ST">
	</cfif>
	<cfif  isdefined('session.rec_il_caresrx') and isdefined('session.rec_il_seniorcare') and session.rec_il_caresrx eq 'y' and session.rec_il_seniorcare eq 'y'  >
		<cfset stateReceive_prg_id = "XXX-311-2716-IL-ST">
	</cfif>
	<cfif  isdefined('session.rec_mo_rxplan') and isdefined('session.rec_mo_seniorrx') and session.rec_mo_rxplan eq 'y' and session.rec_mo_seniorrx eq 'y'  >
		<cfset stateReceive_prg_id = "XXX-311-2717-MO-ST">
	</cfif>
	<cfif  isdefined('session.rec_sc_gaps') and isdefined('session.rec_sc_silverrx') and session.rec_sc_gaps eq 'y' and session.rec_sc_silverrx eq 'y'  >
		<cfset stateReceive_prg_id = "XXX-311-2718-SC-ST">
	</cfif>
	<cfif stateReceive eq "rec_me_del" >
		<cfset stateReceive_prg_id = "XXX-311-1223-ME-ST">
	<cfelseif stateReceive eq "rec_me_rxplus" >
		<cfset stateReceive_prg_id = "118-311-2574-ME-ST">
	<cfelseif stateReceive eq "rec_nj_paad">
		<cfset stateReceive_prg_id = "117-311-1020-NJ-ST">
	<cfelseif stateReceive eq "rec_nj_seniorgold" >
		<cfset stateReceive_prg_id = "XXX-311-2263-NJ-ST">
	<cfelseif stateReceive eq "rec_pa_pace">
		<cfset stateReceive_prg_id = "XXX-311-1288-PA-ST">
	<cfelseif stateReceive eq "rec_pa_pacenet" >
		<cfset stateReceive_prg_id = "XXX-311-1289-PA-ST">
	<cfelseif stateReceive eq "rec_il_circuitbreaker" >
		<cfset stateReceive_prg_id = "XXX-311-1555-IL-ST">
	<cfelseif stateReceive eq "rec_il_seniorcare">
		<cfset stateReceive_prg_id = "XXX-311-2669-IL-ST">
	<cfelseif stateReceive eq "rec_il_rxbuyingclub" >
		<cfset stateReceive_prg_id = "118-311-2524-IL-ST">
	<cfelseif stateReceive eq "rec_de_dpap">
		<cfset stateReceive_prg_id = "XXX-311-2191-DE-ST">
	<cfelseif stateReceive eq "rec_de_nemours" >
		<cfset stateReceive_prg_id = "XXX-311-2577-DE-ST">
	<cfelseif stateReceive eq "rec_sc_silverrx" >
		<cfset stateReceive_prg_id = "XXX-311-2191-SC-ST">
	<cfelseif stateReceive eq "rec_vt_healthy_vermonters">	
		<cfset stateReceive_prg_id = "118-311-2578-VT-ST">
	<cfelseif stateReceive eq "rec_vt_vpharm1" >
		<cfset stateReceive_prg_id = "XXX-311-2719-VT-ST">
	<cfelseif stateReceive eq "rec_vt_vpharm2" >
		<cfset stateReceive_prg_id = "XXX-311-2720-VT-ST">
	<cfelseif stateReceive eq "rec_vt_vpharm3" >
		<cfset stateReceive_prg_id = "XXX-311-2721-VT-ST">
	<cfelseif stateReceive eq "rec_vt_vhap">	
		<cfset stateReceive_prg_id = "118-311-2417-VT-ST">
	<cfelseif stateReceive eq "rec_vt_vscript">	
		<cfset stateReceive_prg_id = "118-311-2418-VT-ST">
	<cfelseif stateReceive eq "rec_vt_vscriptexp">	
		<cfset stateReceive_prg_id = "XXX-311-1750-VT-ST">
	<cfelse>
		<cfset stateReceive_prg_id = qryStateReceive.prg_id >
	</cfif>
</cfif>
</cfloop>
<cfif stateReceive eq "rec_il_rxbuyingclub" and #listcontains(prg_list,'XXX-311-1555-IL-ST')# >
	<cfset stateType = 'eligible'>
	<cfset stateReceive = "No">
<cfelseif stateReceive eq "rec_il_rxbuyingclub" and #listcontains(prg_list,'XXX-311-2669-IL-ST')#>
	<cfset stateType = 'eligible'>
	<cfset stateReceive = "No">
</cfif>
<cfif (isdefined('session.receive_partd') and session.receive_partd eq 'y') and (isdefined('session.receive_lis') and session.receive_lis eq 'y') >
	<cfset LIS = 2>
<cfelseif (isdefined('session.receive_partd') and session.receive_partd eq 'y')  >
	<cfset LIS = 7>
<cfelseif  (isdefined('session.receive_lis') and session.receive_lis eq 'y')  >
	<cfset LIS = 2>
<cfelseif ((isdefined('session.rec_il_rxbuyingclub') and session.rec_il_rxbuyingclub neq 'Y') and not #listcontains(prg_list, "118-311-2524-IL-ST")# ) and ((isdefined('session.receive_medadv_plan_presc_n') and session.receive_medadv_plan_presc_n eq 'y' ) or (isdefined('session.receive_medadv_plan_presc_y') and session.receive_medadv_plan_presc_y eq 'y' )) >
	<cfset LIS = 5>
<cfelseif (( isdefined('session.rec_il_rxbuyingclub') and session.rec_il_rxbuyingclub neq 'Y') and not #listcontains(prg_list, "118-311-2524-IL-ST")#) and  (isdefined('session.receive_employ_retiree') and session.receive_employ_retiree eq 'y' ) >
	<cfset LIS = 6>
<cfelseif isdefined('session.receive_msp') and session.receive_msp eq 'y'>
	<cfset LIS = 4>
<cfelseif isdefined('session.lis_apply') and session.lis_apply eq 'y'>
	<cfset LIS = 3>
<cfelseif #listcontains(prg_list,'103-311-2593-FD-FD')#>
	<cfset LIS = 2>
	<cfelseif #listcontains(prg_list,'103-311-2588-FD-FD')#>
	<cfset LIS = 1>
<cfelse>
	<cfset LIS = 0>
</cfif>
<cfif stateReceive eq "No">
	<cfquery name="qryStatePrg" datasource="#application.dbSrc#">
	SELECT      p.prg_id, p.prg_nm, pt.programtext_id, pt.summary, pt.rec, pt.type, pt.benefit, pt.actions
	FROM          tbl_prg_all p, programtext pt
	WHERE     
	p.recid = pt.program_id
	and p.st =<cfqueryparam 
					value="#session.st#" 
					cfsqltype="cf_sql_varchar"
 					maxlength="2">  
	and pt.Active=1
	and pt.type = <cfqueryparam 
                        value="#stateType#" 
                        cfsqltype="CF_SQL_VARCHAR" 
                        maxlength="25">
	and benefit =<cfqueryparam 
                        value="#LIS#" 
                        cfsqltype="cf_sql_integer"
                        maxlength="2">
	and  p.prg_id in (#preservesinglequotes(prg_list)#) and pt.template = 'SPAP'
	order by p.order_num, p.prg_nm
	</cfquery>
<cfelse>
	<cfquery name="qryStatePrg" datasource="#application.dbSrc#">
		<cfif session.st eq "OH" or session.st eq "IL" or session.st eq "VT" or session.st eq "OR">
		SELECT      p.prg_id, p.prg_nm, pt.programtext_id, pt.summary, pt.rec, pt.type, pt.benefit, pt.actions, p.order_num
		FROM          tbl_prg_all p, programtext pt
		WHERE     
		p.recid = pt.program_id
		and p.st =<cfqueryparam 
					value="#session.st#" 
					cfsqltype="cf_sql_varchar"
 					maxlength="2">
		and pt.type = 'eligible' 
		and pt.benefit =<cfqueryparam 
                        value="#LIS#" 
                        cfsqltype="cf_sql_integer"
                        maxlength="2">
		and pt.Active=1
		and  p.prg_id in (#preservesinglequotes(prg_list)#) and pt.template = 'SPAP'
		union all
		</cfif>	
		SELECT p.prg_id, p.prg_nm, pt.programtext_id, pt.summary, pt.rec, pt.type, pt.benefit, pt.actions, p.order_num
		FROM tbl_prg_all p, program_answerfield pa, answerfield a, programtext pt
		WHERE (
				<cfif isdefined('session.rec_oh_bestrx') and isdefined('session.rec_oh_buckeye') and session.rec_oh_buckeye eq 'y' 	and session.rec_oh_bestrx eq 'y'>
				 (a.answerfield = 'rec_oh_bestrx' or a.answerfield = 'rec_oh_buckeye') 
				
				<cfelseif isdefined('session.rec_or_pdap_2') and isdefined('session.rec_or_pdap') and session.rec_or_pdap_2 eq 'y' 	and session.rec_or_pdap eq 'y'>
				 (a.answerfield = 'rec_or_pdap' or a.answerfield = 'rec_or_pdap_2')  
				<cfelse>
				 p.prg_id = <cfqueryparam 
					value="#stateReceive_prg_id#" 
					cfsqltype="cf_sql_varchar"
 					maxlength="30">
				 and a.answerfield = <cfqueryparam 
					value="#stateReceive#" 
					cfsqltype="cf_sql_varchar"
 					maxlength="30">
				</cfif>
		and p.st =<cfqueryparam 
					value="#session.st#" 
					cfsqltype="cf_sql_varchar"
 					maxlength="2">
		and p.recid = pa.program_id
		and pa.answerfield_id=a.answerfield_id
		and p.recid = pt.program_id
		and pt.type = <cfqueryparam 
                        value="#stateType#" 
                        cfsqltype="CF_SQL_VARCHAR" 
                        maxlength="25">
		and pt.benefit =<cfqueryparam 
                        value="#LIS#" 
                        cfsqltype="cf_sql_integer"
                        maxlength="2">
		and pt.Active=1
		and pt.template = 'SPAP' )
		order by p.order_num, p.prg_nm 
	</cfquery>

</cfif>
<cfset request.sttype = stateType>
<cfset request.stbenefit = LIS>
<cfif stateReceive_prg_id neq "">
<cfset RxPrgList = #listappend(RxPrgList,stateReceive_prg_id, ",")#>
</cfif>
<cfif isdefined('url.showquery')>
	<cfdump var="#qryStatePrg#">
	<cfdump var="#request#">
	<cfoutput><br>  stateReceive_prg_id: #stateReceive_prg_id# <br>
				stateType: #stateType# <br>
				stateReceive: #stateReceive#</cfoutput>
</cfif>