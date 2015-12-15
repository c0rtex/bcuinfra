<!----=======================================
DESCRIPTION: Checks to see if user is eligible for the SpendDown income disregard rule
CALLED BY: procEligibility
GOES TO: Caller
REQUIRED: rule = the eligibility rule as a string
RETURNS: answer = YES or NO dependant on if user is eligible
NOTE: The manipulation of the numbers is determined by the content staff
		the rule by structure gives us the single person limit high and low, and the married limit high and low
		the rule will be structured assuch
		BuyInInc - single_limit_high - single_limit_low - married_limit_high - married_limit_low
		so  we do a get token function 
		to set the limits within the tag,  then we offset that limit cus this is the buffer.
		There is also the cahnce that the limit will be in the form of an income table set to household 
		members		
============================================---->	
<cfif not IsNumeric("#attributes.self_high#")>
	<cfset attributes.self_high = 0>
</cfif>
<cfif not IsNumeric("#attributes.s_sp_high#")>
	<cfset attributes.s_sp_high = 0>
</cfif>
<cfif not IsNumeric("#attributes.self_low#")>
	<cfset attributes.self_low = 0>
</cfif>
<cfif not IsNumeric("#attributes.s_sp_low#")>
	<cfset attributes.s_sp_low = 0>
</cfif>
<cfset strRule = attributes.rule>	
<cfset table = FINDNOCASE("table", strRule, 1)>
<cfif table EQ 0>
	<cfif attributes.ynDoBuffer>
		<cfset self_high = attributes.self_high+100>	
		<cfset s_sp_high = attributes.s_sp_high+100>
		<cfset minFigure=0>
	<cfelse>
		<cfset self_high = attributes.self_high>	
		<cfset s_sp_high = attributes.s_sp_high>	
		<cfset minFigure=1>
	</cfif>
	
	<cfset self_low = attributes.self_low>	
	<cfset s_sp_low = attributes.s_sp_low>
	
	<cfif SESSION.MARITAL_STAT NEQ 'Married'>
		<cfset spouseEarnedIncome = 0>
		<cfset selfEarnedIncome = SESSION.S_INCOME_EARNED>
		<cfset unearnedIncome = SESSION.S_INCOME_TOTAL_UNEARNED>
		<cfset highfigure = self_high>
		<cfset lowfigure = self_low>
	<cfelse>
		
		<cfif SESSION.SP_INCOME_EARNED EQ ''>
			<cfset SESSION.SP_INCOME_EARNED = 0>
		</cfif>
		<cfif SESSION.S_SP_INCOME_TOTAL_UNEARNED EQ ''>
			<cfset SESSION.S_SP_INCOME_TOTAL_UNEARNED = 0>
		</cfif>
		
		<cfset spouseEarnedIncome = SESSION.SP_INCOME_EARNED>
		<cfset selfEarnedIncome = SESSION.S_SP_INCOME_EARNED - spouseEarnedIncome>
		<cfset unearnedIncome = SESSION.S_SP_INCOME_TOTAL_UNEARNED>
		<cfset highfigure = s_sp_high>
		<cfset lowfigure = s_sp_low>
	</cfif>
	
	<cfset selfEarnedIncomeAdjusted = MAX(((selfEarnedIncome - 65) / 2), minFigure)>
	<cfset finalfigure = spouseEarnedIncome + selfEarnedIncomeAdjusted + unearnedIncome>
	<cfif finalfigure LTE highfigure AND finalfigure GT lowfigure>	
		<cfset caller.answer = "YES">
	<cfelse>
		<cfset caller.answer = "NO">
	</cfif>
<cfelse>
	<!--- find table in rule --->
	<cfset figure = MAX(((SESSION.S_SP_INCOME_EARNED - SESSION.SP_INCOME_EARNED - 65) / 2),0) + SESSION.SP_INCOME_EARNED>
	<cfif ynDoBuffer>
		<cfset figure = MAX((figure - 100),0)>
	</cfif>
	<cfset Rule = ReplaceNoCase(strRule, "BuyInQI2inc", figure, "ALL")>	
	<cfset caller.answer = EVALUATE(Rule)>	
</cfif>
