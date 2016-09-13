<cfquery name="qryLISNOTES" datasource="#application.dbSrc#">
	SELECT      pt.summary, pt.rec, pt.type, pt.benefit
	FROM        programtext pt
	WHERE     
	pt.template = 'LISNOTE' 
	and benefit =<cfqueryparam 
            value="#request.notesbenefit#" 
            cfsqltype="cf_sql_integer"
            maxlength="2">
	and active=1
	and answerfield = <cfqueryparam 
            value="#request.answerfieldnotes#" 
            cfsqltype="cf_sql_varchar"
            maxlength="50">
</cfquery>

<!-- EVEN MORE NOTES -->
<cfoutput  query="qryLISNOTES">
	<br><br>#rec#<br>
</cfoutput>