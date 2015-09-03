<cfset medicareOutput = 'N' >
<cfset MedicareSavingsName = "">
<cfset MedicareSavingsPrg_ID = "">
<!-- check for medicare savings programs: 103-309-1031-FD-FD, 103-309-1071-FD-FD,  103-309-1032-FD-FD -->
<CFIF listcontains( #prg_list#, "103-309-1031-FD-FD") >
	<cfset MedicareSavingsName = "Medicare Savings Program - Qualified Medicare Beneficiary (QMB)">
	<cfset MedicareSavingsPrg_ID = "103-309-1031-FD-FD">
	<cfset medicareOutput = 'Y' >
<cfelseif listcontains( #prg_list#, "103-309-1071-FD-FD")>
	<cfset MedicareSavingsName = "Medicare Savings Program - Qualifying Individual (QI)">
	<cfset MedicareSavingsPrg_ID = "103-309-1071-FD-FD">
	<cfset medicareOutput = 'Y' >
<cfelseif listcontains( #prg_list#, "103-309-1032-FD-FD") >
	<cfset MedicareSavingsName = "Medicare Savings Program - Specified Low-Income Medicare Beneficiary (SLMB)">
	<cfset MedicareSavingsPrg_ID = "103-309-1032-FD-FD">
	<cfset medicareOutput = 'Y' >
<!--- Arizona programs .... 103-309-2681-AZ-ST .....103-309-2683-AZ-ST....103-309-2682-AZ-ST --->
<cfelseif listcontains( #prg_list#, "103-309-2681-AZ-ST") >
	<cfset MedicareSavingsName = "Medicare Savings Program Qualified Medicare Beneficiary (QMB)">
	<cfset MedicareSavingsPrg_ID = "103-309-2681-AZ-ST">
	<cfset medicareOutput = 'Y' >
<cfelseif listcontains( #prg_list#, "103-309-2683-AZ-ST") >
	<cfset MedicareSavingsName = "Medicare Savings Program Qualifying Individual (QI)">
	<cfset MedicareSavingsPrg_ID = "103-309-2683-AZ-ST">
	<cfset medicareOutput = 'Y' >
<cfelseif listcontains( #prg_list#, "103-309-2682-AZ-ST") >
	<cfset MedicareSavingsName = "Medicare Savings Program Specified Low-Income Medicare Beneficiary (SLMB)">
	<cfset MedicareSavingsPrg_ID = "103-309-2682-AZ-ST">
	<cfset medicareOutput = 'Y' >
<!--- NY programs .... 103-309-2940-NY-ST --->
<cfelseif listcontains( #prg_list#, "103-309-2940-NY-ST") >
	<cfset MedicareSavingsName = "Medicare Savings Program - Qualifying Individual (QI)">
	<cfset MedicareSavingsPrg_ID = "103-309-2940-NY-ST">
	<cfset medicareOutput = 'Y' >
<!--- CT programs .... 103-309-2939-CT-ST --->
<cfelseif listcontains( #prg_list#, "103-309-2939-CT-ST") >
	<cfset MedicareSavingsName = "Medicare Savings Program - Additional Low-Income Medicare Beneficiary (ALMB)">
	<cfset MedicareSavingsPrg_ID = "103-309-2939-CT-ST">
	<cfset medicareOutput = 'Y' >
</cfif>

<cfif medicareOutput eq 'Y'>
<cfif not isdefined('benefit')>
	<cfset benefit = 1>
</cfif>
<cfif benefit eq 9 >
	<cfset benefit = 2>
<cfelseif benefit eq 8>
	<cfset benefit = 2>
<cfelseif benefit eq 7>
	<cfset benefit = 1>
</cfif>
<cfif session.subset_id eq 40>
	<cfquery name="getvar" datasource="#application.dbSrc#">
			SELECT a.answerfield, sa.responsetype, sa.response, sa.option_id, o.option_code, sa.encryption_flag, sa.encrypted_response
         	FROM answerfield a 
         	INNER JOIN screening_answerfield sa ON a.answerfield_id = sa.answerfield_id 
          	LEFT OUTER JOIN `option` o ON sa.option_id = o.option_id
          	WHERE     sa.screening_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.screening_id#">
            and a.answerfield_id = 6259
          	ORDER BY a.answerfield 
	</cfquery>
	<cfset request.be_send_mspinfo_cd = "">
	<cfif getvar.recordcount gt 0>
	<cfset request.be_send_mspinfo_cd = getvar.option_code>
	  <cfif request.be_send_mspinfo_cd eq 'Y'>
          <cfset answerfield = "be_send_mspinfo_cd_optout">
      <cfelse>
      	  <cfset answerfield = "be_send_mspinfo_cd_optin">
      </cfif>
	</cfif>
	<cfif qrySubmission.submission_status eq 1>
	<cfset benefit = 21 >
	<cfelse>
	<cfset benefit =33 >
	</cfif>
	
</cfif>
<cfquery name="qryMSP" datasource="#session.datasrc#">
	SELECT      pt.programtext_id, pt.summary, pt.rec, pt.type, pt.benefit, pt.actions
	FROM        programtext pt
	WHERE     
	pt.template = 'MSP' and pt.benefit = (#benefit#)
    <cfif isdefined('request.be_send_mspinfo_cd')>
    and answerfield = <cfqueryparam cfsqltype="cf_sql_varchar" value="#answerfield#">
	</cfif>    	
</cfquery>

<cfif isdefined('url.debug')><cfdump var="#qryMSP#"></cfif>

	<cfloop query="qryMSP">
		<cfif mode neq "Summary">
			<cfset RxPrgList = #ListAppend(RxPrgList, MedicareSavingsPrg_ID, ",")# >
			<cfinclude template="../dspOtherOptions.cfm">
			
			<cfoutput><p>
			<li>#rec#</li>
			</cfoutput>
			
			<cfset prg_id = MedicareSavingsPrg_ID>
			
			<cfif session.subset_id neq 14>
				<cfinclude template="../dspLinks.cfm">
			<cfelse>
				<cfset request.MedicareSavingsPrg_ID = MedicareSavingsPrg_ID>
				<cfset request.MSPApply = "Y">
				<cfinclude template="../dspLISLinks.cfm">
			</cfif>
			</p>
		<cfelse>
			<cfoutput><li>#summary#</li></cfoutput>
		</cfif>
	</cfloop>
	
</cfif>

<!-- Display other coverage options -->
<cfif request.lisanswerfield eq "none">
	<cfinclude template="dspOtherCoverage.cfm">
</cfif>