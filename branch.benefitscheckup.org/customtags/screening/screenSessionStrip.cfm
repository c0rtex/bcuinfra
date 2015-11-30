<cfquery name="afstrip" datasource="#application.dbSrc#">
	SELECT answerfield
	FROM tbl_answerfield_list
	ORDER BY answerfield
</cfquery>
<cfloop query="afstrip">
	<cfset structdelete(session, answerfield)>
</cfloop>
<cfset structdelete(session, "selecteddrugnm")>
<cfset structdelete(session, "selectedDrugs")>
<cfset structdelete(session, "clientnum")>
<cfset structdelete(session, "subset_id")>
<cfset structdelete(session, "partner_id")>
<cfset structdelete(session, "start_time")>
<cfset structdelete(session, "end_time")>
<cfset structdelete(session, "dob_month")>
<cfset structdelete(session, "dob_year")>
<cfset structdelete(session, "sp_dob_month")>
<cfset structdelete(session, "sp_dob_year")>
<cfset structdelete(session, "prg_list")>
<cfset structdelete(session, "buff_list")>
