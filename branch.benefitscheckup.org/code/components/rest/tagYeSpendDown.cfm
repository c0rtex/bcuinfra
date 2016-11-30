<!----=======================================
DESCRIPTION: Checks to see if user is eligible for the SpendDown income disregard rule
CALLED BY: procEligibilityr
GOES TO: Caller
REQUIRED: rule = the eligibility rule as a string
RETURNS: answer = YES or NO dependant on if user is eligible
NOTE: The manipulation of the numbers is determined by the content staff
      the rule by structure gives us the single person limit, and the married limit  the rule will be 
      structured assuch  spenddown-singlelimit-marriedlimit so  we do a get token function 
      to set the limits within the tag.
      There is also the cahnce that the limit will be in the form of an income table set to household 
      members      
============================================---->
<cfif Not IsDefined('session.med_costs') Or session.med_costs eq ''>
	<cfset session.med_costs = 0>
</cfif>
<cfset selfEarnedIncomeAdjusted = MAX(((SESSION.S_SP_INCOME_EARNED - SESSION.SP_INCOME_EARNED - 65) / 2),0)>

<cfif attributes.EvaluateRule IS "FALSE">
   <cfset self = gettoken(attributes.Rule,2,"-")>
   <cfset self_spouse = gettoken(attributes.Rule,3,"-")>
	<cfif attributes.ynDoBuffer>
	   <cfset self = self + 100>
	   <cfset self_spouse = self_spouse + 100>
	</cfif>
   <cfif session.MARITAL_STAT EQ "Married">
		<cfset valToCheck = self_spouse>
		<cfset spouseEarnedIncome = session.SP_INCOME_EARNED>
		<cfset selfUnearnedIncome = SESSION.S_SP_INCOME_TOTAL_UNEARNED>
	<cfelse>
		<cfset valToCheck = self>
		<cfset spouseEarnedIncome = 0>
		<cfset selfUnearnedIncome = SESSION.S_INCOME_TOTAL_UNEARNED>
	</cfif>
   <cfset adjustedIncome = spouseEarnedIncome + selfUnearnedIncome + selfEarnedIncomeAdjusted>
   <cfset finalfigure = adjustedIncome - session.med_costs>
   <cfif finalfigure lte valToCheck>
      <cfset caller.answer = "YES">
   <cfelse>
      <cfset caller.answer = "NO">
   </cfif>
<cfelse>
   <cfset selfIncomeAdjusted = (SESSION.S_SP_INCOME_TOTAL_UNEARNED - SESSION.SP_INCOME_TOTAL_UNEARNED) + selfEarnedIncomeAdjusted>
   <cfset rest_hh_income = 
   Session.HH_INCOME_TOTAL_COMPLETE - (SESSION.S_SP_INCOME_TOTAL_COMPLETE - SESSION.SP_INCOME_TOTAL_COMPLETE)>
   <cfset adjustedIncome = selfIncomeAdjusted + rest_hh_income>
   <cfset finalfigure = adjustedIncome - session.med_costs>
	
	<cfif attributes.ynDoBuffer>
		<!--- 07/09/2002 REM  Normally, the rule is just evaluated, but because the buffer
		needs to check for a value between the real val and the buffer val, we do it this way: --->
	   <!--- valStructMem < FinalFigure < valStructMem + 100 --->
		<cfset valStructMem = getToken(attributes.rule, 3, " ")>
	   <cfif (valStructMem LT FinalFigure) AND (FinalFigure LT (valStructMem + 100))>
	      <cfset caller.answer = "YES">
	   <cfelse>
	      <cfset caller.answer = "NO">
	   </cfif>
	<cfelse>
	   <cfset Rule = ReplaceNoCase(Attributes.Rule, "spenddowninc", finalfigure, "ALL")>
	   <cfset caller.answer = EVALUATE(Rule)>
	</cfif>
</cfif>         
            