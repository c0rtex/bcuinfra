<!----=======================================
DESCRIPTION: Checks to see if user is eligible for the SSI income disregard rule
CALLED BY: procBuffer
GOES TO: Caller
REQUIRED: self = income level for a single person,  offset by 100 cus this is for buffer
				self_spouse = income level for a married person, offset by 100 cus this is for buffer
RETURNS: answer = YES or NO dependant on if user is eligible
NOTE: The manipulation of the numbers is determined by the content staff
============================================---->
<!--- Check to make sure that there is atleast 65 in earned income, otherwise just set to 0 --->
<!--- First calc is to subtract 65 from earned income, then divide by 2 --->
	<CFIF #SESSION.S_INCOME_EARNED# gt 65>
		<CFSET figure = (#Session.S_income_earned# - 65) / 2>
	<CFELSE>
		<CFSET figure = 0>
	</CFIF>

<!--- check the maritial status and do calculations accordingly --->
<CFIF #SESSION.MARITAL_STAT# NEQ 'Married'>

	<!--- take the new figure (earned-65/2) and add in TANF and Cash Assist 
		then subtract that from all income,   then compare that to the self number passed in as an attribute--->
	<CFSET X = #session.S_INCOME_TANF# + #session.S_INCOME_CASH_ASSIST#>
	<CFSET finalfigure = #SESSION.S_INCOME_TOTAL_UNEARNED# - #X#>
	<CFSET finalfigure = #finalfigure# + #figure#>
		<CFIF #finalfigure# lte (#attributes.self# + 100)>
			<CFSET answer = 'YES'>
		<CFELSE>
			<CFSET answer = 'NO'>
		</CFIF>
		
<!--- check the maritial status and do calculations accordingly --->
<CFELSEIF #SESSION.MARITAL_STAT# EQ 'Married'>

	<!--- take the new figure (earned-65/2) and add in TANF and Cash Assist 
		then subtract that from all income,   then compare that to the married number passed in as an attribute--->
	<CFSET X = #session.S_INCOME_TANF# + #session.S_INCOME_CASH_ASSIST#>
	<CFSET finalfigure = #SESSION.S_INCOME_TOTAL_UNEARNED# - #X#>
	<CFSET finalfigure = #finalfigure# + #figure#>
	<CFSET spouse = #SESSION.SP_INCOME_TOTAL_COMPLETE# - #session.S_INCOME_TANF# - #session.S_INCOME_CASH_ASSIST#>
	<CFSET finalfigure = #finalfigure# + #spouse#>
		<CFIF #finalfigure# lte (#attributes.self_spouse# + 100)>
			<CFSET answer = 'YES'>
		<CFELSE>
			<CFSET answer = 'NO'>
		</CFIF>
<CFELSE>
	<CFSET answer = 'NO'>
</CFIF>

<CFOUTPUT><CFSET caller.answer = #answer#></CFOUTPUT>
