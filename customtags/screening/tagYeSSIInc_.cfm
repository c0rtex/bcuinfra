<!----=======================================
DESCRIPTION: Checks to see if user is eligible for the SSI income disregard rule
CALLED BY: procEligibility
GOES TO: Caller
REQUIRED: self = income level for a single person
				self_spouse = income level for a married person
RETURNS: answer = YES or NO dependant on if user is eligible
NOTE: The manipulation of the numbers is determined by the content staff
============================================---->
<cfif attributes.ynDoBuffer>
	<cfset attributes.self = attributes.self + 100>
	<cfset attributes.self_spouse = attributes.self_spouse + 100>	
</cfif>

<!--- check the maritial status and do calculations accordingly --->
<cfif SESSION.MARITAL_STAT EQ "Married">
	<cfset spouseEarnedIncome = SESSION.SP_INCOME_EARNED>
	<cfset selfEarnedIncome = SESSION.S_SP_INCOME_EARNED - spouseEarnedIncome>
	<cfset unearnedIncomeAdjusted = SESSION.S_SP_INCOME_TOTAL_UNEARNED - session.S_SP_INCOME_TANF - session.S_SP_INCOME_CASH_ASSIST>
	<cfset valToCheck = attributes.self_spouse>
<cfelse>
	<cfset spouseEarnedIncome = 0>
	<cfif SESSION.S_INCOME_EARNED eq "">
		<cfset SESSION.S_INCOME_EARNED = 0>
	</cfif>
	<cfset selfEarnedIncome = SESSION.S_INCOME_EARNED>
	<cfset unearnedIncomeAdjusted = SESSION.S_INCOME_TOTAL_UNEARNED - session.S_INCOME_TANF - session.S_INCOME_CASH_ASSIST>
	<cfset valToCheck = attributes.self>
</cfif>
<!--- First calc is to subtract 65 from earned income, then divide by 2 --->
<cfset selfEarnedIncomeAdjusted = MAX(((selfEarnedIncome - 65) / 2),0)>

<!--- take the new figure (earned-65/2) and add in TANF and Cash Assist then subtract that from all income, then compare that to the self number passed in as an attribute--->	
	<cfset finalFigure = spouseEarnedIncome + selfEarnedIncomeAdjusted + unearnedIncomeAdjusted>
	<cfif finalFigure lte valToCheck>
		<cfset caller.answer = "YES">
	<cfelse>
		<cfset caller.answer = "NO">
	</cfif>
