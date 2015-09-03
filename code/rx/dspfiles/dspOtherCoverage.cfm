
	<CFSET request.GetRetireeFS = "">
	<!-- Check LIS Benefit Type then Get Display info -->
	<cfif isdefined('session.lis_apply') and session.lis_apply eq 'y' >
		<CFSET benefit = 3 >
	<cfelseif findnocase( "103-311-2593-FD-FD", #prg_list#) gt 0 >
		<cfset benefit = 2 >
	<cfelseif findnocase( "103-311-2588-FD-FD", #prg_list#)  gt 0 and findnocase( "XXX-311-1288-PA-ST", #prg_list#) eq 0 and findnocase( "XXX-311-1289-PA-ST", #prg_list#) eq 0 and session.rec_pa_pace neq 'Y' and session.rec_pa_pacenet neq 'Y' >
		<cfset benefit = 1 >
	</cfif>
	
	<cfif  isdefined('session.receive_employ_retiree') and session.receive_employ_retiree eq 'y' and StructFind(session.screening.afval, 'receive_employ_retiree_credit_2') eq 0 >
		<CFSET answerfield = 'rec_employ_retiree_credit_0'>
		<CFSET request.GetRetireeFS = "N">
		<CFSET request.Compare = "N">
	<cfelseif isdefined('session.receive_employ_retiree') and session.receive_employ_retiree eq 'y' and StructFind(session.screening.afval, 'receive_employ_retiree_credit_2') eq 1462 >
		<CFSET answerfield = 'rec_employ_retiree_credit_1462'>
		<CFSET request.GetRetireeFS = "DK">
		<CFSET request.Compare = "N">
	<cfelseif isdefined('session.receive_medigap') and  session.receive_medigap eq 'y' >
		<cfif isdefined('session.receive_medigap_credit') and  session.receive_medigap_credit eq 'y'>
			<CFSET answerfield = 'receive_medigap_credit'>
		<cfelse>
			<CFSET answerfield = 'receive_medigap'>
		</cfif>
	<cfelseif isdefined('session.receive_medadv_plan_presc_y') and session.receive_medadv_plan_presc_y eq 'y' >
		<CFSET answerfield = 'receive_medadv_plan_presc_y'>
	<cfelseif isdefined('session.receive_medadv_plan_presc_n') and session.receive_medadv_plan_presc_n eq 'y' >
		<CFSET answerfield = 'receive_medadv_plan_presc_n'>
	<!-- others -->
	<cfelseif isdefined('session.med_receive_rx_n') and session.med_receive_rx_n eq 'y' >
		<CFSET answerfield = 'med_receive_rx_n'>
	<cfelseif isdefined('session.receive_adap') and session.receive_adap eq 'y' >
		<CFSET answerfield = 'receive_adap'>
	<cfelse>
			<CFSET answerfield = 'none'>
	</cfif>
<cfif answerfield neq 'none' >
<!-- Get content from db-->
<cfquery name="qryLIS" datasource="#application.dbSrc#">
	SELECT      pt.programtext_id, pt.summary, pt.rec, pt.type, pt.benefit, pt.actions
	FROM        programtext pt
	WHERE     
	pt.template = 'LIS' 
	and pt.benefit=<cfqueryparam 
                        value="#benefit#" 
                        cfsqltype="cf_sql_integer"
                        maxlength="2">
	and answerfield = <cfqueryparam 
                        value="#answerfield#" 
                        cfsqltype="CF_SQL_VARCHAR" 
                        maxlength="25">
</cfquery>

<!-- loop through query-->
<cfloop  query="qryLIS" startrow="1" endrow="1" >
<cfif mode eq "Summary">
			<cfif #len(summary)# gt 1>
				<cfoutput><li>#Summary#</li></cfoutput>
			</cfif>
<cfelse>
	<cfinclude template="../dspOtherOptions.cfm">
		<cfset rec = "#qryLIS.rec#">
		<cfset actions = "#qryLIS.actions#">
		<cfif len('actions') gt 0 and request.applynow neq "y" and request.compare neq "Y"><cfset result = #arrayAppend(arrayActions, qryLIS.Programtext_id)#></cfif>
		<p>
			<li>
			<!--- Recommendation ---->
			<cfoutput>#rec# </cfoutput>
			</li>
		<br>
		<cfif request.GetRetireeFS eq "N" >
			<cfoutput><a href="RetireeCoverage.pdf" target="_blank"><img src="images/button_fact-sheet.gif" border="0"></a></cfoutput>
			<em><br>(Clicking the button to the left will open a new window.)</em>
		<cfelseif request.GetRetireeFS eq "DK" >
			<cfoutput><a href="RetireeCoverage.pdf" target="_blank"><img src="images/button_fact-sheet.gif" border="0"></a></cfoutput>
			<em><br>(Clicking the button to the left will open a new window.)</em>
		</cfif>
		</p>
</cfif>
</cfloop>
</cfif>