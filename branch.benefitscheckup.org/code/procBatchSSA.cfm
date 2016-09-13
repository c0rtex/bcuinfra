<!-- To Run this file, set the partner id and start and end rows for the recordset to be executed. The batch will not execute without the url.start parameter set to "start"" . 
Set Server to qa for testing ssl1 for production -->

<cfset pre_start = "">
<cfif IsDefined("url.start")>
	<cfset pre_start = "#url.start#">
</cfif>
<cfset pre_partner_id = 0>
<cfif IsDefined("url.partner_id")>
	<cfset pre_partner_id = #url.partner_id#>
</cfif>
<cfset pre_recordnum = 0>
<cfif IsDefined("url.recordnum")>
	<cfset pre_recordnum = #url.recordnum#>
</cfif>
<!---<cfoutput>
	pre_start: #pre_start#<BR>
	pre_partner_id: #pre_partner_id#<BR>
	pre_recordnum: #pre_recordnum#<BR>
</cfoutput>--->
<cfif (pre_start neq 'start') OR (pre_partner_id eq 0) OR (pre_recordnum eq 0)>
	 <cfoutput>PAGE ABORT. Invalid URL parameters passed: start, partner_id and recordnum are required.</cfoutput>
	<cfabort>
<cfelse>
<cfset serverid = "" ><!-- set to either 3 or 4 for production system, empty string  for qa this is used to round robin load balanc live site batches  --->
	
<!----------------------------------------------------------------------------------------------------------------------------------------------------------------------------->
<!---START OF FIELDS THAT NEED TO BE PASSED VIA URL FOR RUNNING BATCHES-------------------------------------------------------------------------------------------------------->
<!----------------------------------------------------------------------------------------------------------------------------------------------------------------------------->

<!--Set Partner ID to 23 for BDT , 29 for EPIC, 49 for pcg 53 for SFP-->
<cfset partner_id =#url.partner_id# ><!--batch partner id used to associate source and result data with partner-->
<cfset recordnum = #url.recordnum#><!-- Num of batch records -->

<!----------------------------------------------------------------------------------------------------------------------------------------------------------------------------->
<!---END OF FIELDS THAT NEED TO BE PASSED VIA URL FOR RUNNING BATCHES---------------------------------------------------------------------------------------------------------->
<!----------------------------------------------------------------------------------------------------------------------------------------------------------------------------->

<cfset batch_datasrc = "BCU"><!-- BCU for live and BCU_QA for testing -->

<!--- Grab the last record in the batchcontrol table for latest batch and batch_status--->
<cfquery name="getLastBatch2" datasource="#batch_datasrc#">
	SELECT * 
	FROM    batchcontrol
	WHERE   batch_id = (SELECT MAX(batch_id)  FROM batchcontrol)
	
</cfquery>

<!--- if status = 0, abort with message. if status = 2, then continue with the same batch and skips batchcontrol record insertion below --->
<cfset runLastBatch="n">
<cfif getLastBatch2.batch_status eq 0>
	<cfoutput>PAGE ABORT. There is a batch process currently running - batch_status = 0.</cfoutput>
	<cfabort>
<cfelseif getLastbatch2.batch_status eq 2>
	<cfquery name="chgBatch_status" datasource="#batch_datasrc#">
		UPDATE `batchcontrol`
   		SET batch_status = 0
		WHERE batch_id = '#getLastBatch2.batch_id#'
	</cfquery>
	<cfset runLastBatch = "y">
</cfif>

<!--- Insert New batch record if batch_status is not 0 or 2--->
<cfif runLastBatch neq "y">
	<cfquery name="addBatchRec" datasource="#batch_datasrc#">	
		INSERT INTO `batchcontrol`
           	  (start_date
           	  ,records_count
           	  ,batch_status
           	  ,batch_action)
     		VALUES
           	  (now()
              	  ,#recordnum#
           	  ,0
           	  ,0)
	</cfquery>
</cfif>

<!-- Get Data from Database -->
<cfquery name="CLIENTIDQUERY"  datasource="#batch_datasrc#">
	SELECT   client_id
	FROM         
	<cfif partner_id eq 23>
	 bdtssabatch
	<cfelseif partner_id eq 29>
	 epicssabatch
	<cfelse>
	epicssabatch
	</cfif> 
	where ssasubmission is NULL
	order by client_id desc
</cfquery>

<cfoutput>Batch Record Count: #CLIENTIDQuery.RecordCount#<br/></cfoutput>

<!-- Loop Through Batch Data -->
<cfloop query ="CLIENTIDQUERY">
<!---  	checking batch_action from the latest  record in batchcontrol, if it is set to 0, continue. 
	if value is 1 terminate  batch and reset batch_status to 2 and batch_action to 0 --->

<!--- Overwrite current batch query with newly inserted batch info if the getLastBatch.batch_status eq 1--->
<cfquery name="getLastBatch2" datasource="#batch_datasrc#" cachedwithin="#CreateTimeSpan(0,0,0,0)#">
	SELECT * 
	FROM    batchcontrol
	WHERE   batch_id = (SELECT MAX(batch_id)  FROM batchcontrol)
</cfquery>

<cfif getLastBatch2.batch_action eq 1>
	<cfquery name="setBatch_status" datasource="#batch_datasrc#">
		UPDATE `batchcontrol`
   		SET batch_status = 2
		,batch_action = 0
      		WHERE batch_id = '#getLastBatch2.batch_id#'
	</cfquery>
	<cfoutput>PAGE ABORT. The batch has been terminated - batch_status = 2.</cfoutput>
	<cfabort>

<cfelseif getLastBatch2.batch_action eq 0>
<cfquery name="BatchQuery"  datasource="#batch_datasrc#">
	SELECT    

bdtssabatch_id,
BE_CLNT_OTH_INCM_XND,
be_clnt_oth_incm_amt, 
BE_RES_BANK_ACC_XND, 
BE_RES_INVST_XND, 
BE_RES_CSH_XND,
BE_CLNT_CHG_ADDR_SW, 
BE_CLNT_COSSN, 
BE_CLNT_DOB_DAY, 
BE_CLNT_DOB_MONTH, 
BE_CLNT_DOB_YEAR, 
BE_CLNT_EARN_AMT,
BE_CLNT_EARN_LOSS_XND, 
BE_CLNT_EARN_WGS_AMT, 
BE_CLNT_EARN_WGS_XND, 
BE_CLNT_FNM,
BE_CLNT_LNM, 
BE_CLNT_MAIL_ADDRLN_1, 
BE_CLNT_MAIL_ADDRLN_2,
BE_CLNT_MAIL_ADDRLN_3, 
BE_CLNT_MAIL_ADDRLN_4, 
BE_CLNT_MAIL_ADDR_CITY, 
BE_CLNT_MAIL_ADDR_ST, 
BE_CLNT_MAIL_ADDR_ZIP5, 
BE_CLNT_MNM, 
BE_CLNT_OTH_INCM_TYP,
BE_CLNT_PAY_DISBLTY_XND, 
BE_CLNT_PENS_ANNUIT_AMT, 
BE_CLNT_PENS_ANNUIT_XND, 
CT_CLNT_PHONE,
BE_CLNT_RR_INCM_AMT,
BE_CLNT_RR_INCM_XND, 
BE_CLNT_SFX, 
BE_CLNT_SS_BENEFITS_AMT, 
BE_CLNT_SS_BENEFITS_XND, 
BE_CLNT_STOP_WRK_MONTH, 
BE_CLNT_STOP_WRK_XND, 
BE_CLNT_STOP_WRK_YEAR,
BE_CLNT_SUB_SW, 
BE_CLNT_VA_BENEFITS_AMT, 
BE_CLNT_VA_BENEFITS_XND, 
BE_CLNT_WRKD_L2YR_XND, 
BE_CNTCT_FNM, 
BE_CNTCT_LNM, 
CT_CNTCT_PHONE, 
BE_INCM_DECRS_XND, 
BE_NONCL_COSSN, 
BE_NONCL_DOB_DAY, 
BE_NONCL_DOB_MONTH, 
BE_NONCL_DOB_YEAR, 
BE_NONCL_EARN_AMT,
BE_NONCL_EARN_LOSS_XND, 
BE_NONCL_EARN_WGS_AMT, 
BE_NONCL_EARN_WGS_XND, 
BE_NONCL_FNM, 
BE_NONCL_LNM, 
BE_NONCL_MNM, 
BE_NONCL_OTH_INCM_AMT,
BE_NONCL_OTH_INCM_TYP, 
BE_NONCL_OTH_INCM_XND, 
BE_NONCL_PAY_DISBLTY_XND, 
BE_NONCL_PENS_ANNUIT_AMT, 
BE_NONCL_PENS_ANNUIT_XND, 
BE_NONCL_RR_INCM_AMT,
BE_NONCL_RR_INCM_XND, 
BE_NONCL_SFX, 
BE_NONCL_SS_BENEFITS_AMT, 
BE_NONCL_SS_BENEFITS_XND, 
BE_NONCL_STOP_WRK_MONTH, 
BE_NONCL_STOP_WRK_XND, 
BE_NONCL_STOP_WRK_YEAR,
BE_NONCL_SUB_SW, 
BE_NONCL_VA_BENEFITS_AMT, 
BE_NONCL_VA_BENEFITS_XND, 
BE_NONCL_WRKD_L2YR_XND, 
BE_RESTT_XND, 
BE_RES_BANK_ACC_AMT, 
BE_RES_CSH_AMT, 
BE_RES_INVST_AMT,
BE_CLNT_BUEXP_SW, 
BE_NONCL_BUEXP_SW, 
BE_RLTVS_SUP, 
BE_SAV_LMT_XND, 
BE_SEND_MSPINFO_CD, 
BE_SAV_LMT_XND1, 
BE_THRD_ADDRLN_1, 
BE_THRD_ADDRLN_2,
BE_THRD_ADDRLN_3, 
BE_THRD_ADDRLN_4, 
BE_THRD_ADDR_CITY, 
BE_THRD_ADDR_ST, 
BE_THRD_ADDR_ZIP5, 
BE_THRD_FNM, 
BE_THRD_LNM, 
CT_THRD_PHONE,
BE_THRD_REL, 
BE_THRD_REL_OTH, 
BE_THRD_SUB_SW, 
BE_WGS_DECRS_XND, 
BE_WH_APPLY, 
CLIENT_ID, 
CT_LIVE, 
CT_MAIL_XND, 
CT_MRTL_STUS, 
CT_OLDER_XND, 
CT_RECEIVE_MEDICARE_XND,
CT_SS_DISBLTY_XND, 
CT_THRD_PTY_XND
	FROM         
	<cfif partner_id eq 23>
	 bdtssabatch
	<cfelseif partner_id eq 29>
	 epicssabatch
	<cfelse>
	epicssabatch
	</cfif> 
	where client_id = '#CLIENTIDQUERY.client_id#'

</cfquery>

<cfset client_id  = BatchQuery.client_id >
<cfset bdtssabatch_id = BatchQuery.bdtssabatch_id >

<cfoutput><br/>START======Time:#TimeFormat(Now())# Record #CLIENTIDQUERY.currentrow# -----  #client_id#--#bdtssabatch_id#<br/></cfoutput>

<cftry>
<!--set internal processing error flag  -->
<cfset internal_error = ''>
<cfset badResponseList = ''>

<!-- map field data -->
<cfinvoke component="mapSSAdata" method="setvalues" returnvariable="mappedresults">
	<cfinvokeargument name="BatchQuery" value="#BatchQuery#">
</cfinvoke>
<cfif IsDefined("url.expand")>
	<cfset show = "true">
<cfelse>
	<cfset show = "false">
</cfif>
<cfif show eq "true">
	mapSSA-SET: Mapped Results(Click to expand):<BR><cfdump var="#mappedresults#" expand="no"><BR />
</cfif>
<!-- process screening -->
<cfset session.org_id = 0>
<cfset session.prev_id = 0>
<cfset session.language_id = "EN">
<cfset session.access_id = 0>
<cfset session.user_id = "NULL">
<cfset session.subset_id = 41>
<cfset session.partner_id = partner_id >
<cfset session.source_id = 7>
<cfset session.state_id = "">
<cfset session.test_id = 0>
<cfset session.client_id = batchquery.client_id >
<!--- map field data --->
<cfinvoke component="mapSSAdata" method="getfieldlist" returnvariable="aflist">
	<cfinvokeargument name="mappedresults" value="#mappedresults#">
</cfinvoke>
<!---<br/>mapSSA-GET: Answer Field List: afList: #aflist# <br/>--->

<!--- set mapped result variables to form scope --->
<cfloop collection="#mappedresults#"  item="fieldname">
	<cfset newval = #structfind(mappedresults,fieldname)#>
	<cfset results = #structinsert(form,fieldname,newval, "yes")#>
</cfloop>
<!-- <cfoutput><b>Kiryl Debug  loop ended for map vars</b><br></cfoutput> -->
<cf_handleScreening action="start">
<!--Session Screening: <cf var="#session.screening#" expand="no"><br />-->
<!--- START session info loading --->
<!-- <cfoutput><b>Kiryl Debug  New log screening</b><br></cfoutput> -->
	<cfquery name="subsetInfo" datasource="#session.datasrc#">
		SELECT subsettype_id, subset_name, subset_longname, subset_description, subset_text,
			all_flag, grid_flag, schip_flag, drug_flag, optional_flag, rec_flag, eform_flag
		FROM xsubset
		WHERE subset_id=#session.subset_id#
	</cfquery>
	<cfif subsetInfo.RecordCount>
		<cfset session.subsetName = subsetInfo.subset_name>
		<cfset session.subsetLongName = subsetInfo.subset_longname>
		<cfset session.subsetDescription = subsetInfo.subset_description>
		<cfset session.subsetText = subsetInfo.subset_text>
		<cfset session.subsetAllFlag = subsetInfo.all_flag>
		<cfset session.subsetGridFlag = subsetInfo.grid_flag>
		<cfset session.subsetSCHIPFlag = subsetInfo.schip_flag>
		<cfset session.subsetDrugFlag = subsetInfo.drug_flag>
		<cfset session.subsetOptionalFlag = subsetInfo.optional_flag>
		<cfset session.subsetRecFlag = subsetInfo.rec_flag>
		<cfset session.subsetEFormFlag = subsetInfo.eform_flag>
	<cfelse>
		<cfset session.subsetName = ''>
		<cfset session.subsetLongName = ''>
		<cfset session.subsetDescription = ''>
		<cfset session.subsetText = ''>
		<cfset session.subsetAllFlag = 0>
		<cfset session.subsetGridFlag = 0>
		<cfset session.subsetSCHIPFlag = 0>
		<cfset session.subsetDrugFlag = 0>
		<cfset session.subsetOptionalFlag = 0>
		<cfset session.subsetRecFlag = 0>
		<cfset session.subsetEFormFlag = 0>
	</cfif>
<!-- <cfoutput><b>Kiryl Debug  New query from subsetinfo is done</b><br></cfoutput> -->
	<cfquery name="subsetPartnerInfo" datasource="#session.datasrc#">
		SELECT resultpage_id
		FROM subset_partner
		WHERE subset_id=#session.subset_id#
			AND partner_id=#session.partner_id#
			AND resultpage_id IS NOT NULL
	</cfquery>
	<cfif subsetPartnerInfo.RecordCount>
		<cfset session.subsetRecFlag = subsetPartnerInfo.resultpage_id - 1>
    </cfif>
    <cfset session.BE_RES_INVST_XND = "">
	<cfset session.BE_RES_CSH_XND  = "">
	<!--- Removed 12/7/09
	<cfset session.BE_CLNT_INS_POL_XND   = "">
	<cfset session.BE_NONCL_INS_POL_XND = "">
	<cfset session.be_ins_pol_amt = "">--->
	<cfset session.skipinc = "no">
	<cfset session.hh_depend = 0>
	<cfset session.WANTCHIPS = "No">
	<cfset session.SSI_RECEIVE = "">
	<cfset session.LIHEAP_RECEIVE = "">
	<cfset session.S_INCOME_EARNED = 0>
	<cfset session.SP_INCOME_TOTAL_UNEARNED = 0>
	<cfset session.S_SP_INCOME_TOTAL_UNEARNED = 0 >
	<cfset session.S_INCOME_TOTAL_UNEARNED = 0 >
	<cfset session.HH_INCOME_TOTAL_UNEARNED = 0>
	<cfset session.HH_income_earned  = 0>
	<cfset session.st = "">
<!-- <cfoutput><b>Kiryl Debug  Right Before Screening</b><br></cfoutput> -->
	<cf_logScreeningInput  aflist="#afList#" batch="true">
<!-- <cfoutput><b>Kiryl Debug  New Screening Input was OK</b><br></cfoutput> -->
	<cfoutput><br>badResponseList: #badResponseList#<br></cfoutput>
	<cf_handleScreening action="end" screening_id="#session.screening_id#">
<!-- <cfoutput><b>Kiryl Debug  Right after Screening</b><br></cfoutput> -->

<!-- End Screening -->
<!-- Check Batch Output and save results in table -->
<!-- <cfoutput><b>Kiryl Debug</b></cfoutput> -->
<cfoutput>ScreeningID:#session.screening_id# || Client ID: #client_id#<br></cfoutput>

<cfif len(mappedresults.BE_CLNT_MAIL_ADDRLN_1) gt 22>
<cfoutput>More than 22 chars in BE_CLNT_MAIL_ADDRLN_1</cfoutput>
	<cfset badResponseList = badResponseList & 'BE_CLNT_MAIL_ADDRLN_1'>
</cfif>
<cfset result = structclear(form)>
<cfset result2 = structclear(mappedresults)>
<cfif #len(badResponseList)# eq 0>
	<cfoutput>Submitting application... Record #CLIENTIDQUERY.currentrow# </cfoutput>
	<!--- When moving to live, change replace bcuqa with ssl --->
    <!--- Prior to moving to redesign from qa this link was --->
    <!---cfhttp url="https://bcuqa#serverid#.benefitscheckup.org/ssatransfer/submitApplicant.php?Screening_id=#session.screening_id#&batch=true" method="get"--->
    <cfoutput> https://www.benefitscheckup.org/cf/ssatransfer/submitApplicant.php?Screening_id=#session.screening_id#&batch=true method=get  </cfoutput>
    <cfhttp url="https://www.benefitscheckup.org/cf/ssatransfer/submitApplicant.php?Screening_id=#session.screening_id#&batch=true" method="get"  >
	</cfhttp>
    
	<!-- Rotate servers so that each server gets an equal number of submissions -->
	<cfif serverid neq "">
	<cfset serverid = serverid + 1 >
	<cfif serverid gt 4 >
		<cfset serverid = 3 >
	</cfif>
	</cfif>
</cfif>
<!---Insert get the status from submission table  --->
<cfquery name="status"  datasource="#session.datasrc#">
	select * from screening_submission where screening_id = #session.screening_id#
</cfquery>
<!-- <cfoutput>IMPORTANT: #status.submission_status#</cfoutput>-->
<!-- Catch any internal errors and set status  -->

<!-- Commented by Kiryl -->
<cfcatch>
	<cfset status.submission_status = 9 >
	<cfset internal_error = 'y'>
</cfcatch>
</cftry>
<!-- Print Validation or Status Info -->
<cfset status_message = "Social Security Cannot Process Your Request At This Time"><!-- -->
<cfset source = "">

<cfif status.submission_status gt 0>
<cfswitch expression="#status.submission_status#">
	<cfcase value="1">
		<cfset status_message = "Successful">
	</cfcase>
	<cfcase value="2">
		<cfset status_message = "The Information You Entered Cannot Be Verified by Social Security">
	</cfcase>
	<cfcase value="3">
		<cfset status_message = "Check The Social Security Number You Entered">
	</cfcase>
	<cfcase value="8">
		<cfset status_message = "Name Check Mismatch">
	</cfcase>
	<cfcase value="9">
		<cfset status_message = "Social Security Cannot Process Your Request At This Time">
	</cfcase>
	<cfcase value="16">
		<cfset status_message = "Social Security Has Partially Processed Your Application">
	</cfcase>
	<cfcase value="10">
		<cfset status_message = "Not Eligible For Medicare">
	</cfcase>
	<cfcase value="14">
		<cfset status_message = "There Is A Pending Application For This Social Security Number">
	</cfcase>
	<cfcase value="15">
		<cfset status_message = "Social Security Cannot Verify the Information You Entered">
	</cfcase>
	<cfcase value="17">
		<cfset status_message = "You Have Already Sent Social Security an Application">
	</cfcase>
	<cfcase value=""><!-- default --->
		<cfset status_message = "Social Security Cannot Process Your Request At This Time">
	</cfcase>
</cfswitch>

<cfelseif #len(badResponseList)# gt 0>
	<cfset status_message = "Validation Error: " & badResponseList>
<cfelseif status.submission_status eq 0 or status.submission_status IS "">
	<cfset status_message = "Social Security Cannot Process Your Request At This Time">
</cfif>
<cfif partner_id eq 23>
	<cfquery name="getsource" datasource="#batch_datasrc#">
		Select BDTSource from bdtssabatch
		where bdtssabatch_id = #BatchQuery.bdtssabatch_id#
	</cfquery>
		<cfset source = getsource.bdtSource>
<cfelseif partner_id  eq 29>
		<cfset source = "EPIC">
<cfelseif partner_id  eq 49>
		<cfset source = "PCG">
<cfelseif partner_id  eq 53>
		<cfset source = "SFP">
</cfif>

<cfquery name="getreentry" datasource="#batch_datasrc#" timeout="60000">
	select reentry_number 
	from screening_submission 
	where  screening_submission.screening_id = #session.screening_id#
</cfquery>
<cfset myReentry = "#Trim(getreentry.reentry_number)#">
<cfif myReentry eq "" and  status_message eq "Social Security Has Partially Processed Your Application">
	<cfset status_message = "Social Security Cannot Process Your Request At This Time">
</cfif>
	

<cfquery name="insert_result" datasource="#batch_datasrc#">
	INSERT INTO batch_submission
		(screening_id, source, status_message,date_time, batch_id, client_id)
	VALUES
		(#session.screening_id#,'#source#','#status_message#',#CREATEODBCDATETIME(now())#,#getLastBatch2.batch_id#,'#BatchQuery.client_id#' )

</cfquery>
<!---
<cfquery name="update_result" datasource="#batch_datasrc#">
	update batch_submission  
	set reentry_number = screening_submission.reentry_number
	from screening_submission 
	inner join batch_submission on screening_submission.screening_id = batch_submission.screening_id
	where  screening_submission.screening_id = #session.screening_id#
</cfquery>
--->
<cfquery name="update_result" datasource="#batch_datasrc#">
        update batch_submission set reentry_number = 
        (select screening_submission.reentry_number from screening_submission where screening_submission.screening_id = batch_submission.screening_id)
        where batch_submission.screening_id = #session.screening_id#
</cfquery>

<!--- Query to flag record as submitted --->
<cfquery name="procFlag" datasource="#batch_datasrc#">
	<cfif partner_id eq 23>
	  UPDATE `bdtssabatch`
	<cfelseif partner_id eq 29>
	  UPDATE `epicssabatch`
	<cfelse>
	  UPDATE `epicssabatch`
	</cfif> 
	SET ssasubmission = 1
 	where client_id = '#CLIENTIDQUERY.client_id#'
</cfquery>

<cfoutput>status:#status.submission_status#<BR>status message: #status_message#<BR><BR></cfoutput>
<!-- Stop the Processing if a SSA Website Error Occurs -->
<cfif (status.submission_status eq 9 or status.submission_status eq 11) and internal_error neq 'y'  >
	<!--- Set batch_status to 2 (Terminated)--->
	<cfquery name="setBatch_status" datasource="#batch_datasrc#">
		UPDATE `batchcontrol`
   		SET batch_status = 2
		,batch_action = 0
      		WHERE batch_id = #getLastBatch2.batch_id#
	</cfquery>
	<cfoutput>SSA Website Processing Error</cfoutput>
	<cfabort>
</cfif>
<!-- <cfoutput>====END</cfoutput><br/> -->
<cfflush >
<cf_handleScreening action="kill">
</cfif>
</cfloop><!-- Finish Batch Record and Go to the next -->
<!--- Set batch_status to 1 ("Complete") --->
<cfquery name="setBatch_status" datasource="#batch_datasrc#">
	UPDATE `batchcontrol`
   	SET batch_status = 1
      	WHERE batch_id = #getLastBatch2.batch_id#
</cfquery>
</cfif>
