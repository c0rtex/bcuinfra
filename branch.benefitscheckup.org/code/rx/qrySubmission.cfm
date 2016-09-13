<cfset submission_status = "">
<cfquery name="qrySubmission" datasource="#application.dbSrc#">
SELECT     prev_screening_id
FROM         screening
WHERE     screening_id = <cfqueryparam 
                        value="#session.screening_id#"  
                        cfsqltype="cf_sql_integer"
                        maxlength="10"> 
</cfquery>
<cfset  receipt_screening_id = qrySubmission.prev_screening_id  >
<cfquery name="qrySubmission" datasource="#application.dbSrc#">
SELECT     *
FROM         screening_submission
WHERE     screening_id = <cfqueryparam 
                        value="#receipt_screening_id#"  
                        cfsqltype="cf_sql_integer"
                        maxlength="10"> 
</cfquery>
<cfif qrySubmission.recordcount gt 0  and receipt_screening_id neq 0>
	<cfset  submission_status = qrySubmission.submission_status >
</cfif>