<!----=======================================
DESCRIPTION: Checks to see if user is eligible for the SpendDown income disregard rule
CALLED BY: procBuffer
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
<CFSET strRule = attributes.rule>
<CFSET table = FINDNOCASE("table", strRule, 1)>
	<CFIF table EQ 0>
					<CFSET self_high = gettoken(strRule,2,"-")>
					<CFSET self_low = gettoken(strRule,3,"-")>
					<CFSET s_sp_high = gettoken(strRule,4,"-")>
					<CFSET s_sp_low = gettoken(strRule,5,"-")>
	
		<CFIF #SESSION.MARITAL_STAT# NEQ 'Married'>
			<CFIF #SESSION.S_INCOME_EARNED# gt 65>
				<CFSET figure = (#Session.S_income_earned# - 65) / 2>
			<CFELSE>
				<CFSET figure = 0>
			</CFIF>
			
				<CFSET finalfigure = #SESSION.S_INCOME_TOTAL_UNEARNED# + #figure#>
		
			<CFIF #finalfigure# lte (#self_high# + 100) AND #finalfigure# gt #self_low#>
				<CFSET answer = 'YES'>
			<CFELSE>
				<CFSET answer = 'NO'>
			</CFIF>
		
		<CFELSEIF #SESSION.MARITAL_STAT# EQ 'Married'>
			<CFIF #SESSION.S_INCOME_EARNED# gt 65>
				<CFSET figure = (#Session.S_income_earned# - 65) / 2>
			<CFELSE>
				<CFSET figure = 0>
			</CFIF>
			
				<CFSET finalfigure = #SESSION.S_INCOME_TOTAL_UNEARNED# + #figure#>
				<CFSET finalfigure = #finalfigure# + #SESSION.SP_INCOME_EARNED# + #SESSION.SP_INCOME_TOTAL_UNEARNED#>
			<CFIF #finalfigure# lte (#s_sp_high# + 100) AND #finalfigure# gt #s_sp_low#>
				<CFSET answer = 'YES'>
			<CFELSE>
				<CFSET answer = 'NO'>
			</CFIF>
		
		<CFELSE>
		<CFSET answer = 'NO'>
		</CFIF>
	<CFELSE> <!--- find table in rule --->
				<CFIF #SESSION.S_SP_INCOME_EARNED# gt 65>
					<CFSET figure = ((#Session.S_sp_income_earned# - 65) / 2)>
					<CFIF figure gt 100>
						<CFSET figure = #figure# - 100>
					<CFELSE>
						<CFSET figure = 0>
					</cfif>
				<CFELSE>
					<CFSET figure = 0>
				</CFIF>
				
				<CFSET Rule = #ReplaceNoCase(#strRule#, "BuyInQI2inc", "#figure#", "ALL")#>
				<CFSET temp=#EVALUATE("#Rule#")#>
				<CFSET answer = temp>
		
	</CFIF>
	<CFOUTPUT><CFSET caller.answer = #answer#></CFOUTPUT>
		
		
		
		
		
		
