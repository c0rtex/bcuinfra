


<cfinsert DATASOURCE="#application.dbSrc#" TABLENAME="tbl_answerfield_list">

<cfif len(form.answerfield) eq 0>
	<cflocation URL="add_ques.cfm">
<cfelse>
	<CFSET answer = form.answerfield>
	<cflocation URL="add_ques.cfm?answer=#answer#">
</cfif>
<cfmodule template="../footer.cfm">