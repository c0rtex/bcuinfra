<cfparam name="page" type="numeric" default="0">
<cfparam name="edit" type="numeric" default="0">
<cfparam name="continue" type="numeric" default="0">
<cfparam name="badResponseList" type="string" default="">
<cfparam name="url.pdf" default="false">
<cfset session.screening.prepopulate = 1>
<cf_handleScreening action="end" screening_id="#session.screening.id#">

<cfset handledObj = createObject("component","com.bcu.fitHandler").init(session.screening.id)>
<!--- Create insertFlags to block reinsertion into current screening if user refreshes action plan page in browser--->
<cfset insertFitScore = 0>
<cfquery name="ctFitScore" datasource="#application.dbSrc#">
	Select count(*) as ctFitScore
    from screening_answerfield
    where screening_id = #session.screening_id# and answerfield_id = 6644
</cfquery>
<cfif ctFitScore.ctFitScore neq 0>
	<cfset insertFitScore = 1>
</cfif>
<cfif insertFitScore eq 0>
    <cfquery name="logFitScore" datasource="#application.dbSrc#">
        INSERT INTO screening_answerfield 
            (screening_id, answerfield_id, responsetype, response, pagenum, derived_flag, submit_datetime)
        VALUES
            (#session.screening_id#, 6644, 1, #handledObj.getFitNum()#, 1, 1, #CreateODBCDateTime(Now())#)
    </cfquery>
</cfif>
<cfset insertEstMthlyCashNeeds = 0>
<cfquery name="ctEstMthlyCashNeeds" datasource="#application.dbSrc#">
	Select count(*) as ctEstMthlyCashNeeds
    from screening_answerfield
    where screening_id = #session.screening_id# and answerfield_id = 6645
</cfquery>
<cfif ctEstMthlyCashNeeds.ctEstMthlyCashNeeds neq 0>
	<cfset insertEstMthlyCashNeeds = 1>
</cfif>
<cfif insertEstMthlyCashNeeds eq 0>
    <cfquery name="logEstMthlyCashNeeds" datasource="#application.dbSrc#">
        INSERT INTO screening_answerfield 
            (screening_id, answerfield_id, responsetype, response, pagenum, derived_flag ,submit_datetime)
        VALUES
            (#session.screening_id#, 6645, 1, #handledObj.getMonthlyCashNeeds()#, 1, 1, #CreateODBCDateTime(Now())#)
    </cfquery>
</cfif>
<cfset insertEstLumpSum = 0>
<cfquery name="ctEstLumpSum" datasource="#application.dbSrc#">
	Select count(*) as ctEstLumpSum
    from screening_answerfield
    where screening_id = #session.screening_id# and answerfield_id = 6646
</cfquery>
<cfif ctEstLumpSum.ctEstLumpSum neq 0>
	<cfset insertEstLumpSum = 1>
</cfif>
<cfif insertEstLumpSum eq 0>
    <cfquery name="logEstLumpSum" datasource="#application.dbSrc#">
        INSERT INTO screening_answerfield 
            (screening_id, answerfield_id, responsetype, response, pagenum, derived_flag, submit_datetime)
        VALUES
            (#session.screening_id#, 6646, 1, #handledObj.getLumpSum()#, 1, 1, #CreateODBCDateTime(Now())#)
    </cfquery>
</cfif>
<!--- <cfset qAnswerfields = handledObj.getAnswerfieldsAsQuery()> --->
<!---<cfdump var="#form#" expand="no">
<cfdump var="#qAnswerfields#" expand="no">
<cfdump var="#session#" expand="no">
 --->
 <cf_buildHTML cellpadding="12" cellspacing="2" allowBack="true">
 <script type="text/javascript">
	function showReqText(bool){
		if(bool){
			document.getElementById('showReqText').style.display = "";
		}else{
			document.getElementById('showReqText').style.display = "none";
		}
	}
</script>
<style type="text/css">
	.fitListItem{
		font-family:Verdana, Geneva, sans-serif;
		font-size:12px;
		padding:4px;
		margin-bottom:4px;
		border:1px dotted #CCC;
		color:#666;
	}
	.fitBold{
		font-weight:bold;	
	}
	.fitHeaders{
		font-weight:bold;
		font-size:14px;	
	}
</style>
<cfsavecontent variable="fitOutput">
	<cfoutput>
        <table width="100%">
            <tr>
                <td align="left" width="50%">Client: #session.fit_last_name#</td>
                <td align="right" width="50%">Date: #DateFormat(Now(), "mmm-dd-yyyy")#</td>
            </tr>
        </table>
	</cfoutput>
	<BR />
	<cf_displayText code="site_fit_summary_main" group="site">
    <p style="padding-left:20px;"><span><span class="fitHeaders"><cf_displayText code="site_fit_summary_mthlycash" group="site"></span> <cfoutput>#dollarFormat(handledObj.getMonthlyCashNeeds())#</cfoutput></span></p>
    <p style="padding-left:20px;"><span><span class="fitHeaders"><cf_displayText code="site_fit_summary_lumpsum" group="site"></span> <cfoutput>#dollarFormat(handledObj.getLumpSum())#</cfoutput></span></p>
    <p><cf_displayText code="site_fit_summary_main2" group="site"></p>
    <cfset showBene = handledObj.benefitsExist()>
    <cfif showBene is 1>
		<cf_displayText code="site_fit_summary_assessment_needed" group="site"> <cfoutput>(Click <cf_sessionpassvars href="full.cfm?screening_id=#session.screening_id#&zip=#session.fit_zip#&lastname=#session.fit_last_name#&agency_id=#session.fit_agency_id#&subset_id=51&partner_id=76">here</cf_sessionpassvars> to do a BenefitsCheckUp Assessment now.)</cfoutput>
    <cfelseif showBene is 2>
    	<cf_displayText code="site_fit_summary_assessment_requested" group="site"> <cfoutput>(Click <cf_sessionpassvars href="full.cfm?screening_id=#session.screening_id#&zip=#session.fit_zip#&lastname=#session.fit_last_name#&agency_id=#session.fit_agency_id#&subset_id=51&partner_id=76">here</cf_sessionpassvars> to do a BenefitsCheckUp Assessment now.)</cfoutput>
    </cfif>
    
    <cf_displayText code="site_fit_summary_other_issues_header" group="site">
    <p style="padding-left:20px;"><span>
    	<span class="fitHeaders"><cf_displayText code="site_fit_summary_fitnum" group="site"></span> 
		<cfoutput>#handledObj.getFitNum()# (on a scale of 1 to 5)</cfoutput>
    </span></p>
    <p><cf_displayText code="site_fit_summary_main1" group="site"></p>
    <cfif handledObj.makingEndsMeetExist()>
    	<cf_displayText code="site_fit_summary_making_ends_meet" group="site">
    </cfif>
    <cfif handledObj.otherResourcesExist()>
    	<cf_displayText code="site_fit_summary_resources_limited" group="site">
    </cfif>
    <cfif handledObj.homeRespExist()>
    	<cf_displayText code="site_fit_summary_homeowner_responsibilities" group="site">
    </cfif>
    <cfif handledObj.activityLimitsExist()>
    	<cf_displayText code="site_fit_summary_health_activity_limitations" group="site">
    </cfif>
    <cfif handledObj.homeChallengeExist()>
    	<cf_displayText code="site_fit_summary_home_challenges" group="site">
    </cfif> 
    <cfif handledObj.stayingHomeExist()>
    	<cf_displayText code="site_fit_summary_uncertain_staying_home" group="site">
    </cfif>
    <cfif handledObj.publicProgramsExist()>
    	<cf_displayText code="site_fit_summary_public_help" group="site">
    </cfif>
    <cfif handledOBj.annuityExist()>
    	<cf_displayText code="site_fit_summary_buying_financial_product" group="site">
    </cfif>
    <cfif handledObj.getFitNum() IS 5>
    	<cf_displayText code="site_fit_summary_no_immediate_life_challenges" group="site">
    </cfif>
    <cf_displayText code="site_fit_summary_additional_counselor_comments" group="site">
    
    <div style="height:250px;">&nbsp;</div>
    <!--- UNUSED NOW SAVING JUT IN CASE
	<p><cf_displayText code="site_fit_summary_main3" group="site"></p>
    
    <cf_displayText code="site_fit_summary_footer" group="site">--->
</cfsavecontent>
<cfif NOT url.pdf>
    <div style="float:left;">
        <cf_sessionPassVars action="/cf/fit_questions.cfm" prev_id="#session.screening_id#" method="post">
            <input type="submit" value="Back to Form">
        </cf_sessionPassVars>
    </div>
    <div style="float:left;padding-left:10px;">
        <cf_sessionPassVars action="fit_actionplan.cfm?pdf=true" method="post">
            <input type="submit" value="View PDF Version">
        </cf_sessionPassVars>
    </div>
    <div style="clear:both;"></div>

	<cfoutput>#fitOutPut#</cfoutput>
    
    <div style="float:left;">
        <cf_sessionPassVars action="/cf/fit_questions.cfm" prev_id="#session.screening_id#" method="post">
            <input type="submit" value="Back to Form">
        </cf_sessionPassVars>
    </div>
    <div style="float:left;padding-left:10px;">
        <cf_sessionPassVars action="fit_actionplan.cfm?pdf=true" method="post">
            <input type="submit" value="View PDF Version">
        </cf_sessionPassVars>
    </div>
    <div style="clear:both;"></div>
</cfif>
</cf_buildHTML>
</td>
</tr>
</table>

<cfif URL.pdf>
	<cfdocument format="PDF" filename="/opt/bcu/apps/bcu_code/other/pdf/FIT_Report.pdf" overwrite="TRUE"><cfoutput>#fitOutPut#</cfoutput></cfdocument>
	<cfheader name="Content-Disposition" value="attachment;filename=FIT_Report.pdf">
<cfcontent type="application/pdf" file="/opt/bcu/apps/bcu_code/other/pdf/FIT_Report.pdf" deletefile="Yes">
</cfif>
<!--- 5384: be_res_bank_acc_xnd --->
