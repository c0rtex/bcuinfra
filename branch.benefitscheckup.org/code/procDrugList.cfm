<cfif IsDefined('form.selectedDrugNm')>
	<cfset session.selectedDrugs = ListAppend(session.selectedDrugs,form.selectedDrugNm)>
</cfif>

<!---<cflocation url="frmDrugQuestions.cfm" addtoken="yes">--->
