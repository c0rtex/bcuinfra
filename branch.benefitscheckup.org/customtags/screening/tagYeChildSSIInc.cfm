<!----=======================================
DESCRIPTION: Checks to see if user is eligible for the Children's SSI income disregard rule
CALLED BY: procEligibility
GOES TO: Caller
RETURNS: answer = YES or NO dependant on if user is eligible
NOTE: The manipulation of the numbers is determined by the content staff
============================================---->
<cfparam name="attributes.checkState" type="boolean" default="false">
<!---
<cfif attributes.ynDoBuffer>
	<cfset attributes.self = attributes.self + 100>
	<cfset attributes.self_spouse = attributes.self_spouse + 100>	
	<cfset attributes.childrens = attributes.childrens + 100>	
</cfif>
--->

<!--- calculate child's adjusted income --->
<cfif session.ch_income_earned eq ''>
	<cfset session.ch_income_earned = 0>
</cfif>
<cfif session.ch_income_total_unearned eq ''>
	<cfset session.ch_income_total_unearned = 0>
</cfif>
<cfif session.ch_income_child_support eq ''>
	<cfset session.ch_income_child_support = 0>
</cfif>
<cfset childIncomeAdjusted = MAX(((session.ch_income_earned - 65) / 2), 0) + session.ch_income_total_unearned + (session.ch_income_child_support * 0.66666667)>

<!--- calculate parents' adjusted income --->
<cfif session.ch_parent eq 'Y'>
	<!--- check the maritial status and do calculations accordingly --->
	<cfif SESSION.MARITAL_STAT EQ 'Married'>
		<cfset spouseEarnedIncome = SESSION.SP_INCOME_EARNED>
		<cfset selfEarnedIncome = SESSION.S_SP_INCOME_EARNED - spouseEarnedIncome>
		<cfset unearnedIncomeAdjusted = SESSION.S_SP_INCOME_TOTAL_UNEARNED - session.S_SP_INCOME_TANF - session.S_SP_INCOME_CASH_ASSIST - session.S_SP_INCOME_VET_BEN>
		<cfset tableToCheck = 'married'>
	<cfelse>
		<cfset spouseEarnedIncome = 0>
		<cfset selfEarnedIncome = SESSION.S_INCOME_EARNED>
		<cfset unearnedIncomeAdjusted = SESSION.S_INCOME_TOTAL_UNEARNED - session.S_INCOME_TANF - session.S_INCOME_CASH_ASSIST - session.S_INCOME_VET_BEN>
		<cfset tableToCheck = 'single'>
	</cfif>
	<cfset selfEarnedIncomeAdjusted = MAX(((selfEarnedIncome - 65) / 2), 0)>
	<cfset parentsIncomeAdjusted = spouseEarnedIncome + selfEarnedIncomeAdjusted + unearnedIncomeAdjusted>
<cfelse>
	<cfset parentsIncomeAdjusted = 0>
</cfif>

<!--- calculate child count for lookup --->
<cfset childcount = session.no_hh_children>
<cfif childcount eq '' or childcount lt 1>
	<cfset childcount = 1>
<cfelseif childcount gt 8>
	<cfset childcount = 8>
</cfif>

<!--- decide whether to check Federal or state --->
<cfif attributes.checkState>
	<cfset passStateID = session.st>
<cfelse>
	<cfset passStateID = 'FD'>
</cfif>

<!--- do calc --->
<cfif session.ch_parent neq 'Y'>
	<cf_compareSSILookup table="child" state_id="#passStateID#" count="#childcount#" childIncome="#childIncomeAdjusted#">
<cfelseif session.ch_guardian eq 'Y' or session.ch_other eq 'Y'>
	<cf_compareSSILookup table="#tableToCheck#" state_id="#passStateID#" count="#childcount#" childIncome="#childIncomeAdjusted#" parentsIncome="#parentsIncomeAdjusted#" checkHighIncome="true">
	<cfif not result>
		<cf_compareSSILookup table="child" state_id="#passStateID#" count="#childcount#" childIncome="#childIncomeAdjusted#">
	</cfif>
<cfelse>
	<cf_compareSSILookup table="#tableToCheck#" state_id="#passStateID#" count="#childcount#" childIncome="#childIncomeAdjusted#" parentsIncome="#parentsIncomeAdjusted#" checkHighIncome="true">
</cfif>

<!--- send result to calling code --->
<cfset caller.answer = result>