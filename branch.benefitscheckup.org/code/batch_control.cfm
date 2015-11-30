<cfset batch_datasrc = "BCU"><!-- BCU for live and BCU_QA for testing -->

<!--- Grab the last record in the batchcontrol table for latest batch and batch_status--->
<cfoutput>
<cfif IsDefined("url.bid")>
	<cfquery name="setBatch_action" datasource="#batch_datasrc#">
		UPDATE batchcontrol
   		SET batch_action = 1
      		WHERE batch_id = #url.bid#
	</cfquery>
	<cfquery name="lastBatch" datasource="#batch_datasrc#">
		SELECT * 
		FROM    batchcontrol
		WHERE   batch_id = #url.bid#
	</cfquery>
<cfelse>
	<cfquery name="lastBatch" datasource="#batch_datasrc#">
		SELECT * 
		FROM    batchcontrol
		WHERE   batch_id = (SELECT MAX(batch_id)  FROM batchcontrol)
	</cfquery>
</cfif>

<form action="batch_control.cfm?bid=#lastBatch.batch_id#" method="post" name="terminateBatch">
	<b>LAST RECORD FROM BATCHCONTROL</b><BR><BR>
	<table border="1" cellpadding="1">
	<tr><td><b>batch_id</b></td>
	    <td><b>start_date</b></td>
	    <td><b>records_count</b></td>
	    <td><b>batch_status</b></td>
	    <td><b>batch_action</b></td>
	</tr>
	<tr><td>#lastBatch.batch_id#</td>
	    <td>#lastBatch.start_date#</td>
	    <td>#lastBatch.records_count#</td>
	    <td>#lastBatch.batch_status#</td>
	    <td>#lastBatch.batch_action#</td>
	</tr>
	<cfif lastBatch.batch_status eq 0>
	<tr align="center"><td rowspan="5"><BR><input type="submit" value="Terminate Batch" name="end" /></td></tr>
	</cfif>
	</table>
</form>
</cfoutput>
