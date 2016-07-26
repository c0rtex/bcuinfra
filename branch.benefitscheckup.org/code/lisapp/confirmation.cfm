<!---
Template Name: confirmation.cfm 
Component Purpose: final page of low income subsidy application
Data Tables: NA	
--->

<cfquery name="qrySubmission" datasource="#application.dbSrc#">
	SELECT *
	FROM screening_submission
	WHERE screening_id=#session.prev_id#
	AND submission_status = 1
</cfquery>
<cfif qrySubmission.submission_status eq "">
	<cfquery name="qrySubmission" datasource="#application.dbSrc#">
		SELECT *
		FROM screening_submission
		WHERE screening_id=#session.prev_id#
		ORDER BY post_finish_time DESC	
	</cfquery>
</cfif>
<cf_buildHTML cellpadding="12" cellspacing="2">
<cfoutput>

<cfif ListFind('7,07,8,08,9,09,10,11,12,13,14,15,16,17,18,19,20,21,26,27,29,30,31', qrySubmission.submission_status)>
<form>
	<input type="button" value="Print This Page" onClick="window.print();">
</form>
</cfif>

<cfif ListFind('1', qrySubmission.submission_status)>
<form action="submissionreceipt.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#" method="post">
	<input type="submit" value="View Your Submission Receipt">
</form>
<cfif ListFind('1,3,4,5,6,7,8,11,13,14,15,16,17', qrySubmission.submission_status)>
<form action="/cf/frmRecommend.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#" method="post">
	<input type="submit" value="BenefitsCheckUp Results">
</form>
</cfif>
</cfif>

<cfif qrySubmission.reentry_number gt 0 and qrySubmission.submission_status gt 1>
	<cfoutput><strong><font size="5">Your Reentry Number: #qrySubmission.reentry_number#</font></strong></cfoutput>
	<br><br>
	<cf_displayText code="site_reentry_number" group="site">
<cfelseif qrySubmission.submission_status gt 0 and qrySubmission.submission_status lt 18>	         
	<cf_displayText code="site_turboapp_submission_status_#qrySubmission.submission_status#" group="site"><br><br>
<cfelse>
	An error has occurred.<br><br>
</cfif>

<cfif ListFind('1', qrySubmission.submission_status)>
<form action="submissionreceipt.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#" method="post">
	<input type="submit" value="View Your Submission Receipt">
</form>
</cfif>

<cfif ListFind('2,3,4,5,8,10,15', qrySubmission.submission_status)>
<p> Click <cf_sessionPassVars href="questions.cfm" subset_id="41" prev_id="#session.prev_id#">here</cf_sessionPassVars> to edit your responses. </p>
</cfif>

<cfif ListFind('1,3,4,5,6,7,8,11,13,14,15,16', qrySubmission.submission_status)>
<p>To find out information about additional programs you may be eligible for, click the BenefitsCheckUp Results button.</p>
</cfif>


<cfif ListFind('1,3,4,5,6,7,8,9,11,12,13,14,15,16,17', qrySubmission.submission_status)>
<form action="/cf/frmRecommend.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#" method="post">
	<input type="submit" value="BenefitsCheckUp Results">
</form>
</cfif>

<cfif ListFind('1,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17', qrySubmission.submission_status)>
<p>
 <cf_displayButton return_oe="true">
</p>
</cfif>

</cfoutput>
</cf_buildHTML>
