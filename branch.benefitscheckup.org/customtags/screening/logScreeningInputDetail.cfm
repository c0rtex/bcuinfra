<cfparam name="attributes.pgno" type="numeric">
<cfparam name="attributes.response_type" type="string" default="">
<cfparam name="attributes.response_var" type="string" default="">
<cfparam name="attributes.composite_id" type="string" default="">
<cfparam name="attributes.response" type="any" default="">
<cfparam name="attributes.retained_flag" type="any" default="NULL" >
<cfparam name="attributes.derived_flag" type="any" default="NULL" >
<cfparam name="attributes.approximation_flag" type="any" default="NULL" >
<cfparam name="attributes.encryption_flag" type="any" default="NULL" >
<cfparam name="attributes.prepopulateWithInput" type="boolean" default="false">
<cfparam name="attributes.debug" type="boolean" default="false">
<cfif attributes.debug><cfoutput><br>response_type: #attributes.response_type# response_var #attributes.response_var#  response #attributes.response# composite_id #attributes.composite_id#</br></cfoutput></cfif>
<cfif attributes.response_var eq 'no_hh_members'>
	<cfif isdefined('session.marital_stat') and session.marital_stat eq 'married'>
		<cfif attributes.response lt 2>
			<cfset attributes.response = 2 >
		</cfif>
	<cfelseif isdefined('session.marital_stat') and session.marital_stat neq 'married'>
		<!--- 01/12/2010 MH - Set no_hh_members to default to 1 if single and no_hh_members doesn't have a value --->
		<cfif attributes.response lt 1>
			<cfset attributes.response = 1 >
		</cfif>
	</cfif>
<cfelseif attributes.response_var eq 'hh_depend'>
	<cfif isdefined('session.marital_stat') and session.marital_stat eq 'married'>
		<cfif attributes.response lt 2>
			<cfset attributes.response = 2 >
		</cfif>
	<cfelseif isdefined('session.marital_stat') and session.marital_stat neq 'married'>
		<!--- 01/12/2010 MH - Set no_hh_members to default to 1 if single and hh_depend doesn't have a value --->
		<cfif attributes.response lt 1>
			<cfset attributes.response = 1 >
		</cfif>
	</cfif>
</cfif>
<cfif attributes.composite_id Eq ''>
	<cfset lsidType = attributes.response_type>
	<cfset lsidVar = attributes.response_var>
<cfelse>
	<cfset lsidType = ListGetAt(attributes.composite_id, 1, '-')>
	<cfset lsidVar = ListGetAt(attributes.composite_id, 2, '-')>
</cfif>
<cfset lsidVal = attributes.response>
<cfif lsidVal eq 0>
	<cfset attributes.approximation_flag = 'NULL'>
</cfif>
<cfif attributes.timestamp Eq ''>
	<cfset lsidTimestamp = CreateODBCDateTime(Now())>
<cfelse>
	<cfset lsidTimestamp = attributes.timestamp>
</cfif>
<cfif lsidType eq 'n'>
	<cfset lsidVal = Replace(lsidVal, ',', '', 'ALL')>
</cfif>

<cfset lsidResponse = 'NULL'>
<cfset lsidOptionID = 'NULL'>

<cfif lsidVal Neq ''>
	<cfif lsidType eq 'n' or lsidType eq 'i' or lsidType eq 'a'>
		<cfset lsidResponseType = 1>
		<cfif IsNumeric(lsidVal)>
			<cfloop condition="Len(lsidVal) gt 1 And Left(lsidVal, 1) eq '0'">
				<cfset lsidVal = Right(lsidVal, Len(lsidVal) - 1)>
			</cfloop>
			<cfset lsidResponse = lsidVal>
		</cfif>
		<cfset lsidStore = lsidVal>
	<cfelseif lsidType eq 's'>
		<cfset lsidResponseType = 2>
		<cfset lsidResponse = Left(lsidVal, 64)>
		<cfset lsidStore = lsidVal>
	<cfelseif lsidType eq 'y' Or lsidType eq 'c'>
		<cfset lsidResponseType = 3>
		<cfif lsidVal eq 'y' OR lsidVal eq 'Y'>
			<cfset lsidOptionID = 1>
		<cfelseif lsidVal eq 'notsure'> <!-- the rare NOT SURE case -->
			<cfset lsidOptionID = 1462>
		<cfelseif lsidVal eq 'dontknow'> <!-- the rare I DON'T KNOW case -->
			<cfset lsidOptionID = 1474>
       	<cfelseif lsidVal eq 'unsure'>
			<cfset lsidOptionID = 1462>
		<cfelse>
			<cfset lsidOptionID = 0>
		</cfif>
		<cfset lsidStore = lsidOptionID>
	<cfelseif lsidType eq 'g'>
		<cfset lsidResponseType = 3>
		<cfif lsidVal eq 'm' OR lsidVal eq 'M'>
			<cfset lsidOptionID = 2>
		<cfelse>
			<cfset lsidOptionID = 3>
		</cfif>
		<cfset lsidStore = lsidOptionID>
	<cfelseif lsidType eq 'o'>
		<cfset lsidResponseType = 3>
		<cfset lsidOptionID = ListGetAt(lsidVal, 1, '-')>
		<cfset lsidStore = lsidOptionID>
	</cfif>
<cfelse>
	<cfif lsidType eq 'n' or lsidType eq 'i' or lsidType eq 'a'>
		<cfset lsidResponseType = 1>
	<cfelseif lsidType eq 's'>
		<cfset lsidResponseType = 2>
	<cfelse>
		<cfset lsidResponseType = 3>
	</cfif>
	<cfset lsidStore = ''>
</cfif>
<cfset ansObj = application.answerfieldPool.getAnswerfield(lsidVar)>
<cfif ansObj.exists>
	<cfset varExists = true>
	<cfset id = ansObj.id>
<cfelse>
	<cfset varExists = false>
</cfif>

<cfif varExists>
	<cf_handleScreeningAnswerfield action="get" code="#lsidVar#" element="ins" var="afIsInserted">
	<cfif afIsInserted eq 1>
		<cfquery name="delScreeningAnswerfield" datasource="#application.dbSrc#">
			DELETE FROM screening_answerfield
			WHERE screening_id=#session.screening.id#
				AND answerfield_id=#id#
		</cfquery>
		<cf_handleScreeningAnswerfield action="set" code="#lsidVar#" ins="0">
	</cfif>
	<cfset responseToSave = lsidResponse>
	<cfset encryptedResponseToSave = 'NULL'>
	<cfif lsidResponse neq 'NULL'>
		<cfif attributes.encryption_flag eq 1>
			<cf_encodeString text="#lsidResponse#" var="responseToSave">
		</cfif>
		<cfset responseToSave = "'" & Replace(responseToSave, "'", "''", 'ALL') & "'">
		<cfif attributes.encryption_flag eq 1>
			<cfset encryptedResponseToSave = responseToSave>
			<cfset responseToSave = 'NULL'>
		</cfif>
	</cfif>
	<cftry>
	<cfquery name="logAnswerfield" datasource="#application.dbSrc#">
		INSERT INTO screening_answerfield 
			(screening_id, answerfield_id, responsetype, response, option_id, pagenum,
			 retained_flag, derived_flag, approximation_flag, encryption_flag, encrypted_response, submit_datetime)
		VALUES
			(#session.screening.id#, #id#, #lsidResponseType#,
			 #PreserveSingleQuotes(responseToSave)#, #lsidOptionID#, #attributes.pgno#, 
			 #attributes.retained_flag#,#attributes.derived_flag#,#attributes.approximation_flag#, #attributes.encryption_flag#,
			 #PreserveSingleQuotes(encryptedResponseToSave)#, #lsidTimestamp#)
	</cfquery>
	<cfif attributes.debug><cfoutput>INSERT INTO screening_answerfield 
			(screening_id, answerfield_id, responsetype, response, option_id, pagenum,
			 retained_flag, derived_flag, approximation_flag, encryption_flag, encrypted_response, submit_datetime)
		VALUES
			(#session.screening.id#, #id#, #lsidResponseType#,
			 #PreserveSingleQuotes(responseToSave)#, #lsidOptionID#, #attributes.pgno#, 
			 #attributes.retained_flag#,#attributes.derived_flag#,#attributes.approximation_flag#, #attributes.encryption_flag#,
			 #PreserveSingleQuotes(encryptedResponseToSave)#, #lsidTimestamp#)</cfoutput>..<br>
	</cfif>
	<cfcatch></cfcatch>
	</cftry>
	<cf_handleScreeningAnswerfield action="set" code="#lsidVar#" ins="1">
</cfif>
<cfif attributes.prepopulateWithInput>
	<cfif lsidResponseType lt 3>
		<cfif lsidResponse eq 'NULL'>
			<cfset lsidCore = ''>
		<cfelseif Left(lsidResponse, 1) eq "'" And Right(lsidResponse, 1) eq "'" And Len(lsidResponse) gt 1>
			<cfset lsidCore = Mid(lsidResponse, 2, Len(lsidResponse) - 2)>
		<cfelse>
			<cfset lsidCore = lsidResponse>
		</cfif>
		<cf_handleScreeningAnswerfield action="set" code="#lsidVar#" val="#lsidStore#" type="#lsidResponseType#" pre="#lsidCore#">
	<cfelse>
		<cf_handleScreeningAnswerfield action="set" code="#lsidVar#" val="#lsidStore#" type="#lsidResponseType#" pre="#lsidOptionID#">
	</cfif>
<cfelse>
	<cftry><cf_handleScreeningAnswerfield action="set" code="#lsidVar#" val="#lsidStore#" type="#lsidResponseType#"><cfcatch></cfcatch></cftry>
</cfif>
<cfif attributes.derived_flag neq '1' and ListFind('dob_month,dob_year,sp_dob_month,sp_dob_year,ct_mrtl_stus,ct_clnt_mail_addr_st_grt,be_clnt_mail_addr_zip5,ct_ss_disblty_xnd,be_clnt_under_age_xnd,be_noncl_under_age_xnd,be_res_bank_acc_amt,be_res_invst_amt,be_res_csh_amt,be_clnt_ss_benefits_amt,be_clnt_rr_incm_amt,be_clnt_va_benefits_amt,be_clnt_pens_annuit_amt,be_clnt_oth_incm_amt,be_noncl_ss_benefits_amt,be_noncl_rr_incm_amt,be_noncl_va_benefits_amt,be_noncl_pens_annuit_amt,be_noncl_oth_incm_amt,be_clnt_earn_wgs_xnd,be_clnt_earn_wgs_amt,be_clnt_earn_loss_xnd,be_clnt_earn_amt,be_clnt_stop_wrk_xnd,be_noncl_earn_wgs_xnd,be_noncl_earn_wgs_amt,be_noncl_earn_loss_xnd,be_noncl_earn_amt,be_noncl_stop_wrk_xnd,zip,skipinc,skipassets,ct_live,be_clnt_fnm,be_noncl_fnm,be_thrd_fnm,be_clnt_dob_day,be_clnt_dob_month,be_clnt_dob_year,be_noncl_dob_day,be_noncl_dob_month,be_noncl_dob_year,chip', lsidVar)>
	<cfset caller.lsiDeriveList = ListAppend(caller.lsiDeriveList, lsidVar)>
</cfif>

