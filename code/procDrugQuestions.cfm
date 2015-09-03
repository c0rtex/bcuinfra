<!--- 04/08/2008 bshunn  Save list of drug answerfields to session --->
<cf_logScreeningInput>
<!--- loop through the answer fields from the form and set the session variables --->
<cfloop list="#form.selectedDrugNm#" index="af">
	<!---
	#5452
	<cf_cacheAnswerfieldpool action="get" code="#af#" var="afobj">
    --->
    <cfset afobj = application.AnswerfieldPool.getAnswerfield('#af#')>
	<cfif afobj.type eq 'generic'>
		<CFQUERY NAME="qryGeneric" DATASOURCE="#application.dbSrc#">
			select aa.answerfield
			from answerfield_relationship ar, answerfield aa
			where ar.right_answerfield_id=#afobj.id#
				and ar.relationship_id=1
				and ar.left_answerfield_id=aa.answerfield_id
		</CFQUERY>
		<cfloop query="qryGeneric">
			<cfset "session.#answerfield#" = 'Y'>
		</cfloop>
	</cfif>
</cfloop>
<cfset session.screening.qnum = session.screening.qnum + 1>
<!--- 10/31/2002 RX Only users were being directed past optional questions.  Took cfif out. --->
<!--- 08/24/2004 BShunn  Remove the "true or" below to restore the drug costs page to q'aire --->
<cfif true or session.selectedDrugs eq '' or session.selectedDrugs eq 'null'>
	<cfif SESSION.subset_id EQ 0 AND SESSION.partner_id EQ 77>
		<cflocation url="proceligibility.cfm" addtoken="Yes">
	<cfelseif session.subsetOptionalFlag eq 0>
		<cflocation url="frmOptionalQuestions.cfm" addtoken="Yes">
	<cfelse>
		<cflocation url="proceligibility.cfm" addtoken="Yes">
	</cfif>
<cfelse>
	<cflocation url="frmDrugCosts.cfm" addtoken="Yes">
</cfif>