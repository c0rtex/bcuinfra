<cf_logScreeningInput>
<cfset session.skipinc = 'Y'>
<cfset session.skipassets = 'Y'>
<cfset session.int_saving_money = 'Y'>
<cfif session.subset_id eq 27 or session.subset_id eq 39 >
    <cfset session.subsetGridFlag = 1>
	<cflocation url="frmassetgrid.cfm" AddToken="Yes">
<cfelseif session.subset_id eq 70>
 <cfset session.subsetGridFlag = 1>
	<cflocation url="frmincomegrid.cfm" AddToken="Yes">
</cfif>
<!--- 2005/05/05 BShunn  Nowadays we check the subset variables to see where to go next. --->
<cfif session.subsetDrugFlag eq 0>
	<cfset session.selectedDrugs = ''>
	<cflocation url="frmDrugList.cfm" addtoken="Yes">
<cfelse>
	<!--- 12/17/2002 BS  If we skip the drug question page, we need to delete all drugname variables from the session before proceeding, or else bad things will happen --->
	<cfset session.selectedDrugs=''>
	<cfloop collection=#session# item="chosendrug">
		<cfif FindNoCase('dn_', chosendrug) eq 1>
			<cfset StructDelete(session, chosendrug)>
		</cfif>
	</cfloop>
	<cfif session.subsetOptionalFlag eq 0>
		<cflocation url="frmOptionalQuestions.cfm" addtoken="Yes">
	<cfelse>
		<cflocation url="proceligibility.cfm" addtoken="Yes">
	</cfif>
</cfif>