<!-- To Run this file, set the partner id and start and end rows for the recordset to be executed. The batch will not execute without the url.start parameter set to "start"" . Set Server to qa for testing ssl1 for production -->
<cfparam name="attributes.screen_source" default="remote">
<cfparam name="url.start" default="start">
<cfparam name="attributes.row_num" default="1">
<cfif url.start neq 'start' and attributes.screen_source neq "remote">
	<h2>Invalid Page Access</h2>
	<cfabort>
<cfelse>
<cfoutput>Screening Source:#attributes.screen_source#</cfoutput>
<!---Set Partner ID to 23 for BDT , 29 for EPIC, 49 for pcg 53 for SFP--->
<cfset serverid = 3 >
<cfset partner_id =53 >
<cfset startrow = 1>
<cfset endrow = 2>
<cfset batch_id = 0>
<cfif attributes.screen_source eq "remote">
	<cfset startrow = 1>
	<cfset endrow = 1>
	<cfset PARTNER_ID = request.partner_id >  >
	<cfset screening_row_num = attributes.row_num >
	<cfset batch_id = 0>
</cfif>

<cfset batch_datasrc = "#session.datasrc#">
<!-- Set Server to qa for testing ssl1 for production -->
<cfset server = "ssl4">
<!-- Get Data from Database -->
<cfif attributes.screen_source neq "remote">
<cfquery name="CLIENTIDQUERY"  datasource="#batch_datasrc#"  >
	SELECT   client_id
	FROM         
	<cfif partner_id eq 23>
	 bdtssabatch
	<cfelseif partner_id eq 29>
	 epicssabatch
	<cfelse>
	epicssabatch
	</cfif> 
	order by client_id desc
</cfquery>
<cfelse>
	<cfset ClientIDQUERY = QueryNew("client_id","varchar")>
	<cfset temp = #QueryAddRow(ClientIDQUERY,1)#>
   	<cfset Temp = #QuerySetCell(ClientIDQUERY, "client_id", "1")#>
	<cfif not isdefined('batchquery')>
	<cfif attributes.screen_source eq 'remote'>
		<cfset batchQuery = QueryNew("screening_id,partner_screening_id,partner_id,org_id,subset_id,client_id,report_url,validation_error,program_list,screening_status,reentry_number,date_time,program_title","integer,integer,integer,integer,integer,varchar,varchar,varchar,varchar,varchar,integer,date,varchar")>
	</cfif>
	</cfif>
</cfif>
<cfoutput>Batch Record Count: #CLIENTIDQuery.RecordCount#<br/></cfoutput>

<!-- Loop Through Batch Data -->
<cfloop query ="CLIENTIDQuery" startrow=#startrow#  endrow=#endrow#  >
<cfquery name="BatchQuery"  datasource="#batch_datasrc#"  >
SELECT    


bdtssabatch_id,  
BE_CLNT_OTH_INCM_XND,be_clnt_oth_incm_amt, BE_RES_BANK_ACC_XND, BE_RES_INVST_XND, BE_RES_CSH_XND,
BE_CLNT_CHG_ADDR_SW, BE_CLNT_COSSN as CT_CLNT_COSSN, BE_CLNT_DOB_DAY, BE_CLNT_DOB_MONTH, BE_CLNT_DOB_YEAR, BE_CLNT_EARN_AMT,
BE_CLNT_EARN_LOSS_XND, BE_CLNT_EARN_WGS_AMT, BE_CLNT_EARN_WGS_XND, BE_CLNT_FNM,BE_CLNT_LNM, BE_CLNT_MAIL_ADDRLN_1, BE_CLNT_MAIL_ADDRLN_2,
BE_CLNT_MAIL_ADDRLN_3, BE_CLNT_MAIL_ADDR_CITY, BE_CLNT_MAIL_ADDR_ST as CT_CLNT_MAIL_ADDR_ST_GRT, BE_CLNT_MAIL_ADDR_ZIP5, BE_CLNT_MAIL_ADDRLN_4 as BE_CLNT_MAIL_APT_NO, 
BE_CLNT_MNM, BE_CLNT_OTH_INCM_TYP,
BE_CLNT_PAY_DISBLTY_XND, 
BE_CLNT_PENS_ANNUIT_AMT, 
BE_CLNT_PENS_ANNUIT_XND, 
CT_CLNT_PHONE as BE_CLNT_PHNAREA, 
CT_CLNT_PHONE as BE_CLNT_PHNEXCH, 
CT_CLNT_PHONE as BE_CLNT_PHNNUM, 
BE_CLNT_RR_INCM_AMT,
BE_CLNT_RR_INCM_XND, 
BE_CLNT_SFX, 
BE_CLNT_SS_BENEFITS_AMT, 
BE_CLNT_SS_BENEFITS_XND, BE_CLNT_STOP_WRK_MONTH, BE_CLNT_STOP_WRK_XND, BE_CLNT_STOP_WRK_YEAR,
BE_CLNT_SUB_SW, BE_CLNT_VA_BENEFITS_AMT, BE_CLNT_VA_BENEFITS_XND, BE_CLNT_WRKD_L2YR_XND, BE_CNTCT_FNM, BE_CNTCT_LNM, 
CT_CNTCT_PHONE as BE_CNTCT_PHNAREA, 
CT_CNTCT_PHONE as BE_CNTCT_PHNEXCH,
CT_CNTCT_PHONE as BE_CNTCT_PHNNUM, 
BE_INCM_DECRS_XND, BE_NONCL_COSSN as CT_NONCL_COSSN, BE_NONCL_DOB_DAY, BE_NONCL_DOB_MONTH, BE_NONCL_DOB_YEAR, BE_NONCL_EARN_AMT,
BE_NONCL_EARN_LOSS_XND, BE_NONCL_EARN_WGS_AMT, BE_NONCL_EARN_WGS_XND, BE_NONCL_FNM, BE_NONCL_LNM, BE_NONCL_MNM, BE_NONCL_OTH_INCM_AMT,
BE_NONCL_OTH_INCM_TYP, BE_NONCL_OTH_INCM_XND, BE_NONCL_PAY_DISBLTY_XND, BE_NONCL_PENS_ANNUIT_AMT, BE_NONCL_PENS_ANNUIT_XND, BE_NONCL_RR_INCM_AMT,
BE_NONCL_RR_INCM_XND, BE_NONCL_SFX, BE_NONCL_SS_BENEFITS_AMT, BE_NONCL_SS_BENEFITS_XND, BE_NONCL_STOP_WRK_MONTH, BE_NONCL_STOP_WRK_XND, BE_NONCL_STOP_WRK_YEAR,
BE_NONCL_SUB_SW, BE_NONCL_VA_BENEFITS_AMT, BE_NONCL_VA_BENEFITS_XND, BE_NONCL_WRKD_L2YR_XND, BE_RESTT_XND, BE_RES_BANK_ACC_AMT, BE_RES_CSH_AMT, BE_RES_INVST_AMT,
BE_CLNT_BUEXP_SW, BE_NONCL_BUEXP_SW, BE_RLTVS_SUP, BE_SAV_LMT_XND, BE_SEND_MSPINFO_CD, BE_SAV_LMT_XND1, BE_THRD_ADDRLN_1, BE_THRD_ADDRLN_2,
BE_THRD_ADDRLN_3, BE_THRD_ADDR_CITY, BE_THRD_ADDR_ST as CT_THRD_ADDR_ST_GRT, BE_THRD_ADDR_ZIP5, BE_THRD_ADDRLN_4 as BE_THRD_APT_NO, BE_THRD_FNM, BE_THRD_LNM, 
CT_THRD_PHONE as BE_THRD_PHNAREA, 
CT_THRD_PHONE as BE_THRD_PHNEXCH, 
CT_THRD_PHONE as BE_THRD_PHNNUM,
BE_THRD_REL, BE_THRD_REL_OTH, BE_THRD_SUB_SW, BE_WGS_DECRS_XND, BE_WH_APPLY, CLIENT_ID, CT_LIVE as CT_LIVE_GRT, CT_MAIL_XND, CT_MRTL_STUS, CT_OLDER_XND, CT_RECEIVE_MEDICARE_XND,
CT_SS_DISBLTY_XND, CT_THRD_PTY_XND

	FROM         
	<cfif partner_id eq 23>
	 bdtssabatch
	<cfelseif partner_id eq 29>
	 epicssabatch
	<cfelse>
	epicssabatch
	</cfif> 
	<cfif attributes.screen_source eq 'remote' >
	where (1= 0)
	<cfelse>
	where client_id = '#CLIENTIDQUERY.client_id#'
	</cfif>
</cfquery>
<cfdump var="#BatchQuery#">

	<cfset temp = #QueryAddRow(batchQuery,1)#>

	<cfloop collection="#structBCUVars[screening_row_num]#" item="field">
		<cfset toevaluate = "structBCUVars[#screening_row_num#]" & "." & "#field#">
			<cfset fieldval = #evaluate(toevaluate)#>

		<cftry>
		<cfif field eq 'be_clnt_buexp_xnd'>
			<cfset fieldtoinsert = 'be_clnt_buexp_sw'>
		<cfelseif field eq 'be_noncl_buexp_xnd'>
			<cfset fieldtoinsert = 'be_noncl_buexp_sw'> 
		<cfelse>
			<cfset fieldtoinsert = field>
		</cfif>
		<cfset newfield = field>
		<cfif newfield eq 'ct_live' >
 			 <cfset newfield = 'ct_live_grt'>
		<cfelseif newfield eq 'be_thrd_addr_st' >
 			 <cfset newfield = 'ct_thrd_addr_st_grt'>
		<cfelseif newfield eq 'be_clnt_cossn' >
 			 <cfset newfield = 'ct_clnt_cossn'>
		<cfelseif newfield eq 'be_noncl_cossn' >
  			<cfset newfield = 'ct_noncl_cossn'>
		<cfelseif newfield eq 'be_clnt_mail_addr_st' >
 		      <cfset newfield = 'ct_clnt_mail_addr_st_grt'>
		</cfif>
   		<cfset Temp = #QuerySetCell(batchQuery, newfield, fieldval)# >
		<cfcatch><cfoutput>#field#</cfoutput> not added <br></cfcatch>
		</cftry>
	</cfloop>


<cfset client_id  = BatchQuery.client_id >
<cfset bdtssabatch_id = BatchQuery.bdtssabatch_id >
<cfif bdtssabatch_id eq "" and attributes.screen_source eq "remote">
	<cfset bdtssabatch_id = int(rand() * 10000)>
</cfif>
<cfoutput><br/>START======Time:#TimeFormat(Now())# Record #CLIENTIDQUERY.currentrow# -----  #client_id#--#bdtssabatch_id#<br/>
</cfoutput>

<!--set internal processing error flag  -->
<cfset internal_error = ''>
<cfset badResponseList = ''>



<!-- map field data -->
<cfinvoke component="mapSSAdata" method="setvalues" returnvariable="mappedresults">

	<cfinvokeargument name="BatchQuery" value="#BatchQuery#">

</cfinvoke>
<cfset screening_string = "">


<!---cfloop collection="#mappedresults#" item="x">
<cfoutput>
<Answer AnswerField="#x#" AnswerValue="#evaluate('mappedresults.#x#')#"/>
</cfoutput>
</cfloop --->



<cfdump var="#mappedresults#">

<!-- process screening -->

<cfset session.org_id = 0>

<cfset session.prev_id = 0>

<cfset session.language_id = "EN">

<cfset session.access_id = 0>

<cfset session.user_id = "NULL">
<cfset session.subset_id = 41>
<cfset session.partner_id = partner_id >
<cfif isdefined('url.source_id') and url.source_id neq 8>
	<cfset session.source_id = 7>
<cfelse>
	<cfset session.source_id = 8>
</cfif>
<cfset session.state_id = "">
<cfset session.test_id = 0>
<cfset session.client_id = 0 >
<!-- map field data -->
<cfinvoke component="mapSSAdata" method="getfieldlist" returnvariable="aflist" >

	<cfinvokeargument name="mappedresults" value="#mappedresults#">

</cfinvoke>

<!--cfoutput><br/>Answer Field List: afList: #aflist# <br/>cfoutput -->

<!--<cfdump var="#mappedresults#"> -->



<!-- set mapped result variables to form scope --->

<cfloop collection="#mappedresults#"  item="fieldname">

	<cfset newval = #structfind(mappedresults,fieldname)#>

	<cfset results = #structinsert(form,fieldname,newval, "yes")#>

</cfloop>

<cfoutput><b>Kiryl Debug  loop ended for map vars</b><br></cfoutput>

<!-- cfdump  var="#mappedresults#" label="Mapped Fields" expand="no" -->

<cf_handleScreening action="start">

<!-- cfdump var="#session.screening#" expand="no" -->

<!--- START session info loading --->

<cfoutput><b>Kiryl Debug  New log screening</b><br></cfoutput>

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

<cfoutput><b>Kiryl Debug  New query fro subsetinfo is done</b><br></cfoutput>

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
	<cfset session.BE_CNTCT_FNM = "">
       <cfset session.BE_CNTCT_LNM = "">
	<cfset session.BE_RES_BANK_ACC_XND = "">

	<cfset session.BE_RES_INVST_XND = "">

	<cfset session.BE_RES_CSH_XND  = "">

	<cfset session.BE_CLNT_INS_POL_XND   = "">

	<cfset session.BE_NONCL_INS_POL_XND = "">

	<cfset session.be_ins_pol_amt = "">

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

<cfoutput><b>Kiryl Debug  Right Before Screening</b><br></cfoutput>

	<cf_logScreeningInput  aflist="#afList#" batch="true">

<cfoutput><b>Kiryl Debug  New Screening Input was OK</b><br></cfoutput>

	<cfoutput><br>badResponseList: #badResponseList#<br></cfoutput>

	<cf_handleScreening action="end" screening_id="#session.screening_id#">

<cfoutput><b>Kiryl Debug  Right after Screening</b><br></cfoutput>



<!-- End Screening -->

<!-- Check Batch Output and save results in table -->

<cfoutput><b>Kiryl Debug</b></cfoutput>

<cfoutput>ScreeningID:#session.screening_id# : #session.prg_list#-#client_id#<br></cfoutput>

<cfif len(mappedresults.BE_CLNT_MAIL_ADDRLN_1) gt 22>

<cfoutput>More than 22 chars in BE_CLNT_MAIL_ADDRLN_1</cfoutput>
	<cfif badResponseList eq ''>
    <cfset badResponseList = badResponseList & 'BE_CLNT_MAIL_ADDRLN_1'>
    <cfelse>
	<cfset badResponseList = badResponseList & ',BE_CLNT_MAIL_ADDRLN_1'>
	</cfif>
</cfif>

<cfset result = structclear(form)>

<cfset result2 = structclear(mappedresults)>

<cfif #len(badResponseList)# eq 0>

	<cfoutput>Submitting application.....Record 1 -----  #client_id#--</cfoutput>

	<cfhttp url="http://#session.servername#/cf/ssatransfer/submitApplicant.php?Screening_id=#session.screening_id#" method="get"  >

	</cfhttp>
	<cfoutput>posting to.. http://#session.servername#/ssatransfer/submitApplicant.php?Screening_id=#session.screening_id#</cfoutput>


</cfif>

<cfquery name="status"  datasource="#session.datasrc#"  >

	select * from screening_submission where screening_id = #session.screening_id#

</cfquery>



<!-- Catch any internal errors and set status  -->





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
	<cfcase value="4">
		<cfset status_message = "Check The Social Security Number You Entered">
	</cfcase>
	<cfcase value="5">
		<cfset status_message = "Limit Number Of Restarts">
	</cfcase>
	<cfcase value="6">
		<cfset status_message = "Limit Number Of Starts For A New Application">
	</cfcase>
	<cfcase value="7">
		<cfset status_message = "Limit On The Number Of Tries To Start The Application">
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

   <cfoutput><h2>Initial Status #status_message#</h2></cfoutput> 

<cfelseif #len(badResponseList)# gt 0>

	<cfset status_message = "Validation Error: " & badResponseList>
<cfelseif status.submission_status eq 0 or status.submission_status IS "">

	<cfset status_message = "No Status: #status.submission_status# Social Security Cannot Process Your Request At This Time">
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
<cfelse>

	<cfset source = "remote">
</cfif>
	
<cfquery name="getreentry" datasource="#batch_datasrc#">

	select reentry_number 

	from screening_submission 

	where  screening_submission.screening_id = #session.screening_id#

</cfquery>

<cfif getreentry.recordcount eq 0 and  status_message eq "Social Security Has Partially Processed Your Application">
	<cfset status_message = "Social Security Cannot Process Your Request At This Time">
</cfif>
	<cfoutput>Status Message: #status_message#<br/></cfoutput>


	

<cfoutput>status:#status.submission_status#</cfoutput>

<!-- Stop the Processing if a SSA Website Error Occurs -->

<cfif (status.submission_status eq 9 or status.submission_status eq 11) and internal_error neq 'y'  >

	<cfoutput>SSA Website Processing Error</cfoutput>

<cfabort>

</cfif>

<cfoutput>====END</cfoutput><br/>

<cfif attributes.screen_source neq "remote">
<cfflush >
</cfif>
<cfset batch_screening_id = session.screening_id>
<cf_handleScreening action="kill">



<!-- Finish Batch Record and Go to the next -->
</cfloop>
</cfif>
