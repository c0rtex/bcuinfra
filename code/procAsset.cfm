<!----=======================================
DESCRIPTION: takes the asset grid, calls custom tag to do calcs, and set variables
CALLED BY: frmAssetGrid.cfm
GOES TO: frmOptionalQuestions.cfm
REQUIRED: N/A
============================================---->
<cf_logScreeningInput>
<!--- 09/01/2002 REM  Now we figure out whether or not to ask the drug question:
 - First we test to see if we need to ask it
 - Then we test to see if they're eligible
 --->
<cfif IsDefined('session.partner_id') And session.partner_id eq 5>
	<cflocation url="proceligibility.cfm" addtoken="Yes">
<cfelseif session.subsetDrugFlag eq 0 AND session.skipinc eq 'Y'>
	<cfset session.selectedDrugs = ''>
	<cflocation url="frmDrugList.cfm" addtoken="Yes">
<cfelseif session.subsetOptionalFlag eq 0>
	<cflocation url="frmOptionalQuestions.cfm" addtoken="Yes">
<cfelse>
	<cflocation url="proceligibility.cfm" addtoken="Yes">
</cfif>